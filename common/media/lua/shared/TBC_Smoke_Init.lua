--***********************************************************
--**               ANDRZEJ PEC (pimatstudio)               **
--**   Definitions of smokable and chewable items          **
--**   + algorithmic check for new items added by mods     **
--***********************************************************

TBC = TBC or {}

TBC.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.LighterDisposable",
    [3] = "Base.Matches",
    [4] = "Base.Matchbox",
    [5] = "Base.LighterBBQ",
    [6] = "Base.CandleLit",
    [7] = "HGO.HGOLighterBBQ"
    -- [6] = "Base.Lantern_HurricaneLit", -- the game won't let to use this item to light cigarettes
    -- although I disagree, it's flame after all, but I go with the game's decision
}

TBC.smokerIsPresent = false

TBC.cigarettes = {
    [1] = "Base.CigaretteSingle",
    [2] = "Base.CigaretteRolled",
    [3] = "Base.Cigar",
    [4] = "Base.Cigarillo",
    [5] = "Base.CigaretteSingle_Clove",
    [6] = "Base.SmokingPipe_Tobacco",
    [7] = "Base.GlassSmokingPipe_Tobacco", -- this is acutally from the mod Hemp & Tobacco
    [8] = "Base.CanPipe_Tobacco",
    -- Mod Narcotics smokeable items
    [9] = "NnC.BluntAK",
    [10] = "NnC.BluntNorthernLights",
    [11] = "NnC.BluntSourDiesel",
    [12] = "NnC.BluntKief",
    [13] = "NnC.JointAK",
    [14] = "NnC.JointNorthernLights",
    [15] = "NnC.JointSourDiesel",
    [16] = "NnC.JointKief",
    [17] = "NnC.CanPipeAK",
    [18] = "NnC.CanPipeNorthernLights",
    [19] = "NnC.CanPipeSourDiesel",
    [20] = "NnC.CanPipeKief",
    [21] = "NnC.SmokingPipeAK",
    [22] = "NnC.SmokingPipeNorthernLights",
    [23] = "NnC.SmokingPipeSourDiesel",
    [24] = "NnC.SmokingPipeKief",
    [25] = "NnC.Pipe1GreenAK",
    [26] = "NnC.Pipe1GreenNL",
    [27] = "NnC.Pipe1GreenSD",
    [28] = "NnC.Pipe1GreenKief",
    [29] = "NnC.Pipe1OrangeAK",
    [30] = "NnC.Pipe1OrangeNL",
    [31] = "NnC.Pipe1OrangeSD",
    [32] = "NnC.Pipe1OrangeKief",
    [33] = "NnC.Pipe1YellowAK",
    [34] = "NnC.Pipe1YellowNL",
    [35] = "NnC.Pipe1YellowSD",
    [36] = "NnC.Pipe1YellowKief",
    [37] = "NnC.Bong1GreenAK",
    [38] = "NnC.Bong1GreenNL",
    [39] = "NnC.Bong1GreenSD",
    [40] = "NnC.Bong1GreenKief",
    [41] = "NnC.Bong2PinkAK",
    [42] = "NnC.Bong2PinkNL",
    [43] = "NnC.Bong2PinkSD",
    [44] = "NnC.Bong2PinkKief",
    [45] = "NnC.Bong2RedAK",
    [46] = "NnC.Bong2RedNL",
    [47] = "NnC.Bong2RedSD",
    [48] = "NnC.Bong2RedKief",
    [49] = "NnC.Bong1RedAK",
    [50] = "NnC.Bong1RedNL",
    [51] = "NnC.Bong1RedSD",
    [52] = "NnC.Bong1RedKief",
    [53] = "NnC.Bong2RainbowAK",
    [54] = "NnC.Bong2RainbowNL",
    [55] = "NnC.Bong2RainbowSD",
    [56] = "NnC.Bong2RainbowKief",
    [57] = "NnC.Bong1PurpleAK",
    [58] = "NnC.Bong1PurpleNL",
    [59] = "NnC.Bong1PurpleSD",
    [60] = "NnC.Bong1PurpleKief",
    [61] = "NnC.BongPokeAK",
    [62] = "NnC.BongPokeNL",
    [63] = "NnC.BongPokeSD",
    [64] = "NnC.BongPokeKief",
    -- absent in the mod but added just in case they are introduced
    [65] = "NnC.GlassSmokingPipeAK",
    [66] = "NnC.GlassSmokingPipeNorthernLights",
    [67] = "NnC.GlassSmokingPipeSourDiesel",
    [68] = "NnC.GlassSmokingPipeKief",
    -- Mod Hemp & Tobacco smokeable items
    [69] = "Base.CanPipe_Hemp",
    [70] = "Base.HempCigarillo",
    [71] = "Base.HempCigar",
    [72] = "Base.GlassSmokingPipe_Hemp",
    [73] = "Base.HempCigarette",
    [74] = "Base.SmokingPipe_Hemp",
    -- Mod Cluvius Crack Cigarettes smokeable items
    [75] = "CVCrackCigs.CrackCigSingle",
    -- Mod ReeferMadness smokeable items
    [76] = "ReeferMadness.SmokingPipe_marijuana",
    [77] = "ReeferMadness.CanPipe_marijuana",
    [78] = "ReeferMadness.WeedCigarette",
    [79] = "ReeferMadness.Joint",
    [80] = "ReeferMadness.blunt",
    [81] = "ReeferMadness.WeedCigarette2",
    -- Mod SupportCorps smokeable items
    [82] = "SupportCorps.StreetJointRolled",
}

