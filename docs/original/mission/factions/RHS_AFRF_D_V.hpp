/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RHS_AFRF_D_V.hpp";
*/

//EAST (DESERT)
BikeE=[["O_G_Quadbike_01_F",""]]; //quad bike
CarE=[["rhs_tigr_3camo_vdv",""],["rhs_tigr_m_3camo_vdv",""],["rhs_uaz_vdv","Camo"],["rhs_uaz_open_vdv","Camo"]]; //car
CarDlcE=[]; //car apex dlc
CarArE=[["rhs_tigr_sts_3camo_vdv",""]]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=[["rhs_gaz66_vdv","rhs_sand"],["rhs_gaz66o_vdv","rhs_sand"],["RHS_Ural_VDV_01","rhs_sand"],["RHS_Ural_Open_VDV_01","rhs_sand"]]; //truck
ArmorE1=[["rhs_btr60_vdv","3tone"],["rhs_btr70_vdv","rhs_sand"],["rhs_btr80_vdv","rhs_sand"],["rhs_btr80a_vdv","rhs_sand"],["rhs_bmd1","Camo1"],["rhs_bmd1k","Camo1"],["rhs_bmd1p","Camo1"],["rhs_bmd1pk","Camo1"],["rhs_bmd1r","Camo1"],["rhs_bmd2","Desert"],["rhs_bmd2k","Desert"],["rhs_bmd2m","Desert"],["rhs_bmp1_vdv","rhs_sand"],["rhs_bmp1d_vdv","rhs_sand"],["rhs_bmp1k_vdv","rhs_sand"],["rhs_bmp1p_vdv","rhs_sand"],["rhs_bmp2e_vdv","rhs_sand"],["rhs_bmp2_vdv","rhs_sand"],["rhs_bmp2d_vdv","rhs_sand"],["rhs_brm1k_vdv","rhs_sand"],["rhs_prp3_vdv","rhs_sand"]]; //apc, ifv
ArmorE2=[["rhs_t72ba_tv","rhs_Sand"],["rhs_t72bb_tv","rhs_Sand"],["rhs_t72bc_tv","rhs_Sand"],["rhs_t72bd_tv","rhs_Sand"],["rhs_t72be_tv","rhs_Sand"],["rhs_t80u","tricolor"],["rhs_t80u45m","tricolor"],["rhs_t80ue1","tricolor"],["rhs_t80uk","tricolor"],["rhs_t80um","tricolor"],["rhs_t90_tv","rhs_sand"],["rhs_t90a_tv","rhs_sand"],["rhs_t90am_tv","rhs_sand"],["rhs_t90saa_tv","rhs_sand"],["rhs_t90sab_tv","rhs_sand"],["rhs_t90sm_tv","rhs_sand"]]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["rhs_ka60_c","RHS_Mi8mt_vvsc"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["RHS_Ka52_vvsc","RHS_Mi24P_vvsc","rhs_mi28n_vvsc"]; //gunship (armed heli)
PlaneE=["RHS_Su25SM_vvs","rhs_mig29sm_vmf","RHS_T50_vvs_generic_ext","RHS_T50_vvs_blueonblue"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[["rhs_zsu234_aa","rhs_sand"]]; //Anti Air
artiE=[]; //artillery (["rhs_2s1_tv","rhs_sand"],["rhs_2s3_tv","rhs_sand"])
mortE = ["rhs_2b14_82mm_vdv"]; //mortar
crewE="rhs_vdv_des_armoredcrew"; //crew

boatTrE=["O_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=["U_O_Wetsuit","V_RebreatherIR","G_O_Diving"]; //diver gear (boat cargo) 
divWe="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMe="30Rnd_556x45_Stanag_green"; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["rhs_weapon_crate"];
flgE = "RHS_Flag_Russia_F";

endE = "EndAFRF";

unitsE=
[
	"rhs_vdv_des_sergeant", //0 - Squad leader
	"rhs_vdv_des_grenadier_rpg", //1 - Rifleman AT
	"rhs_vdv_des_arifleman", //2 - Autorifleman
	"rhs_vdv_des_medic", //3 - Combat life saver
	"rhs_vdv_des_efreitor", //4 - Team leader
	"rhs_vdv_des_rifleman", //5 - Rifleman
	"rhs_vdv_des_engineer", //6 - Engineer
	"rhs_vdv_des_marksman", //7 - Marksman
	"rhs_vdv_des_at", //8 - Missile specialist AT
	"rhs_vdv_des_grenadier", //9 - Grenadier
	"rhs_vdv_des_aa", //10 - Missile specialist AA
	"rhs_vdv_des_sergeant", //11 - Recon team leader
	"rhs_vdv_des_grenadier_rpg", //12 - Recon scout AT (Rifleman AT)
	"rhs_vdv_des_arifleman", //13 - Recon Marksman (Autorifleman)
	"rhs_vdv_des_medic", //14 - Recon Paramedic (Medic)
	"rhs_vdv_des_efreitor", //15 - Recon JTAC (Grenadier)
	"rhs_vdv_des_rifleman", //16 - Recon Scout (Rifleman)
	"rhs_vdv_des_engineer", //17 - Recon demo specialist (Engineer)
	"rhs_vdv_des_marksman" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='RUS_'; //voices
nameE="RussianMen"; //names