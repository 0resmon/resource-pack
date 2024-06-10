-- Loads a specific locale file based on the given locale.
-- If the file is not found, falls back to the default "en" locale.
---@param locale string The desired locale.
---@return string file The content of the loaded locale file.
local function loadLocaleFile(locale)
    local resourceName = GetCurrentResourceName()
    local file = LoadResourceFile(resourceName, ("locales/%s.lua"):format(locale))
    if not file then
        file = LoadResourceFile(resourceName, "locales/en.lua")
        CreateThread(function()
            print(("Locale file \"%s\" not found, falling back to default \"en\"."):format(locale))
        end)
    end
    return file
end

-- Loads the locale data from a file and returns it.
-- Also handles error cases by printing and raising an error.
---@param locale string The desired locale.
---@return table table The loaded locale data.
local function loadLocale(locale)
    local file = loadLocaleFile(locale)
    local data, err = load(file)
    if err then
        print(err)
        error(err)
    end
    return data()
end

-- Loads the default or user-configured locale and stores the data.
locales = loadLocale(Config.Locale or "en")

-- Takes a key and optional arguments, then formats the corresponding localized text.
---@param key string The key to look up in the locale data.
---@return string value The formatted localized text.
function _t(key, ...)
    local keys = {}
    for k in string.gmatch(key, "[^.]+") do
        table.insert(keys, k)
    end
    local currentTable = locales
    for _, k in ipairs(keys) do
        currentTable = currentTable[k]
        if not currentTable then
            return key
        end
    end
    if type(currentTable) == "string" then
        return currentTable:format(...)
    else
        return key
    end
end
