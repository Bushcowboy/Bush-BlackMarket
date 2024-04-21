function RegisterShop()
    for _, ShopInfo in ipairs(Config.Peds) do
        for _, info in ipairs(ShopInfo.info) do
            exports.ox_inventory:RegisterShop(info.type, {
                name = info.label,
                inventory = info.items,
                locations = { ShopInfo.location }
            })
        end
    end
end

RegisterShop()
