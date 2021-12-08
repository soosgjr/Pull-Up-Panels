require "TimedActions/ISOpenContainerTimedAction"

function ISOpenContainerTimedAction:perform()
    -- First, roll on contents.
    if not self.container:isExplored() then
        if not isClient() then
            ItemPicker.fillContainer(self.container, self.character);
        else
            self.container.inventory:requestServerItemsForContainer();
        end
        self.container:setExplored(true);
    end

    if ISContainerPanelInstance == nil then
        local panel2 = ISInventoryPage:new(ISInventoryPage.playerInventory:getX()+ISInventoryPage.playerInventory:getWidth()+2, ISInventoryPage.playerInventory:getY(), 260, 120, self.container, false);
        ISContainerPanelInstance = panel2;
        local min = getCore():getScreenWidth() - panel2.width;
        if(self.x > min) then
            panel2:setX(min);
        end
        min = getCore():getScreenHeight() - panel2.height;
        if(self.y > min) then
            panel2:setY(min);
        end
     --   panel2:setNewContainer(self.container);
        panel2:setVisible(true);
        panel2:initialise();
        panel2:addToUIManager();
        panel2.lootAll:setVisible(true);

    else
        local panel2 = ISContainerPanelInstance;

        panel2:setNewContainer(self.container);
        panel2:setVisible(true);
        panel2.lootAll:setVisible(true);
        panel2.collapseCounter = 0;
        if panel2.isCollapsed then
            panel2:openPanel()
            panel2.collapseCounter = -40;
        end
    end

    ISBaseTimedAction.perform(self);
end
