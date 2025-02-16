require "ISUI/ISCollapsableModalRichText"
require "TimedActions/ISBaseTimedAction"
require "SKAL_Actions"
require "ISUI/ISPanel"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"
require "TBC_UtilityFunctions"

MyCustomModal = ISPanel:derive("MyCustomModal")

TBCEatSNUSAction = ISBaseTimedAction:derive("TBCEatSNUSAction")

local CLOSE_BTN_OFFSET = 15

function MyCustomModal:initialise()
    ISPanel.initialise(self)
    self:create()
end

function MyCustomModal:create()
    local btnWidth = 200
    local btnHeight = 40
    local btnSpacing = 10
    local yOffset = 10
    local player = getPlayer()
    local inv = player:getInventory()
    local SNUSforModal = TBC.getAllItems(TBC.SNUS, inv)

    local totalHeight = (#SNUSforModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset) + CLOSE_BTN_OFFSET

    self:setHeight(math.max(totalHeight, 150))

    for _, snusType in ipairs(SNUSforModal) do
        if snusType and snusType.getName then
            local snusName = snusType:getName()
            local button = ISButton:new(10, yOffset, btnWidth, btnHeight, snusName, self, MyCustomModal.onOptionSelected)
            button.internal = snusType
            button:initialise()
            button:instantiate()
            button.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
            self:addChild(button)
    
            yOffset = yOffset + btnHeight + btnSpacing
        else
            print("[ERROR] Nieprawidłowy obiekt SNUS w SNUSforModal")
        end
    end
    

    local closeButton = ISButton:new(10, yOffset + CLOSE_BTN_OFFSET, btnWidth, btnHeight, "Close", self, MyCustomModal.onClose)
    closeButton.internal = "CLOSE"
    closeButton:initialise()
    closeButton:instantiate()
    closeButton.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
    self:addChild(closeButton)
end


function MyCustomModal:onOptionSelected(button)
    if button.internal ~= "CLOSE" then
        local snus = button.internal
        -- print(string.format("[DEBUG] Wybrano SNUS: %s (Typ: %s)", snus:getName(), snus:getFullType()))
        TBC.putSelectedSNUSInLip(snus)
    else
        -- print("[DEBUG] Zamykam okno modalne.")
    end
    self:onClose()
end


function MyCustomModal:onClose()
    self:setVisible(false)
    self:removeFromUIManager()
    -- isCustomModalOpen = false
end

function MyCustomModal:new(x, y, width, height)
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

-- local isCustomModalOpen = false

function OpenMyCustomModal()
    -- if isCustomModalOpen then
    --     print("[DEBUG] Snus modal already visible, terminating modal show func...")
    --     return
    -- end

    -- isCustomModalOpen = true

    local screenWidth = getCore():getScreenWidth()
    local screenHeight = getCore():getScreenHeight()
    local width = 220
    local height = 200
    local x = (screenWidth - width) / 2 + (screenWidth) / 4
    local y = (screenHeight - height) / 2

    local modal = MyCustomModal:new(x, y, width, height)
    modal:initialise()
    modal:addToUIManager()
end

local SNUSDialogues = {
    [1] = "I need a SNUS for my lip!",
    [2] = "Where did my SNUS go?",
    [3] = "Gotta have some SNUS!"
}

function TBC.getAllItems(dictionary, inv)
    local items = {}
    for index, fullType in pairs(dictionary) do

        local foundItem = inv:getFirstTypeRecurse(fullType)
        if foundItem then
            table.insert(items, foundItem)
        end
    end

    return items
end

-- function TBC.TransferItemBackToContainer(item, originalContainer)
--     print("[DEBUG] transferitemback called")

--     if not item then
--         print("[ERROR] Przedmiot jest NIL!")
--         return
--     end

--     if not originalContainer then
--         print("[ERROR] Oryginalny kontener jest NIL!")
--         return
--     end

--     local player = getPlayer()
--     local currentContainer = item:getContainer()

--     print("[DEBUG] Sprawdzam kontenery:")
--     print("[DEBUG] Aktualny kontener:", currentContainer and currentContainer:getType() or "NIL")
--     print("[DEBUG] Oryginalny kontener:", originalContainer and originalContainer:getType() or "NIL")

--     if currentContainer ~= originalContainer then
--         print(string.format("[DEBUG] Przenoszenie SNUS: %s z %s do %s", 
--             item:getName(), 
--             currentContainer and currentContainer:getType() or "NONE", 
--             originalContainer:getType()))

--         -- Tworzymy transfer tak jak w ISCraftingUI
--         local action = ISInventoryTransferAction:new(player, item, currentContainer, originalContainer, 10)
--         action:setAllowMissingItems(true) -- Nie wywoła błędu, jeśli przedmiotu już nie ma
--         ISTimedActionQueue.add(action)
--     else
--         print("[DEBUG] Przedmiot już znajduje się w oryginalnym kontenerze, brak potrzeby transferu.")
--     end
-- end

local originalPerform = ISTakePillAction.perform

function ISTakePillAction:perform()
    print("[DEBUG] perform() rozpoczęte...")

    -- 📌 **Pobieramy oryginalny kontener SNUS z tabeli `TBC.OriginalContainers`**
    local originalContainer = TBC.OriginalContainers and TBC.OriginalContainers[self.item]
    if not originalContainer then
        print("[ERROR] Oryginalny kontener SNUS nie został zapisany! Przerywamy transfer.")
        return
    else
        print("[DEBUG] Oryginalny kontener SNUS: " .. originalContainer:getType())
    end

    -- 📌 **Wykonujemy oryginalną funkcję `perform()`**
    originalPerform(self)

    print("[DEBUG] perform() zakończone!")

    -- 📌 **Przenosimy SNUS z powrotem do oryginalnego kontenera**
    if self.item and self.character:getInventory():contains(self.item) then
        print("[DEBUG] Przenoszenie SNUS z powrotem do " .. originalContainer:getType())
        local transferAction = ISInventoryTransferAction:new(self.character, self.item, self.character:getInventory(), originalContainer, 10)
        ISTimedActionQueue.add(transferAction)
    else
        print("[ERROR] Nie można przenieść SNUS - brak przedmiotu lub oryginalnego kontenera!")
    end

    -- 📌 **Usuwamy zapisany kontener po zakończeniu akcji**
    TBC.OriginalContainers[self.item] = nil
end


-- Function to handle putting SNUS in lip
function TBC.putSelectedSNUSInLip(snus)
    local player = getPlayer()
    local inv = player:getInventory()
    local snusType = snus and snus:getFullType() or "Unknown"

    if not snus then return end

    local originalContainer = snus:getContainer()
    if not originalContainer then
        print("[DEBUG] SNUS jest w inventory postaci.")
        originalContainer = inv
    else
        print("[DEBUG] Oryginalny kontener SNUS: " .. originalContainer:getType())
    end

    -- snus.originalContainer = originalContainer
    -- print(snus.originalContainer)

    TBC.OriginalContainers = TBC.OriginalContainers or {}
    TBC.OriginalContainers[snus] = originalContainer
    print(TBC.OriginalContainers[snus])

    if not inv:contains(snus) then
        print("[DEBUG] Przenoszenie SNUS do głównego ekwipunku...")
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, snus, originalContainer, inv))
    end

    if snusType == "Base.TobaccoChewing" or snusType == "Base.HempChewing" then
        local action = ISTakePillAction:new(player, snus)
        ISTimedActionQueue.add(action)
    else
        local item = TBC.getFirstItem({snusType}, inv)
        ISInventoryPaneContextMenu.eatItem(item, 1, 0)
    end

    -- local transferAction = ISInventoryTransferAction:new(player, snus, inv, TBC.OriginalContainers[snus])
    -- ISTimedActionQueue.add(transferAction)
end

function TBC.putTobaccoInLip()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo

    -- print("[DEBUG] Called TBC.putTobaccoInLip")
    -- print("[DEBUG] Gathering SNUS from inventory...")
    local availableSNUS = TBC.getAllItems(TBC.SNUS, inv)

    -- print("[DEBUG] Number of available SNUS: " .. #availableSNUS)

    if #availableSNUS > 1 then
        OpenMyCustomModal()
        return
    elseif #availableSNUS == 1 then
        -- print("[DEBUG] Only one SNUS available. Using it directly.")
        TBC.putSelectedSNUSInLip(availableSNUS[1])
        return
    elseif #availableSNUS == 0 then
        -- print("[DEBUG] No SNUS found. Showing fallback dialogue.")
        dialogueNo = ZombRand(3) + 1
        player:Say(SNUSDialogues[dialogueNo])
    end
end
