CreateThread(function()
    local model = Config.ElectronicsDealerModel
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1000) end

    local ElectronicsDealer = CreatePed(0, model, Config.ElectronicsDealerCoords -1.0, 24.41, 0.0, false, false)

    local ScenarioTable = { 
        'WORLD_HUMAN_DRUG_DEALER'
    }
    local ScenarioRequest = math.random(1, #ScenarioTable)

    FreezeEntityPosition(ElectronicsDealer, true)
    SetEntityInvincible(ElectronicsDealer, true)
    SetEntityNoCollisionEntity(ElectronicsDealer, true)
    TaskStartScenarioInPlace(ElectronicsDealer, ScenarioTable[ScenarioRequest], -1, true)

    exports['srp-target']:AddTargetEntity(ElectronicsDealer, {
        options = {
        {
            type = 'client',
            event = 'srp-atmrobbery:client:ElectronicsMenu',
            icon = Config.ElectronicsDealerIcon,
            label = Config.ElectronicsDealerLabel
        }
        },
        distance = 2.5,
    })
end)

RegisterNetEvent('srp-atmrobbery:client:ElectronicsMenu', function()
    exports['srp-menu']:openMenu({
        {
            header = 'Electronics?',
            icon = 'fas fa-server',
            isMenuHeader = true,
        },
        {
            header = 'Purchase goodies!',
            txt = 'Purchase Electronic',
            icon = 'fas fa-cash-register',
            params = {
                event = 'srp-atmrobbery:client:openShop',
                args = {}
            }
        },
    })
end)

RegisterNetEvent('srp-atmrobbery:client:openShop', function()
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Electronics Dealer', Config.ElectronicsDealerShop)
end)

exports['srp-target']:AddTargetModel(Config.ATMProps,  {
	options = {
		{
		type = 'client',
		event = 'srp-atmrobbery:UseDisruptor',
		icon = Config.ATMIcon,
		label = Config.ATMLabel,
		item = Config.ATMLabelItem,
		},
	},
	distance = 2.5,
})