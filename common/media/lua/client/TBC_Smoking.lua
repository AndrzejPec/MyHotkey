require "ISUI/ISPanel"
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"

local ISEatFoodAction = require("TimedActions/ISEatFoodAction")

local cigarettesDialogues = {
    [1] = getText("IGUI_TBC_cigarettes_1"),
    [2] = getText("IGUI_TBC_cigarettes_2"),
    [3] = getText("IGUI_TBC_cigarettes_3"),
}

local lightDialogues = {
    [1] = getText("IGUI_TBC_light_1"),
    [2] = getText("IGUI_TBC_light_2"),
    [3] = getText("IGUI_TBC_light_3"),
}

local packedDialogues = function(count)
    return getText("IGUI_TBC_packed_prefix") .. count .. getText("IGUI_TBC_packed_suffix")
end

local CLOSE_BTN_OFFSET = 15

function TBC.getFirstItem(dictionary, inv, smokingItemType)
    local output
    for i, fullType in pairs(dictionary) do
        -- print(string.format("[DEBUG] Sprawdzam przedmiot: %s", fullType))
        local identifier = useKey and i or fullType
        output = inv:getFirstTypeRecurse(identifier)
        if output and (smokingItemType ~= "cigarettes" or output.getBaseHunger) then
            -- print(string.format("[DEBUG] Znaleziono przedmiot: %s", output:getName()))
            break
        else
            -- print("[DEBUG] Nie znaleziono przedmiotu dla: " .. fullType)
            output = nil
        end
    end
    return output
end

MySmokingModal = ISPanel:derive("MySmokingModal")

function MySmokingModal:initialise()
    ISPanel.initialise(self)
    self:create()
end

function MySmokingModal:create()
    local btnWidth = 200
    local btnHeight = 40
    local btnSpacing = 10
    local yOffset = 10
    local player = getPlayer()
    local inv = player:getInventory()
    local smokingItemsForModal = TBC.getAllItems(TBC.cigarettes, inv)
    if #smokingItemsForModal == 0 then
        -- print("[ERROR] Nie znaleziono przedmiotów do palenia.")
        return
    end

    local totalHeight = (#smokingItemsForModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset) + CLOSE_BTN_OFFSET

    self:setHeight(math.max(totalHeight, 150))

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
    
            yOffset = yOffset + btnHeight + btnSpacing
        else
            -- print("[ERROR] Nieprawidłowy obiekt w smokingItemsForModal")
        end
    end

    local closeButton = ISButton:new(10, yOffset + CLOSE_BTN_OFFSET, btnWidth, btnHeight, getText("IGUI_TBC_close_modal"), self, MySmokingModal.onClose)
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
        local fullType = smokingItem:getFullType()
        local item = TBC.getFirstItem({fullType}, inv)
        if item then
            -- print(string.format("[DEBUG] Wybrano do palenia: %s (Typ: %s)", item:getName(), item:getFullType()))
            -- Użyj ISInventoryPaneContextMenu.eatItem do rozpoczęcia akcji
            -- local action = ISInventoryPaneContextMenu.eatItem(item, 1, 0)
            -- ISTimedActionQueue.add(action)
            ISInventoryPaneContextMenu.eatItem(item, 1, 0)
            -- print("Rozpoczęto akcję jedzenia wybranego papierosa!")
        else
            -- print("[ERROR] Nie udało się znaleźć przedmiotu w inwentarzu na podstawie fullType!")
        end
    else
        -- print("[ERROR] Nieprawidłowy przedmiot lub brak metody getFullType!")
    end

    -- isSmokingModalOpen = false
    self:onClose()
end

function MySmokingModal:onClose()
    -- isSmokingModalOpen = false
    self:setVisible(false)
    self:removeFromUIManager()
    MySmokingModal.instance = nil
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

-- local isSmokingModalOpen = false

function OpenMySmokingModal()
    -- if isSmokingModalOpen then
    --     print("[DEBUG] Modal jest już otwarty! Nie otwieram kolejnego.")
    --     return
    -- end
    if MySmokingModal.instance then
        -- print("[DEBUG] Modal jest już otwarty! Nie otwieram kolejnego.")
        return
    end

    -- isSmokingModalOpen = true

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
    local dialogueNo = ZombRand(#cigarettesDialogues) + 1

    local availableSmokingItems = TBC.getAllItems(TBC.cigarettes, inv)
    local availableCigarettesPack = TBC.getAllItems(TBC.cigarettesPacks, inv)

    if #availableSmokingItems == 0 then
        if #availableCigarettesPack == 0 then
            player:Say(cigarettesDialogues[dialogueNo])
        else
            player:Say(packedDialogues(#availableCigarettesPack))
        end
        return
    end

    local fireSource = TBC.getFirstItem(TBC.fireSources, inv)
    if not fireSource then
        -- print("[DEBUG] Brak zapalniczki lub źródła ognia!")
        player:Say(lightDialogues[dialogueNo])
        return
    end

    if #availableSmokingItems > 1 then
        -- print("[DEBUG] Więcej niż jeden przedmiot do palenia. Otwieram modal.")
        OpenMySmokingModal()
        return
    elseif #availableSmokingItems == 1 then
        local cigarette = availableSmokingItems[1]
        if cigarette then
            ISInventoryPaneContextMenu.eatItem(cigarette, 1, 0)
            -- local sourceContainer = cigarette:getContainer()
            -- local transferSnusBack = ISInventoryTransferAction:new(player, item, inv, sourceContainer)
            -- ISTimedActionQueue.add(transferSnusBack)
            -- TBC.TransferItemsBack(cigarette)
            return
        end
    else
    -- print("[DEBUG] Brak przedmiotów do palenia!")
        player:Say(cigarettesDialogues[dialogueNo])
    end
end     
