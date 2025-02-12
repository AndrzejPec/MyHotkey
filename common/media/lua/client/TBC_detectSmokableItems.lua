function TBC:scanForSmokableItemsWithoutTests()
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
        if eatType and (eatType == "Cigarettes" or eatType == "pipe") then
            -- print("🚬 Przedmiot \"" .. itemName .. "\" ma EatType ustawione na 'Cigarettes'.")
            -- print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 1. warunku")
            isSmokable = true
            -- return
        end

        -- Warunek 2: Przedmiot ma tag "Smokable"
        local tags = item:getTags()
        -- if not isSmokable and tags and tags:contains("Smokable") then
        if tags and tags:contains("Smokable") then
            isSmokable = true
            -- print("🚬 Przedmiot \"" .. itemName .. "\" posiada tag 'Smokable'.")
            -- print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 2. warunkełe")
            -- return
        end

        -- Warunek 3 i 4: OnEat lub CustomContextMenu zawiera odpowiednie frazy
        if itemType == "Food" then
            if inventoryItem then
                local onEat = inventoryItem:getOnEat()

                if onEat and string.find(onEat, "Cigar") then
                    isSmokable = true
                    -- print("🚬 Przedmiot \"" .. itemName .. "\" ma OnEat zawierające 'Cigar'.")
                    -- print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 3. warunkszfiucie")
                    -- return
                end

                local customContextMenu = inventoryItem.CustomContextMenu
                
                -- if not isSmokable and customContextMenu and string.find(customContextMenu, "Smoke") then
                if customContextMenu and string.find(customContextMenu, "Smoke") then
                    isSmokable = true
                    -- print("🚬 Przedmiot \"" .. itemName .. "\" ma CustomContextMenu zawierające 'Smoke'.")
                    -- print("🚬 Przedmiot \"" .. itemName .. "\" wpadł na 4. warunkszfiutsenie")
                    -- return
                end
            end
        end

        if isSmokable then
            table.insert(smokables, item)
            -- return
        end
    end
    -- print('Łonczna liczba wykrytych SMOŁKABULSÓW wynosi ' .. #smokables)
    -- print(smokables)

    return smokables
end

-- I've developed an algorithm that should ensure - more or less - an future-proof - further or shorter - onward compatibility with mods that would be created in the future. After having added manually nearly a 100 items introduced by differnt mods that I'd decided to support (on top of all the items from the base game) I kind of grew tired with all the labour it took to keep the existing dictionary of smokable items up to date with what modders every now and then add to the game. And so...

-- So here's a quick instruction for all fellow modders who add smoking items to the game, and would like these items to be compatible with this mod. It's pretty simple. In order for an item to be recognized by my mod's system and therefore added to the modal/radial menu, it needs to meet at least one of the following conditions. It has to either:
-- - have a tag "Smokable" (duh, I know, but it's really not that obvious, not even half of the mod introduced smokables have that tag)
-- - have the eatType property be of value either "Cigarettes" or "pipe" (not necesarilly case sensitive but I used here the case that the base game uses at the current moment - algorithm entries are case insensitive in case the devs decide it's time to flip the casing)
-- - have the OnEat function value represented by a string containing substring "cigar" (like OnEat_Cigarette, OnEat_Cigarillo...) "weed" or "smoke" (again, case insensitive)
-- - and lastly, if the item is not caught by any of nets above, it has to have CustomContextMenu property be of value "Smoke" (and yet again out of my generosity, I'm leaving this still case insensitive ;))

-- In case I abandon the development/patching of my mod(s) I give full permission to anyone willing to pick up the code after me, feel free to carry on, albeit with a different name. I plan on leaving a note in the description if that time comes, but who knows what the future brings. So just in case I'm leaving this note here.
