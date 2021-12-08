require "ISUI/ISCollapsableWindowJoypad"
require "ISUI/ISCollapsableWindow-pup"

ISCollapsableWindowJoypad.createChildren_pupBase = ISCollapsableWindowJoypad.createChildren
function ISCollapsableWindowJoypad:createChildren()
	self:createChildren_pupBase()
	ISCollapsableWindow.addInverseCollapseButton(self)
end

ISCollapsableWindowJoypad.collapse = ISCollapsableWindow.collapse
ISCollapsableWindowJoypad.inverseCollapse = ISCollapsableWindow.inverseCollapse
ISCollapsableWindowJoypad.pin = ISCollapsableWindow.pin
ISCollapsableWindowJoypad.uncollapse = ISCollapsableWindow.uncollapse
ISCollapsableWindowJoypad.onMouseMoveOutside = ISCollapsableWindow.onMouseMoveOutside
ISCollapsableWindowJoypad.getKeepOnScreen = ISCollapsableWindow.getKeepOnScreen
ISCollapsableWindowJoypad.RestoreLayout = ISCollapsableWindow.RestoreLayout
ISCollapsableWindowJoypad.SaveLayout = ISCollapsableWindow.SaveLayout
ISCollapsableWindowJoypad.collapsePanel = ISCollapsableWindow.collapsePanel
ISCollapsableWindowJoypad.openPanel = ISCollapsableWindow.openPanel