TBC.Drugs = {
    [1] = "NnC.CokeBaggie",
    [2] = "NnC.LSD",
    [3] = "NnC.MDMA",
    [4] = "NnC.Oxycodone",
    [5] = "NnC.Ritalin",
    [6] = "NnC.Xanax",
}

TBC.SNUS = {
    [1] = "Base.TobaccoChewing",
    [2] = "SKAL.SkalMint",
    [3] = "SKAL.SkalStraight",
    [4] = "SKAL.SkalWintergreen",
    [5] = "SKAL.SkalBlackshields",
    [6] = "SKAL.HalkenWintergreen",
    [7] = "SKAL.CopingWintergreen",
    [8] = "SKAL.RealManPouch",
    [9] = "SKAL.KojakMint",
    [10] = "SKAL.XenMint",
    [11] = "SKAL.XenCoffee",
    [12] = "Base.HempChewing",
}

TBC.cigarettesPacks = {
    [1] = "Base.CigarettePack",
    [2] = "Base.CigarettePack_Clove",
    [3] = "CVCrackCigs.CrackCigPack",
}

-- apparently "logs" are packs of SNUS tabacco, they provide 5 packs of SNUS (SKAL)
TBC.SNUSlogs = {
    [1] = "SKAL.SkalMintLog",
    [2] = "SKAL.SkalWintergreenLog",
    [3] = "SKAL.SkalStraightLog",
    [4] = "SKAL.BlackshieldsLog",
    [5] = "SKAL.KojakMintLog",
    [6] = "SKAL.CopingWintergreenLog",
    [7] = "SKAL.HalkenWintergreenLog",
    [8] = "SKAL.XenMintLog",
    [9] = "SKAL.XenCoffeeLog",
}

TBC.validRecipes = {
    ["Take Cigarette"] = true,
    ["Unpack Cigarettes"] = true,
}

function TBC:containsItem(list, item)
    if not list then return false end

    for _, v in ipairs(list) do
        if v == item then return true end
    end

    return false
end

function TBC:addItemToDictionary(item)
    if item and not self:containsItem(self.cigarettes, item) and not self:containsItem(self.SNUS, item) then
        table.insert(self.cigarettes, item)
    end
end

function TBC:detectSmokableItems()
    if not getPlayer() then
        return
    end

    local allItems = getScriptManager():getAllItems()
    if not allItems then 
        return
    end

    local itemCount = allItems:size()
    local initialSmokableItemsCount = #self.cigarettes

    for i = 0, itemCount - 1 do
        local item = allItems:get(i)
        if not item then return end
        
        local itemName = item:getName()
        local fullType = item:getFullName()
        local itemType = item:getTypeString()

        local eatType = item:getEatType()
        if eatType and (eatType == "Cigarettes" or eatType == "pipe") then
            self:addItemToDictionary(fullType)
        end

        local tags = item:getTags()
        if tags and tags:contains("Smokable") then
            self:addItemToDictionary(fullType)
        end

        -- we need to spawn an item instance in order to check other conditions since these properties exist for inventoryItem class only
        local inventoryItem = instanceItem(fullType)
        if inventoryItem and itemType == "Food" then
            local onEat = inventoryItem:getOnEat()
            if onEat and (string.find(onEat, "Cigar") or string.find(onEat, "Weed") or string.find(onEat, "Smoke")) then
                self:addItemToDictionary(fullType)
            end

            local customContextMenu = inventoryItem.CustomContextMenu
            if type(customContextMenu) == "string" and string.find(customContextMenu, "Smoke") then
                self:addItemToDictionary(fullType)
            end
        end
    end

    local newItemCount = (#self.cigarettes - initialSmokableItemsCount)

    print('Smokable items count: ' .. #self.cigarettes .. ', there were ' .. newItemCount .. ' added to the list.')
end

Events.OnGameStart.Add(function()
    print("Detecting smokable items on game start...")
    TBC:detectSmokableItems()
end)
