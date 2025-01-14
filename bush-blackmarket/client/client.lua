CreateThread(function()
    for _, pedData in ipairs(Config.Peds) do
        local modelHash = pedData.hash
        local coords = pedData.coords
        local modelLoaded = lib.requestModel(modelHash, 5000)

        if modelLoaded then
            local spawnedPed = CreatePed(0, modelHash, coords.x, coords.y, coords.z-1.0, pedData.heading, false, false)
            SetupPed(spawnedPed, pedData)
        else
            print(("Failed to load model: %s"):format(modelHash))
        end
    end
end)

function SetupPed(ped, pedData)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', -1)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local pedLabel = pedData.label
    local info = pedData.info

    exports.ox_target:addLocalEntity(ped, {
        {
            icon = 'fas fa-circle',
            label = ('Open %s shop'):format(pedLabel),
            onSelect = function() HandlePedInteraction(ped, pedData) end,
            distance = 2.0
        }
    })
end

function HandlePedInteraction(ped, pedData)
    local info = pedData.info
    if #info > 1 then
        ShowMultiItemShop(ped, pedData)
    else
        local singleItem = info[1]
        ShowSingleItemShop(ped, pedData.label, singleItem)
    end
end

function ShowMultiItemShop(ped, pedData)
    local options = {}

    local info = pedData.info
    for i = 1, #info do
        local shopInfo = info[i]
        options[#options + 1] = {
            id = shopInfo.type,
            label = ('I want to buy some %s'):format(shopInfo.label),
            icon = 'shopping-cart',
            close = true,
            action = function() OpenShop(shopInfo.type) end
        }
    end

    options[#options + 1] = {
        id = 'close',
        label = 'I don\'t need anything',
        icon = 'ban',
        close = true
    }

    exports.mt_lib:showDialogue({
        ped = ped,
        label = pedData.label,
        speech = 'How can I help you today?',
        options = options
    })
end

function ShowSingleItemShop(ped, shopLabel, shopInfo)
    exports.mt_lib:showDialogue({
        ped = ped,
        label = shopLabel,
        speech = ('I only have %s.'):format(shopInfo.label),
        options = {
            {
                id = 'single-item',
                label = 'Let\'s go, that\'s what I\'m here for',
                icon = 'shopping-cart',
                close = true,
                action = function() OpenShop(shopInfo.type) end
            },
            {
                id = 'close',
                label = 'I don\'t need anything',
                icon = 'ban',
                close = true
            }
        }
    })
end

function OpenShop(shopType)
    if ValidateShopType(shopType) then
        exports.ox_inventory:openInventory('shop', { type = shopType, id = 1 })
    else
        print(("Invalid shop type: %s"):format(shopType))
    end
end

function ValidateShopType(shopType)
    for _, pedData in ipairs(Config.Peds) do
        local info = pedData.info
        for i = 1, #info do
            if info[i].type == shopType then
                return true
            end
        end
    end
    return false
end
