require "ISUI/ISCollapsableWindow"
require "ISUI/ISCollapsableWindowJoypad"
require "ISUI/ISInventoryPage"

function ISCollapsableWindow:clearMaxDrawHeight()
	if self.javaObject == nil then
		self:instantiate();
	end

	if self:isMaxDrawHeightCleared() then
		return nil;
	else
		local pulledUpY = self:getY() - self:getHeight() + self:getMaxDrawHeight();
		local isCloserToBottom = pulledUpY > getCore():getScreenHeight() - self:getY() - self:getHeight();
		if isCloserToBottom then
			self:setY(pulledUpY);
		end

		local result = self.javaObject:clearMaxDrawHeight();
		return result;
	end
end
ISCollapsableWindowJoypad.clearMaxDrawHeight = ISCollapsableWindow.clearMaxDrawHeight;
ISInventoryPage.clearMaxDrawHeight = ISCollapsableWindow.clearMaxDrawHeight;

function ISCollapsableWindow:isMaxDrawHeightCleared()
	if self.javaObject == nil then
		return false;
	else
		return self:getMaxDrawHeight() < 0;
	end
end
ISCollapsableWindowJoypad.isMaxDrawHeightCleared = ISCollapsableWindow.isMaxDrawHeightCleared;
ISInventoryPage.isMaxDrawHeightCleared = ISCollapsableWindow.isMaxDrawHeightCleared;

function ISCollapsableWindow:getKeepOnScreen()
	return self:isMaxDrawHeightCleared();
end
ISCollapsableWindowJoypad.getKeepOnScreen = ISCollapsableWindow.getKeepOnScreen;
ISInventoryPage.getKeepOnScreen = ISCollapsableWindow.getKeepOnScreen;

ISInventoryPage.RestoreLayout_pupBase = ISInventoryPage.RestoreLayout;
function ISInventoryPage:RestoreLayout(name, layout)
	self:clearMaxDrawHeight();
	self:RestoreLayout_pupBase(name, layout);
	self:setMaxDrawHeight(self:titleBarHeight());
end

ISCollapsableWindow.SaveLayout_pupBase = ISCollapsableWindow.SaveLayout;
function ISCollapsableWindow:SaveLayout(name, layout)
	self:clearMaxDrawHeight();
	self:SaveLayout_pupBase(name, layout);
end
ISCollapsableWindowJoypad.SaveLayout = ISCollapsableWindow.SaveLayout;

ISInventoryPage.SaveLayout_pupBase = ISInventoryPage.SaveLayout;
function ISInventoryPage:SaveLayout(name, layout)
	self:clearMaxDrawHeight();
	self:SaveLayout_pupBase(name, layout);
end

function ISCollapsableWindow:setMaxDrawHeight(height)
	if self.javaObject == nil then
		self:instantiate();
	end

	if self:isMaxDrawHeightCleared() then
		local isCloserToBottom = self:getY() > getCore():getScreenHeight() - self:getY() - self:getHeight();
		local result = self.javaObject:setMaxDrawHeight(height);

		if isCloserToBottom then
			local newY = self:getY() + self:getHeight() - self:getMaxDrawHeight();
			self:setY(newY);
		end

		return result;
	else
		return nil;
	end
end
ISCollapsableWindowJoypad.setMaxDrawHeight = ISCollapsableWindow.setMaxDrawHeight;
ISInventoryPage.setMaxDrawHeight = ISCollapsableWindow.setMaxDrawHeight
