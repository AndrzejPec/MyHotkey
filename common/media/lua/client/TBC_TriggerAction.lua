TBC = TBC or {}

function TBC.generateKeyActionsTable()
    local ActionForKey = {}
    for keyVar, cfg in pairs(TBC.keyConfigs) do
        ActionForKey[tostring(getCore():getKey(keyVar))] = cfg.action
    end
    return ActionForKey
end

TBC.triggerAction = function(keyPressed)
    local player = getPlayer()
    if not player then
        -- prevents errors when in main menu
        return
    end
    local ActionForKey = TBC.generateKeyActionsTable()
    local keyPressedString = tostring(keyPressed)
    local action = ActionForKey[keyPressedString]
    if action then
        action(keyPressedString)
    end
end

Events.OnCustomUIKey.Add(TBC.triggerAction)
