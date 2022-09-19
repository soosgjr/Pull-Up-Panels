require "ISUI/ISCollapsableWindow"

ISCollapsableWindow.createChildren_pupBase = ISCollapsableWindow.createChildren
function ISCollapsableWindow:createChildren()
	self:createChildren_pupBase()
	self:addInverseCollapseButton()
end

function ISCollapsableWindow:collapse()
	self.pin = false;
	self.doInverseCollapse = true;
	self.pinButton:setVisible(false);
	self.collapseButton:setVisible(false);
	if self.inverseCollapseButton ~= nil then
		self.inverseCollapseButton:setVisible(true);
		self.inverseCollapseButton:bringToTop();
	end
end

function ISCollapsableWindow:inverseCollapse()
	self.pin = true;
	self.doInverseCollapse = false;
	self.collapseButton:setVisible(false);
	self.inverseCollapseButton:setVisible(false);
	self.pinButton:setVisible(true);
	self.pinButton:bringToTop();
end

function ISCollapsableWindow:pin()
	self.pin = false;
	self.doInverseCollapse = false;
	self.collapseButton:setVisible(true);
	self.inverseCollapseButton:setVisible(false);
	self.pinButton:setVisible(false);
	self.collapseButton:bringToTop();
end

function ISCollapsableWindow:uncollapse()
	self.collapseCounter = 0;
	if self.isCollapsed and self:getMouseY() < self:titleBarHeight() then
		self:openPanel()
		self.collapseCounter = 0;
	end
end

function ISCollapsableWindow:onMouseMoveOutside(dx, dy)
	self.mouseOver = false;

	if self.moving then
		self:setX(self.x + dx);
		self:setY(self.y + dy);
		self:bringToTop();
	end

	if not self.pin and (self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > self:getHeight()) then
		self.collapseCounter = self.collapseCounter + 1;

		local bDo = true;

		if self.collapseCounter > 20 and not self.isCollapsed and bDo then
			self:collapsePanel()
		end
	end
end

function ISCollapsableWindow:getKeepOnScreen()
	return not (self.isCollapsed and self.doInverseCollapse)
end

function ISCollapsableWindow:RestoreLayout(name, layout)
	if not self.resizable then
		layout.width = nil
		layout.height = nil
	end
	ISLayoutManager.DefaultRestoreWindow(self, layout)
	if layout.pin == 'true' then
		ISCollapsableWindow.inverseCollapse(self)
	elseif layout.invert == 'true' then
		ISCollapsableWindow.collapse(self)
	else
		ISCollapsableWindow.pin(self)
	end
end

function ISCollapsableWindow:SaveLayout(name, layout)
	ISLayoutManager.DefaultSaveWindow(self, layout)
	if self.isCollapsed and self.doInverseCollapse then
		layout.y = layout.y - self:getHeight() + self:titleBarHeight()
	end
	if self.pin then layout.pin = 'true' else layout.pin = 'false' end
	if self.doInverseCollapse then layout.invert = 'true' else layout.invert = 'false' end
end

function ISCollapsableWindow:addInverseCollapseButton()
	self.doInverseCollapse = false;
	self.inverseCollapseButtonTexture = getTexture("media/ui/Panel_Icon_Collapse-pup.png");

	local th = self:titleBarHeight()
	self.inverseCollapseButton = ISButton:new(self.width - th - 3, 0, th, th, "", self, ISCollapsableWindow.inverseCollapse);
	self.inverseCollapseButton.anchorRight = true;
	self.inverseCollapseButton.anchorLeft = false;
	self.inverseCollapseButton:initialise();
	self.inverseCollapseButton.borderColor.a = 0.0;
	self.inverseCollapseButton.backgroundColor.a = 0;
	self.inverseCollapseButton.backgroundColorMouseOver.a = 0;
	self.inverseCollapseButton:setImage(self.inverseCollapseButtonTexture);
	self:addChild(self.inverseCollapseButton);

	self.collapseButton:setVisible(false);
	self.inverseCollapseButton:setVisible(false);
	self.pinButton:setVisible(true);
end

function ISCollapsableWindow:collapsePanel()
	if not self.isCollapsed then
		self.isCollapsed = true
		if self.doInverseCollapse then
			self:setY(self.y + self:getHeight() - self:titleBarHeight())
		end
	end
	self:setMaxDrawHeight(self:titleBarHeight())
end

function ISCollapsableWindow:openPanel()
	if self.isCollapsed then
		if self.doInverseCollapse then
			self:setY(self.y - self:getHeight() + self:titleBarHeight())
		end
		self.isCollapsed = false
	end
	self:clearMaxDrawHeight()
	self.collapseCounter = 0
end
