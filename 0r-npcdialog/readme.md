---
description: To hide menu use this export: exports["0r-npcdialog"]:closeMenu()
---

## Here is a empty npc dialog to help you creating new ones.

```lua
{ -- 1
    Ped = {
        Enable = true,
        coords = Vector4 Coords,
        hash = "Ped Hash" -- Check here https://docs.fivem.net/docs/game-references/ped-models/
    },
    Blip = { -- https://docs.fivem.net/docs/game-references/blips/
        Enable = false, -- to enable make it true
        coords = Vector3 Coords,
        sprite = Blip Sprite,
        color = Blip Color,
        scale = Blip Scale,
        text = "Blip Text"
    },
    Menu = {
        Label = "Menu Label",
        Description = "Menu Description",
        Icon = "fas fa-hands-usd", -- Fınd an icon for your menu from this website https://fontawesome.com/v5/search | You can use Pro Icons too
    },
    AutoMessage = { -- This is an automatic message system that sends automatic message when you open dialog menu.
        Enable = false, -- to enable make it true
        AutoMessages = {
            {type = "question", text = "Write your text here."}, -- message type question means it adds a question icon to message
            {type = "message",  text = "Write your text here."} -- this is a default message
        }
    },
    Buttons = {
        [1] = { -- Button 1 and answers
            label = "Button Label",
            systemAnswer = {enable = true, type = "question", text = "You accepted heist you want to coordinate plan?"},
            playerAnswer = {enable = true, text = "Yes let's do it!"},
            maxClick = 2, -- Max click amount after the amount maximize it disables button
            onClick = function()
                -- Write your export or events here
                -- exports[GetCurrentResourceName()]:closeMenu()
            end
        },
        [2] = { -- Button 2 and answers
            label = "Button Label",
            systemAnswer = {enable = true, type = "message", text = "We need to synchronize our watches and stick to the plan."},
            playerAnswer = {enable = true, text = "Agreed. Everyone, make sure you know your roles and follow the timeline."},
            maxClick = 1, -- Max click amount after the amount maximize it disables button
            onClick = function()
                -- Write your export or events here
                -- exports[GetCurrentResourceName()]:closeMenu()
            end
        },
        [3] = { -- Button 3 and answers
            label = "Button Label",
            systemAnswer = {enable = true, type = "message", text = "It's time. Let's move in and secure the objective."},
            playerAnswer = {enable = true, text = "Roger that. Stay focused and don't engage unless absolutely necessary."},
            maxClick = 1, -- Max click amount after the amount maximize it disables button
            onClick = function()
                -- Write your export or events here
                -- exports[GetCurrentResourceName()]:closeMenu()
            end
        },
        [4] = { -- Button 4 and answers
            label = "Button Label",
            systemAnswer = {enable = true, type = "message", text = "The authorities are closing in. We need a clear path for extraction."},
            playerAnswer = {enable = false, text = "Understood. Head to the rendezvous point, and be ready to move fast."},
            maxClick = 1, -- Max click amount after the amount maximize it disables button
            onClick = function()
                -- Write your export or events here
                -- exports[GetCurrentResourceName()]:closeMenu()
            end
        },
        -- Don't write more than 5 buttons
    },
    Interaction = {
        Target = {
            Enable = false, -- to enable make it true
            Distance = 2.0,
            Label = "Target Label",
            Icon = "fa-solid fa-address-book"
        },
        Text = {
            Enable = true, -- to enable make it true
            Distance = 3.0,
            Label = "Text Label"
        },
        DrawText = {
            Enable = false, -- to enable make it true
            Distance = 3.0,
            Show = function()
                exports["qb-core"]:DrawText("[Key Name] Text Label", "Menu Position - left, right")
            end,
            Hide = function()
                exports["qb-core"]:HideText()
            end
        }
    }
},
```