require "ISUI/ISInventoryPage"

ISInventoryPage.collapsePanel = ISCollapsableWindow.collapsePanel
ISInventoryPage.openPanel = ISCollapsableWindow.openPanel
ISInventoryPage.setPinned = ISCollapsableWindow.pin

ISInventoryPage.createChildren_pupBase = ISInventoryPage.createChildren
function ISInventoryPage:createChildren()
	self:createChildren_pupBase()
	ISCollapsableWindow.addInverseCollapseButton(self)
	self:setPinned()
end

function ISInventoryPage:collapse()
	if ISMouseDrag.dragging and #ISMouseDrag.dragging > 0 then
		return;
	end
	ISCollapsableWindow.collapse(self);
end

function ISInventoryPage:inverseCollapse()
	if ISMouseDrag.dragging and #ISMouseDrag.dragging > 0 then
		return;
	end
	ISCollapsableWindow.inverseCollapse(self);
end

function ISInventoryPage:update()
	if self.coloredInv and (self.inventory ~= self.coloredInv or self.isCollapsed) then
		if self.coloredInv:getParent() then
			self.coloredInv:getParent():setHighlighted(false)
		end
		self.coloredInv = nil;
	end

	if not self.isCollapsed then
		if self.inventory:getParent() and (instanceof(self.inventory:getParent(), "IsoObject") or instanceof(self.inventory:getParent(), "IsoDeadBody")) then
			self.inventory:getParent():setHighlighted(true, false);
			self.inventory:getParent():setHighlightColor(getCore():getObjectHighlitedColor());
			self.coloredInv = self.inventory;
		end
	end
	
	if (ISMouseDrag.dragging ~= nil and #ISMouseDrag.dragging > 0) or self.pin then
		self.collapseCounter = 0;
		if isClient() and self.isCollapsed then
			self.inventoryPane.inventory:requestSync();
		end
		self:openPanel()
	end

	if not self.onCharacter then
		self.removeAll:setVisible(self:isRemoveButtonVisible())

		local playerObj = getSpecificPlayer(self.player)
		if self.lastDir ~= playerObj:getDir() then
			self.lastDir = playerObj:getDir()
			self:refreshBackpacks()
		elseif self.lastSquare ~= playerObj:getCurrentSquare() then
			self.lastSquare = playerObj:getCurrentSquare()
			self:refreshBackpacks()
		end

		local object = self.inventory and self.inventory:getParent() or nil
		if #self.backpacks > 1 and instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj) then
			local currentIndex = self:getCurrentBackpackIndex()
			local unlockedIndex = self:prevUnlockedContainer(currentIndex, false)
			if unlockedIndex == -1 then
				unlockedIndex = self:nextUnlockedContainer(currentIndex, false)
			end
			if unlockedIndex ~= -1 then
				if playerObj:getJoypadBind() ~= -1 then
					self.backpackChoice = unlockedIndex
				end
				self:selectContainer(self.backpacks[unlockedIndex])
			end
		end
	end

	self:syncToggleStove()
end

function ISInventoryPage:onMouseMove(dx, dy)
	self.mouseOver = true;

	if self.moving then
		self:setX(self.x + dx);
		self:setY(self.y + dy);
	end

	if not isGamePaused() then
		if self.isCollapsed and self.player and getSpecificPlayer(self.player) and getSpecificPlayer(self.player):isAiming() then
			return
		end
	end

	local panCameraKey = getCore():getKey("PanCamera")
	if self.isCollapsed and panCameraKey ~= 0 and isKeyDown(panCameraKey) then
		return
	end

	if not isMouseButtonDown(0) and not isMouseButtonDown(1) and not isMouseButtonDown(2) then
		self.collapseCounter = 0;
		if self.isCollapsed and self:getMouseY() < self:titleBarHeight() then
			self:openPanel()
			if isClient() and not self.onCharacter then
				self.inventoryPane.inventory:requestSync();
			end
		end
	end
end

function ISInventoryPage:onMouseMoveOutside(dx, dy)
	self.mouseOver = false;

	if self.moving then
		self:setX(self.x + dx);
		self:setY(self.y + dy);
	end

	if ISMouseDrag.dragging ~= true and not self.pin and (self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > -self:getHeight()) then
		self.collapseCounter = self.collapseCounter + getGameTime():getMultiplier() / 0.8;
		local bDo = false;
		if ISMouseDrag.dragging == nil then
			bDo = true;
		else
			for i, k in ipairs(ISMouseDrag.dragging) do
				bDo = true;
				break;
			end
		end
		local playerObj = getSpecificPlayer(self.player)
		if playerObj and playerObj:isAiming() then
			self.collapseCounter = 1000
		end
		if ISMouseDrag.dragging and #ISMouseDrag.dragging > 0 then
			bDo = false;
		end
		if self.collapseCounter > 120 and not self.isCollapsed and bDo then
			self:collapsePanel()
		end
	end
end

function ISInventoryPage:onMouseDownOutside(x, y)
	if((self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > self:getHeight()) and  not self.pin) then
		self:collapsePanel()
	end
end
ISInventoryPage.onRightMouseDownOutside = ISInventoryPage.onMouseDownOutside

function ISInventoryPage:RestoreLayout(name, layout)
	ISLayoutManager.DefaultRestoreWindow(self, layout)
	self.isCollapsed = false
	if layout.pin == 'true' then
		self:inverseCollapse()
	elseif layout.invert == 'true' then
		self:collapse()
	else
		self:setPinned()
	end
	self.inventoryPane:RestoreLayout(name, layout)

	if not self.pin then
		self:collapsePanel()
	end
end

function ISInventoryPage:SaveLayout(name, layout)
	ISCollapsableWindow.SaveLayout(self, name, layout)
	self.inventoryPane:SaveLayout(name, layout)
end

function ISInventoryPage:getKeepOnScreen()
	return not (self.isCollapsed and self.doInverseCollapse)
end
