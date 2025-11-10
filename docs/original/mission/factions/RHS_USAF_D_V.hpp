/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RHS_USAF_D_V.hpp";
*/

//WEST (DESERT, arid)
BikeW=["B_Quadbike_01_F"]; //quad bike
CarW=["rhsusf_m1025_d","rhsusf_m1043_d","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr","rhsusf_m998_d_4dr_fulltop","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr","rhsusf_m1151_usarmy_d","rhsusf_m1165_usarmy_d","rhsusf_M1220_usarmy_d","rhsusf_M1232_usarmy_d","rhsusf_m1240a1_usarmy_d"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_m1043_d_m2","rhsusf_m1043_d_mk19","rhsusf_m1045_d","rhsusf_m1151_m2crows_usarmy_d","rhsusf_m1151_mk19crows_usarmy_d","rhsusf_m1151_m2_v1_usarmy_d","rhsusf_m1151_m2_lras3_v1_usarmy_d","rhsusf_m1151_m240_v1_usarmy_d","rhsusf_m1151_mk19_v1_usarmy_d","rhsusf_m1151_m2_v2_usarmy_d","rhsusf_m1151_m240_v2_usarmy_d","rhsusf_m1151_mk19_v2_usarmy_d","rhsusf_m966_d","rhsusf_M1117_D","rhsusf_M1220_M153_M2_usarmy_d","rhsusf_M1220_M153_MK19_usarmy_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1220_MK19_usarmy_d","rhsusf_M1230_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1232_MK19_usarmy_d","rhsusf_M1237_M2_usarmy_d","rhsusf_M1237_MK19_usarmy_d","rhsusf_m1240a1_m2_usarmy_d","rhsusf_m1240a1_m240_usarmy_d","rhsusf_m1240a1_mk19_usarmy_d","rhsusf_m1240a1_m2_uik_usarmy_d","rhsusf_m1240a1_m240_uik_usarmy_d","rhsusf_m1240a1_mk19_uik_usarmy_d","rhsusf_m1240a1_m2crows_usarmy_d","rhsusf_m1240a1_mk19crows_usarmy_d"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["rhsusf_M1078A1P2_D_fmtv_usarmy","rhsusf_M1078A1P2_B_D_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1083A1P2_D_fmtv_usarmy","rhsusf_M1083A1P2_B_D_fmtv_usarmy"]; //truck
ArmorW1=[["rhsusf_stryker_m1126_m2_d","Tan"],["rhsusf_stryker_m1126_mk19_d","Tan"],["rhsusf_stryker_m1127_m2_d","Tan"],["rhsusf_stryker_m1132_m2_np_d","Tan"],"rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_MK19","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII","RHS_M6"]; //apc, ifv
ArmorW2=["rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","rhsusf_m1a2sep2d_usarmy"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["RHS_UH60M_d","RHS_UH60M2_d"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["RHS_AH64D","RHS_AH64DGrey"]; //gunship (armed heli)
PlaneW=["RHS_A10","rhsusf_f22"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=[["rhsusf_stryker_m1134_d","Tan"]]; //Anti Air
artiW=["rhsusf_m109d_usarmy","rhsusf_M142_usarmy_D"]; //artillery ("RHS_M119_D")
mortW = ["RHS_M252_D"]; //mortar
crewW="rhsusf_army_ocp_crewman"; //crew

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
	"rhsusf_army_ocp_squadleader", //0 - Squad leader
	"rhsusf_army_ocp_riflemanat", //1 - Rifleman AT
	"rhsusf_army_ocp_autorifleman", //2 - Autorifleman
	"rhsusf_army_ocp_medic", //3 - Combat life saver
	"rhsusf_army_ocp_teamleader", //4 - Team leader
	"rhsusf_army_ocp_rifleman", //5 - Rifleman
	"rhsusf_army_ocp_engineer", //6 - Engineer
	"rhsusf_army_ocp_marksman", //7 - Marksman
	"rhsusf_army_ocp_javelin", //8 - Missile specialist AT
	"rhsusf_army_ocp_grenadier", //9 - Grenadier
	"rhsusf_army_ocp_aa", //10 - Missile specialist AA
	"rhsusf_army_ocp_squadleader", //11 - Recon team leader
	"rhsusf_army_ocp_maaws", //12 - Recon scout AT (Rifleman AT)
	"rhsusf_army_ocp_autorifleman", //13 - Recon Marksman (Autorifleman)
	"rhsusf_army_ocp_medic", //14 - Recon Paramedic (Medic)
	"rhsusf_army_ocp_jfo", //15 - Recon JTAC (Grenadier)
	"rhsusf_army_ocp_rifleman", //16 - Recon Scout (Rifleman)
	"rhsusf_army_ocp_explosives", //17 - Recon demo specialist (Engineer)
	"rhsusf_army_ocp_sniper" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names