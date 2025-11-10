removeUniform _this;
removeHeadgear _this;
removeAllWeapons _this; 
removeGoggles _this; 
_heads = selectRandom ["WhiteHead_06", "WhiteHead_09", "AsianHead_A3_02", "LivonianHead_5", "LivonianHead_2", "WhiteHead_25", "WhiteHead_28", "WhiteHead_27", "LivonianHead_3", "LivonianHead_10", "LivonianHead_4", "RuHead_00"];  
_voice = selectRandom ["male01rus", "male02rus", "male03rus"];  
[_this,_heads,_voice] call BIS_fnc_setIdentity; 

_this forceAddUniform selectRandom ["RUS_VKPO_Demi_1", "RUS_VKPO_Jacket_Winter_1", "RUS_VKPO_Winter_5", "RUS_VKPO_Jacket_Winter_1", "RUS_VKPO_Winter_5", "RUS_Reversible_Suit_6Sh122_Autumn_1", "RUS_6Sh122_Autumn_5", "RUS_6Sh122_Autumn_6"];

_this linkItem selectRandom ["nvg_ratnik2", "nvg_ratnik3", "nvg_ratnik4"];

_this addVest selectRandom ["rus_6b45_mechanik_driver", "", "", ""];

for "_i" from 1 to 4 do {_this addItemToUniform "rhs_30Rnd_545x39_7N10_AK";};

_this addWeapon selectRandom ["rhs_weap_ak74m", "rhs_weap_aks74u"];

_this addHeadgear selectRandom ["rhs_6b48", "RUS_tsh4m", "RUS_tsh4m", "RUS_tsh4m", "RUS_tsh4m"];

_this addGoggles selectRandom ["RUS_Balaclava_VKPO_Green_1", "RUS_Balaclava_VKPO_Green_2", "RUS_Balaclava_VKPO_Winter_Green_1", "RUS_Balaclava_VKPO_Winter_Green_2", "fleece_scarf", "fleece_scarf", "fleece_scarf", "fleece_scarf", "RUS_Balaclava_Olive_1", "RUS_Balaclava_Olive_2", "RUS_Balaclava_Green_3", "RUS_Balaclava_Green_4", "RUS_Balaclava_Black_1", "RUS_Balaclava_Black_2", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];



