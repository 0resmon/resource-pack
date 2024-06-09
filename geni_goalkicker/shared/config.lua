Config = {
    AutoDatabaseCreator = false,
    UseCharacterNames = true, -- If it is false in UI you will see Steam names
    MinigameTime = 15, -- Second
    MultiplierTable = { -- First value (min) is player's total shoot number if total shoot number is smaller than min number player's multiplier will be data's multiplier
        {min = 50, multiplier = 0.30},
        {min = 100, multiplier = 0.32},
        {min = 150, multiplier = 0.34},
        {min = 250, multiplier = 0.36},
        {min = 300, multiplier = 0.38},
        {min = 350, multiplier = 0.40},
        {min = 400, multiplier = 0.42},
        {min = 450, multiplier = 0.44},
        {min = 500, multiplier = 0.46},
        {min = 600, multiplier = 0.48},
        {min = 900, multiplier = 0.50},
        {min = 1500, multiplier = 0.55},
        {min = 3000, multiplier = 0.58},
        {min = 6000, multiplier = 0.61},
    },
    GoalKickers = {
        {
            objectData = {
                coords = vector4(-1725.6, -1128.36, 13.03, 228.81), 
                duiDistance = 5,
                lodDistance = 40
            },
            blipData = {
                blip = true,
                sprite = 450, 
                color = 0, 
                blipName = "Goal Kicker"
            }
        },
        {
            objectData = {
                coords = vector4(-1742.75, -1106.1, 13.02, 49.72), 
                duiDistance = 5,
                lodDistance = 40
            },
            blipData = {
                blip = true,
                sprite = 450, 
                color = 0, 
                blipName = "Goal Kicker"
            }
        },
        {
            objectData = {
                coords = vector4(338.88, -204.1, 54.23, -20.64), 
                duiDistance = 5,
                lodDistance = 40
            },
            blipData = {
                blip = true,
                sprite = 450, 
                color = 0, 
                blipName = "Goal Kicker"
            }
        },
    },
    Interaction = {
        Target = {
            Enable = true,
            Distance = 2.0,
            Icon = "fa-solid fa-address-book"
        },
        Text = {
            Enable = false,
            Distance = 3.0,
            KickBallKey = 38,
            ShowScoreboardkey = 311
        },
        DrawText = {
            Enable = false,
            Distance = 3.0,
            KickBallKey = 38,
            ShowScoreboardkey = 311,
            Show = function()
                exports["qb-core"]:DrawText(Lang:t("text3d.text"), "left")
            end,
            Hide = function()
                exports["qb-core"]:HideText()
            end
        }
    }
}

function Config.DrawText3D(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end