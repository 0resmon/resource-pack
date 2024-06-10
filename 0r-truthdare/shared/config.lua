--[[ Configuration settings ]]
Config            = {}
---Locale setting for language localization.
Config.Locale     = "en"
---@type "ox_target" | "qb_target" | "custom" -- System to be used
Config.TargetType = "ox_target"

---@type "dark"|"light"
Config.Theme      = "light"

--[[ Commands ]]
Config.Commands = {
    -- [[ To Open the menu. ]]
    openMenu = "truthdare", -- or nil
}

--[[ To Open the menu. ]]
Config.Item = "truthdare"

--[[ To Bottle item for flipping]]
Config.BottleItem         = "truthdare_bottle"

Config.QuestionCategories = {
    {
        key = "star",
        label = "Star",
        description = "Share your brightest moments",
        icon = "star.png",
    },
    {
        key = "fire",
        label = "Fire",
        description = "Share your passionate moments (Adult content)",
        icon = "fire.png",
        isAdult = true,
    },
    {
        key = "kiss",
        label = "Kiss",
        description = "Share your unforgettable kissing moments (Adult content)",
        icon = "kiss.png",
        isAdult = true,
    },
    {
        key = "couple",
        label = "Couple",
        description = "Share your moments as a couple",
        icon = "couple.png",
    },
    {
        key = "party",
        label = "Party",
        description = "Share your party moments",
        icon = "party.png",
    },
    {
        key = "crazy",
        label = "Crazy",
        description = "Share your craziest moments",
        icon = "crazy.png",
    },
    {
        key = "general",
        label = "General",
        description = "Share your general moments",
        icon = "general.png",
    },
}

Config.CategoryTasks      = {
    ["star"] = {
        ["truth"] = {
            "Share a moment when you were extremely embarrassed.",
            "Reveal the name of the last person you had a crush on.",
            "Describe in detail your all-time favorite movie and why you love it.",
        },
        ["dare"] = {
            "Compose and send a hilariously quirky message to your neighbor.",
            "Challenge yourself to stay completely still for 10 seconds without any movement.",
            "Summon the courage to ask your neighbor for a cup of sugar in the most polite yet amusing way possible.",
        },
    },
    ["fire"] = {
        ["truth"] = {
            "Open up about your deepest fear and why it affects you so profoundly.",
            "Confess the naughtiest or most mischievous act you've committed recently.",
            "Bravely reveal and display a photo of yourself at your most embarrassing moment.",
        },
        ["dare"] = {
            "Step outside and give a warm hug to the nearest person you encounter.",
            "Take the center stage and dance on the nearest table with wild abandon.",
            "Entertain everyone with your most hilariously energetic dance moves.",
        },
    },
    ["kiss"] = {
        ["truth"] = {
            "Share the story behind your very first kiss, including all the emotions and circumstances involved.",
            "Paint a vivid picture of a romantic dream you recently experienced, sparing no details.",
            "Relive and recount your most cherished romantic memory, from beginning to end.",
        },
        ["dare"] = {
            "Lock eyes with someone nearby for a daring 10 seconds, and see if they reciprocate.",
            "Attempt to hang upside down from a table, showcasing your playful side.",
            "Impersonate someone funny and give it your best shot to spread laughter.",
        },
    },
    ["couple"] = {
        ["truth"] = {
            "Recall and share an embarrassing or awkward experience from one of your dates.",
            "Discuss your ultimate favorite romantic movie and why it holds a special place in your heart.",
            "Delight everyone with the tale of your funniest blunder in a relationship.",
        },
        ["dare"] = {
            "Exchange shoes with your partner and strut around for a little while, experiencing each other's footwear.",
            "Team up and perform an impromptu dance routine, showcasing your unity and coordination.",
            "Entertain the group by mimicking a funny voice or character with your partner.",
        },
    },
    ["party"] = {
        ["truth"] = {
            "Recount a particularly embarrassing moment from one of your past parties.",
            "Revisit your fondest memory from any party you've attended and share it with the group.",
            "Bring laughter to the room by narrating your most amusing party anecdote.",
        },
        ["dare"] = {
            "Take the fun indoors and dance around the house to the beat of your favorite song.",
            "Spread joy by flashing a warm smile at everyone in the room for a full 10 seconds.",
            "Liven up the atmosphere by singing a song while doing a little lap around the table.",
        },
    },
    ["crazy"] = {
        ["truth"] = {
            "Describe in vivid detail your most bizarre or surreal nightmare.",
            "Share a memory of a peculiar or eccentric pet experience that has stuck with you.",
            "Recount the scariest or most spine-chilling encounter you've ever had.",
        },
        ["dare"] = {
            "Embrace the absurdity and take the most outrageously embarrassing selfie you can think of.",
            "Let loose and roll around on the floor in a fit of laughter or silliness for a solid 10 seconds.",
            "Infuse the room with energy by dancing wildly around the house, without a care in the world.",
        },
    },
    ["general"] = {
        ["truth"] = {
            "Confess a quirky or unusual habit of yours that others might find embarrassing.",
            "Reveal a secret fantasy or desire that you've kept hidden from others.",
            "Share your favorite music genre and what draws you to it above all others.",
        },
        ["dare"] = {
            "Test your neighbor's generosity by asking them for a simple glass of water.",
            "Unleash your creativity and make the most bizarre and amusing noise you can think of.",
            "Take a trip down memory lane and reenact your favorite childhood game for 10 seconds of nostalgic fun.",
        },
    },
}
