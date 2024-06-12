Utils = {}
Utils.Framework = nil
Utils.Functions = {}
Utils.Functions.CustomTarget = {}

function Utils.Functions.GetFrameworkType()
    if Utils.Functions.HasResource("qb-core") then
        return "qb"
    elseif Utils.Functions.HasResource("es_extended") then
        return "esx"
    end
end

--[[ Utils ]]
function Utils.Functions.printTable(table, indent)
    indent = indent or 0
    if type(table) == "table" then
        for k, v in pairs(table) do
            local tblType = type(v)
            local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)
            if tblType == "table" then
                print(formatting)
                Utils.Functions.printTable(v, indent + 1)
            else
                print(("%s^2 %s ^0"):format(formatting, v))
            end
        end
    else
        print(("%s ^0%s"):format(string.rep("  ", indent), table))
    end
end

---@param name string resource name
---@return boolean
function Utils.Functions.HasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

function Utils.Functions.GetFramework()
    if Utils.Functions.HasResource("qb-core") then
        return exports["qb-core"]:GetCoreObject()
    end
    if Utils.Functions.HasResource("es_extended") then
        return exports["es_extended"]:getSharedObject()
    end
end

function _e(event)
    local script = "0r-truthdare"
    return script .. ":" .. event
end

--[[ Core Thread]]

Utils.Framework = Utils.Functions.GetFrameworkType()
