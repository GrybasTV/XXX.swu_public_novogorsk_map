/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RHS_USAF_S_V.hpp";
*/

//WEST (WINTER)
BikeW=["B_Quadbike_01_F"]; //quad bike
CarW=["rhsusf_m1025_w","rhsusf_m1043_w","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr","rhsusf_m998_w_4dr_fulltop","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr","rhsusf_m1165_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_m1240a1_usarmy_wd","rhsusf_M1220_usarmy_wd"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m1043_w_m2","rhsusf_m1043_w_mk19","rhsusf_m1045_w","rhsusf_m1151_usarmy_wd","rhsusf_m1151_m2crows_usarmy_wd","rhsusf_m1151_mk19crows_usarmy_wd","rhsusf_m1151_m2_v1_usarmy_wd","rhsusf_m1151_m2_lras3_v1_usarmy_wd","rhsusf_m1151_m240_v1_usarmy_wd","rhsusf_m1151_mk19_v1_usarmy_wd","rhsusf_m1151_m2_v2_usarmy_wd","rhsusf_m1151_m240_v2_usarmy_wd","rhsusf_m1151_mk19_v2_usarmy_wd","rhsusf_m966_w","rhsusf_M1117_W","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M153_MK19_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230_M2_usarmy_wd","rhsusf_M1230_MK19_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd","rhsusf_m1240a1_m2_usarmy_wd","rhsusf_m1240a1_m240_usarmy_wd","rhsusf_m1240a1_mk19_usarmy_wd","rhsusf_m1240a1_m2_uik_usarmy_wd","rhsusf_m1240a1_m240_uik_usarmy_wd","rhsusf_m1240a1_mk19_uik_usarmy_wd","rhsusf_m1240a1_m2crows_usarmy_wd","rhsusf_m1240a1_mk19crows_usarmy_wd"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["rhsusf_M1078A1P2_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1083A1P2_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy"]; //truck
ArmorW1=["rhsusf_stryker_m1126_m2_wd","rhsusf_stryker_m1126_mk19_wd","rhsusf_stryker_m1127_m2_wd","rhsusf_stryker_m1132_m2_np_wd","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd","RHS_M6_wd"]; //apc, ifv
ArmorW2=["rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy","rhsusf_m1a2sep2wd_usarmy"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["RHS_UH60M","RHS_UH60M2"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["RHS_AH64D_wd"]; //gunship (armed heli)
PlaneW=["RHS_A10","rhsusf_f22"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["rhsusf_stryker_m1134_wd"]; //Anti Air
artiW=["rhsusf_m109_usarmy","rhsusf_M142_usarmy_WD"]; //artillery ("RHS_M119_WD")
mortW = ["RHS_M252_WD"]; //mortar
crewW="rhsusf_army_ucp_crewman"; //crew

boatTrW=["B_Boat_Transport_01_F"]; //small boat
boatArW=[]; //patrol boat

divEw=["U_B_Wetsuit","V_RebreatherB","G_B_Diving"]; //diver gear (boat cargo) 
divWw="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMw="30Rnd_556x45_Stanag_red"; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["rhsusf_weapon_crate"];
flgW = "Flag_US_F";

endW = "EndUSAF";

unitsW=
[
	"rhsusf_army_ucp_squadleader", //0 - Squad leader
	"rhsusf_army_ucp_riflemanat", //1 - Rifleman AT
	"rhsusf_army_ucp_autorifleman", //2 - Autorifleman
	"rhsusf_army_ucp_medic", //3 - Combat life saver
	"rhsusf_army_ucp_teamleader", //4 - Team leader
	"rhsusf_army_ucp_rifleman", //5 - Rifleman
	"rhsusf_army_ucp_engineer", //6 - Engineer
	"rhsusf_army_ucp_marksman", //7 - Marksman
	"rhsusf_army_ucp_javelin", //8 - Missile specialist AT
	"rhsusf_army_ucp_grenadier", //9 - Grenadier
	"rhsusf_army_ucp_aa", //10 - Missile specialist AA
	"rhsusf_army_ucp_squadleader", //11 - Recon team leader
	"rhsusf_army_ucp_maaws", //12 - Recon scout AT (Rifleman AT)
	"rhsusf_army_ucp_autorifleman", //13 - Recon Marksman (Autorifleman)
	"rhsusf_army_ucp_medic", //14 - Recon Paramedic (Medic)
	"rhsusf_army_ucp_jfo", //15 - Recon JTAC (Grenadier)
	"rhsusf_army_ucp_rifleman", //16 - Recon Scout (Rifleman)
	"rhsusf_army_ucp_explosives", //17 - Recon demo specialist (Engineer)
	"rhsusf_army_ucp_sniper" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names