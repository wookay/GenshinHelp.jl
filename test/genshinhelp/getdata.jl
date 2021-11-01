module test_genshinhelp_getdata

using GenshinHelp
using Test

@test getData("Korean", "characters", "lisa")["name"] == "리사"
@test getIndex("Korean", "characters")["names"]["리사"] == "lisa"
@test getImage("characters", "lisa")["icon"] == "https://upload-os-bbs.mihoyo.com/game_record/genshin/character_icon/UI_AvatarIcon_Lisa.png"
@test getStats("characters", "lisa")["base"]["hp"] == 802.3760986328125
@test GenshinHelp.getCurve("characters")["1"]["GROW_CURVE_HP_S4"] == 1

end # module test_genshinhelp_getdata
