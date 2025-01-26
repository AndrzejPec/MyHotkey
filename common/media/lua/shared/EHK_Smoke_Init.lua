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
    [7] = "CVCrackCigs.CrackCigSingle",
    -- [9] = "Base.TobaccoLoose", -- loose tobacco is not an edible item, since it is only used in recipe for rolled cigarettes
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
