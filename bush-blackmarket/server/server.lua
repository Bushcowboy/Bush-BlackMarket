function RegisterShop()
    for _, ShopInfo in ipairs(Config.ShopTypes) do
        exports.ox_inventory:RegisterShop(ShopInfo.type, {
            name = ShopInfo.label,
            inventory = ShopInfo.items,
            locations = {
                vector3(21.780282974243, -1107.4278564453, 29.797216415405) -- Changed vec3 to vector3
            }
        })
    end
end

RegisterShop()
