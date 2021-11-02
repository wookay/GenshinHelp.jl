# module GenshinHelp

export genshin_characters

using StringDistances

const levenshtein = Levenshtein()

const baseoptions = (;
    dumpResult = false,
    matchAltNames = true,
    matchAliases = false,
    matchCategories = false,
    verboseCategories = false,
    queryLanguages = ["English"],
    resultLanguage = "English"
)

function buildQueryDict(querylangs, folder, opts)
    dict = opts.matchCategories ? ["names"] : String[]
    for lang in querylangs
        langindex = getIndex(lang, folder)
        langindex === nothing && continue
        haskey(langindex, "names") && append!(dict, keys(langindex["names"]))
    end
    dict
end

function autocomplete(input, dict)
    (nearest, idx) = findnearest(input, dict, levenshtein)
    nearest
end

function retrieveData(query, folder, options, getfilename)
    opts = merge(baseoptions, options)
    queryMatch = autocomplete(query, buildQueryDict(opts.queryLanguages, folder, opts))
    queryMatch === nothing && return nothing
    for lang in opts.queryLanguages
        langindex = getIndex(lang, folder)
        langindex === nothing && continue
        if haskey(langindex["names"], queryMatch)
            filename::String = langindex["names"][queryMatch]
            getfilename && return filename
            result = getData(opts.resultLanguage, folder, filename)
            return result
        end
        @info :langindex langindex
    end
end

function genshin_characters(query; opts...)
    return retrieveData(query, Folder.characters, opts, false)
end

# module GenshinHelp
