/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\SPE_Wehrmacht_W_V.hpp";
*/

//WEST (arid, WOODLAND, jungle)
BikeW=["SPE_GER_R200_Unarmed","SPE_GER_R200_Hood"]; //quad bike
CarW=["SPE_GER_R200_Unarmed","SPE_GER_R200_Hood"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["SPE_GER_R200_MG34"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["SPE_ST_OpelBlitz","SPE_ST_OpelBlitz_Open"]; //truck
ArmorW1=["SPE_SdKfz250_1"]; //apc, ifv
ArmorW2=["SPE_PzKpfwIII_J","SPE_PzKpfwIII_L","SPE_PzKpfwIII_M","SPE_PzKpfwIII_N","SPE_PzKpfwIV_G","SPE_PzKpfwVI_H1","SPE_Nashorn","SPE_PzKpfwV_G","SPE_StuG_III_G_Early","SPE_StuG_III_G_Late","SPE_StuG_III_G_SKB","SPE_StuH_42","SPE_Jagdpanther_G1"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[]; //gunship (armed heli)
PlaneW=["SPE_FW190F8"]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["SPE_OpelBlitz_Flak38","SPE_FlaK_38"]; //Anti Air
artiW=["SPE_leFH18"]; //artillery
mortW = ["SPE_GrW278_1"]; //mortar
crewW="SPE_GER_rifleman"; //crew

boatTrW=["B_G_Boat_Transport_01_F"]; //small boat
boatArW=[]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["SPE_BasicWeaponsBox_GER"];
flgW = "SPE_FlagCarrier_GER";

endW = "EndWehrmacht";

unitsW=
[
	"SPE_GER_SquadLead", //0 - Squad leader
	"SPE_GER_LAT_Rifleman", //1 - Rifleman AT
	"SPE_GER_mgunner", //2 - Autorifleman
	"SPE_GER_medic", //3 - Combat life saver
	"SPE_GER_ober_grenadier", //4 - Team leader
	"SPE_GER_rifleman", //5 - Rifleman
	"SPE_GER_sapper", //6 - Engineer
	"SPE_GER_scout_sniper", //7 - Marksman
	"SPE_GER_LAT_Rifleman", //8 - Missile specialist AT
	"SPE_GER_ober_grenadier", //9 - Grenadier
	"SPE_GER_LAT_30m_Rifleman", //10 - Missile specialist AA
	"SPE_GER_SquadLead", //11 - Recon team leader
	"SPE_GER_LAT_Rifleman", //12 - Recon scout AT (Rifleman AT)
	"SPE_GER_mgunner2", //13 - Recon Marksman (Autorifleman)
	"SPE_GER_medic", //14 - Recon Paramedic (Medic)
	"SPE_GER_ober_grenadier", //15 - Recon JTAC (Grenadier)
	"SPE_GER_rifleman_2", //16 - Recon Scout (Rifleman)
	"SPE_GER_sapper_gefr", //17 - Recon demo specialist (Engineer)
	"SPE_GER_scout_sniper" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW= ["SPE_Male01GER","SPE_Male02GER"]; //voices (check later)
nameW="SPE_GermanMen"; //names