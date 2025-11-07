/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_DesertRats_D_V.hpp";
*/

//EAST (DESERT)
BikeE=["LIB_UK_DR_Willys_MB"]; //quad bike
CarE=["LIB_UK_DR_Willys_MB"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["LIB_UK_DR_M3_Halftrack","LIB_UniversalCarrier_desert"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["LIB_US_NAC_GMC_Tent","LIB_US_NAC_GMC_Open"]; //truck
ArmorE1=["LIB_UK_DR_M3_Halftrack","LIB_UniversalCarrier_desert"]; //apc, ifv
ArmorE2=["LIB_UK_DR_M4A3_75","LIB_UK_Italy_M4A3_75","LIB_Churchill_Mk7_desert","LIB_Churchill_Mk7_AVRE_desert","LIB_Churchill_Mk7_Crocodile_desert","LIB_Churchill_Mk7_Howitzer_desert"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["LIB_RAF_P39"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=[]; //artillery
mortE = ["LIB_M2_60"]; //mortar
crewE="LIB_UK_DR_Rifleman"; //crew

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

endE = "EndDesertRats";

unitsE=
[
	"LIB_UK_DR_Sergeant", //0 - Squad leader
	"LIB_UK_DR_AT_Soldier", //1 - Rifleman AT
	"LIB_UK_DR_LanceCorporal", //2 - Autorifleman
	"LIB_UK_DR_Medic", //3 - Combat life saver
	"LIB_UK_DR_Corporal", //4 - Team leader
	"LIB_UK_DR_Rifleman", //5 - Rifleman
	"LIB_UK_DR_Engineer", //6 - Engineer
	"LIB_UK_DR_Sniper", //7 - Marksman
	"LIB_UK_DR_AT_Soldier", //8 - Missile specialist AT
	"LIB_UK_DR_Corporal", //9 - Grenadier
	"LIB_UK_DR_Rifleman", //10 - Missile specialist AA
	"LIB_UK_DR_Sergeant", //11 - Recon team leader
	"LIB_UK_DR_AT_Soldier", //12 - Recon scout AT (Rifleman AT)
	"LIB_UK_DR_LanceCorporal", //13 - Recon Marksman (Autorifleman)
	"LIB_UK_DR_Medic", //14 - Recon Paramedic (Medic)
	"LIB_UK_DR_Corporal", //15 - Recon JTAC (Grenadier)
	"LIB_UK_DR_Rifleman", //16 - Recon Scout (Rifleman)
	"LIB_UK_DR_Engineer", //17 - Recon demo specialist (Engineer)
	"LIB_UK_DR_Sniper" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='ENGB_'; //voices
nameE="EnglishMen"; //names