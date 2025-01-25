require "ISUI/ISPanel"

local cigarettesDialogues = {
    [1] = "I'd like to smoke so badly! If only I had some cigs...!",
    [2] = "I lost my fags again?! Goddamn it!",
    [3] = "A fag! A fag! My kingdom for a fag!"
}

local lightDialogues = {
    [1] = "Anybody got light?",
    [2] = "Where are my matches?",
    [3] = "Gotta search some corpses for a lighter..."
}

MySmokingModal = ISPanel:derive("MySmokingModal")

function MySmokingModal:initialise()
    ISPanel.initialise(self)
    self:create()
end

function MySmokingModal:create()
    local btnWidth = 200 -- Szerokość przycisków
    local btnHeight = 40 -- Wysokość przycisków
    local btnSpacing = 10 -- Odstęp między przyciskami
    local yOffset = 10 -- Początkowy odstęp od góry
    local player = getPlayer()
    local inv = player:getInventory()
    local smokingItemsForModal = TBC.getAllItems(EHK.cigarettes, inv)

    -- Obliczamy wysokość modala na podstawie liczby przycisków
    local totalHeight = (#smokingItemsForModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset)

    -- Aktualizujemy wysokość modala
    self:setHeight(math.max(totalHeight, 150)) -- Minimum wysokości to 150, jeśli mało przycisków

    -- Tworzenie dynamicznych przycisków dla elementów do palenia
    for _, smokingItem in ipairs(smokingItemsForModal) do
        if smokingItem and smokingItem.getName then
            local itemName = smokingItem:getName()
            local button = ISButton:new(10, yOffset, btnWidth, btnHeight, itemName, self, MySmokingModal.onOptionSelected)
            button.internal = smokingItem
            button:initialise()
            button:instantiate()
            button.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
            self:addChild(button)
    
            -- Przesuwamy yOffset w dół
            yOffset = yOffset + btnHeight + btnSpacing
        else
            print("[ERROR] Nieprawidłowy obiekt w smokingItemsForModal")
        end
    end

    -- Dodajemy przycisk "Close" na samym dole
    local closeButton = ISButton:new(10, yOffset, btnWidth, btnHeight, "Close", self, MySmokingModal.onClose)
    closeButton.internal = "CLOSE"
    closeButton:initialise()
    closeButton:instantiate()
    closeButton.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
    self:addChild(closeButton)
end

function MySmokingModal:onOptionSelected(button)
    if button.internal ~= "CLOSE" then
        local smokingItem = button.internal
        print(string.format("[DEBUG] Wybrano do palenia: %s (Typ: %s)", smokingItem:getName(), smokingItem:getFullType()))
        TBC.smokeTobaccoWithSelected(smokingItem)
    else
        print("[DEBUG] Zamykam okno modalne.")
    end
    self:onClose()
end

function MySmokingModal:onClose()
    self:setVisible(false)
    self:removeFromUIManager()
end

function MySmokingModal:new(x, y, width, height)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r = 0, g = 0, b = 0, a = 0.8}
    o.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
    o.width = width
    o.height = height
    o.moveWithMouse = true
    return o
end

function OpenMySmokingModal()
    local screenWidth = getCore():getScreenWidth()
    local screenHeight = getCore():getScreenHeight()
    local width = 220
    local height = 200
    local x = (screenWidth - width) / 2 + (screenWidth) / 4
    local y = (screenHeight - height) / 2

    local modal = MySmokingModal:new(x, y, width, height)
    modal:initialise()
    modal:addToUIManager()
end

function getFirstItem(dictionary, inv, smokingItemType)
    local output
    for i, fullType in pairs(dictionary) do
        local identifier
        if useKey then
            identifier = i
        else
            identifier = fullType
        end
        output = inv:getFirstTypeRecurse(identifier)
        if output and (smokingItemType ~= "cigarettes" or output.getBaseHunger) then
            break
        else
            output = nil
        end
    end
    return output
end

TBC.smokeTobacco = function()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo, fireSourceContainer

    local availableSmokingItems = TBC.getAllItems(EHK.cigarettes, inv)
    if not availableSmokingItems then
        print("[DEBUG] Wywołuję TBC.oldSmokeTobacco jako fallback.")
        TBC.oldSmokeTobacco()
        return
    end

    if #availableSmokingItems > 1 then
        print("[DEBUG] Więcej niż jeden przedmiot do palenia. Otwieram modal.")
        OpenMySmokingModal()
        return
    elseif #availableSmokingItems == 1 then
        TBC.smokeTobaccoWithSelected(availableSmokingItems[1])
        return
    else
    print("[DEBUG] Brak przedmiotów do palenia!")
        local dialogueNo = ZombRand(3) + 1
        player:Say(cigarettesDialogues[dialogueNo])
    end
end

TBC.smokeTobaccoWithSelected = function(item)
    local player = getPlayer()
    if not item then
        print("[ERROR] Nie wybrano przedmiotu do palenia!")
        return
    end

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end
    if item then
        ISInventoryPaneContextMenu.eatItem(item, 1, 0)
        player:Say("Ahh, that's good!")
        local transferFireSource = ISInventoryTransferAction:new(player, fireSource, inv, fireSourceContainer)
        ISTimedActionQueue.add(transferFireSource)
    else
        print("ERROR! Cigarettes not obtained!")
    end
end     

TBC.oldSmokeTobacco = function()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo, fireSourceContainer

    

    local cigarettes = getFirstItem(EHK.cigarettes, inv, "cigarettes")
    if not cigarettes then
        local cigarettesPack = getFirstItem(EHK.cigarettesPacks, inv)
        if not cigarettesPack then
            dialogueNo = ZombRand(3) + 1
            player:Say(cigarettesDialogues[dialogueNo])
            return
        else
            local itemRecipes =
                RecipeManager.getUniqueRecipeItems(
                cigarettesPack,
                player,
                ISInventoryPaneContextMenu.getContainers(player)
            )
            local recipe
            if itemRecipes:size() > 0 then
                for i = 0, itemRecipes:size() - 1 do
                    recipe = itemRecipes:get(i)
                    if EHK.validRecipes[recipe:getName()] then
                        local ingredientName = recipe:getSource():get(0):getItems():get(0)
                        if ingredientName == cigarettesPack:getFullType() then
                            break
                        else
                            recipe = nil
                        end
                    else
                        recipe = nil
                    end
                end
            end
            if recipe then
                cigarettes = RecipeManager.PerformMakeItem(recipe, cigarettesPack, player, EHK.getContainers())
                inv:AddItem(cigarettes)
            else
                player:Say("Must remember to unpack cigarettes!")
                return
            end
        end
    end

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end

    fireSourceContainer = fireSource:getContainer()
    if cigarettes then
        ISInventoryPaneContextMenu.eatItem(cigarettes, 1, 0)
        local transferFireSource = ISInventoryTransferAction:new(player, fireSource, inv, fireSourceContainer)
        ISTimedActionQueue.add(transferFireSource)
    else
        print("ERROR! Cigarettes not obtained!")
    end
end
