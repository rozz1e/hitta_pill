ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem(Config.Item, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Item, 1)
    TriggerClientEvent('hitta_pill:takePill', source)
end)