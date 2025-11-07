/*
Author: IvosH

Description:
	Replace supplies, ammunition according to used faction

Parameter(s):
	0: OBJECT, _box (Supply Box)
	1: SIDE, _side

Returns:
	nothing

Dependencies:
	fn_airDrop.sqf

Execution:
	[_box,_side] call wrm_fnc_supplyBox
*/

_box=_this select 0;
_side=_this select 1;

//clear box
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;

//Global mobilization
if (modA=="GM") then 
{
	call
	{
		//West Germany
		if (_side == sideW) exitWith
		{
			if(factionE=="West Germany")then
			{
				_box addWeaponCargoGlobal ["gm_g3a3_oli", 4]; //assault rifle
				{_box addMagazineCargoGlobal [_x, 24];} forEach ["gm_20Rnd_762x51mm_B_DM41_g3_blk"]; //magazines
				_box addWeaponCargoGlobal ["gm_pzf44_2_oli_feroz2x17", 1]; //AT 
				_box addMagazineCargoGlobal ["gm_1Rnd_44x537mm_heat_dm32_pzf44_2", 3]; //ATmissile
			}else
			{
				_box addWeaponCargoGlobal ["gm_g36a1_blk", 4]; //assault rifle
				{_box addMagazineCargoGlobal [_x, 24];} forEach ["gm_30Rnd_556x45mm_b_dm11_g36_blk"]; //magazines
				_box addWeaponCargoGlobal ["gm_pzf3_blk", 1]; //AT
				{_box addMagazineCargoGlobal [_x, 1];} forEach ["gm_1Rnd_60mm_heat_dm12_pzf3","gm_1Rnd_60mm_heat_dm22_pzf3","gm_1Rnd_60mm_heat_dm32_pzf3"]; //ATmissile
			};
			
			{_box addMagazineCargoGlobal [_x, 1];} forEach ["gm_mine_at_dm21","gm_explosive_petn_charge"]; //mines, explosives
			{_box addMagazineCargoGlobal [_x, 2];} forEach ["gm_smokeshell_red_dm23","gm_smokeshell_grn_dm21","gm_smokeshell_yel_dm26","gm_smokeshell_wht_dm25","gm_1Rnd_265mm_flare_single_wht_DM15","gm_1Rnd_265mm_flare_multi_red_DM23","gm_1Rnd_265mm_flare_multi_grn_DM21","gm_1Rnd_265mm_flare_multi_yel_DM20","gm_1Rnd_84x245mm_heat_t_DM22_carlgustaf","gm_1Rnd_70mm_he_m585_fim43"]; //smoke grenade, flare, ATmissile, AAmissile
			{_box addMagazineCargoGlobal [_x, 3];} forEach ["gm_1rnd_67mm_heat_dm22a1_g3"]; //grenade
			{_box addMagazineCargoGlobal [_x, 6];} forEach ["gm_handgrenade_frag_dm51a1","gm_120Rnd_762x51mm_B_T_DM21A1_mg3_grn","gm_32Rnd_9x19mm_B_DM11_mp2_blk","gm_30Rnd_9x19mm_B_DM51_mp5a3_blk","gm_8Rnd_9x19mm_B_DM11_p1_blk"]; //frag, mgMagazine, smgMag, 
			
			{_box addItemCargoGlobal [_x, 1];} forEach ["gm_ge_facewear_m65","ItemWatch","gm_ge_army_conat2","ItemMap","ItemRadio","gm_repairkit_01","gm_ge_army_medkit_80","gm_feroz24_blk"]; //items, accessories, medkit...
			{_box addItemCargoGlobal [_x, 10];} forEach ["gm_ge_army_gauzeBandage","gm_ge_army_burnBandage"]; //FAK
			
			_box addWeaponCargoGlobal ["gm_mg3_blk", 2]; //machinegun
			{_box addWeaponCargoGlobal [_x, 1];} forEach ["gm_ferod16_oli", //binoculars
			"gm_mp5a2_blk","gm_mp5a3_blk","gm_mp5sd3_blk_feroz24", //smg
			"gm_p1_blk","gm_p2a1_blk", //handgun
			"gm_fim43_oli","gm_pzf84_oli_feroz2x17"]; //launchers
			_box addBackpackCargoGlobal ["gm_ge_army_backpack_80_oli", 2]; //backpack
		};
		if (_side == sideE) exitWith
		{
			{_box addMagazineCargoGlobal [_x, 1];} forEach ["gm_mine_at_tm46","gm_explosive_plnp_charge"]; //mine, charge
			{_box addMagazineCargoGlobal [_x, 2];} forEach ["gm_1Rnd_265mm_flare_single_grn_gc","gm_1Rnd_265mm_flare_single_red_gc","gm_1Rnd_265mm_flare_multi_red_gc","gm_1Rnd_265mm_smoke_single_yel_gc","gm_1Rnd_265mm_smoke_single_blu_gc","gm_1Rnd_265mm_smoke_single_blk_gc"]; //smoke grenade, flare
			{_box addMagazineCargoGlobal [_x, 3];} forEach ["gm_1Rnd_72mm_he_9m32m","gm_1Rnd_40mm_heat_pg7v_rpg7"]; //grenade, missile
			{_box addMagazineCargoGlobal [_x, 6];} forEach ["gm_handgrenade_frag_rgd5","gm_75Rnd_762x39mm_B_T_M43_ak47_blk","gm_100Rnd_762x54mm_B_T_t46_pk_grn","gm_10Rnd_762x54mmR_AP_7N1_svd_blk","gm_30Rnd_762x39mm_B_M43_ak47_blk","gm_25Rnd_9x18mm_B_pst_pm63_blk","gm_8Rnd_9x18mm_B_pst_pm_blk"]; //frag, mgMagazine, smgMag, 
			{_box addMagazineCargoGlobal [_x, 24];} forEach ["gm_30Rnd_545x39mm_B_7N6_ak74_org"]; //magazines
			{_box addItemCargoGlobal [_x, 1];} forEach ["gm_gc_army_facewear_schm41m","ItemRadio","gm_gc_compass_f73","ItemWatch","ItemMap","gm_pso1_gry","gm_zfk4x25_blk"]; //items, accessories, medkit...
			{_box addItemCargoGlobal [_x, 10];} forEach ["gm_gc_army_medkit","gm_gc_army_gauzeBandage"]; //FAK
			{_box addWeaponCargoGlobal [_x, 1];} forEach ["gm_df7x40_grn", //binoculars
			"gm_mpiak74n_brn","gm_mpiaks74nk_brn","gm_mpiaks74n_brn","gm_mpikms72_brn", //assault rifles
			"gm_lmgrpk_brn","gm_hmgpkm_prp", //machinegun
			"gm_pm63_blk", //smg
			"gm_svd_wud_pso1", //long range 
			"gm_pm_blk","gm_lp1_blk", //handgun
			"gm_9k32m_oli","gm_rpg7_prp_pgo7v"]; //launchers
			_box addBackpackCargoGlobal ["gm_gc_army_backpack_80_assaultpack_str", 2]; //backpack	
		};
	};
};
