require "ISUI/ISPanel"
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"

local ISEatFoodAction = require("TimedActions/ISEatFoodAction")

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

function getFirstItem(dictionary, inv, smokingItemType)
    local output
    for i, fullType in pairs(dictionary) do
        print(string.format("[DEBUG] Sprawdzam przedmiot: %s", fullType))
        local identifier = useKey and i or fullType
        output = inv:getFirstTypeRecurse(identifier)
        if output and (smokingItemType ~= "cigarettes" or output.getBaseHunger) then
            print(string.format("[DEBUG] Znaleziono przedmiot: %s", output:getName()))
            break
        else
            print("[DEBUG] Nie znaleziono przedmiotu dla: " .. fullType)
            output = nil
        end
    end
    return output
end


TBC.smokeTobaccoWithSelected = function(item, inv)
    local player = getPlayer()
    local inv = player:getInventory()
    if not item then
        print("[ERROR] Nie wybrano przedmiotu do palenia!")
        return
    end
    if not inv then
        print("[ERROR] Inwentarz (inv) jest nil!")
        return
    end

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end

    print(string.format("[DEBUG] Używam papierosa: %s (Typ: %s)", item:getName(), item:getFullType()))
    local action = ISEatFoodAction:new(player, item, 1) -- Tworzymy nową akcję jedzenia
    if action then
        ISTimedActionQueue.add(action) -- Dodajemy akcję do kolejki
        player:Say("Ahh, that's good!")
    else
        print("[ERROR] Nie udało się stworzyć akcji jedzenia!")
    end

    local fireSourceContainer = fireSource:getContainer()
    local transferFireSource = ISInventoryTransferAction:new(player, fireSource, inv, fireSourceContainer)
    ISTimedActionQueue.add(transferFireSource)
end

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
    if not smokingItemsForModal then
        print("[ERROR] Nie znaleziono przedmiotów do palenia.")
        return
    end

    -- Obliczamy wysokość modala na podstawie liczby przycisków
    local totalHeight = (#smokingItemsForModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset)

    -- Aktualizujemy wysokość modala
    self:setHeight(math.max(totalHeight, 150)) -- Minimum wysokości to 150, jeśli mało przycisków

    -- Tworzenie dynamicznych przycisków dla elementów do palenia
    for _, smokingItem in ipairs(smokingItemsForModal) do
        if smokingItem and smokingItem.getName then
            local itemName = smokingItem:getName()
            local button = ISButton:new(10, yOffset, btnWidth, btnHeight, smokingItem:getName(), self, function(_, _)
                MySmokingModal.onOptionSelected(self, smokingItem)
            end)
            
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

function MySmokingModal:onOptionSelected(smokingItem)
    local player = getPlayer()
    local inv = player:getInventory()

    if smokingItem and smokingItem.getFullType then
        -- Pobierz fullType wybranego przedmiotu
        local fullType = smokingItem:getFullType()
        
        -- Spróbuj znaleźć przedmiot w inwentarzu na podstawie fullType
        local item = inv:getFirstTypeRecurse(fullType)

        if item then
            print(string.format("[DEBUG] Wybrano do palenia: %s (Typ: %s)", item:getName(), item:getFullType()))
            
            -- Użyj ISInventoryPaneContextMenu.eatItem do rozpoczęcia akcji
            ISInventoryPaneContextMenu.eatItem(item, 1, 0)
            print("Rozpoczęto akcję jedzenia wybranego papierosa!")
        else
            print("[ERROR] Nie udało się znaleźć przedmiotu w inwentarzu na podstawie fullType!")
        end
    else
        print("[ERROR] Nieprawidłowy przedmiot lub brak metody getFullType!")
    end

    self:onClose() -- Zamknięcie modala
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

    local fireSource = getFirstItem(EHK.fireSources, inv)
    if not fireSource then
        print("[DEBUG] Brak zapalniczki lub źródła ognia!")
        local dialogueNo = ZombRand(3) + 1
        player:Say(lightDialogues[dialogueNo])
        return
    end

    if #availableSmokingItems > 1 then
        print("[DEBUG] Więcej niż jeden przedmiot do palenia. Otwieram modal.")
        OpenMySmokingModal()
        return
    elseif #availableSmokingItems == 1 then
        local item = availableSmokingItems[1]
        if item then
            ISInventoryPaneContextMenu.eatItem(item, 1, 0)
        else
            print("[WARNING] nie ma takiego papierosa!")
        -- TBC.smokeTobaccoWithSelected(availableSmokingItems[1])
            return
        end
    else
    print("[DEBUG] Brak przedmiotów do palenia!")
        local dialogueNo = ZombRand(3) + 1
        player:Say(cigarettesDialogues[dialogueNo])
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