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

-- function TBC:scanForSmokableItemsInInventory()
--     local player = getPlayer()
--     if not player then
--         print("❌ Błąd: Nie znaleziono gracza!")
--         return
--     end

--     local inventory = player:getInventory()
--     if not inventory then
--         print("❌ Błąd: Gracz nie ma ekwipunku? Coś tu nie gra!")
--         return
--     end

--     local allItems = inventory:getItems()
--     if not allItems or allItems:size() == 0 then
--         print("📭 Ekwipunek pusty, nic do skanowania!")
--         return
--     end

--     print("📌 Znaleziono " .. allItems:size() .. " przedmiotów w ekwipunku!")

--     for i = 1, allItems:size() do
--         local item = allItems:get(i-1)
--         if item then
--             local scriptItem = item:getScriptItem()
--             if scriptItem then
--                 local eatType = scriptItem:getEatType()
--                 if eatType then
--                     print("🍽️ Przedmiot " .. item:getName() .. " ma EatType: " .. eatType)
--                     -- Dodatkowa logika dla przedmiotów z określonym EatType
--                 else
--                     print("🔹 Przedmiot " .. item:getName() .. " nie ma zdefiniowanego EatType.")
--                 end
--             else
--                 print("⛔ Przedmiot " .. item:getName() .. " nie ma skryptu, pomijam.")
--             end
--         else
--             print("⚠️ Przedmiot na indeksie " .. (i-1) .. " jest nil, pomijam.")
--         end
--     end
-- end


function TBC:scanWithFactory()
    local allItems = getScriptManager():getAllItems()

    if not allItems then
        print("❌ Błąd: getScriptManager():getAllItems() zwróciło `nil`!")
        return
    end

    local itemCount = allItems:size()
    print("📌 Znaleziono " .. itemCount .. " przedmiotów w grze!")

    for i = 1, itemCount do
        local item = allItems:get(i - 1)

        if item then
            local fullType = item:getFullName()
            local inventoryItem = instanceItem(fullType)
            local itemType = item:getTypeString()

            if itemType == "Food" then
                if inventoryItem then
                    local onEat = inventoryItem:getOnEat()
                    if onEat and string.find(onEat, "Cigar") then
                        print("🚬 Przedmiot \"" .. inventoryItem:getName() .. "\" ma OnEat zawierające 'Cigar'.")
                        -- Dodatkowa logika dla znalezionych przedmiotów
                    end
                else
                    print("⚠️ Nie udało się utworzyć InventoryItem dla: " .. fullType)
                end
            end
        else
            print("⚠️ Przedmiot na indeksie " .. (i - 1) .. " jest nil, pomijam.")
        end
    end
end
    


function TBC:scanForCigaretteItems()
    local allItems = getScriptManager():getAllItems()

    if not allItems then
        print("❌ Błąd: getScriptManager():getAllItems() zwróciło `nil`!")
        return
    end

    local itemCount = allItems:size()
    print("📌 Znaleziono " .. itemCount .. " przedmiotów w grze!")

    for i = 0, itemCount - 1 do
        local item = allItems:get(i)
        local isSmokable = false

        if item then
            -- local eatType = item:getEatType()
            -- if eatType and eatType == "Cigarettes" then
            --     local itemName = item:getName() or "Brak nazwy"
            --     print("🚬 Przedmiot \"" .. itemName .. "\" ma EatType ustawione na 'Cigarettes'.")
            --     -- Tutaj możesz dodać dodatkową logikę dla znalezionych przedmiotów
            -- end
            -- local tags = item:getTags()
            -- if tags and tags:contains("Smokable") then
            --     isSmokable = true
            --     print("🚬 Przedmiot \"" .. item:getName() .. "\" posiada tag 'Smokable'.")
            -- end
            -- local itemType = item:getTypeString()
            -- local scriptItem = item:getScriptItem()

            -- if scriptItem:getOnEat() then
            --     local onEat = item:getOnEat()
            --     print(item:getFullType())
            -- end
            -- if itemType == "Food" and item:getOnEat() and string.find(onEat, "Cigar") then
            --     local onEat = item:getOnEat()
            --     if onEat and string.find(onEat, "Cigar") then
            --         print("🚬 Przedmiot \"" .. item:getName() .. "\" ma OnEat ustawione na '" .. onEat .. "' i jest typu 'Food'.")
            --         -- Tutaj możesz dodać dodatkową logikę dla znalezionych przedmiotów
            --     end
            -- end
        else
            print("⚠️ Przedmiot na indeksie " .. i .. " jest nil, pomijam.")
        end
    end
