require "ISUI/ISRadialMenu"
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"

TBC = TBC or {}

local lightDialogues = {
    [1] = getText("IGUI_TBC_light_1"),
    [2] = getText("IGUI_TBC_light_2"),
    [3] = getText("IGUI_TBC_light_3"),
}

local cigarettesDialogues = {
    [1] = getText("IGUI_TBC_cigarettes_1"),
    [2] = getText("IGUI_TBC_cigarettes_2"),
    [3] = getText("IGUI_TBC_cigarettes_3"),
}

function TBC.handleSmokeCigarette(cigarette)
    local player = getPlayer()
    local inv = player:getInventory()
    local fireSource = TBC.getFirstItem(TBC.fireSources, inv)
    local dialogueNo = ZombRand(3) + 1
    if not fireSource then
        player:Say(lightDialogues[dialogueNo])
        return
    end

    if cigarette and cigarette.getFullType then
        local fullType = cigarette:getFullType()
        local item = TBC.getFirstItem({fullType}, inv)
        ISInventoryPaneContextMenu.eatItem(item, 1, 0)
    end
end

function TBC.openSmokingRadial()
    local player = getPlayer()
    local inv = player:getInventory()
    if not player then return end
    local dialogueNo = ZombRand(3) + 1

    -- prevent the radial to appear while...
    -- if player:isSeatedInVehicle() then return end -- in a vehicle
    -- local queue = ISTimedActionQueue.queues[player] -- performing a timed action
    -- if queue and #queue.queue > 0 then return end -- having action queue contain at least one action
    if getCell():getDrag(0) then return end -- game being paused

    local menu = getPlayerRadialMenu(player:getPlayerNum())
    menu:clear()

    -- collecting list of smokeables right before populating the radial menu
    local availableSmokingItems = TBC.getAllItems(TBC.cigarettes, inv) or {}

    if #availableSmokingItems == 1 then
        TBC.handleSmokeCigarette(availableSmokingItems[1])
        return
    elseif #availableSmokingItems > 1 then
        for _, item in ipairs(availableSmokingItems) do
            print(item:getName())
            local icon = item:getTexture() or getTexture("media/ui/cursor_white.png")
            menu:addSlice(item:getName(), icon, function() TBC.handleSmokeCigarette(item) end)
        end
    else
        player:Say(cigarettesDialogues[dialogueNo])
    end
     
    menu:center()
    menu:addToUIManager()

    -- I've no way of testing the mod for a joypad, whatever that is, but I'm leaving it for future generations

    -- if JoypadState.players[player:getPlayerNum() + 1] then
    --     menu:setHideWhenButtonReleased(Joypad.DPadUp)
    --     setJoypadFocus(player:getPlayerNum(), menu)
    --     player:setJoypadIgnoreAimUntilCentered(true)
    -- end
end
