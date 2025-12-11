/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RHS_AFRF_A_V.hpp";
*/

//EAST (ARID, winter)
BikeE=[["O_G_Quadbike_01_F",""]]; //quad bike
CarE=["rhs_tigr_vdv","rhs_tigr_m_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["rhs_tigr_sts_vdv"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_kamaz5350_vdv","rhs_kamaz5350_open_vdv","RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_zil131_vdv","rhs_zil131_open_vdv"]; //truck
ArmorE1=["rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2k","rhs_bmd2m","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_bmp1_vdv","rhs_bmp1d_vdv","rhs_bmp1k_vdv","rhs_bmp1p_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_brm1k_vdv","rhs_prp3_vdv","rhs_t15_tv"]; //apc, ifv
ArmorE2=["rhs_t14_tv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t72be_tv","rhs_t80","rhs_t80a","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_t90am_tv","rhs_t90saa_tv","rhs_t90sab_tv","rhs_t90sm_tv","rhs_sprut_vdv"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["rhs_ka60_c","RHS_Mi8mt_vvsc"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["RHS_Ka52_vvsc","RHS_Mi24P_vvsc","rhs_mi28n_vvsc"]; //gunship (armed heli)
PlaneE=["RHS_Su25SM_vvs","rhs_mig29sm_vmf","RHS_T50_vvs_generic_ext","RHS_T50_vvs_blueonblue"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=["rhs_zsu234_aa"]; //Anti Air
artiE=[]; //artillery ("rhs_2s1_tv","rhs_2s3_tv")
mortE = ["rhs_2b14_82mm_vdv"]; //mortar
crewE="rhs_vdv_armoredcrew"; //crew

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
	"rhs_vdv_sergeant", //0 - Squad leader
	"rhs_vdv_grenadier_rpg", //1 - Rifleman AT
	"rhs_vdv_arifleman", //2 - Autorifleman
	"rhs_vdv_medic", //3 - Combat life saver
	"rhs_vdv_efreitor", //4 - Team leader
	"rhs_vdv_rifleman", //5 - Rifleman
	"rhs_vdv_engineer", //6 - Engineer
	"rhs_vdv_marksman", //7 - Marksman
	"rhs_vdv_at", //8 - Missile specialist AT
	"rhs_vdv_grenadier", //9 - Grenadier
	"rhs_vdv_aa", //10 - Missile specialist AA
	"rhs_vdv_sergeant", //11 - Recon team leader
	"rhs_vdv_grenadier_rpg", //12 - Recon scout AT (Rifleman AT)
	"rhs_vdv_arifleman", //13 - Recon Marksman (Autorifleman)
	"rhs_vdv_medic", //14 - Recon Paramedic (Medic)
	"rhs_vdv_efreitor", //15 - Recon JTAC (Grenadier)
	"rhs_vdv_rifleman", //16 - Recon Scout (Rifleman)
	"rhs_vdv_engineer", //17 - Recon demo specialist (Engineer)
	"rhs_vdv_marksman" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='RUS_'; //voices
nameE="RussianMen"; //names