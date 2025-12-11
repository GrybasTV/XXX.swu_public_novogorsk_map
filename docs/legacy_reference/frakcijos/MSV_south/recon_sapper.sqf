removeUniform _this;
removeHeadgear _this;
removeAllWeapons _this; 
removeGoggles _this; 
_heads = selectRandom ["WhiteHead_06", "WhiteHead_09", "AsianHead_A3_02", "LivonianHead_5", "LivonianHead_2", "WhiteHead_25", "WhiteHead_28", "WhiteHead_27", "LivonianHead_3", "LivonianHead_10", "LivonianHead_4", "RuHead_00"];  
_voice = selectRandom ["male01rus", "male02rus", "male03rus"];  
[_this,_heads,_voice] call BIS_fnc_setIdentity; 

_this forceAddUniform selectRandom ["RUS_VKPO_Demi_1", "RUS_VKPO_Jacket_Winter_1", "RUS_VKPO_Winter_5", "RUS_VKPO_Jacket_Winter_1", "RUS_VKPO_Winter_5", "RUS_Reversible_Suit_6Sh122_Autumn_1", "RUS_6Sh122_Autumn_5", "RUS_6Sh122_Autumn_6", "RUS_VKPO_Demi_2", "RUS_VKPO_Jacket_Winter_2", "RUS_VKPO_Jacket_Winter_2", "RUS_Reversible_Suit_6Sh122_Autumn_2", "RUS_VKPO_Demi_3", "RUS_VKPO_Jacket_Winter_3", "RUS_VKPO_Jacket_Winter_3", "RUS_Reversible_Suit_6Sh122_Autumn_3", "RUS_VKPO_Demi_4", "RUS_VKPO_Jacket_Winter_4", "RUS_VKPO_Jacket_Winter_4", "RUS_Reversible_Suit_6Sh122_Autumn_4", "RUS_Gorka_A_Tacs_4"];

_this linkItem selectRandom ["nvg_ratnik2", "nvg_ratnik3", "nvg_ratnik4"];

_this addVest selectRandom ["rus_6b45_6sh117_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman_warbelt", "rus_6b46_rifleman", "rus_6b46_rifleman_warbelt", "rus_6b45_6sh117_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman", "rus_6b45_rifleman_warbelt", "rus_6b46_rifleman", "rus_6b46_rifleman_warbelt"];

_this addItemToVest "FirstAidKit";
for "_i" from 1 to 17 do {_this addItemToVest "MMM_mag_30rnd_545x39_AK12_7N10";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_f1";};
_this addItemToVest "rhs_mag_rdg2_white";

for "_i" from 1 to 10 do {_this addItemToVest "rhs_VOG25";};

_this addBackpack "RUS_6Sh117_buttpack";

for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_mag_rdg2_white";};
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_VOG25P";};
_this addItemToBackpack "rhs_mag_nspd";
_this addItemToBackpack "rhs_mag_nspn_green";
_this addItemToBackpack "rhs_mag_nspn_red";
_this addItemToBackpack "MineDetector";
_this addItemToBackpack "rhs_mine_ozm72_b_mag";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_mine_pmn2_mag";};
for "_i" from 1 to 3 do {_this addItemToBackpack "MMM_mag_30rnd_545x39_AK12_7N10";};


_this addWeapon "rhs_weap_ak74mr_gp25";

_this addPrimaryWeaponItem selectRandom ["rhs_acc_1p87", "", "", "", "", "", "", "", ""];

_this addWeapon "rhs_weap_rshg2";
_this addSecondaryWeaponItem "rhs_rshg2_mag";

_this addHeadgear selectRandom ["RUS_6B47_EMRsummer", "RUS_6B47_EMRsummer", "RUS_6B47_EMRsummer", "RUS_6B47_EMRsummer", "RUS_6B47_EMR", "RUS_6B47_EMRsummer_shapka", "RUS_6B47_EMRsummer_shapka", "RUS_6B47_EMRsummer_shapka", "RUS_6B47_EMRsummer_shapka", "RUS_6B47_EMR_shapka", "RUS_6B47_EMRsummer_6b50", "RUS_6B47_EMR_6b50", "RUS_6B47_EMRsummer_6b50_open", "RUS_6B47_EMRsummer_6b50_open", "RUS_6B47_EMR_6b50_open", "RUS_6B47_EMRsummer_shapka_6b50", "RUS_6B47_EMRsummer_shapka_6b50", "RUS_6B47_EMRsummer_shapka_6b50", "RUS_6B47_EMRsummer_shapka_6b50", "RUS_6B47_EMR_shapka_6b50", "RUS_6B47_EMRsummer_shapka_6b50_open", "RUS_6B47_EMRsummer_shapka_6b50_open", "RUS_6B47_EMRsummer_shapka_6b50_open", "RUS_6B47_EMRsummer_shapka_6b50_open", "RUS_6B47_EMR_shapka_6b50_open", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare", "RUS_6b47_bare"];

_this addGoggles selectRandom ["fleece_scarf", "", "", "", "", "RUS_Balaclava_VKPO_Green_1", "RUS_Balaclava_VKPO_Green_2", "RUS_Balaclava_VKPO_Winter_Green_1", "RUS_Balaclava_VKPO_Winter_Green_2", "RUS_Balaclava_EMR_Summer_1", "RUS_Balaclava_EMR_Summer_2", "RUS_Balaclava_EMR_Autumn_1", "RUS_Balaclava_EMR_Autumn_2", "RUS_Balaclava_Green_3", "RUS_Balaclava_Green_4", "RUS_Balaclava_Black_1", "RUS_Balaclava_Black_2", "RUS_Balaclava_Olive_1", "RUS_Balaclava_Olive_2", "RUS_Balaclava_Sage_1", "RUS_Balaclava_Sage_2", "RUS_Balaclava_A_Tacs_1", "RUS_Balaclava_A_Tacs_2", "RUS_Balaclava_A_Tacs_3", "RUS_Balaclava_A_Tacs_4", "BalaklavaMC"];



