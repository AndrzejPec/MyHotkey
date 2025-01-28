require "TimedActions/ISBaseTimedAction"

TBC.TransferItemsBack = function(item)
    local player = getPlayer()
    local inv = player:getInventory()
    local sourceContainer = item:getContainer()
    local transferItemBack = ISInventoryTransferAction:new(player, item, inv, sourceContainer)
    ISTimedActionQueue.add(transferItemBack)
end