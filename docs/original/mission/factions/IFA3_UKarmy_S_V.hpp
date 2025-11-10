/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_UKarmy_S_V.hpp";
*/

//EAST (WINTER)
BikeE=["LIB_UK_Willys_MB_w","LIB_UK_Willys_MB_Hood_w"]; //quad bike
CarE=["LIB_UK_Willys_MB_w","LIB_UK_Willys_MB_Hood_w"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["LIB_UK_Willys_MB_M1919_w"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["LIB_US_GMC_Tent_w","LIB_US_GMC_Open_w"]; //truck
ArmorE1=["LIB_UK_M3_Halftrack","LIB_UniversalCarrier_w"]; //apc, ifv
ArmorE2=["LIB_Churchill_Mk7_w","LIB_Churchill_Mk7_AVRE_w","LIB_Churchill_Mk7_Crocodile_w","LIB_Churchill_Mk7_Howitzer_w","LIB_Cromwell_Mk4_w","LIB_M4A4_FIREFLY"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["LIB_RAF_P39"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=[]; //artillery
mortE = ["LIB_M2_60"]; //mortar
crewE="LIB_UK_Rifleman_w"; //crew

boatTrE=["I_G_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["LIB_BasicWeaponsBox_UK"];
flgE = "LIB_FlagCarrier_UK";

endE = "EndUKarmy";

unitsE=
[
	"LIB_UK_Sergeant_w", //0 - Squad leader
	"LIB_UK_AT_Soldier_w", //1 - Rifleman AT
	"LIB_UK_LanceCorporal_w", //2 - Autorifleman
	"LIB_UK_Medic_w", //3 - Combat life saver
	"LIB_UK_Grenadier_w", //4 - Team leader
	"LIB_UK_Rifleman_w", //5 - Rifleman
	"LIB_UK_Engineer_w", //6 - Engineer
	"LIB_UK_Sniper_w", //7 - Marksman
	"LIB_UK_AT_Soldier_w", //8 - Missile specialist AT
	"LIB_UK_Grenadier_w", //9 - Grenadier
	"LIB_UK_Rifleman_w", //10 - Missile specialist AA
	"LIB_UK_Para_Sergeant_w", //11 - Recon team leader
	"LIB_UK_Para_AT_Soldier_w", //12 - Recon scout AT (Rifleman AT)
	"LIB_UK_Para_LanceCorporal_w", //13 - Recon Marksman (Autorifleman)
	"LIB_UK_Para_Medic_w", //14 - Recon Paramedic (Medic)
	"LIB_UK_Para_Grenadier_w", //15 - Recon JTAC (Grenadier)
	"LIB_UK_Para_Rifleman_w", //16 - Recon Scout (Rifleman)
	"LIB_UK_Para_Engineer_w", //17 - Recon demo specialist (Engineer)
	"LIB_UK_Para_Sniper_w" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='ENGB_'; //voices
nameE="EnglishMen"; //names