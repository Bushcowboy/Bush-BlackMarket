
CreateThread(function()
    for _, v in pairs(Config.Peds) do
        local modelHash = v.hash
        local coords = v.location
        lib.requestModel(modelHash, 5000)
        local spawnedPed = CreatePed(0, modelHash, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
        TaskStartScenarioInPlace(spawnedPed, 'WORLD_HUMAN_CLIPBOARD', -1)
        FreezeEntityPosition(spawnedPed, true)
        SetEntityInvincible(spawnedPed, true)
        SetBlockingOfNonTemporaryEvents(spawnedPed, true)

        exports.ox_target:addLocalEntity(spawnedPed, {
            {
                icon = 'fas fa-circle',
                label = 'Open BlackMarket',
                onSelect = function()
                    OpenMenu()
                end,
                distance = 2.0
            },
        })
    end
end)

function OpenMenu()
    local menuItems = {
        id = 'blackmarket',
        title = 'BlackMarket',
        icon = 'gun',
        options = {},
    }
    
    for _, shopType in ipairs(Config.Peds) do
        for _, info in ipairs(shopType.info) do
            local newItem = {
                title = 'Open Shop',
                description = info.label .. ' Shop',
                icon = 'fas fa-code-merge',
                onSelect = function()
                    TriggerEvent('qb-weaponshops:client:OpenShop', info.type)
                end,
            }
            menuItems.options[#menuItems.options + 1] = newItem
        end
    end
    
    

    lib.registerContext(menuItems)
    lib.showContext('blackmarket')
end

RegisterNetEvent('qb-weaponshops:client:OpenShop')
AddEventHandler('qb-weaponshops:client:OpenShop', function(shopType)
    exports.ox_inventory:openInventory('shop', { type = shopType, id = 1 })
end)
