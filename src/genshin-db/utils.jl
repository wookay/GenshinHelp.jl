# module GenshinHelp

function Base.getindex(dict::T, key::Symbol) where {T <: LazyJSON.Object{Nothing, String}}
    getindex(dict, String(key))
end

function Base.getindex(dict::T, key::String) where {T <: LazyJSON.Object{Nothing, String}}
    getindex(Dict(dict), key)
end

function Base.getproperty(dict::T, key::Symbol) where {T <: LazyJSON.Object{Nothing, String}}
    key in fieldnames(T) ? getfield(dict, key) : getindex(dict, key)
end

function Base.getproperty(dict::T, key::Symbol) where {T <: Dict{AbstractString, Any}}
    key in fieldnames(T) ? getfield(dict, key) : getindex(dict, String(key))
end

# module GenshinHelp
