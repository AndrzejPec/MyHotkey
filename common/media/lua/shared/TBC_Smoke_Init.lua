EHK = EHK or {}
TBC = TBC or {}

TBC.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.LighterDisposable",
    [3] = "Base.Matches",
    [4] = "Base.Matchbox",
    [5] = "Base.LighterBBQ",
    [6] = "Base.CandleLit",
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
    [7] = "Base.GlassSmokingPipe_Tobacco",
    [8] = "Base.CanPipe_Tobacco",
    -- Mod Narcotics smokeable items
    [9] = "NnC.BluntAK",
    [10] = "NnC.BluntNorthernLights",
    [11] = "NnC.BluntSourDiesel",
    [12] = "NnC.JointAK",
    [13] = "NnC.JointNorthernLights",
    [14] = "NnC.JointSourDiesel",
    [15] = "NnC.WaterBongAK",
    [16] = "NnC.WaterBongNorthernLights",
    [17] = "NnC.WaterBongSourDiesel",
    [18] = "NnC.WeedPipeAK",
    [19] = "NnC.WeedPipeNorthernLights",
    [20] = "NnC.WeedPipeSourDiesel",
    [21] = "NnC.CanPipeAK",
    [22] = "NnC.CanPipeNorthernLights",
    [23] = "NnC.CanPipeSourDiesel",
    [21] = "NnC.SmokingPipeAK",
    [22] = "NnC.SmokingPipeNorthernLights",
    [23] = "NnC.SmokingPipeSourDiesel",
    -- three items not yet present in the mod, but probably coming
    [24] = "NnC.GlassSmokingPipeAK",
    [25] = "NnC.GlassSmokingPipeNorthernLights",
    [26] = "NnC.GlassSmokingPipeSourDiesel",
    -- Mod Hemp & Tobacco smokeable items
    [27] = "Base.CanPipe_Hemp",
    [28] = "Base.HempCigarillo",
    [29] = "Base.HempCigar",
    [30] = "Base.GlassSmokingPipe_Hemp",
    [31] = "Base.HempCigarette",
    [32] = "Base.SmokingPipe_Hemp",
    -- Mod Cluvius Crack Cigarettes items
    [33] = "CVCrackCigs.CrackCigSingle",
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
