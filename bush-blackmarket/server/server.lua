function RegisterShop()
    for i = 1, #Config.Peds do
        local ShopInfo = Config.Peds[i]
        for j = 1, #ShopInfo.info do
            local info = ShopInfo.info[j]
            exports.ox_inventory:RegisterShop(info.type, {
                name = info.label,
                inventory = info.items,
                locations = { ShopInfo.location }
            })
        end
    end
end

RegisterShop()
