/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_RedArmy_W_V.hpp";
*/

//EAST (desert, arid, WOODLAND, jungle)
BikeE=["LIB_Willys_MB","LIB_GazM1_SOV","LIB_GazM1_SOV_camo_sand"]; //quad bike
CarE=["LIB_Willys_MB","LIB_GazM1_SOV","LIB_GazM1_SOV_camo_sand"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["LIB_Scout_M3","LIB_Scout_M3_FFV"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["LIB_US6_Open","LIB_Zis5v","LIB_US6_Tent"]; //truck
ArmorE1=["LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV"]; //apc, ifv
ArmorE2=["LIB_JS2_43","LIB_M4A2_SOV","LIB_SU85","LIB_T34_76","LIB_T34_85"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["LIB_P39","LIB_RA_P39_3","LIB_RA_P39_2","LIB_Pe2"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=["LIB_US6_BM13"]; //artillery
mortE = ["LIB_BM37"]; //mortar
crewE="LIB_SOV_rifleman"; //crew

boatTrE=["O_G_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["LIB_BasicWeaponsBox_SU"];
flgE = "LIB_FlagCarrier_SU";

endE = "EndRedArmy";

unitsE=
[
	"LIB_SOV_sergeant", //0 - Squad leader
	"LIB_SOV_AT_soldier", //1 - Rifleman AT
	"LIB_SOV_mgunner", //2 - Autorifleman
	"LIB_SOV_medic", //3 - Combat life saver
	"LIB_SOV_staff_sergeant", //4 - Team leader
	"LIB_SOV_rifleman", //5 - Rifleman
	"LIB_SOV_sapper", //6 - Engineer
	"LIB_SOV_scout_sniper", //7 - Marksman
	"LIB_SOV_AT_soldier", //8 - Missile specialist AT
	"LIB_SOV_staff_sergeant", //9 - Grenadier
	"LIB_SOV_rifleman", //10 - Missile specialist AA
	"LIB_SOV_sergeant", //11 - Recon team leader
	"LIB_SOV_AT_soldier", //12 - Recon scout AT (Rifleman AT)
	"LIB_SOV_mgunner", //13 - Recon Marksman (Autorifleman)
	"LIB_SOV_medic", //14 - Recon Paramedic (Medic)
	"LIB_SOV_staff_sergeant", //15 - Recon JTAC (Grenadier)
	"LIB_SOV_rifleman", //16 - Recon Scout (Rifleman)
	"LIB_SOV_sapper", //17 - Recon demo specialist (Engineer)
	"LIB_SOV_scout_sniper" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='RUS_'; //voices
nameE="LIB_RussianMen"; //names