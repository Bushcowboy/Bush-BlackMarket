function RegisterShop()
    for _, ShopInfo in ipairs(Config.ShopTypes) do
        exports.ox_inventory:RegisterShop(ShopInfo.type, {
            name = ShopInfo.label,
            inventory = ShopInfo.items,
            locations = Config.Peds.location
        })
    end
end

RegisterShop()
