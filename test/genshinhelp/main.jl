module test_genshinhelp_main

using Test
using GenshinHelp

const lisa = genshin_characters("lisa")
const lisa_kr = genshin_characters("리사", queryLanguages=["Korean"])
@test lisa.name == lisa_kr.name == "Lisa"

@test genshin_talents("lisa").costs.lvl10 == [
    Dict("name" => "Mora", "count" => 700000),
    Dict("name" => "Philosophies of Ballad", "count" => 16),
    Dict("name" => "Slime Concentrate", "count" => 12),
    Dict("name" => "Dvalin's Claw", "count" => 2),
    Dict("name" => "Crown of Insight", "count" => 1)
]

@test genshin_talentmaterialtypes("Freedom")["4starname"] == "Philosophies of \"Freedom\""

@test genshin_constellations("lisa").c6 == Dict(
    "name"   => "Pulsating Witch",
    "effect" => "When Lisa takes the field, she applies 3 stacks of **Violet Arc**'s Conductive status onto nearby opponents.\n" *
                "This effect can only occur once every 5s.")

@test genshin_weapons("staff homa").costs.ascend1 == [
    Dict("name" => "Mora", "count" => 10000)
    Dict("name" => "Grain of Aerosiderite", "count" => 5)
    Dict("name" => "Dead Ley Line Branch", "count" => 5)
    Dict("name" => "Slime Condensate", "count" => 3)
]

@test genshin_weaponmaterialtypes("Mondstadt", matchCategories=true) == ["Boreal Wolf", "Dandelion Gladiator", "Decarabian"]

@test "Salt" in genshin_materials("Cooking Ingredient", matchCategories=true)
@test genshin_materials("Salt").materialtype == "Cooking Ingredient"

@test genshin_artifacts("왕실", queryLanguages="Korean")["2pc"] == "Elemental Burst DMG +20%"

@test "Golden Crab" in genshin_foods("Salt", matchCategories=true)
@test genshin_foods("Golden Crab").ingredients == [
    Dict("name" => "Bird Egg", "count" => 5),
    Dict("name" => "Flour", "count" => 5),
    Dict("name" => "Crab", "count" => 4),
    Dict("name" => "Salt", "count" => 2),
]

@test "Domain of Mastery: Frozen Abyss IV" in genshin_domains("Talent Level-Up Material", matchCategories=true)

const abyss = genshin_domains("Domain of Mastery: Frozen Abyss IV")
@test abyss.daysofweek == ["Tuesday", "Friday", "Sunday"]
@test abyss.rewardpreview == [
    Dict("name" => "Adventure EXP", "count" => 100),
    Dict("name" => "Mora", "count" => 2375),
    Dict("name" => "Companionship EXP", "count" => 20),
    Dict("name" => "Teachings of Resistance"),
    Dict("name" => "Guide to Resistance"),
    Dict("name" => "Philosophies of Resistance"),
]

@test "La Signora" in genshin_enemies("boss", matchCategories=true)
@test genshin_enemies("La Signora").type == "BOSS"

const pyro = genshin_elements("Pyro")
@test pyro.type == "Fire"
@test pyro.region == "Natlan"
@test pyro.theme == "Unknown"

@test genshin_rarity("Five Stars").name == "Five Stars"

end # module test_genshinhelp_main
