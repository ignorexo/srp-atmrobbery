local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('srp-atmrobbery:server:AddMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local Possibility = Config.LuckyItemPossibility
    local Variation = Config.LuckyItemVariation

    if Possibility == Variation then
        Player.Functions.AddItem(Config.LuckyItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LuckyItem], 'add', 1)
        Player.Functions.AddItem('dirtymoney', Config.RewardMoney)
        TriggerClientEvent('QBCore:Notify', src, "You stole a role of cash.", "success")
        Player.Functions.AddMoney('cash', Config.RewardMoney, 'ATM withdrawal')
    else
        Player.Functions.AddMoney('cash', Config.RewardMoney, 'ATM withdrawal')
    end
end)

QBCore.Functions.CreateCallback('srp-atmrobbery:server:RemoveDisruptor', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local DisruptorScan = Player.Functions.GetItemByName(item)
    if DisruptorScan then
        cb(true)
        Player.Functions.RemoveItem(Config.ATMRequiredItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ATMRequiredItem], 'remove', 1)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('srp-atmrobbery:server:PoliceInteger', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayers()
    local PoliceInteger = 0

    for i = 1, #Player do
        local xPlayer = QBCore.Functions.GetPlayer(Player[i])
        if (xPlayer.PlayerData.job.name == 'police' and xPlayer.PlayerData.job.onduty) then
            PoliceInteger = PoliceInteger + 1
        end
    end

    if PoliceInteger >= Config.RequiredPolice then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, ('Not enough police'), 'error')
    end
end)