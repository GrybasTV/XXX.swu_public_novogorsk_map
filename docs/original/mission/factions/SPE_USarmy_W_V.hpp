/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\SPE_USarmy_W_V.hpp";
*/

//EAST (desert, arid, WOODLAND, jungle)
BikeE=["SPE_US_G503_MB","SPE_US_G503_MB_Armoured","SPE_US_G503_MB_Open"]; //quad bike
CarE=["SPE_US_G503_MB","SPE_US_G503_MB_Armoured","SPE_US_G503_MB_Open"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["SPE_US_G503_MB_M1919_Armoured","SPE_US_G503_MB_M1919","SPE_US_G503_MB_M2_Armoured","SPE_US_G503_MB_M2"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["SPE_US_M3_Halftrack_Unarmed","SPE_US_M3_Halftrack_Unarmed_Open","SPE_CCKW_353","SPE_CCKW_353_M2","SPE_CCKW_353_Open"]; //truck
ArmorE1=["SPE_US_M3_Halftrack","SPE_M8_LAC","SPE_M8_LAC_ringMount"]; //apc, ifv
ArmorE2=["SPE_M10","SPE_M18_Hellcat","SPE_M4A0_75_Early","SPE_M4A0_75","SPE_M4A1_76","SPE_M4A1_75","SPE_M4A0_composite","SPE_M4A0_105","SPE_M4A1_75_erla","SPE_M4A3_105","SPE_M4A3_75","SPE_M4A3_76"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=["SPE_P47"]; //jet
PlaneDlcE=[]; //jets dlc

aaE=["SPE_US_M16_Halftrack","SPE_M45_Quadmount"]; //Anti Air
artiE=["SPE_M4A1_T34_Calliope","SPE_M4A3_T34_Calliope","SPE_105mm_M3"]; //artillery
mortE = ["SPE_M1_81"]; //mortar
crewE="SPE_US_Rifleman"; //crew

boatTrE=["I_G_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["SPE_BasicWeaponsBox_US"];
flgE = "SPE_FlagCarrier_USA";

endE = "EndUSarmy";

unitsE=
[
	"SPE_US_Captain", //0 - Squad leader
	"SPE_US_AT_Soldier", //1 - Rifleman AT
	"SPE_US_Autorifleman", //2 - Autorifleman
	"SPE_US_Medic", //3 - Combat life saver
	"SPE_US_First_Lieutenant", //4 - Team leader
	"SPE_US_Rifleman", //5 - Rifleman
	"SPE_US_Engineer", //6 - Engineer
	"SPE_US_Sniper", //7 - Marksman
	"SPE_US_AT_Soldier", //8 - Missile specialist AT
	"SPE_US_Grenadier", //9 - Grenadier
	"SPE_US_AT_Soldier", //10 - Missile specialist AA
	"SPE_US_Captain", //11 - Recon team leader
	"SPE_US_AT_Soldier", //12 - Recon scout AT (Rifleman AT)
	"SPE_US_HMGunner", //13 - Recon Marksman (Autorifleman)
	"SPE_US_Medic", //14 - Recon Paramedic (Medic)
	"SPE_US_First_Lieutenant", //15 - Recon JTAC (Grenadier)
	"SPE_US_Rifleman", //16 - Recon Scout (Rifleman)
	"SPE_US_Engineer", //17 - Recon demo specialist (Engineer)
	"SPE_US_Sniper" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='ENG_'; //voices
nameE="SPE_EnglishMen"; //names