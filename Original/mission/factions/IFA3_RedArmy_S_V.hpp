/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_RedArmy_S_V.hpp";
*/

//EAST (WINTER)
BikeE=["LIB_Willys_MB_w"]; //quad bike
CarE=["LIB_Willys_MB_w"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["LIB_Scout_m3_w","LIB_Scout_M3_FFV_w"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["LIB_Zis5v_w"]; //truck
ArmorE1=["LIB_SOV_M3_Halftrack_w","LIB_SdKfz251_captured_w","LIB_SdKfz251_captured_FFV_w"]; //apc, ifv
ArmorE2=["LIB_JS2_43_w","LIB_M4A2_SOV_w","LIB_SU85_w","LIB_T34_76_w","LIB_T34_85_w"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["LIB_P39_w"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=["LIB_US6_BM13"]; //artillery
mortE = ["LIB_BM37"]; //mortar
crewE="LIB_SOV_Rifleman_w"; //crew

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
	"LIB_SOV_Sergeant_w", //0 - Squad leader
	"LIB_SOV_AT_soldier_w", //1 - Rifleman AT
	"LIB_SOV_Mgunner_w", //2 - Autorifleman
	"LIB_SOV_Medic_w", //3 - Combat life saver
	"LIB_SOV_Staff_sergeant_w", //4 - Team leader
	"LIB_SOV_Rifleman_ADS_w", //5 - Rifleman
	"LIB_SOV_Sapper_w", //6 - Engineer
	"LIB_SOV_Scout_sniper_w", //7 - Marksman
	"LIB_SOV_AT_soldier_w", //8 - Missile specialist AT
	"LIB_SOV_Staff_sergeant_w", //9 - Grenadier
	"LIB_SOV_Rifleman_ADS_w", //10 - Missile specialist AA
	"LIB_SOV_Sergeant_w", //11 - Recon team leader
	"LIB_SOV_AT_soldier_w", //12 - Recon scout AT (Rifleman AT)
	"LIB_SOV_Mgunner_w", //13 - Recon Marksman (Autorifleman)
	"LIB_SOV_Medic_w", //14 - Recon Paramedic (Medic)
	"LIB_SOV_Staff_sergeant_w", //15 - Recon JTAC (Grenadier)
	"LIB_SOV_Rifleman_ADS_w", //16 - Recon Scout (Rifleman)
	"LIB_SOV_Sapper_w", //17 - Recon demo specialist (Engineer)
	"LIB_SOV_Scout_sniper_w" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='RUS_'; //voices
nameE="LIB_RussianMen"; //names