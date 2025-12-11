/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\VN_PAVN_J_V.hpp";
*/

//EAST (desert, arid, woodland, JUNGLE, winter)
BikeE=["vn_o_bicycle_01"]; //quad bike
CarE=["vn_o_wheeled_btr40_01"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["vn_o_wheeled_btr40_mg_01","vn_o_wheeled_btr40_mg_02","vn_o_wheeled_btr40_mg_04"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["vn_o_wheeled_z157_01","vn_o_wheeled_z157_02"]; //truck
ArmorE1=["vn_o_armor_btr50pk_01","vn_o_armor_m113_acav_01","vn_o_armor_m113_acav_03","vn_o_armor_m113_01"]; //apc, ifv
ArmorE2=["vn_o_armor_m41_01","vn_o_armor_ot54_01","vn_o_armor_pt76a_01","vn_o_armor_pt76b_01","vn_o_armor_t54b_01","vn_o_armor_type63_01"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["vn_o_air_mi2_01_03","vn_o_air_mi2_03_04"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["vn_o_air_mi2_04_02","vn_o_air_mi2_04_04","vn_o_air_mi2_05_06","vn_o_air_mi2_05_02","vn_o_air_mi2_05_04","vn_o_air_mi2_04_06"]; //gunship (armed heli)
PlaneE=["vn_o_air_mig19_bmb","vn_o_air_mig19_hbmb","vn_o_air_mig19_mr","vn_o_air_mig21_bmb","vn_o_air_mig21_hbmb","vn_o_air_mig21_mr"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=["vn_o_nva_static_zpu4"]; //Anti Air
artiE=["vn_o_nva_static_d44_01","vn_o_nva_static_h12"]; //artillery
mortE = ["vn_o_nva_static_mortar_type53","vn_o_nva_static_mortar_type63"]; //mortar
crewE="vn_o_men_nva_12"; //crew

boatTrE=["O_G_Boat_Transport_01_F"]; //small boat
boatArE=["vn_o_boat_03_01","vn_o_boat_03_02","vn_o_boat_04_01","vn_o_boat_04_02"]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["vn_o_ammobox_full_08"];
flgE = "vn_flag_pavn";

endE = "EndVnPavn";

unitsE=
[
	"vn_o_men_nva_01", //0 - Squad leader
	"vn_o_men_nva_14", //1 - Rifleman AT
	"vn_o_men_nva_11", //2 - Autorifleman
	"vn_o_men_nva_08", //3 - Combat life saver
	"vn_o_men_nva_07", //4 - Team leader
	"vn_o_men_nva_06", //5 - Rifleman
	"vn_o_men_nva_09", //6 - Engineer
	"vn_o_men_nva_10", //7 - Marksman
	"vn_o_men_nva_14", //8 - Missile specialist AT
	"vn_o_men_nva_07", //9 - Grenadier
	"vn_o_men_nva_43", //10 - Missile specialist AA
	"vn_o_men_nva_01", //11 - Recon team leader
	"vn_o_men_nva_14", //12 - Recon scout AT (Rifleman AT)
	"vn_o_men_nva_11", //13 - Recon Marksman (Autorifleman)
	"vn_o_men_nva_08", //14 - Recon Paramedic (Medic)
	"vn_o_men_nva_07", //15 - Recon JTAC (Grenadier)
	"vn_o_men_nva_03", //16 - Recon Scout (Rifleman)
	"vn_o_men_nva_09", //17 - Recon demo specialist (Engineer)
	"vn_o_men_nva_10" //18 - Sniper (Marksman)
];

faceE='Asian'; //faces (config)
voiceE='VIE_'; //voices
nameE="vietmen"; //names