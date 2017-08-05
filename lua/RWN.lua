if not _G.RWNLoc then
_G.RWNLoc = _G.RWNLoc or {}
RWNLoc._path = ModPath .. "lua/loc/"

-- Determina le lingue supportate dalla mod e le identifica
Hooks:Add("LocalizationManagerPostInit", "RWNLoc_LocalizationManagerPostInit", function(loc)
    local current_language = nil
    local supported_languages = {
        ["chinese"] = "ch",
        ["german"] = "de",
        ["english"] = "en",
        ["spanish"] = "es",
        ["french"] = "fr",
        ["italian"] = "it",
        ["russian"] = "ru",
    }
    for k,v in pairs(supported_languages) do
        if Idstring(k):key() == SystemInfo:language():key() then
            log("RWN: Current language is: " .. v)
            current_language = v
        end
    end

    if current_language then -- Controlla che la lingua sia stata identificata nel modo corretto
        local _path = RWNLoc._path .. current_language .. ".txt"

        if io.file_is_readable(_path) then -- Il file esiste?
            loc:load_localization_file(RWNLoc._path .. current_language .. ".txt") -- current_language == nome del file!
            loc:load_localization_file(RWNLoc._path .. "en.txt", false) -- Se mancano stringhe nelle altre lingue vengono usate quelle inglesi
        else -- Se altrimenti non esistono altri file carica la localizzazione inglese
            loc:load_localization_file(RWNLoc._path .. "en.txt")
        end
    end
end)

end
