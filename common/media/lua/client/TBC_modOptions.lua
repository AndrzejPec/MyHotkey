TBC = TBC or {}  -- Upewnia się, że TBC istnieje
require("PZAPI")  -- Potem wymagamy PZAPI


local config = {
    TBC_cigarettes_1 = nil,
    TBC_cigarettes_2 = nil,
    TBC_cigarettes_3 = nil,
    TBC_lighter_1 = nil,
    TBC_lighter_2 = nil,
    TBC_lighter_3 = nil,
    TBC_display_mode = nil,
}

print("PZAPI loaded:", PZAPI)
print(getText("UI_optionscreen_binding_tobaccoMod"))

function TBC:initModOptions()
    local options = PZAPI.ModOptions:create("myTobaccoHotkeyMod", "Tobacco+ Hotkey")

    -- No cigarettes dialogues
    options:addTitle(getText("UI_options_TBC_no_cigarettes_title"))
    options:addDescription(getText("UI_options_TBC_no_cigarettes_desc"))

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
    options:addTitle(getText("UI_options_TBC_no_lighter_title"))
    options:addDescription(getText("UI_options_TBC_no_lighter_desc"))

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

    options:addSeparator()

    -- Cigarette count display mode
    options:addTitle(getText("UI_options_TBC_display_mode_title"))
    options:addDescription(getText("UI_options_TBC_display_mode_desc"))

    config.TBC_display_mode = options:addComboBox("TBC_display_mode", getText("UI_options_TBC_comboBox"))
    config.TBC_display_mode:addItem(getText("UI_options_TBC_comboBox_1"), true)
    config.TBC_display_mode:addItem(getText("UI_options_TBC_comboBox_2"), false)
end

TBC:initModOptions()

-- Events.OnGameStart.Add(function() 
--     TBC:initModOptions()
-- end)
