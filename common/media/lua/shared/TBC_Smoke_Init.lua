EHK = EHK or {}
TBC = TBC or {}

TBC.fireSources = {
    [1] = "Base.Lighter",
    [2] = "Base.LighterDisposable",
    [3] = "Base.Matches",
    [4] = "Base.Matchbox",
    [5] = "Base.CandleLit",
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
    -- Mod Hemp & Tobacco smokeable items
    [24] = "Base.CanPipe_Hemp",
    [25] = "Base.HempCigarillo",
    [26] = "Base.HempCigar",
    [27] = "Base.GlassSmokingPipe_Hemp",
    [28] = "Base.HempCigarette",
    [29] = "Base.SmokingPipe_Hemp",
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
    [2] = "Base.SkalMint",
    [3] = "Base.SkalStraight",
    [4] = "Base.SkalWintergreen",
    [5] = "Base.SkalBlackshields",
    [6] = "Base.HalkenWintergreen",
    [7] = "Base.CopingWintergreen",
    [8] = "Base.RealManPouch",
    [9] = "Base.KojakMint",
    [10] = "Base.XenMint",
    [11] = "Base.XenCoffee",
    [12] = "Base.HempChewing",
}

TBC.cigarettesPacks = {
    [1] = "Base.CigarettePack",
    [2] = "Base.CigarettePack_Clove",
    [3] = "CVCrackCigs.CrackCigPack",
}

-- apparently "logs" are packs of SNUS tabacco, they provide 5 packs of SNUS (SKAL)
TBC.SNUSlogs = {
    [1] = "Base.SkalMintLog",
    [2] = "Base.SkalWintergreenLog",
    [3] = "Base.SkalStraightLog",
    [4] = "Base.BlackshieldsLog",
    [5] = "Base.KojakMintLog",
    [6] = "Base.CopingWintergreenLog",
    [7] = "Base.HalkenWintergreenLog",
    [8] = "Base.XenMintLog",
    [9] = "Base.XenCoffeeLog",
}

TBC.validRecipes = {
    ["Take Cigarette"] = true,
    ["Unpack Cigarettes"] = true,
}
