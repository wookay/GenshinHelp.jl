const genshindb = require("genshin-db")
const mucko = require("mucko")

var Test = mucko.Test

Test.test_genshindb_options = function() {
    assert_equal(genshindb.getOptions(), {
        dumpResult: false,
        matchAltNames: true,
        matchAliases: false,
        matchCategories: false,
        verboseCategories: false,
        queryLanguages: [ "English" ],
        resultLanguage: "English"
    })
}

Test.test_genshindb_characters = function() {
    assert_true(genshindb.characters("lisa")["name"] == "Lisa")
}

Test.test_genshindb_talents = function() {
    assert_equal(genshindb.talents("lisa").costs.lvl10, [
        { name: "Mora", count: 700000 },
        { name: "Philosophies of Ballad", count: 16 },
        { name: "Slime Concentrate", count: 12 },
        { name: "Dvalin's Claw", count: 2 },
        { name: "Crown of Insight", count: 1 }
    ])
}

Test.test_genshindb_talentmaterialtypes = function() {
    assert_true(genshindb.talentmaterialtypes("Freedom")["4starname"] == "Philosophies of \"Freedom\"")
}

Test.test_genshindb_constellations = function() {
    assert_equal(genshindb.constellations("lisa").c6, {
        name: "Pulsating Witch",
        effect: "When Lisa takes the field, she applies 3 stacks of **Violet Arc**'s Conductive status onto nearby opponents.\n" +
          "This effect can only occur once every 5s."
    })
}

Test.test_genshindb_weapons = function() {
    assert_equal(genshindb.weapons("staff homa").costs.ascend1, [
        { name: "Mora", count: 10000 },
        { name: "Grain of Aerosiderite", count: 5 },
        { name: "Dead Ley Line Branch", count: 5 },
        { name: "Slime Condensate", count: 3 }
    ])
}

Test.test_genshindb_weaponmaterialtypes = function() {
    assert_equal(genshindb.weaponmaterialtype("Mondstadt", { matchCategories: true }), [ "Boreal Wolf", "Dandelion Gladiator", "Decarabian" ])
}

Test.test_genshindb_materials = function() {
    assert_true(genshindb.materials("Cooking Ingredient", { matchCategories: true }).includes("Salt"))
    assert_true(genshindb.materials("Salt").materialtype == "Cooking Ingredient")
}

Test.test_genshindb_artifacts = function() {
    assert_true(genshindb.artifacts("왕실", { queryLanguages: "Korean" })["2pc"] == "Elemental Burst DMG +20%")
}

Test.test_genshindb_foods = function() {
    assert_true(genshindb.foods("Salt", { matchCategories: true }).includes("Golden Crab"))
    assert_equal(genshindb.foods("Golden Crab").ingredients, [
        { name: "Bird Egg", count: 5 },
        { name: "Flour", count: 5 },
        { name: "Crab", count: 4 },
        { name: "Salt", count: 2 }
    ])
}

Test.test_genshindb_domains = function() {
    assert_true(genshindb.domains("Talent Level-Up Material", { matchCategories: true }).includes("Domain of Mastery: Frozen Abyss IV"))
    const abyss = genshindb.domains("Domain of Mastery: Frozen Abyss IV")
    assert_equal(abyss.daysofweek, [ "Tuesday", "Friday", "Sunday" ])
    assert_equal(abyss.rewardpreview, [
        { name: "Adventure EXP", count: 100 },
        { name: "Mora", count: 2375 },
        { name: "Companionship EXP", count: 20 },
        { name: "Teachings of Resistance" },
        { name: "Guide to Resistance" },
        { name: "Philosophies of Resistance" }
    ])
}

Test.test_genshindb_enemie = function() {
    assert_true(genshindb.enemies("boss", { matchCategories: true }).includes("La Signora"))
    assert_true(genshindb.enemies("La Signora").type == "BOSS")
}

Test.test_genshindb_elements = function() {
    const pyro = genshindb.elements("Pyro")
    assert_true(pyro.type == "Fire")
    assert_true(pyro.region == "Natlan")
    assert_true(pyro.theme == "Unknown")
    const hydro = genshindb.elements("Hydro")
    assert_true(hydro.type == "Water")
    assert_true(hydro.region == "Fontaine")
    assert_true(hydro.theme == "France or Italy")
    const anemo = genshindb.elements("Anemo")
    assert_true(anemo.type == "Wind")
    assert_true(anemo.region == "Mondstadt")
    assert_true(anemo.theme == "Germany")
    const electro = genshindb.elements("Electro")
    assert_true(electro.type == "Lightning")
    assert_true(electro.region == "Inazuma")
    assert_true(electro.theme == "Japan")
    const dendro = genshindb.elements("Dendro")
    assert_true(dendro.type == "Nature")
    assert_true(dendro.region == "Sumeru")
    assert_true(dendro.theme == "Middle East or India")
    const cryo = genshindb.elements("Cryo")
    assert_true(cryo.type == "Frost")
    assert_true(cryo.region == "Snezhnaya")
    assert_true(cryo.theme == "Russia")
    const geo = genshindb.elements("Geo")
    assert_true(geo.type == "Earth")
    assert_true(geo.region == "Liyue")
    assert_true(geo.theme == "China")
}

Test.test_genshindb_rarity = function() {
    assert_true(genshindb.rarity("Five Stars").name == "Five Stars")
}
