local QBCore = exports['qb-core']:GetCoreObject()
local RecentRobbery = 0, 0, 0

local function spawnShootingGuards()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local radius = 10.0
    local guardCount = 3

    for i = 1, guardCount do
        local angle = (2 * math.pi / guardCount) * i
        local offsetX = playerCoords.x + radius * math.cos(angle)
        local offsetY = playerCoords.y + radius * math.sin(angle)
        local pedModel = "s_m_m_security_01"
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Citizen.Wait(500)
        end
        local ped = CreatePed(4, GetHashKey(pedModel), offsetX, offsetY, playerCoords.z, angle * 180 / math.pi, true, false)
        SetPedRelationshipGroupHash(ped, GetHashKey("ARMY"))
        GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 1000, false, true)
        SetPedAccuracy(ped, 40)
        TaskWanderStandard(ped, 10.0, 10)
        Citizen.CreateThread(function()
            Citizen.Wait(1500)
            TaskCombatPed(ped, playerPed, 0, 16)
        end)
    end
end

RegisterNetEvent('srp-atmrobbery:UseDisruptor', function()
    if RecentRobbery == 0 or GetGameTimer() > RecentRobbery then
        spawnShootingGuards()

        QBCore.Functions.TriggerCallback('srp-atmrobbery:server:PoliceInteger', function(ReturnStatus)
            if ReturnStatus then
                QBCore.Functions.TriggerCallback('srp-atmrobbery:server:RemoveDisruptor', function(ItemChecks)
                    
                end, Config.ATMRequiredItem)
            end
        end)

        QBCore.Functions.Progressbar('atm_connecting_disruptor', 'Plugging in disruptor', Config.ProgressBarInteger, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 49,
        }, {}, {}, function()
            ClearPedTasks(PlayerPedId())
            RecentRobbery = GetGameTimer() + Config.HeistCooldown
            exports['ps-ui']:Scrambler(function(success)
                if success then
                    QBCore.Functions.Progressbar('atm_grabing_cash', 'Grabing cash', Config.ProgressBarInteger, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = 'oddjobs@shop_robbery@rob_till',
                        anim = 'loop',
                        flags = 17,
                    }, {}, {}, function()
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent('srp-atmrobbery:server:AddMoney')
                    end)
                else
                    QBCore.Functions.Notify('Pin incorrect', 'error', 5000)
                end
            end, Config.ScramblerHackType, 20, 0)
        end)
    else
        QBCore.Functions.Notify('Firewall breach detected, come back later', 'error', 5000)
    end
end)