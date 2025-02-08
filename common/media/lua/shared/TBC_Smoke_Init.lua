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
    [12] = "NnC.BluntKief",
    [13] = "NnC.JointAK",
    [14] = "NnC.JointNorthernLights",
    [15] = "NnC.JointSourDiesel",
    [16] = "NnC.JointKief",
    [17] = "NnC.WaterBongAK",
    [18] = "NnC.WaterBongNorthernLights",
    [19] = "NnC.WaterBongSourDiesel",
    [20] = "NnC.WeedPipeAK",
    [21] = "NnC.WeedPipeNorthernLights",
    [22] = "NnC.WeedPipeSourDiesel",
    [23] = "NnC.CanPipeAK",
    [24] = "NnC.CanPipeNorthernLights",
    [25] = "NnC.CanPipeSourDiesel",
    [26] = "NnC.CanPipeKief",
    [27] = "NnC.SmokingPipeAK",
    [28] = "NnC.SmokingPipeNorthernLights",
    [29] = "NnC.SmokingPipeSourDiesel",
    [30] = "NnC.SmokingPipeKief",
    [31] = "NnC.Pipe1GreenAK",
    [32] = "NnC.Pipe1GreenNL",
    [33] = "NnC.Pipe1GreenSD",
    [34] = "NnC.Pipe1GreenKief",
    [35] = "NnC.Bong1GreenAK",
    [36] = "NnC.Bong1GreenNL",
    [37] = "NnC.Bong1GreenSD",
    [38] = "NnC.Bong1GreenKief",
    [39] = "NnC.Bong2PinkAK",
    [40] = "NnC.Bong2PinkNL",
    [41] = "NnC.Bong2PinkSD",
    [42] = "NnC.Bong2PinkKief",
    [43] = "NnC.Bong2RedAK",
    [44] = "NnC.Bong2RedNL",
    [45] = "NnC.Bong2RedSD",
    [46] = "NnC.Bong2RedKief",
    [47] = "NnC.Bong1RedAK",
    [48] = "NnC.Bong1RedNL",
    [49] = "NnC.Bong1RedSD",
    [50] = "NnC.Bong1RedKief",
    [51] = "NnC.Bong2RainbowAK",
    [52] = "NnC.Bong2RainbowNL",
    [53] = "NnC.Bong2RainbowSD",
    [54] = "NnC.Bong2RainbowKief",
    [55] = "NnC.Bong1PurpleAK",
    [56] = "NnC.Bong1PurpleNL",
    [57] = "NnC.Bong1PurpleSD",
    [58] = "NnC.Bong1PurpleKief",
    [59] = "NnC.BongPokeAK",
    [60] = "NnC.BongPokeNL",
    [61] = "NnC.BongPokeSD",
    [62] = "NnC.BongPokeKief",
    -- absent in the mod but added just in case they are introduced
    [63] = "NnC.GlassSmokingPipeAK",
    [64] = "NnC.GlassSmokingPipeNorthernLights",
    [65] = "NnC.GlassSmokingPipeSourDiesel",
    [66] = "NnC.GlassSmokingPipeKief",
    -- Mod Hemp & Tobacco smokeable items
    [67] = "Base.CanPipe_Hemp",
    [68] = "Base.HempCigarillo",
    [69] = "Base.HempCigar",
    [70] = "Base.GlassSmokingPipe_Hemp",
    [71] = "Base.HempCigarette",
    [72] = "Base.SmokingPipe_Hemp",
    -- Mod Cluvius Crack Cigarettes smokeable items
    [73] = "CVCrackCigs.CrackCigSingle",
    -- Mod ReeferMadness smokeable items
    [74] = "ReeferMadness.SmokingPipe_marijuana",
    [75] = "ReeferMadness.CanPipe_marijuana",
    [76] = "ReeferMadness.WeedCigarette",
    [77] = "ReeferMadness.Joint",
    [78] = "ReeferMadness.blunt",
    [79] = "ReeferMadness.WeedCigarette2",
    -- Mod SupportCorps smokeable items
    [80] = "SupportCorps.StreetJointRolled",
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
