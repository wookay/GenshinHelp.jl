# module GenshinHelp

export genshin_characters,
       genshin_talents,
       genshin_talentmaterialtypes,
       genshin_constellations,
       genshin_weapons,
       genshin_weaponmaterialtypes,
       genshin_materials,
       genshin_artifacts,
       genshin_foods,
       genshin_domains,
       genshin_enemies,
       genshin_elements,
       genshin_rarity

using StringDistances

const distance_dist = Levenshtein()

const baseoptions = (;
    dumpResult = false,
    matchAltNames = true,
    matchAliases = false,
    matchCategories = false,
    verboseCategories = false,
    queryLanguages = ["English"],
    resultLanguage = "English"
)

function buildQueryDict(querylangs::Vector{String}, folder, opts)
    dict = opts.matchCategories ? String["names"] : String[]
    for lang in querylangs
        langindex = getIndex(lang, folder)
        langindex === nothing && continue
        haskey(langindex, "names") && append!(dict, keys(langindex.names))
        opts.matchCategories && haskey(langindex, "categories") && append!(dict, keys(langindex.categories))
    end
    dict
end

function autocomplete(input, list::Vector)
    (nearest, idx) = findnearest(input, lowercase.(list), distance_dist)
    list[idx]
end

function sanitizeOptions(opts::NamedTuple)::NamedTuple
    sanOpts = Dict{Symbol, Any}(pairs(opts))
    if haskey(opts, :queryLanguages) && opts.queryLanguages isa String
        sanOpts[:queryLanguages] = String[opts.queryLanguages]
    end
    NamedTuple(sanOpts)
end

function retrieveData(query, folder, options::NamedTuple, getfilename::Bool)
    opts = merge(baseoptions, sanitizeOptions(options))
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
        if opts.matchCategories && (haskey(langindex.categories, queryMatch) || queryMatch == "names")
            reslangindex = getIndex(opts.resultLanguage, folder)
            reslangindex === nothing && return nothing
            tmparr = queryMatch == "names" ? values(reslangindex.names) : langindex.categories[queryMatch]
            accum = []
            for filename::String in tmparr
                res = opts.verboseCategories ? getData(opts.resultLanguage, folder, filename) : reslangindex.namemap[filename]
                res !== nothing && push!(accum, res)
            end
            return accum
        end
    end
end

for f in (:characters,
          :talents,
          :talentmaterialtypes,
          :constellations,
          :weapons,
          :weaponmaterialtypes,
          :materials,
          :artifacts,
          :foods,
          :domains,
          :enemies,
          :elements,
          :rarity)
    genshin_f = Symbol(:genshin_, f)
    @eval begin
        function $genshin_f(query; opts...)
            return retrieveData(query, Folder.$f, NamedTuple(opts), false)
        end
    end
end

# module GenshinHelp
