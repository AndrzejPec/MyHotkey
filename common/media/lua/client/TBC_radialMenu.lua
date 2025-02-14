require "ISUI/ISRadialMenu"
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"
require "TBC_Smoking"

TBC = TBC or {}

local function loadDialogues()
    local options = PZAPI.ModOptions:getOptions("myTobaccoHotkeyMod")
    cigarettesDialogues = {
        [1] = options:getOption("TBC_cigarettes_1"):getValue(),
        [2] = options:getOption("TBC_cigarettes_2"):getValue(),
        [3] = options:getOption("TBC_cigarettes_3"):getValue(),
    }
    lightDialogues = {
        [1] = options:getOption("TBC_lighter_1"):getValue(),
        [2] = options:getOption("TBC_lighter_2"):getValue(),
        [3] = options:getOption("TBC_lighter_3"):getValue(),
    }
end

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
    local dialogueNo = ZombRand(#cigarettesDialogues) + 1

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

Events.OnGameStart.Add(loadDialogues)