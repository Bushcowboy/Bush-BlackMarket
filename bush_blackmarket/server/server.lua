function RegisterShop()
    for _, ShopInfo in pairs(Config.Peds) do
        for _, info in ipairs(ShopInfo.info) do
            exports.ox_inventory:RegisterShop(info.type, {
                name = info.label,
                inventory = info.items,
                locations = { ShopInfo.coords }
            })
        end
    end
end

RegisterShop()
