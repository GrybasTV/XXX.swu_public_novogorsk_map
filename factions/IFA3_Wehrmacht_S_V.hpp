/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_Wehrmacht_S_V.hpp";
*/

//WEST (WINTER)
BikeW=["LIB_Kfz1_w","LIB_Kfz1_Hood_w"]; //quad bike
CarW=["LIB_Kfz1_w","LIB_Kfz1_Hood_w"]; //car
CarDlcW=[]; //car apex dlc
CarArW=[["LIB_Kfz1_MG42","winter"]]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["LIB_OpelBlitz_Open_G_Camo_w","LIB_OpelBlitz_Open_Y_Camo_w","LIB_OpelBlitz_Tent_Y_Camo_w","LIB_SdKfz_7_w"]; //truck
ArmorW1=["LIB_Sdkfz251_w","LIB_SdKfz251_FFV_w"]; //apc, ifv
ArmorW2=["LIB_PzKpfwIV_H_w","LIB_PzKpfwV_w","LIB_PzKpfwVI_B_w","LIB_PzKpfwVI_B_camo_w","LIB_PzKpfwVI_E_w","LIB_StuG_III_G_w","LIB_StuG_III_G_WS_w"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[]; //gunship (armed heli)
PlaneW=["LIB_FW190F8_2_W","LIB_FW190F8_3_W","LIB_FW190F8_w","LIB_Ju87_w"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["LIB_FlakPanzerIV_Wirbelwind_w"]; //Anti Air
artiW=["LIB_FlaK_36_ARTY_w"]; //artillery
mortW = ["LIB_GrWr34","LIB_GrWr34_g"]; //mortar
crewW="LIB_GER_Rifleman_w"; //crew

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

endW = "EndWehrmacht";

unitsW=
[
	"LIB_GER_Unterofficer_w", //0 - Squad leader
	"LIB_GER_AT_soldier_w", //1 - Rifleman AT
	"LIB_GER_Mgunner_w", //2 - Autorifleman
	"LIB_GER_Medic_w", //3 - Combat life saver
	"LIB_GER_Smgunner_w", //4 - Team leader
	"LIB_GER_Rifleman_w", //5 - Rifleman
	"LIB_GER_Sapper_w", //6 - Engineer
	"LIB_GER_Scout_sniper_2_w", //7 - Marksman
	"LIB_GER_AT_soldier_w", //8 - Missile specialist AT
	"LIB_GER_Smgunner_w", //9 - Grenadier
	"LIB_GER_Rifleman_w", //10 - Missile specialist AA
	"LIB_GER_Unterofficer_w", //11 - Recon team leader
	"LIB_GER_AT_soldier_w", //12 - Recon scout AT (Rifleman AT)
	"LIB_GER_Mgunner_w", //13 - Recon Marksman (Autorifleman)
	"LIB_GER_Medic_w", //14 - Recon Paramedic (Medic)
	"LIB_GER_Smgunner_w", //15 - Recon JTAC (Grenadier)
	"LIB_GER_Rifleman_w", //16 - Recon Scout (Rifleman)
	"LIB_GER_Sapper_w", //17 - Recon demo specialist (Engineer)
	"LIB_GER_Scout_sniper_2_w" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='_GER'; //voices
nameW="LIB_GermanMen"; //names