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
    
function TBC:scanForSmokableItems()
    local smokables = {}
    local allItems = getScriptManager():getAllItems()

    if not allItems then return end

    local itemCount = allItems:size()

    for i = 0, itemCount - 1 do
        local item = allItems:get(i)

        if not item then return end
        
        local itemName = item:getName()
        local fullType = item:getFullName()
        local itemType = item:getTypeString()
        local inventoryItem = instanceItem(fullType)

        local isSmokable = false

        -- Warunek 1: EatType == "Cigarettes"
        local eatType = item:getEatType()
        if eatType and eatType == "Cigarettes" then
            print("🚬 Przedmiot \"" .. itemName .. "\" ma EatType ustawione na 'Cigarettes'.")
            print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 1. warunku")
            isSmokable = true
        end

        -- Warunek 2: Przedmiot ma tag "Smokable"
        local tags = item:getTags()
        if not isSmokable and tags and tags:contains("Smokable") then
            isSmokable = true
            print("🚬 Przedmiot \"" .. itemName .. "\" posiada tag 'Smokable'.")
            print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 2. warunkełe")
        end

        -- Warunek 3 i 4: OnEat lub CustomContextMenu zawiera odpowiednie frazy
        if not isSmokable and itemType == "Food" then
            if inventoryItem then
                local onEat = inventoryItem:getOnEat()

                if onEat and string.find(onEat, "Cigar") then
                    print("🚬 Przedmiot \"" .. itemName .. "\" ma OnEat zawierające 'Cigar'.")
                    print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 3. warunkszfiucie")
                end

                local customContextMenu = inventoryItem:CustomContextMenu()
                
                if not isSmokable and customContextMenu and string.find(customContextMenu, "Smoke") then
                    print("🚬 Przedmiot \"" .. itemName .. "\" ma CustomContextMenu zawierające 'Smoke'.")
                    print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 4. warunkszfiutsenie")
                end
            end
        end

        if isSmokable then
            table.insert(smokables, item)
        end
    end
    print('Łonczna liczba wykrytych SMOŁKABULSÓW wynosi ' .. #smokables)

    return smokables
end

-- I've developed an algorithm that should ensure - more or less - an future-proof - further or shorter - onward compatibility with mods that would be created in the future. After having added manually nearly a 100 items introduced by differnt mods that I'd decided to support (on top of all the items from the base game) I kind of grew tired with all the labour it took to keep the existing dictionary of smokable items up to date with what modders every now and then add to the game. And so...

-- So here's a quick instruction for all fellow modders who add smoking items to the game, and would like these items to be compatible with this mod. It's pretty simple. In order for an item to be recognized by my mod's system and therefore added to the modal/radial menu, it needs to meet at least one of the following conditions. It has to either:
-- - have a tag "Smokable" (duh, I know, but it's really not that obvious, not even half of the mod introduced smokables have that tag)
-- - have the eatType property be of value either "Cigarettes" or "pipe" (not necesarilly case sensitive but I used here the case that the base game uses at the current moment - algorithm entries are case insensitive in case the devs decide it's time to flip the casing)
-- - have the OnEat function value represented by a string containing substring "cigar" (like OnEat_Cigarette, OnEat_Cigarillo...) "weed" or "smoke" (again, case insensitive)
-- - and lastly, if the item is not caught by any of nets above, it has to have CustomContextMenu property be of value "Smoke" (and yet again out of my generosity, I'm leaving this still case insensitive ;))

-- In case I abandon the development/patching of my mod(s) I give full permission to anyone willing to pick up the code after me, feel free to carry on, albeit with a different name. I plan on leaving a note in the description if that time comes, but who knows what the future brings. So just in case I'm leaving this note here.


-- If you're not in the mood and want to go straight to the fix without learning a valuable lesson, head over to the point 10 straight away, otherwise...

-- 1. you download [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2289454303&searchtext=eggon]this mod[/url]
-- 2. you are being confused by the fact I've just sent you a link to the mod you were asking me to fix, but you just subscribe to it and you keep reading ;)
-- 3. you follow the mod's download folder - it should be something like this: C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2289454303\mods\eggonsHotkeys
-- 4. you are looking at the contents of the folder and you are seeing in it a folder named "media" and two other files
-- 5. you feel the powers of the divine creator and thus you are creating two folders named exactly:
-- - "42" (which BTW is the answer to the greatest question about the very "nature of the universe", no joke, it is, google it :P)
-- - "common"
-- (so theres 3 folders - media, 42 and common, + 2 files
-- 6. you move the folder media + 2 of the files in any of the other folders (either 42 or common, it should not matter, and just trust me, it really does not :D)
-- 7. you launch pacman... i mean project zomboid
-- 7.5 when game's launching you repeat "abracadabra" 3x (it's crucial!)
-- 8. you go into mods -> there should be eggon's hotkey mod for you to select and run :)
-- 9. if you followed my guidance you should be able to use the mod just the same like you could when you had B41
-- 10. What if following my meticulously written tutorial does not get the mod to work? No worries, someone else did that exact process already and uploaded the outcome here:
-- https://steamcommunity.com/sharedfiles/filedetails/?id=3391426402&searchtext=eggon

-- You're welcome. As a thank you, I only accept sums not smaller than 1 BTC, my wallet address is... just kidding, but srsly I'm in a foolish mood today, as I'm sure you've noticed already :D
-- And to be honest no need for thank you's but it'd be great to have a word of feedback about the mod of mine - at least if you're finding the radial or the modal menu to be more convenient in my mod? I added the radials just a couple days ago actually. I personally preffer the modal window really. But curious how you find it?
-- Hope you chose the path of the enlightened player and completed my guide :D but it's also fine if you skipped to the fix itself ^^

-- From what I'm seeing it's the middle of the night in USA now, so I hope you'll have a great day :) 
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
