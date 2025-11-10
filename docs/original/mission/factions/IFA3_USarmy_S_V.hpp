/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_USarmy_S_V.hpp";
*/

//EAST (WINTER)
BikeE=["LIB_US_Willys_MB_w","LIB_US_Willys_MB_Hood_w"]; //quad bike
CarE=["LIB_US_Willys_MB_w","LIB_US_Willys_MB_Hood_w"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["LIB_US_Scout_m3_w","LIB_US_Scout_M3_FFV_w","LIB_US_Willys_MB_M1919_w"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["LIB_US_GMC_Tent_w","LIB_US_GMC_Open_w"]; //truck
ArmorE1=["LIB_US_M3_Halftrack_w"]; //apc, ifv
ArmorE2=["LIB_M8_Greyhound","LIB_M3A3_Stuart","LIB_M4A3_75","LIB_M4A3_76","LIB_M4A3_76_HVSS","LIB_M5A1_Stuart","LIB_M4A3_75_w"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["LIB_US_P39","LIB_US_P39_2","LIB_P47"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=[]; //artillery
mortE = ["LIB_M2_60"]; //mortar
crewE="LIB_US_Rifleman_w"; //crew

boatTrE=["I_G_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["LIB_BasicWeaponsBox_US"];
flgE = "LIB_FlagCarrier_USA";

endE = "EndUSarmy";

unitsE=
[
	"LIB_US_Captain_w", //0 - Squad leader
	"LIB_US_AT_soldier_w", //1 - Rifleman AT
	"LIB_US_Mgunner_w", //2 - Autorifleman
	"LIB_US_Medic_w", //3 - Combat life saver
	"LIB_US_First_lieutenant_w", //4 - Team leader
	"LIB_US_Rifleman_w", //5 - Rifleman
	"LIB_US_Engineer_w", //6 - Engineer
	"LIB_US_Sniper_w", //7 - Marksman
	"LIB_US_AT_soldier_w", //8 - Missile specialist AT
	"LIB_US_First_lieutenant_w", //9 - Grenadier
	"LIB_US_Rifleman_w", //10 - Missile specialist AA
	"LIB_US_Captain_w", //11 - Recon team leader
	"LIB_US_AT_soldier_w", //12 - Recon scout AT (Rifleman AT)
	"LIB_US_Mgunner_w", //13 - Recon Marksman (Autorifleman)
	"LIB_US_Medic_w", //14 - Recon Paramedic (Medic)
	"LIB_US_First_lieutenant_w", //15 - Recon JTAC (Grenadier)
	"LIB_US_Rifleman_w", //16 - Recon Scout (Rifleman)
	"LIB_US_Engineer_w", //17 - Recon demo specialist (Engineer)
	"LIB_US_Sniper_w" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='ENG_'; //voices
nameE="NATOMen"; //names