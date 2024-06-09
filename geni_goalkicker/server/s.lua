RegisterNetEvent('geni_goalkicker:getPropData', function(id)
    local goalKickerData = MySQL.query.await('SELECT * FROM geni_goalkicker_data WHERE gkId = ?', {id})
    if goalKickerData[1] then
        if goalKickerData[1].best then
            TriggerClientEvent('geni_goalkicker:updateBestScore', -1, id, goalKickerData[1].best)
        end
    end
end)

RegisterNetEvent('geni_goalkicker:getScoreboard', function(id)
    local src = source
    -- Identifier
    local myIdentifier = nil
    local identifiers = GetPlayerIdentifiers(src)
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "license:") then
            myIdentifier = identifier
        end
    end
    while myIdentifier == nil do Citizen.Wait(0) end
    -- Discord
    local myDiscord = nil
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "discord:") then
            myDiscord = string.gsub(identifier, "discord:", "")
        end
    end
    local discordProfileAvatar = "files/defaultpp.webp"
    while myDiscord == nil do Citizen.Wait(5000) if myDiscord == nil then break end end
    local endpoint = ("users/%s"):format(myDiscord)
    local member = DiscordRequest("GET", endpoint, {})
    local memberData = json.decode(member.data)
    if memberData ~= nil then
        discordProfileAvatar = "https://cdn.discordapp.com/avatars/" .. myDiscord .. "/" .. memberData.avatar
    end
    -- Functions
    local myData = MySQL.query.await('SELECT * FROM geni_goalkicker_scoreboard WHERE gkId = ? AND license = ?', {id, myIdentifier})
    local myRank = "Unknown"
    local myTable = {}
    local scoreBoardData = MySQL.query.await('SELECT * FROM geni_goalkicker_scoreboard WHERE gkId = ?', {id})
    local scoreBoardTable = {}
    if next(scoreBoardData) ~= nil then
        for k, v in pairs(scoreBoardData) do
            table.insert(scoreBoardTable, {
                total = v.total,
                skill = v.skill,
                highest = v.highest,
                name = v.name,
                avatar = v.avatar,
                license = v.license
            })
        end
        table.sort(scoreBoardTable, function(a, b)
            return a.highest > b.highest
        end)
        for k, v in pairs(scoreBoardTable) do
            if v.license == myIdentifier then
                myRank = k
            end
        end
        if next(myData) ~= nil then
            for k, v in pairs(myData) do
                table.insert(myTable, {
                    total = v.total,
                    skill = v.skill,
                    highest = v.highest,
                    name = v.name,
                    avatar = v.avatar,
                    rank = myRank
                })
            end
        else
            local myName = GetPlayerName(src)
            if Config.UseCharacterNames then
                myName = GetCharName(src)
            end
            table.insert(myTable, {
                total = "UNKNOWN",
                skill = "UNKNOWN",
                highest = "UNKNOWN",
                name = myName,
                avatar = discordProfileAvatar,
                rank = "UNKNOWN"
            })
        end
        TriggerClientEvent('geni_goalkicker:openScoreboard', src, scoreBoardTable, myTable[1])
    else
        local myName = GetPlayerName(src)
        if Config.UseCharacterNames then
            myName = GetCharName(src)
        end
        table.insert(myTable, {
            total = "UNKNOWN",
            skill = "UNKNOWN",
            highest = "UNKNOWN",
            name = myName,
            avatar = discordProfileAvatar,
            rank = "UNKNOWN"
        })
        TriggerClientEvent('geni_goalkicker:openScoreboard', src, "unknown", myTable[1])
    end
end)

