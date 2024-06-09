Config = {
    MenuAlign = "right", -- left or right
    Dialogs = {
        { -- 1
            Ped = {
                Enable = true,
                coords = vector4(-1465.16, -34.56, 55.05, 310.67),
                hash = "a_m_y_hasjew_01", -- Check here https://docs.fivem.net/docs/game-references/ped-models/
                animDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
                animName = "idle_a"
            },
            Blip = { -- https://docs.fivem.net/docs/game-references/blips/
                Enable = false,
                coords = vector3(-1465.16, -34.56, 55.05),
                sprite = 59,
                color = 2,
                scale = 0.5,
                text = "Blip Text"
            },
            Menu = {
                Label = "HEIST MISSION",
                Description = "SYSTEM",
                Icon = "fas fa-hands-usd", -- https://fontawesome.com/v5/search | You can use Pro Icons too
            },
            AutoMessage = { -- This is an automatic message system that sends automatic message when you open dialog menu.
                Enable = true,
                AutoMessages = {
                    {type = "question", text = "Welcome, choose a mission."},
                    --{type = "message",  text = "This is an automatic message."}
                }
            },
            Buttons = {
                [1] = { -- Button 1 and answers
                    label = "Accept Heist",
                    systemAnswer = {enable = true, type = "question", text = "You accepted heist you want to coordinate plan?"},
                    playerAnswer = {enable = true, text = "Yes let's do it!"},
                    maxClick = 2,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [2] = { -- Button 2 and answers
                    label = "Coordinate Plan",
                    systemAnswer = {enable = true, type = "message", text = "We need to synchronize our watches and stick to the plan."},
                    playerAnswer = {enable = true, text = "Agreed. Everyone, make sure you know your roles and follow the timeline."},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [3] = { -- Button 3 and answers
                    label = "Execute Mission",
                    systemAnswer = {enable = true, type = "message", text = "It's time. Let's move in and secure the objective."},
                    playerAnswer = {enable = true, text = "Roger that. Stay focused and don't engage unless absolutely necessary."},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [4] = { -- Button 4 and answers
                    label = "Escape Route",
                    systemAnswer = {enable = true, type = "message", text = "The authorities are closing in. We need a clear path for extraction."},
                    playerAnswer = {enable = false, text = "Understood. Head to the rendezvous point, and be ready to move fast."},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                -- Don't write more than 5 buttons
            },
            Interaction = {
                Target = {
                    Enable = false,
                    Distance = 2.0,
                    Label = "Contact",
                    Icon = "fa-solid fa-address-book"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Contact"
                },
                DrawText = {
                    Enable = true,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
        { -- 2
            Ped = {
                Enable = true,
                coords = vector4(-266.53, -972.09, 31.22, 221.37),
                hash = "a_m_m_soucent_02", -- Check here https://docs.fivem.net/docs/game-references/ped-models/
                animDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
                animName = "idle_a"
            },
            Blip = { -- https://docs.fivem.net/docs/game-references/blips/
                Enable = false,
                coords = vector3(-266.53, -972.09, 31.22),
                sprite = 59,
                color = 2,
                scale = 0.5,
                text = "Blip Text"
            },
            Menu = {
                Label = "GOVERNMENT",
                Description = "MENU",
                Icon = "fas fa-id-card-alt", -- https://fontawesome.com/v5/search | You can use Pro Icons too
            },
            AutoMessage = { -- This is an automatic message system that sends automatic message when you open dialog menu.
                Enable = true,
                AutoMessages = {
                    {type = "question", text = "Welcome, choose what you want to do."},
                    --{type = "message",  text = "This is an automatic message."}
                }
            },
            Buttons = {
                [1] = { -- Button 1 and answers
                    label = "Renew ID Card",
                    systemAnswer = {enable = true, type = "question", text = "You want to renew your identity card?"},
                    playerAnswer = {enable = true, text = "Yes I lost it, I need new one!"},
                    maxClick = 2,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [2] = { -- Button 2 and answers
                    label = "Renew Driver License",
                    systemAnswer = {enable = true, type = "message", text = "You want to renew your driver license?"},
                    playerAnswer = {enable = true, text ="Yes I lost it, I need new one!"},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [3] = { -- Button 3 and answers
                    label = "Buy License",
                    systemAnswer = {enable = true, type = "message", text = "You want to buy a weapon license."},
                    playerAnswer = {enable = true, text = "Yes I need to protect myself."},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        -- exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                [4] = { -- Button 4 and answers
                    label = "Leave Conversation",
                    systemAnswer = {enable = false, type = "message", text = "The authorities are closing in. We need a clear path for extraction."},
                    playerAnswer = {enable = false, text = "Understood. Head to the rendezvous point, and be ready to move fast."},
                    maxClick = 1,
                    onClick = function()
                        -- Write your export or events here
                        exports[GetCurrentResourceName()]:closeMenu()
                    end
                },
                -- Don't write more than 5 buttons
            },
            Interaction = {
                Target = {
                    Enable = false,
                    Distance = 2.0,
                    Label = "Contact",
                    Icon = "fa-solid fa-address-book"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Contact"
                },
                DrawText = {
                    Enable = true,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")

                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
    }
}