function Utils.Functions.CustomTarget.AddTargetModel(model, options)
    --[[
        The following variables will help you.
        Integrate them according to your own target script.
        !!! return created target id ! for it to be removable
        example:
            exports.ox_target:addModel(model, options)
    ]]
end

function Utils.Functions.CustomTarget.RemoveTargetModel(model)
    --[[
        -- models:string or table
        example:
            exports.ox_target:removeModel(model, optionNames)
    ]]
end

-- @ --
function Utils.Functions.RequestModel(model)
    model = tonumber(model) or GetHashKey(model)
    if HasModelLoaded(model) then return true end
    local count = 0
    while not HasModelLoaded(model) do
        if count > 100 then
            return false
        end
        RequestModel(model)
        count = count + 1
        Wait(10)
    end
    return true
end