RegisterNetEvent('geni_goalkicker:kick', function(score, id)
    TriggerClientEvent('geni_goalkicker:updateCurrentScore', -1, id, score)
    local src = source
    local myHighestScore = nil
    -- Identifier
    local myIdentifier = nil
    local identifiers = GetPlayerIdentifiers(src)
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "license:") then
            myIdentifier = identifier
        end
    end
    while myIdentifier == nil do Citizen.Wait(0) end
    -- Discord
    local myDiscord = nil
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "discord:") then
            myDiscord = string.gsub(identifier, "discord:", "")
        end
    end
    local discordProfileAvatar = nil
    local myAvatar = "files/defaultpp.webp"
    while myDiscord == nil do Citizen.Wait(5000) if myDiscord == nil then break end end
    local endpoint = ("users/%s"):format(myDiscord)
    local member = DiscordRequest("GET", endpoint, {})
    local memberData = json.decode(member.data)
    if memberData ~= nil then
        discordProfileAvatar = "https://cdn.discordapp.com/avatars/" .. myDiscord .. "/" .. memberData.avatar
    end
    if discordProfileAvatar then
        myAvatar = discordProfileAvatar
    end
    -- Functions
    local type2 = getType2(id)
    local goalKickerData = MySQL.query.await('SELECT * FROM geni_goalkicker_data WHERE gkId = ?', {id})
    if next(goalKickerData) == nil then
        myHighestScore = score
        TriggerClientEvent('geni_goalkicker:updateBestScore', -1, id, score)
    else
        for k, v in pairs(goalKickerData) do
            if score > v.best then
                myHighestScore = score
                TriggerClientEvent('geni_goalkicker:updateBestScore', -1, id, score)
                if type2.type == "update" then
                    MySQL.update('UPDATE geni_goalkicker_data SET best = ? WHERE gkId = ?', {score, id})
                end
            end
        end
    end
    if type2.type == "insert" then
        MySQL.insert('INSERT INTO geni_goalkicker_data (best, gkId) VALUES (:best, :gkId)', {
            best = score,
            gkId = id
        })
    end
    -- Scoreboard
    local type = getType(myIdentifier, id)
    if type.type == "update" then
        local playerData = MySQL.query.await('SELECT * FROM geni_goalkicker_scoreboard WHERE gkId = ? AND license = ?', {id, myIdentifier})
        local playerData2 = MySQL.query.await('SELECT * FROM geni_goalkicker_player_data WHERE license = ?', {myIdentifier})
        if playerData[1] and playerData2[1] then
            if myHighestScore then
                local total = tonumber(playerData[1].total) + 1
                local skill = tonumber(playerData2[1].skill) + 0.1
                local highest = myHighestScore
                MySQL.update('UPDATE geni_goalkicker_scoreboard SET total = ?, skill = ?, highest = ? WHERE license = ?', {total, skill, highest, myIdentifier})
            else
                local total = tonumber(playerData[1].total) + 1
                local skill = tonumber(playerData2[1].skill) + 0.1
                MySQL.update('UPDATE geni_goalkicker_scoreboard SET total = ?, skill = ? WHERE license = ?', {total, skill, myIdentifier})
            end
        end
    else
        local myName = GetPlayerName(src)
        if Config.UseCharacterNames then
            myName = GetCharName(src)
        end
        MySQL.insert('INSERT INTO geni_goalkicker_scoreboard (license, gkId, total, skill, highest, name, avatar) VALUES (:license, :gkId, :total, :skill, :highest, :name, :avatar)', {
            license = myIdentifier,
            total = 1,
            skill = 0.1,
            highest = score,
            name = myName,
            avatar = myAvatar,
            gkId = id
        })
    end
    -- Player Data
    local type3 = getType3(myIdentifier)
    if type3.type == "insert" then
        local myName = GetPlayerName(src)
        if Config.UseCharacterNames then
            myName = GetCharName(src)
        end
        MySQL.insert('INSERT INTO geni_goalkicker_player_data (license, total, skill, highest, name, avatar) VALUES (:license, :total, :skill, :highest, :name, :avatar)', {
            license = myIdentifier,
            total = 1,
            skill = 0.1,
            highest = score,
            name = myName,
            avatar = myAvatar
        })
    elseif type3.type == "update" then
        local playerData = MySQL.query.await('SELECT * FROM geni_goalkicker_player_data WHERE license = ?', {myIdentifier})
        if playerData[1] then
            if myHighestScore then
                local total = tonumber(playerData[1].total) + 1
                local skill = tonumber(playerData[1].skill) + 0.1
                local highest = myHighestScore
                MySQL.update('UPDATE geni_goalkicker_player_data SET total = ?, skill = ?, highest = ? WHERE license = ?', {total, skill, highest, myIdentifier})
            else
                local total = tonumber(playerData[1].total) + 1
                local skill = tonumber(playerData[1].skill) + 0.1
                MySQL.update('UPDATE geni_goalkicker_player_data SET total = ?, skill = ? WHERE license = ?', {total, skill, myIdentifier})
            end
        end
    end
end)

function DiscordRequest(method, endpoint, jsondata, reason)
    local FormattedToken = "Bot " .. ConfigSV.DiscordBotToken
    local data = nil
    PerformHttpRequest("https://discord.com/api/"..endpoint, function(errorCode, resultData, resultHeaders) data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and jsondata or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken, ['X-Audit-Log-Reason'] = reason})
    while data == nil do Citizen.Wait(0) end
    return data
end

function getType(identifier, id)
    local myScoreboardData = MySQL.query.await('SELECT * FROM geni_goalkicker_scoreboard WHERE gkId = ? AND license = ?', {id, identifier})
    if myScoreboardData[1] then
        if myScoreboardData[1].gkId == id then
            return {type = "update"}
        end
    end
    return {type = "insert"}
end

function getType2(id)
    local goalKickerData = MySQL.query.await('SELECT * FROM geni_goalkicker_data WHERE gkId = ?', {id})
    if goalKickerData[1] then
        if goalKickerData[1].gkId == id then
            return {type = "update"}
        end
    end
    return {type = "insert"}
end

function getType3(license)
    local playerData = MySQL.query.await('SELECT * FROM geni_goalkicker_player_data WHERE license = ?', {license})
    if playerData[1] then
        return {type = "update"}
    end
    return {type = "insert"}
end

RegisterNetEvent('geni_goalkicker:busyData:server', function(id, state)
    TriggerClientEvent('geni_goalkicker:busyData:client', -1, id, state)
end)

if Config.AutoDatabaseCreator then
    Citizen.CreateThread(function()
        while CoreReady == false do Citizen.Wait(0) end
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS `geni_goalkicker_data` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `gkId` int(11) NOT NULL DEFAULT 0,
            `best` int(11) DEFAULT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;]], {}, function(rowsChanged)
        end)
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS `geni_goalkicker_player_data` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `license` varchar(50) NOT NULL DEFAULT '0',
            `total` int(11) DEFAULT NULL,
            `skill` float DEFAULT NULL,
            `highest` int(11) DEFAULT NULL,
            `name` varchar(50) DEFAULT NULL,
            `avatar` longtext DEFAULT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;]], {}, function(rowsChanged)
        end)
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS `geni_goalkicker_scoreboard` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `license` varchar(50) NOT NULL DEFAULT '0',
            `gkId` int(11) DEFAULT NULL,
            `total` int(11) DEFAULT NULL,
            `skill` float DEFAULT NULL,
            `highest` int(11) DEFAULT NULL,
            `name` varchar(50) DEFAULT NULL,
            `avatar` longtext DEFAULT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;]], {}, function(rowsChanged)
        end)
    end)
end