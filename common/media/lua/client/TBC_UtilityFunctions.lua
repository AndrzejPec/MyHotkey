require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "DebugUIs/DebugScenarios"

function dawajFajki()
    local player = getPlayer()
    local inv = player:getInventory()

    local itemsToAdd = {
        "Base.Lighter",
        "Base.CigaretteSingle",
        "Base.Cigarillo",
        "Base.Cigar",
        "Base.CigaretteRolled"
    }

    for _, itemType in ipairs(itemsToAdd) do
        for i = 1, 2 do
            inv:AddItem(itemType)
        end
    end
end

print("[DEBUG] Dodano po 2 sztuki każdego przedmiotu do ekwipunku!")


-- function TBC.TransferItemBackToContainer(item, originalContainer)
--     if not item or not originalContainer then
--         print("[ERROR] Brak przedmiotu lub oryginalnego kontenera.")
--         return
--     end

--     local player = getPlayer()
--     local currentContainer = item:getContainer()

--     if currentContainer ~= originalContainer then
--         print(string.format("[DEBUG] Przenoszenie SNUS: %s z %s do %s", item:getName(), currentContainer:getType(), originalContainer:getType()))
--         ISTimedActionQueue.add(ISInventoryTransferAction:new(player, item, currentContainer, originalContainer))
--     end
-- end

TBC.TransferItemsBack = function(item)
    local player = getPlayer()
    local inv = player:getInventory()
    local sourceContainer = item:getContainer()
    local transferItemBack = ISInventoryTransferAction:new(player, item, inv, sourceContainer)
    ISTimedActionQueue.add(transferItemBack)
end

TBC.getInv = function()
    local player = getPlayer()
    local inv = player:getInventory()

    return inv
end

function TBC.onGameStart()
    if selectedDebugScenario ~= nil then
        dawajFajki()
    end
end


Events.OnGameStart.Add(TBC.onGameStart)
