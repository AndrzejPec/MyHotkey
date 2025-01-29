function TBC.takePills(fullType)
    local player = getPlayer()
    local inv = player:getInventory()
    local pills = inv:getFirstTypeRecurse(fullType)
    if pills then
        ISInventoryPaneContextMenu.takePill(pills, 0)
        TBC.TransferItemsBack(pills)
    else
        player:Say("I'm out of pills! Goddamn it!")
    end
end

function TBC.takeBetaBlockers()
    TBC.takePills("Base.PillsBeta")
end
function TBC.takePainKillers()
    TBC.takePills("Base.Pills")
end
function TBC.takeVitamins()
    TBC.takePills("Base.PillsVitamins")
end
