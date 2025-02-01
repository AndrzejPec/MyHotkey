TBC = TBC or {}

TBC.keyConfigs = {
    putTobaccoInLip = {
        displayName = "Put a snus/chew in lip",
        action = TBC.putTobaccoInLip,
        keyCode = Keyboard.KEY_NONE
    },
    smokeTobacco = {
        displayName = "Smoke tobacco",
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
    TBC_bind = {}
    TBC_bind.value = keyVar -- Use keyVar as identifier
    TBC_bind.key = cfg.keyCode
    table.insert(keyBinding, TBC_bind)
end