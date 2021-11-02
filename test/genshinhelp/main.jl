module test_genshinhelp_main

using GenshinHelp
using Test

lisa = genshin_characters("lisa")
@test lisa["name"] == "Lisa"

end # module test_genshinhelp_main
