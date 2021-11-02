const genshindb = require('genshin-db')
const mucko = require('mucko')

var Test = mucko.Test

Test.test_genshindb_characters = function() {
    assert_true(genshindb.characters('lisa')["name"] == "Lisa")
}
