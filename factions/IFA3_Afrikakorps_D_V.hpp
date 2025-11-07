/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_Afrikakorps_D_V.hpp";
*/

//WEST (DESERT)
BikeW=["LIB_DAK_Kfz1","LIB_DAK_Kfz1_hood"]; //quad bike
CarW=["LIB_DAK_Kfz1","LIB_DAK_Kfz1_hood"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["LIB_DAK_Scout_M3","LIB_DAK_Kfz1_MG42","LIB_DAK_Scout_M3_FFV"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["LIB_DAK_SdKfz_7","LIB_DAK_OpelBlitz_Open","LIB_DAK_OpelBlitz_Open_2","LIB_DAK_OpelBlitz_Open_3","LIB_DAK_OpelBlitz_Tent","LIB_DAK_OpelBlitz_Tent_2","LIB_DAK_OpelBlitz_Tent_3"]; //truck
ArmorW1=["LIB_DAK_M3_Halftrack","LIB_DAK_SdKfz251","LIB_DAK_SdKfz251_FFV"]; //apc, ifv
ArmorW2=["LIB_DAK_PzKpfwIV_H","LIB_DAK_PzKpfwVI_E"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[]; //gunship (armed heli)
PlaneW=["LIB_DAK_FW190F8","LIB_DAK_FW190F8_Desert","LIB_DAK_FW190F8_Desert2","LIB_DAK_FW190F8_Desert3","LIB_DAK_Ju87","LIB_DAK_Ju87_2"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["LIB_DAK_FlakPanzerIV_Wirbelwind"]; //Anti Air
artiW=["LIB_DAK_FlaK_36_ARTY"]; //artillery
mortW = ["LIB_GrWr34"]; //mortar
crewW="LIB_DAK_Soldier"; //crew

boatTrW=["B_G_Boat_Transport_01_F"]; //small boat
boatArW=[]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["LIB_BasicWeaponsBox_GER"];
flgW = "LIB_FlagCarrier_GER";

endW = "EndAfrikakorps";

unitsW=
[
	"LIB_DAK_NCO", //0 - Squad leader
	"LIB_DAK_AT_soldier", //1 - Rifleman AT
	"LIB_DAK_Soldier_4", //2 - Autorifleman
	"LIB_DAK_medic", //3 - Combat life saver
	"LIB_DAK_Soldier_2", //4 - Team leader
	"LIB_DAK_Soldier", //5 - Rifleman
	"LIB_DAK_sapper", //6 - Engineer
	"LIB_DAK_Sniper", //7 - Marksman
	"LIB_DAK_AT_soldier", //8 - Missile specialist AT
	"LIB_DAK_Soldier_2", //9 - Grenadier
	"LIB_DAK_Soldier", //10 - Missile specialist AA
	"LIB_DAK_NCO", //11 - Recon team leader
	"LIB_DAK_AT_soldier", //12 - Recon scout AT (Rifleman AT)
	"LIB_DAK_Soldier_4", //13 - Recon Marksman (Autorifleman)
	"LIB_DAK_medic", //14 - Recon Paramedic (Medic)
	"LIB_DAK_Soldier_2", //15 - Recon JTAC (Grenadier)
	"LIB_DAK_Soldier", //16 - Recon Scout (Rifleman)
	"LIB_DAK_sapper", //17 - Recon demo specialist (Engineer)
	"LIB_DAK_Sniper" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='_GER'; //voices
nameW="LIB_GermanMen"; //names