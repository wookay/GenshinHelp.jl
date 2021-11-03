# module GenshinHelp

export getData, getIndex, getImage, getStats

global alldata  = Dict{String, Any}()
global allindex = Dict{String, Any}()
global allimage = Dict{String, Any}()
global allurl   = Dict{String, Any}()
global allstats = Dict{String, Any}()
global allcurve = Dict{String, Any}()

const availableimage = ["characters", "artifacts", "weapons", "constellations", "talents", "materials", "foods", "elements", "domains", "enemies"]
const availableurl   = ["characters", "artifacts", "weapons", "foods", "materials"]
const availablestats = ["characters", "weapons"]
const availablecurve = ["characters", "weapons"]

function calcStatsCharacter(filename)
end

function calcStatsWeapon(filename)
end

const calcStatsMap = Dict(
    "characters" => calcStatsCharacter,
    "weapons" => calcStatsWeapon
)

function setAttributesTalent(data, filename)
    myparams = getStats("talents", filename)
    for prop in ("combat1", "combat2", "combatsp", "combat3")
        !haskey(myparams, prop) && continue
        data_prop::Dict = data[prop]
        data_prop_attributes::Dict = data_prop["attributes"]
        data_prop_attributes["parameters"] = myparams[prop]
    end
end

function getData(lang, folder, filename)
    tmp::Dict = alldata[lang][folder][filename]
    if !haskey(tmp, "images") && folder in availableimage
        tmp["images"] = getImage(folder, filename)
    end
    if !haskey(tmp, "url") && folder in availableurl
        tmp["url"] = getURL(folder, filename)
    end
    if !haskey(tmp, "stats") && folder in availablestats && haskey(calcStatsMap, folder)
        tmp["stats"] = calcStatsMap[folder](filename)
    end
    if folder == "talents" && !haskey(tmp["combat1"], "parameters")
        setAttributesTalent(tmp, filename)
    end
    return tmp
end

function getIndex(lang, folder)
    return allindex[lang][folder]
end

function getImage(folder, filename)
    return allimage[folder][filename]
end

function getURL(folder, filename)
    return allurl[folder][filename]
end

function getStats(folder, filename)
    return allstats[folder][filename]
end

function getCurve(folder)
    return allcurve[folder]
end

# module GenshinHelp
