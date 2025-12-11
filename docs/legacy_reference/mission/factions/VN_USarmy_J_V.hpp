/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\VN_USarmy_J_V.hpp";
*/

//WEST (desert, arid, woodland, JUNGLE, winter)
BikeW=["vn_c_bicycle_01"]; //quad bike
CarW=["vn_b_wheeled_m151_01","vn_b_wheeled_m151_02"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["vn_b_wheeled_m151_mg_02","vn_b_wheeled_m151_mg_03","vn_b_wheeled_m151_mg_04","vn_b_wheeled_m151_mg_05","vn_b_wheeled_m151_mg_06"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["vn_b_wheeled_m54_01","vn_b_wheeled_m54_02","vn_b_wheeled_m54_01_sog","vn_b_wheeled_m54_02_sog","vn_b_wheeled_m54_mg_01","vn_b_wheeled_m54_mg_03"]; //truck
ArmorW1=["vn_b_armor_m113_acav_04","vn_b_armor_m113_acav_02","vn_b_armor_m113_acav_01","vn_b_armor_m113_acav_06","vn_b_armor_m113_acav_03","vn_b_armor_m113_acav_05","vn_b_armor_m113_01"]; //apc, ifv
ArmorW2=["vn_b_armor_m41_01_01","vn_b_armor_m48_01_01","vn_b_armor_m67_01_01"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["vn_b_air_oh6a_01",
/*"vn_b_air_oh6a_06","vn_b_air_oh6a_05","vn_b_air_oh6a_04","vn_b_air_oh6a_07","vn_b_air_oh6a_03","vn_b_air_oh6a_02",*/
"vn_b_air_uh1c_07_01","vn_b_air_uh1c_06_01","vn_b_air_uh1c_02_01","vn_b_air_uh1c_01_01","vn_b_air_uh1d_02_01"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["vn_b_air_ah1g_02","vn_b_air_ah1g_03","vn_b_air_ah1g_04","vn_b_air_ah1g_05","vn_b_air_ah1g_01","vn_b_air_ah1g_07","vn_b_air_ah1g_08","vn_b_air_ah1g_09","vn_b_air_ah1g_10","vn_b_air_ah1g_06"]; //gunship (armed heli)
PlaneW=["vn_b_air_f100d_bmb","vn_b_air_f100d_cbu","vn_b_air_f100d_ehcas","vn_b_air_f100d_hbmb","vn_b_air_f100d_hcas","vn_b_air_f100d_lbmb","vn_b_air_f100d_mbmb","vn_b_air_f100d_mr",
"vn_b_air_f4c_at","vn_b_air_f4c_bmb","vn_b_air_f4c_cas","vn_b_air_f4c_cbu","vn_b_air_f4c_chico","vn_b_air_f4c_ehcas","vn_b_air_f4c_gbu","vn_b_air_f4c_hbmb","vn_b_air_f4c_hcas","vn_b_air_f4c_lbmb","vn_b_air_f4c_lrbmb","vn_b_air_f4c_mbmb","vn_b_air_f4c_mr"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["vn_b_army_static_m45","vn_b_navy_static_l60mk3","vn_b_navy_static_l70mk2"]; //Anti Air
artiW=["vn_b_army_static_m101_02"]; //artillery
mortW = ["vn_b_army_static_mortar_m2","vn_b_army_static_mortar_m29"]; //mortar
crewW="vn_b_men_army_15"; //crew

boatTrW=["B_Boat_Transport_01_F"]; //small boat
boatArW=["vn_b_boat_12_02","vn_b_boat_12_04","vn_b_boat_12_01","vn_b_boat_12_03","vn_b_boat_13_02","vn_b_boat_13_04","vn_b_boat_13_01","vn_b_boat_13_03",
"vn_b_boat_10_01","vn_b_boat_09_01","vn_b_boat_11_01"]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["vn_b_ammobox_full_07"];
flgW = "vn_flag_usa";

endW = "EndVnUsarmy";

unitsW=
[
	"vn_b_men_army_02", //0 - Squad leader
	"vn_b_men_army_12", //1 - Rifleman AT
	"vn_b_men_army_06", //2 - Autorifleman
	"vn_b_men_army_03", //3 - Combat life saver
	"vn_b_men_army_07", //4 - Team leader
	"vn_b_men_army_15", //5 - Rifleman
	"vn_b_men_army_04", //6 - Engineer
	"vn_b_men_army_10", //7 - Marksman
	"vn_b_men_army_12", //8 - Missile specialist AT
	"vn_b_men_army_17", //9 - Grenadier
	"vn_b_men_army_16", //10 - Missile specialist AA
	"vn_b_men_army_02", //11 - Recon team leader
	"vn_b_men_army_12", //12 - Recon scout AT (Rifleman AT)
	"vn_b_men_army_27", //13 - Recon Marksman (Autorifleman)
	"vn_b_men_army_03", //14 - Recon Paramedic (Medic)
	"vn_b_men_army_07", //15 - Recon JTAC (Grenadier)
	"vn_b_men_army_18", //16 - Recon Scout (Rifleman)
	"vn_b_men_army_05", //17 - Recon demo specialist (Engineer)
	"vn_b_men_army_11" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names