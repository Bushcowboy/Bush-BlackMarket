Citizen.CreateThread(function() -- Changed CreateThread to Citizen.CreateThread
    local model = GetHashKey("a_m_m_indian_01") -- Changed `a_m_m_indian_01` to GetHashKey("a_m_m_indian_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local entity = CreatePed(0, model, Config.Ped.x, Config.Ped.y, Config.Ped.z, Config.Ped.w, false) -- Changed Config.Ped to Config.Ped.x, etc.
    
    -- Freeze the ped in place
    FreezeEntityPosition(entity, true)
    
    -- Make the ped invincible
    SetEntityInvincible(entity, true)

    exports['qb-target']:AddTargetEntity(entity, {
        options = {
            {
                type = "client",
                icon = 'fas fa-crab',
                label = 'Attachments Menu',
                action = function()
                    OpenMenu()
                end
            }
        },
        distance = 2.5,
    })
end)

function OpenMenu()
    local menuItems = {
        id = 'blackmarket',
        title = 'BlackMarket',
        icon = 'gun',
        options = {},
    }

    for _, shopType in ipairs(Config.ShopTypes) do
        print("Inserting menu item for shop type:", shopType.label)
        table.insert(menuItems.options, {
            title = 'Open Shop',
            description = shopType.label .. ' Shop',
            icon = 'fas fa-code-merge',
            onSelect = function()
                TriggerEvent('qb-weaponshops:client:OpenShop', shopType.type)
            end,
        })
    end

    lib.registerContext(menuItems)
    lib.showContext('blackmarket')
end

RegisterNetEvent('qb-weaponshops:client:OpenShop')
AddEventHandler('qb-weaponshops:client:OpenShop', function(shopType)
    exports.ox_inventory:openInventory('shop', { type = shopType, id = 1 })
    print("Opened inventory for shop type:", shopType)
end)