end



-- function TBC:scanForSmokableItems()
--     local player = getPlayer()
--     if not player then
--         print("❌ Błąd: Nie znaleziono gracza!")
--         return
--     end

--     local inventory = player:getInventory()
--     if not inventory then
--         print("❌ Błąd: Gracz nie ma ekwipunku? Coś tu nie gra!")
--         return
--     end

--     local allItems = inventory:getItems()
--     if not allItems or allItems:size() == 0 then
--         print("📭 Ekwipunek pusty, nic do skanowania!")
--         return
--     end

--     print("📌 Znaleziono " .. allItems:size() .. " przedmiotów w ekwipunku!")

--     for i = 1, allItems:size() do
--         local item = allItems:get(i - 1)
--         if item then
--             local scriptItem = item:getScriptItem()
--             if scriptItem then
--                 local itemType = scriptItem:getType()
--                 print(itemType)
--                 if itemType == "Food" then
--                     print("🍎 Przedmiot " .. item:getName() .. " jest typu Food.")
--                     -- Dodatkowa logika dla przedmiotów typu Food
--                 else
--                     print("🔹 Przedmiot " .. item:getName() .. " nie jest typu Food. Typ: " .. itemType)
--                 end
--             else
--                 print("⚠️ Przedmiot " .. item:getName() .. " nie ma skryptu, pomijam.")
--             end
--         else
--             print("⚠️ Przedmiot na indeksie " .. (i - 1) .. " jest nil, pomijam.")
--         end
--     end
-- end


-- function TBC:scanForSmokableItems()
--     local player = getPlayer()
--     if not player then
--         print("❌ Błąd: Nie znaleziono gracza!")
--         return
--     end

--     local inventory = player:getInventory()
--     if not inventory then
--         print("❌ Błąd: Nie znaleziono ekwipunku gracza!")
--         return
--     end

--     local allItems = inventory:getItems()
--     local itemCount = allItems:size()
--     print("📌 Znaleziono " .. itemCount .. " przedmiotów w ekwipunku gracza!")

--     local nextIndex = #self.cigarettes + 1 -- Licznik nowych pozycji

--     for i = 0, itemCount - 1 do
--         local item = allItems:get(i)

--         if item then
--             local fullType = item:getFullType()
--             local properties = item:getModData()
--             local isSmokable = false
--             local itemType = item:getType()
--             print('Item' .. fullType .. ' ma typ ' .. itemType)

--             if item:getEatType() then
--                 local eatType = item:getEatType()
--                 print('Zaś jego eattype jest ' .. eatType)
--             end
--             -- Sprawdzenie właściwości OnEat
--             if properties and properties.OnEat then
--                 local onEat = string.lower(properties.OnEat)
--                 if string.find(onEat, "cigar", 1, true) or string.find(onEat, "weed", 1, true) then
--                     isSmokable = true
--                 end
--             end

--             -- Sprawdzenie właściwości EatType
--             if not isSmokable and properties and properties.EatType then
--                 local eatType = properties.EatType
--                 if eatType == "pipe" or eatType == "Cigarettes" then
--                     isSmokable = true
--                 end
--             end

--             -- Sprawdzenie tagów
--             if not isSmokable and properties and properties.Tags then
--                 local tags = properties.Tags:split(";")
--                 for _, tag in ipairs(tags) do
--                     if tag == "Smokable" then
--                         isSmokable = true
--                         break
--                     end
--                 end
--             end

--             -- Dodanie do listy, jeśli nie istnieje
--             if isSmokable then
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
--             end
--         end
--     end

--     print("✅ Skrypt zakończony! Wykryto " .. #self.cigarettes .. " smokable items w ekwipunku gracza.")
-- end





-- if TBC and TBC.scanForSmokableItems then
--     Events.OnGameStart.Add(function() TBC:scanForSmokableItems() end)
-- else
--     print("❌ Błąd: Funkcja scanForSmokableItems() nie istnieje w momencie rejestracji eventu!")
-- end
