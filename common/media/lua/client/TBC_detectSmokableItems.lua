TBC = TBC or {}

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

-- function TBC:scanForSmokableItems()
--     local allItems = getScriptManager():getAllItems()
--     if not allItems then return end

--     local nextIndex = #self.cigarettes + 1 -- Licznik nowych pozycji

--     print("🔍 Skanuję przedmioty w poszukiwaniu smokable items...")
    
--     if type(allItems) ~= "table" then
--         print("❌ Błąd: getScriptManager():getAllItems() nie zwróciło tabeli!")
--         return
--     end

--     for _, item in pairs(allItems) do
--         local properties = item:getModData()
--         if properties then
--             local isSmokable = false

--             if properties.OnEat then
--                 local onEat = string.lower(properties.OnEat)
--                 if string.find(onEat, "cigar", 1, true) or string.find(onEat, "weed", 1, true) then
--                     isSmokable = true
--                 end
--             end

--             if not isSmokable and properties.EatType then
--                 local eatType = properties.EatType
--                 if eatType == "pipe" or eatType == "Cigarettes" then
--                     isSmokable = true
--                 end
--             end

--             if not isSmokable and properties.Tags then
--                 local tags = properties.Tags:split(";")
--                 for _, tag in ipairs(tags) do
--                     if tag == "Smokable" then
--                         isSmokable = true
--                         break
--                     end
--                 end
--             end

--             -- Wykluczamy produkty do żucia (jeśli już oznaczyliśmy jako smokable)
--             -- if isSmokable and properties.Tags then
--             --     local tags = properties.Tags:split(";")
--             --     for _, tag in ipairs(tags) do
--             --         if tag == "ChewingTobacco" then
--             --             isSmokable = false
--             --             break
--             --         end
--             --     end
--             -- end

--             if isSmokable then
--                 local fullType = item:getFullType()
--                 local exists = false

--                 for _, v in pairs(self.cigarettes) do
--                     if v == fullType then
--                         exists = true
--                         break
--                     end
--                 end

--                 if not exists then
--                     self.cigarettes[nextIndex] = fullType
--                     print("✅ Dodano: " .. fullType)
--                     nextIndex = nextIndex + 1
--                 else
--                     print("⚠️ Już istnieje: " .. fullType)
--                 end

--                 -- Dodatkowy debug print: sprawdzamy, jaki jest fullType
--                 print("ℹ️ Pełny typ przedmiotu: " .. fullType)
--             end
--         end
--     end

--     print("✅ Skrypt zakończony! Wykryto " .. #self.cigarettes .. " smokable items.")
-- end

function TBC:scanForSmokableItems()
    local player = getPlayer()
    if not player then
        print("❌ Błąd: Nie znaleziono gracza!")
        return
    end

    local inventory = player:getInventory()
    if not inventory then
        print("❌ Błąd: Gracz nie ma ekwipunku? Coś tu nie gra!")
        return
    end

    local allItems = inventory:getItems()

    if not allItems or allItems:size() == 0 then
        print("📭 Ekwipunek pusty, nic do skanowania!")
        return
    end

    print("📌 Znaleziono " .. allItems:size() .. " przedmiotów w ekwipunku!")

    local nextIndex = #self.cigarettes + 1 

    for i = 1, allItems:size() do
        local item = allItems:get(i-1) 
        print('🛠 Procesowany AJTEM namber ' .. i)

        if not item then
            print('⚠️ Item jest nil, pomijam!')
            -- Przechodzimy do następnego przedmiotu
            goto continue
        end

        local fullType = item:getFullType()
        print('📦 Fulltajp ajtema: ' .. fullType)

        local properties = item:getModData()
        if not properties then
            print('⛔ Ajtem nie ma PROPERTISUW, pomijam.')
            -- Pomijamy przedmiot
            goto continue
        end

        local isSmokable = false

        -- Sprawdzamy czy item ma właściwość OnEat sugerującą, że jest do palenia
        if properties.OnEat then
            local onEat = string.lower(properties.OnEat)
            if string.find(onEat, "cigar", 1, true) or string.find(onEat, "weed", 1, true) then
                isSmokable = true
            end
        end

        -- Sprawdzamy czy to fajki lub fajki wodne
        if not isSmokable and properties.EatType then
            local eatType = properties.EatType
            if eatType == "pipe" or eatType == "Cigarettes" then
                isSmokable = true
            end
        end

        -- Sprawdzamy tagi
        if not isSmokable and properties.Tags then
            local tags = properties.Tags:split(";")
            for _, tag in ipairs(tags) do
                if tag == "Smokable" then
                    isSmokable = true
                    break -- Możemy przerwać pętlę, bo już wiemy, że item jest smokable
                end
            end
        end

        -- Jeśli przedmiot nie jest smokable, pomijamy go
        if not isSmokable then
            print("🚫 " .. fullType .. " nie nadaje się do palenia.")
            goto continue
        end

        -- Sprawdzamy, czy przedmiot już istnieje na liście
        local exists = false
        for _, v in pairs(self.cigarettes) do
            if v == fullType then
                exists = true
                break
            end
        end

        if not exists then
            self.cigarettes[nextIndex] = fullType
            print("✅ Dodano: " .. fullType)
            nextIndex = nextIndex + 1
        else
            print("⚠️ Już istnieje: " .. fullType)
        end

        ::continue::
    end

    print("next-index jest " .. nextIndex .. ", co co co cnie kurwa")
    print("✅ Skrypt zakończony! Wykryto " .. (#self.cigarettes - 82) .. " smokable items w ekwipunku.")
end


-- if TBC and TBC.scanForSmokableItems then
--     Events.OnGameStart.Add(function() TBC:scanForSmokableItems() end)
-- else
--     print("❌ Błąd: Funkcja scanForSmokableItems() nie istnieje w momencie rejestracji eventu!")
-- end
