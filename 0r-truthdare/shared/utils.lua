Resmon = nil
Utils = {}
Utils.Framework = nil
Utils.Functions = {}
Utils.Functions.CustomTarget = {}

function Utils.Functions.GetFrameworkType()
    if not Resmon then return false end
    local framework = Resmon.Lib.GetFramework()
    if string.lower(framework) == "qbcore" then
        return "qb"
    elseif string.lower(framework) == "esx" then
        return "esx"
    end
end

function Utils.Functions.GetResmonLib()
    if Utils.Functions.HasResource("0r_lib") then
        local Core = exports["0r_lib"]:GetCoreObject()
        return Core
    else
        CreateThread(function()
            Wait(30000)
            Utils.Functions.printTable(
                "^1!!! The installation could not be done because the 0r_lib could not be found !!!"
            )
        end)
        return false
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

function Utils.Functions.deepCopy(value)
    return Resmon.Lib._deepCopy(value)
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

Resmon = Utils.Functions.GetResmonLib()
Utils.Framework = Utils.Functions.GetFrameworkType()
CreateThread(function()
    while Resmon == nil do
        Resmon = Utils.Functions.GetResmonLib()
        Wait(100)
    end
    Utils.Framework = Utils.Functions.GetFrameworkType()
end)
