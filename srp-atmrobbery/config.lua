Config = {}

Config.HeistCooldown = (60000 * 1)
Config.RequiredPolice = 0

Config.ATMRequiredItem = 'atm_disruptor'

Config.ProgressBarInteger = 12000

Config.ElectronicsDealerModel = `a_m_y_bevhills_01`
Config.ElectronicsDealerCoords = vector3(-1625.86, -362.17, 46.42)
Config.ElectronicsDealerIcon = 'fas fa-server'
Config.ElectronicsDealerLabel = 'Electronics?'

Config.ATMProps = {
    'prop_atm_01',
	'prop_atm_02',
	'prop_atm_03',
	'prop_fleeca_atm',
}

Config.ElectronicsDealerShop = {
    label = "I Got Goodies!",
    slots = 1,
    items = {
        [1] = {
            name = "atm_disruptor",
            price = 500,
            amount = 5,
            type = "item",
            slot = 1,
        },
    }
}

Config.ATMIcon = 'fas fa-microchip'
Config.ATMLabel = 'Setup ATM Disruptor'
Config.ATMLabelItem = 'atm_disruptor'

Config.RewardMoney = math.random(900, 1800)

Config.ScramblerHackType = 'runes'

Config.LuckyItem = 'rallykeyr'
Config.LuckyItemPossibility = math.random(1, 30)
Config.LuckyItemVariation = math.random(1, 30)