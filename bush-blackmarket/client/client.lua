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
                label = 'Open ' .. v.label .. ' shop',
                onSelect = function()
                    OpenMenu(v)
                end,
                distance = 2.0
            },
        })
    end
end)

function OpenMenu(personInfo)
    if #personInfo.info == 1 then
        local singleInfo = personInfo.info[1]
        TriggerEvent('qb-weaponshops:client:OpenShop', singleInfo.type)
    else
        local menuItems = {
            id = 'blackmarket',
            title = personInfo.label .. ' - Shop Types',
            icon = 'gun',
            options = {},
        }
        for _, info in ipairs(personInfo.info) do
            local newItem = {
                title = info.label,
                description = 'Open ' .. info.label .. ' shop',
                icon = 'fas fa-code-merge',
                onSelect = function()
                    TriggerEvent('qb-weaponshops:client:OpenShop', info.type)
                end,
            }
            menuItems.options[#menuItems.options + 1] = newItem
        end

        lib.registerContext(menuItems)
        lib.showContext('blackmarket')
    end
end


RegisterNetEvent('qb-weaponshops:client:OpenShop')
AddEventHandler('qb-weaponshops:client:OpenShop', function(shopType)
    exports.ox_inventory:openInventory('shop', { type = shopType, id = 1 })
end)
