# module GenshinHelp

using Mmap
using LazyJSON

function require(filepath; data_dir=normpath(@__DIR__, "../../gen/genshin-db/src"))
    data_path = normpath(data_dir, filepath)
    f = open(data_path, "r")
    j = Mmap.mmap(f)
    close(f)
    LazyJSON.parse(j)
end

function load_json_data(; loads=(:alldata,
                                 :allindex,
                                 :allimage,
                                 :allurl,
                                 :allstats,
                                 :allcurve))
    :alldata  in loads && (global alldata  = require("./min/data.min.json"))
    :allindex in loads && (global allindex = require("./min/index.min.json"))
    :allimage in loads && (global allimage = require("./min/image.min.json"))
    :allurl   in loads && (global allurl   = require("./min/url.min.json"))
    :allstats in loads && (global allstats = require("./min/stats.min.json"))
    :allcurve in loads && (global allcurve = require("./min/curve.min.json"))
end

GenshinHelp.load_json_data()
# GenshinHelp.load_json_data(; loads=(:alldata, :allindex, :allimage, :allurl))

# module GenshinHelp
