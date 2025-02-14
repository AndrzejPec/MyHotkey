local config = {
    TBC_cigarettes_1 = nil,
    TBC_cigarettes_2 = nil,
    TBC_cigarettes_3 = nil,
    TBC_lighter_1 = nil,
    TBC_lighter_2 = nil,
    TBC_lighter_3 = nil
}

function TBC:initModOptions()
    local options = PZAPI.ModOptions:create("myTobaccoHotkeyMod", "Tobacco+ Hotkey")

    -- No cigarettes dialogues
    options:addTitle("No cigarettes dialogues")
    options:addDescription("You can specify your own dialogues for when there are no cigarettes found in the inventory")

    config.TBC_cigarettes_1 = options:addTextEntry(
        "TBC_cigarettes_1",
        "Dialogue - no cigarettes 1",
        getText("UI_options_TBC_cigarettes_1_textEntry")
    )
    config.TBC_cigarettes_2 = options:addTextEntry(
        "TBC_cigarettes_2",
        "Dialogue - no cigarettes 2",
        getText("UI_options_TBC_cigarettes_2_textEntry")
    )
    config.TBC_cigarettes_3 = options:addTextEntry(
        "TBC_cigarettes_3",
        "Dialogue - no cigarettes 3",
        getText("UI_options_TBC_cigarettes_3_textEntry")
    )

    -- No lighter dialogues
    options:addTitle("No lighter dialogues")
    options:addDescription("You can specify your own dialogues for when there is no lighter found in the inventory")

    config.TBC_lighter_1 = options:addTextEntry(
        "TBC_lighter_1",
        "Dialogue - no lighter 1",
        getText("UI_options_TBC_lighter_1_textEntry")
    )
    config.TBC_lighter_2 = options:addTextEntry(
        "TBC_lighter_2",
        "Dialogue - no lighter 2",
        getText("UI_options_TBC_lighter_2_textEntry")
    )
    config.TBC_lighter_3 = options:addTextEntry(
        "TBC_lighter_3",
        "Dialogue - no lighter 3",
        getText("UI_options_TBC_lighter_3_textEntry")
    )
end

TBC:initModOptions()
