require "ISUI/ISCollapsableModalRichText"
require "TimedActions/ISBaseTimedAction"
require "SKAL_Actions"
require "ISUI/ISPanel"

MyCustomModal = ISPanel:derive("MyCustomModal")

EHKEatSNUSAction = ISBaseTimedAction:derive("EHKEatSNUSAction")

EHK.SNUS = {
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
}

function EHKEatSNUSAction:isValid()
    -- Sprawdza, czy gracz wciąż ma SNUS w ekwipunku
    return self.food ~= nil and self.character:getInventory():contains(self.food)
end

function EHKEatSNUSAction:start()
    print("[DEBUG] EHKEatSNUSAction:start()")
    self:setActionAnim("eat") -- Animacja jedzenia
    self.character:playSound("Eat") -- Dźwięk jedzenia
end

function EHKEatSNUSAction:stop()
    print("[DEBUG] EHKEatSNUSAction:stop()")
    ISBaseTimedAction.stop(self) -- Zatrzymuje akcję, jeśli została anulowana
end

function EHKEatSNUSAction:perform()
    if not self.food or not self.character:getInventory():contains(self.food) then
        print("[ERROR] Food missing during perform()!")
        return
    end

    -- Wywołanie jedzenia SNUS
    OnEat_Smokeless(self.food, self.character, 1)

    -- Kończenie akcji
    ISBaseTimedAction.perform(self)
end

function EHKEatSNUSAction:new(character, food)
    local o = ISBaseTimedAction.new(self, character)
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.food = food
    o.ignoreAction = false -- Ustawienie domyślnej wartości
    o.stopOnWalk = false -- Przerwij akcję, jeśli gracz zacznie chodzić
    o.stopOnRun = true -- Przerwij akcję, jeśli gracz zacznie biec
    o.maxTime = 100 -- Czas trwania akcji (w tickach, około 5 sekund)
    return o
end

function MyCustomModal:initialise()
    ISPanel.initialise(self)
    self:create()
end

function MyCustomModal:create()
    local btnWidth = 200 -- Szerokość przycisków
    local btnHeight = 40 -- Wysokość przycisków
    local btnSpacing = 10 -- Odstęp między przyciskami
    local yOffset = 10 -- Początkowy odstęp od góry
    local player = getPlayer()
    local inv = player:getInventory()
    local SNUSforModal = EHK.getAllItems(EHK.SNUS, inv)

    -- Obliczamy wysokość modala na podstawie liczby przycisków
    local totalHeight = (#SNUSforModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset) -- Dodatkowy przycisk "Close"

    -- Aktualizujemy wysokość modala
    self:setHeight(math.max(totalHeight, 150)) -- Minimum wysokości to 150, jeśli mało przycisków

    -- Tworzenie dynamicznych przycisków dla SNUS
    for _, snusType in ipairs(SNUSforModal) do
        if snusType and snusType.getName then -- Sprawdzamy, czy obiekt istnieje i ma metodę getName
            local snusName = snusType:getName()
            local button = ISButton:new(10, yOffset, btnWidth, btnHeight, snusName, self, MyCustomModal.onOptionSelected)
            button.internal = snusType
            button:initialise()
            button:instantiate()
            button.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
            self:addChild(button)
    
            -- Przesuwamy yOffset w dół
            yOffset = yOffset + btnHeight + btnSpacing
        else
            print("[ERROR] Nieprawidłowy obiekt SNUS w SNUSforModal")
        end
    end
    

    -- Dodajemy przycisk "Close" na samym dole
    local closeButton = ISButton:new(10, yOffset, btnWidth, btnHeight, "Close", self, MyCustomModal.onClose)
    closeButton.internal = "CLOSE"
    closeButton:initialise()
    closeButton:instantiate()
    closeButton.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
    self:addChild(closeButton)
end


function MyCustomModal:onOptionSelected(button)
    if button.internal ~= "CLOSE" then
        local snus = button.internal
        -- Wypisujemy nazwę SNUS i typ
        print(string.format("[DEBUG] Wybrano SNUS: %s (Typ: %s)", snus:getName(), snus:getFullType()))
        EHK.putSelectedSNUSInLip(snus)
    else
        print("[DEBUG] Zamykam okno modalne.")
    end
    self:onClose()
end


function MyCustomModal:onClose()
    self:setVisible(false)
    self:removeFromUIManager()
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

-- Funkcja do otwierania okna
function OpenMyCustomModal()
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
    print("[DEBUG] Rozpoczynam skanowanie inwentarza dla SNUS...")

    local items = {}
    for index, fullType in pairs(dictionary) do
        print(string.format("[DEBUG] Sprawdzam typ SNUS: %s", tostring(fullType)))

        local foundItem = inv:getFirstTypeRecurse(fullType)
        if foundItem then
            print(string.format("[DEBUG] Znaleziono przedmiot: %s", foundItem:getFullType()))
            table.insert(items, foundItem)
        else
            print(string.format("[WARNING] Nie znaleziono przedmiotu dla typu: %s", tostring(fullType)))
        end
    end

    print(string.format("[DEBUG] Skanowanie zakończone. Liczba znalezionych SNUS: %d", #items))
    for i, item in ipairs(items) do
        print(string.format("[DEBUG] Element #%d w items: %s", i, tostring(item)))
    end

    return items
end


-- Function to handle putting SNUS in lip
function EHK.putSelectedSNUSInLip(snus)
    local player = getPlayer()
    local snusType = snus and snus:getFullType() or "Unknown"
    print("[DEBUG] Called EHK.putSelectedSNUSInLip")
    print("[DEBUG] Using SNUS: " .. (snus and snus:getName() or "nil"))

    if not snus then
        print("[ERROR] SNUS object is nil")
        return
    end

    print("[DEBUG] SNUS Type: " .. snusType)

    if snusType == "Base.TobaccoChewing" then
        print("[DEBUG] Detected Base.TobaccoChewing. Initializing ISTakePillAction.")
        local action = ISTakePillAction:new(player, snus)
        ISTimedActionQueue.add(action)
        print("[DEBUG] Added ISTakePillAction to queue.")
    else
        print("[DEBUG] Detected non-TobaccoChewing SNUS. Calling OnEat_Smokeless.")
        local action = EHKEatSNUSAction:new(player, snus)
        ISTimedActionQueue.add(action)
    end
end
-- New function for managing SNUS
function TBC.putTobaccoInLip()
    local player = getPlayer()
    local inv = player:getInventory()
    local dialogueNo

    print("[DEBUG] Called TBC.putTobaccoInLip")
    print("[DEBUG] Gathering SNUS from inventory...")
    local availableSNUS = TBC.getAllItems(EHK.SNUS, inv)

    print("[DEBUG] Number of available SNUS: " .. #availableSNUS)

    -- Pokazanie modala, jeśli dostępnych SNUS jest więcej niż jeden
    if #availableSNUS > 1 then
        OpenMyCustomModal()
        return
    elseif #availableSNUS == 1 then
        print("[DEBUG] Only one SNUS available. Using it directly.")
        EHK.putSelectedSNUSInLip(availableSNUS[1])
        return
    elseif #availableSNUS == 0 then
        print("[DEBUG] No SNUS found. Showing fallback dialogue.")
        dialogueNo = ZombRand(3) + 1
        player:Say(SNUSDialogues[dialogueNo])
    end
end

-- Replace the original umbrella functionality
EHK.originalEquipUmbrella = EHK.equipUmbrella
EHK.equipUmbrella = EHK.putSNUSInLip
