/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RHS_USAF_W_V.hpp";
*/

//WEST (WOODLAND, jungle)
BikeW=["B_Quadbike_01_F"]; //quad bike
CarW=["rhsusf_m1025_w_s","rhsusf_m1043_w_s","rhsusf_m998_w_s_2dr_halftop","rhsusf_m998_w_s_2dr","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_4dr","rhsusf_m998_w_s_4dr_fulltop","rhsusf_m1151_usmc_wd","rhsusf_m1165_usmc_wd","rhsusf_CGRCAT1A2_usmc_wd","rhsusf_m1240a1_usmc_wd"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19","rhsusf_m1043_w_s_m2","rhsusf_m1043_w_s_mk19","rhsusf_m1045_w_s","rhsusf_m1151_m2crows_usmc_wd","rhsusf_m1151_mk19crows_usmc_wd","rhsusf_m1151_m2_v3_usmc_wd","rhsusf_m1151_m240_v3_usmc_wd","rhsusf_m1151_mk19_v3_usmc_wd","rhsusf_CGRCAT1A2_M2_usmc_wd","rhsusf_CGRCAT1A2_Mk19_usmc_wd","rhsusf_M1232_MC_M2_usmc_wd","rhsusf_M1232_MC_MK19_usmc_wd","rhsusf_m1240a1_m2_usmc_wd","rhsusf_m1240a1_m240_usmc_wd","rhsusf_m1240a1_mk19_usmc_wd","rhsusf_m1240a1_m2crows_usmc_wd","rhsusf_m1240a1_mk19crows_usmc_wd"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["rhsusf_M1078A1P2_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1083A1P2_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy"]; //truck
ArmorW1=["rhsusf_stryker_m1126_m2_wd","rhsusf_stryker_m1126_mk19_wd","rhsusf_stryker_m1127_m2_wd","rhsusf_stryker_m1132_m2_np_wd","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd","RHS_M6_wd"]; //apc, ifv
ArmorW2=["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1hc_wd"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["RHS_UH1Y_UNARMED","RHS_UH60M","RHS_UH60M2"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["RHS_AH1Z_wd","RHS_AH64D_wd"]; //gunship (armed heli)
PlaneW=["RHS_A10","rhsusf_f22"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["rhsusf_stryker_m1134_wd"]; //Anti Air
artiW=["rhsusf_m109_usarmy","rhsusf_M142_usarmy_WD"]; //artillery ("RHS_M119_WD")
mortW = ["RHS_M252_USMC_WD"]; //mortar
crewW="rhsusf_usmc_marpat_wd_crewman"; //crew

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
	"rhsusf_usmc_marpat_wd_squadleader", //0 - Squad leader
	"rhsusf_usmc_marpat_wd_smaw", //1 - Rifleman AT
	"rhsusf_usmc_marpat_wd_autorifleman_m249", //2 - Autorifleman
	"rhsusf_usmc_marpat_wd_rifleman_m4", //3 - Combat life saver
	"rhsusf_usmc_marpat_wd_teamleader", //4 - Team leader
	"rhsusf_usmc_marpat_wd_rifleman_m4", //5 - Rifleman
	"rhsusf_usmc_marpat_wd_engineer", //6 - Engineer
	"rhsusf_usmc_marpat_wd_marksman", //7 - Marksman
	"rhsusf_usmc_marpat_wd_javelin", //8 - Missile specialist AT
	"rhsusf_usmc_marpat_wd_grenadier", //9 - Grenadier
	"rhsusf_usmc_marpat_wd_stinger", //10 - Missile specialist AA
	"rhsusf_usmc_recon_marpat_wd_teamleader", //11 - Recon team leader
	"rhsusf_usmc_recon_marpat_wd_rifleman_at", //12 - Recon scout AT (Rifleman AT)
	"rhsusf_usmc_recon_marpat_wd_machinegunner_m249", //13 - Recon Marksman (Autorifleman)
	"rhsusf_usmc_recon_marpat_wd_rifleman", //14 - Recon Paramedic (Medic)
	"rhsusf_usmc_recon_marpat_wd_teamleader_lite", //15 - Recon JTAC (Grenadier)
	"rhsusf_usmc_recon_marpat_wd_rifleman", //16 - Recon Scout (Rifleman)
	"rhsusf_usmc_recon_marpat_wd_autorifleman", //17 - Recon demo specialist (Engineer)
	"rhsusf_usmc_recon_marpat_wd_marksman" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names