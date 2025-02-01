TBC = TBC or {}

TBC.keyConfigs = {
    putTobaccoInLip = {
        displayName = getText("UI_TBC_optionscreen_binding_putTobaccoInLip"),
        action = TBC.putTobaccoInLip,
        keyCode = Keyboard.KEY_NONE
    },
    smokeTobacco = {
        displayName = getText("UI_TBC_optionscreen_binding_smokeTobacco"),
        action = TBC.smokeTobacco,
        keyCode = Keyboard.KEY_NONE
    },
    -- sitOnTheGround = {
    --     displayName = "Sit on the ground",
    --     action = TBC.sitOnTheGround,
    --     keyCode = Keyboard.KEY_NONE
    -- }
}

local TBC_bind = {}
TBC_bind.value = "[tobaccoMod]"
table.insert(keyBinding, TBC_bind)

for keyVar, cfg in pairs(TBC.keyConfigs) do
    local TBC_keybind = {}
    TBC_keybind.value = keyVar -- Use keyVar as identifier
    TBC_keybind.key = cfg.keyCode
    table.insert(keyBinding, TBC_keybind)
end