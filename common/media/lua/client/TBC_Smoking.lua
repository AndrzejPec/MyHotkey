require "ISUI/ISPanel"
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISEatFoodAction"

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- function ISCraftingUI:onCraftComplete(completedAction, recipe, container, containers)
--     if not RecipeManager.IsRecipeValid(recipe, self.character, nil, containers) then return end
--     local items = RecipeManager.getAvailableItemsNeeded(recipe, self.character, containers, nil, nil)
--     if items:isEmpty() then
--         self:refresh()
--         return
--     end
--     local previousAction = completedAction
--     local returnToContainer = {};
--     if not recipe:isCanBeDoneFromFloor() then
--         for i=1,items:size() do
--             local item = items:get(i-1)
--             if item:getContainer() ~= self.character:getInventory() then
--                 local action = ISInventoryTransferAction:new(self.character, item, item:getContainer(), self.character:getInventory(), nil)
--                 ISTimedActionQueue.addAfter(previousAction, action)
--                 previousAction = action
--                 table.insert(returnToContainer, item)
--             end
--         end
--     end
--     local action = ISCraftAction:new(self.character, items:get(0), recipe, container, containers)
--     action:setOnComplete(ISCraftingUI.onCraftComplete, self, action, recipe, container, containers)
--     ISTimedActionQueue.addAfter(previousAction, action)
--     ISCraftingUI.ReturnItemsToOriginalContainer(self.character, returnToContainer)
-- end


local ISEatFoodAction = require("TimedActions/ISEatFoodAction")

local cigarettesDialogues = {}
local lightDialogues = {}

local function loadDialogues()
    local options = PZAPI.ModOptions:getOptions("myTobaccoHotkeyMod")
    cigarettesDialogues = {
        [1] = options:getOption("TBC_cigarettes_1"):getValue(),
        [2] = options:getOption("TBC_cigarettes_2"):getValue(),
        [3] = options:getOption("TBC_cigarettes_3"):getValue(),
    }
    lightDialogues = {
        [1] = options:getOption("TBC_lighter_1"):getValue(),
        [2] = options:getOption("TBC_lighter_2"):getValue(),
        [3] = options:getOption("TBC_lighter_3"):getValue(),
    }
end

local packedDialogues = function(count)
    return getText("IGUI_TBC_packed_prefix") .. count .. getText("IGUI_TBC_packed_suffix")
end

local CLOSE_BTN_OFFSET = 15

local function getItemCountForType(fullType, inv)
    local count = 0
    for i=0, inv:getItems():size()-1 do
        local item = inv:getItems():get(i)
        if item:getFullType() == fullType then
            if item.getCount then
                count = count + item:getCount()
                print('Getcount jednak jest')
            else
                count = count + 1
                print('Getcounta jednak ni ma, ale dodalem jeden bo jestem downem')
            end
        end
    end

    -- print('pszedmiotuw ' .. fullType .. ' je ' .. count)
    return count
end

local function getDisplayCountText(count)
    local options = PZAPI.ModOptions:getOptions("myTobaccoHotkeyMod")
    local mode = options:getOption("TBC_display_mode"):getValue()

    if mode == 1 then -- approximate option
        if count == 1 then
            return "(" .. getText("IGUI_TBC_last_one") .. ")"
        elseif count >= 2 and count <= 10 then
            return "(" .. getText("IGUI_TBC_few") .. ")"
        elseif count >= 11 and count <= 20 then
            return "(" .. getText("IGUI_TBC_plenty") .. ")"
        else
            return "(" .. getText("IGUI_TBC_abundant") .. ")"
        end
    else -- exact
        return "(" .. count .. ")"
    end
end

function TBC.getFirstItem(dictionary, inv, smokingItemType)
    local output
    for i, fullType in pairs(dictionary) do
        local identifier = useKey and i or fullType
        output = inv:getFirstTypeRecurse(identifier)
        if output and (smokingItemType ~= "cigarettes" or output.getBaseHunger) then
            break
        else
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
        return
    end

    local totalHeight = (#smokingItemsForModal * (btnHeight + btnSpacing)) + btnHeight + (2 * yOffset) + CLOSE_BTN_OFFSET

    self:setHeight(math.max(totalHeight, 150))

    for _, smokingItem in ipairs(smokingItemsForModal) do
        if smokingItem and smokingItem.getName then
            local itemName = smokingItem:getName()
            print("DEBUG: smokingItem:", smokingItem)
            print("DEBUG: smokingItem:getFullType() dostępne?", smokingItem and smokingItem.getFullType)
            local itemType = smokingItem:getFullType()
            if itemType then
                print("DEBUG: itemType ->", itemType)
            else
                print('ni ma itemtype, sorry no')
            end
            local count = getItemCountForType(itemType, inv) or 0
            local buttonLabel = itemName .. " " .. getDisplayCountText(count)

            local button = ISButton:new(10, yOffset, btnWidth, btnHeight, buttonLabel, self, function(_, _)
                MySmokingModal.onOptionSelected(self, smokingItem)
            end)
            
            button:initialise()
            button:instantiate()
            button.borderColor = {r = 1, g = 1, b = 1, a = 0.5}
            self:addChild(button)
    
            yOffset = yOffset + btnHeight + btnSpacing
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
            ISInventoryPaneContextMenu.eatItem(item, 1, 0)
        end
    end

    self:onClose()
end

function MySmokingModal:onClose()
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

function OpenMySmokingModal()
    if MySmokingModal.instance then
        return
    end

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

-- local function returnFireSourceToContainer(fireSource, player)
--     local currentContainer = fireSource:getContainer()
--     local originalContainer = TBC.OriginalContainers[fireSource]

--     print("[DEBUG] function launched!")

--     if fireSource and originalContainer then
--         print("[DEBUG] Przenoszenie zapalniczki z powrotem do " .. originalContainer:getType())
--         ISTimedActionQueue.add(ISInventoryTransferAction:new(player, fireSource, player:getInventory(), originalContainer, 10))
--     else
--         print("[ERROR] Nie można przenieść zapalniczki - brak przedmiotu lub oryginalnego kontenera!")
--     end

--     TBC.OriginalContainers[fireSource] = nil
-- end

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
        player:Say(lightDialogues[dialogueNo])
        return
    end

    print('checking firesource cointainer')
    local originalFireContainer = fireSource:getContainer()
    -- if not originalFireContainer then
    --     print("[DEBUG] Zapalniczka jest w inventory postaci.")
    --     originalFireContainer = inv
    -- else
    --     print("[DEBUG] Oryginalny kontener zapalniczki: " .. originalFireContainer:getType())
    -- end

    TBC.OriginalContainers = TBC.OriginalContainers or {}  -- Jeśli tabela nie istnieje, inicjalizujemy ją!
    TBC.OriginalContainers[fireSource] = originalFireContainer

    print(TBC.OriginalContainers[fireSource])

    if #availableSmokingItems > 1 then
        OpenMySmokingModal()
        return
    elseif #availableSmokingItems == 1 then
        local cigarette = availableSmokingItems[1]
        if cigarette then
            ISInventoryPaneContextMenu.eatItem(cigarette, 1, 0)
            -- local returnFireSource = ISInventoryTransferAction:new(player, fireSource, player:getInventory(), TBC.OriginalContainers[fireSource], 10)
            -- print('can return firesource?' .. returnFireSource)
            -- ISTimedActionQueue.add(returnFireSource)
            return
        end
    else
        player:Say(cigarettesDialogues[dialogueNo])
    end
end

Events.OnGameStart.Add(loadDialogues)