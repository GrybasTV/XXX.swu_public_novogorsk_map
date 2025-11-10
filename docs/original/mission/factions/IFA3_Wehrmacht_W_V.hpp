/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\IFA3_Wehrmacht_W_V.hpp";
*/

//WEST (arid, WOODLAND, jungle)
BikeW=["LIB_Kfz1","LIB_Kfz1_camo","LIB_Kfz1_Hood","LIB_Kfz1_Hood_camo","LIB_Kfz1_Hood_sernyt","LIB_Kfz1_sernyt"]; //quad bike
CarW=["LIB_Kfz1","LIB_Kfz1_camo","LIB_Kfz1_Hood","LIB_Kfz1_Hood_camo","LIB_Kfz1_Hood_sernyt","LIB_Kfz1_sernyt"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["LIB_Kfz1_MG42","LIB_Kfz1_MG42_camo","LIB_Kfz1_MG42_sernyt"]; //armed car (,"LIB_SdKfz222","LIB_SdKfz222_camo","LIB_SdKfz222_gelbbraun")
CarArDlcW=[]; //armed car apex dlc
TruckW=["LIB_OpelBlitz_Open_Y_Camo","LIB_OpelBlitz_Tent_Y_Camo"]; //truck
ArmorW1=["LIB_SdKfz251","LIB_SdKfz251_FFV"]; //apc, ifv (,"LIB_SdKfz234_1","LIB_SdKfz234_2","LIB_SdKfz234_3","LIB_SdKfz234_4")
ArmorW2=["LIB_PzKpfwIV_H","LIB_PzKpfwIV_H_tarn51c","LIB_PzKpfwIV_H_tarn51d","LIB_PzKpfwV","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_tarn51c","LIB_PzKpfwVI_B_tarn51d","LIB_PzKpfwVI_E","LIB_PzKpfwVI_E_2","LIB_PzKpfwVI_E_tarn51c","LIB_PzKpfwVI_E_tarn51d","LIB_PzKpfwVI_E_tarn52c","LIB_PzKpfwVI_E_tarn52d","LIB_PzKpfwVI_E_1","LIB_SdKfz124","LIB_StuG_III_G"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[]; //gunship (armed heli)
PlaneW=["LIB_FW190F8","LIB_FW190F8_4","LIB_FW190F8_5","LIB_FW190F8_2","LIB_FW190F8_3","LIB_Ju87"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["LIB_FlakPanzerIV_Wirbelwind"]; //Anti Air
artiW=["LIB_FlaK_36_ARTY"]; //artillery
mortW = ["LIB_GrWr34","LIB_GrWr34_g"]; //mortar
crewW="LIB_GER_rifleman"; //crew

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
	"LIB_GER_unterofficer", //0 - Squad leader
	"LIB_GER_AT_soldier", //1 - Rifleman AT
	"LIB_GER_mgunner", //2 - Autorifleman
	"LIB_GER_medic", //3 - Combat life saver
	"LIB_GER_smgunner", //4 - Team leader
	"LIB_GER_rifleman", //5 - Rifleman
	"LIB_GER_sapper", //6 - Engineer
	"LIB_GER_scout_sniper", //7 - Marksman
	"LIB_GER_AT_soldier", //8 - Missile specialist AT
	"LIB_GER_smgunner", //9 - Grenadier
	"LIB_GER_rifleman", //10 - Missile specialist AA
	"SG_sturmtrooper_unterofficer", //11 - Recon team leader
	"SG_sturmtrooper_AT_soldier", //12 - Recon scout AT (Rifleman AT)
	"SG_sturmtrooper_mgunner", //13 - Recon Marksman (Autorifleman)
	"SG_sturmtrooper_medic", //14 - Recon Paramedic (Medic)
	"SG_sturmtrooper_smgunner", //15 - Recon JTAC (Grenadier)
	"SG_sturmtrooper_rifleman", //16 - Recon Scout (Rifleman)
	"SG_sturmtrooper_sapper", //17 - Recon demo specialist (Engineer)
	"SG_sturmtrooper_sniper" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='_GER'; //voices
nameW="LIB_GermanMen"; //names