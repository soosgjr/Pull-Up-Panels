require "ISUI/ISInventoryPaneContextMenu"

ISInventoryPaneContextMenu.onPlaceItemOnGround = function(items, playerObj)
    local playerNum = playerObj:getPlayerNum()
    local inventoryUI = getPlayerInventory(playerNum)
    local lootUI = getPlayerLoot(playerNum)
    if playerObj:getJoypadBind() ~= -1 and inventoryUI:isVisible() then
        updateJoypadFocus(JoypadState.players[playerNum+1])
        setJoypadFocus(playerNum, nil)
    end
    if inventoryUI:isVisible() and not inventoryUI.isCollapsed and not inventoryUI.pin then
        inventoryUI:collapsePanel()
    end
    if lootUI:isVisible() and not lootUI.isCollapsed and not lootUI.pin then
        lootUI:collapsePanel()
    end
    ISInventoryPaneContextMenu.placeItemCursor = ISPlace3DItemCursor:new(playerObj, items)
    getCell():setDrag(ISInventoryPaneContextMenu.placeItemCursor, playerNum)
end
