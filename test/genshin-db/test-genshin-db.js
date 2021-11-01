const genshindb = require('genshin-db')

console.log(
    genshindb.characters('lisa')["name"] == "Lisa"
)
