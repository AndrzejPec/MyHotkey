function TBC:scanForSmokableItems()
    local itemList = ScriptManager.getItems()
    if not itemList then return end

    local nextIndex = #self.cigarettes + 1 -- Licznik nowych pozycji

    print("🔍 Skanuję przedmioty w poszukiwaniu smokable items...")

    for _, item in pairs(itemList) do
        local properties = item:getModData()
        if properties then
            local isSmokable = false

            if properties.OnEat then
                local onEat = string.lower(properties.OnEat)
                if string.find(onEat, "cigar", 1, true) or string.find(onEat, "weed", 1, true) then
                    isSmokable = true
                end
            end

            if not isSmokable and properties.EatType then
                local eatType = properties.EatType
                if eatType == "pipe" or eatType == "Cigarettes" then
                    isSmokable = true
                end
            end

            if not isSmokable and properties.Tags then
                local tags = properties.Tags:split(";")
                for _, tag in ipairs(tags) do
                    if tag == "Smokable" then
                        isSmokable = true
                        break
                    end
                end
            end

            -- Wykluczamy produkty do żucia (jeśli już oznaczyliśmy jako smokable)
            -- if isSmokable and properties.Tags then
            --     local tags = properties.Tags:split(";")
            --     for _, tag in ipairs(tags) do
            --         if tag == "ChewingTobacco" then
            --             isSmokable = false
            --             break
            --         end
            --     end
            -- end

            if isSmokable then
                local fullType = item:getFullType()
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

                -- Dodatkowy debug print: sprawdzamy, jaki jest fullType
                print("ℹ️ Pełny typ przedmiotu: " .. fullType)
            end
        end
    end

    print("✅ Skrypt zakończony! Wykryto " .. #self.cigarettes .. " smokable items.")
end

Events.OnGameStart.Add(function() TBC:scanForSmokableItems() end)
