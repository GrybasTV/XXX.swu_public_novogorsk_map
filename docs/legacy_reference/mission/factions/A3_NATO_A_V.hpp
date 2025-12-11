/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_NATO_A_V.hpp";
*/

//WEST (desert, ARID, winter)
BikeW=["B_Quadbike_01_F"]; //quad bike
CarW=["B_MRAP_01_F"]; //car
CarDlcW=["B_LSV_01_unarmed_F"]; //car apex dlc
CarArW=["B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"]; //armed car
CarArDlcW=["B_LSV_01_armed_F","B_LSV_01_AT_F"]; //armed car apex dlc
TruckW=["B_Truck_01_transport_F", "B_Truck_01_covered_F"]; //truck
ArmorW1=["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F"]; //apc, ifv
ArmorW2=["B_MBT_01_TUSK_F"]; //tank
ArmorDlcW2=["B_AFV_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F"]; //tank tanks dlc

HeliTrW=["B_Heli_Transport_01_camo_F", "B_Heli_Light_01_F"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc

if(factionE=="CSAT")then{HeliArW=["B_Heli_Attack_01_F"];}; //gunship (armed heli)
if(factionE=="AAF"||factionE=="LDF")then{HeliArW=["B_Heli_Light_01_armed_F"];};

PlaneW=["B_Plane_CAS_01_F"]; //jet
PlaneDlcW=["B_Plane_Fighter_01_Cluster_F"]; //jets dlc

aaW=["B_APC_Tracked_01_AA_F"]; //Anti Air
artiW=["B_MBT_01_arty_F","B_MBT_01_mlrs_F"]; //artillery
mortW = ["B_Mortar_01_F"]; //mortar
crewW="B_crew_F"; //crew

boatTrW=["B_Boat_Transport_01_F"]; //small boat
boatArW=["B_Boat_Armed_01_minigun_F"]; //patrol boat

divEw=["U_B_Wetsuit","V_RebreatherB","G_B_Diving"]; //diver gear (boat cargo) 
divWw="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMw="30Rnd_556x45_Stanag_red"; //diver ammo (boat cargo)

uavsW=["B_UAV_02_F", "B_UAV_05_F", "B_T_UAV_03_F"]; //UAV
uavsDlcW=["B_T_UAV_03_F"]; //UAV apex dlc
uavsDlc2W=["B_UAV_05_F"]; //UAV jets dlc
ugvsW=["B_UGV_01_rcws_F"]; //UGV

supplyW=["B_supplyCrate_F","B_CargoNet_01_ammo_F"]; //supply box for airdrop & arsenal
flgW = "Flag_NATO_F"; //faction flag

endW = "EndNATO"; //end screen (description.ext)

unitsW=
[
	"B_Soldier_SL_F", //0 - Squad leader
	"B_soldier_LAT_F", //1 - Rifleman AT
	"B_soldier_AR_F", //2 - Autorifleman
	"B_medic_F", //3 - Combat life saver
	"B_Soldier_TL_F", //4 - Team leader
	"B_Soldier_F", //5 - Rifleman
	"B_engineer_F", //6 - Engineer
	"B_soldier_M_F", //7 - Marksman
	"B_soldier_AT_F", //8 - Missile specialist AT
	"B_Soldier_GL_F", //9 - Grenadier
	"B_soldier_AA_F", //10 - Missile specialist AA
	"B_recon_TL_F", //11 - Recon team leader
	"B_recon_LAT_F", //12 - Recon scout AT (Rifleman AT)
	"B_recon_M_F", //13 - Recon Marksman (Autorifleman)
	"B_recon_medic_F", //14 - Recon Paramedic (Medic)
	"B_recon_JTAC_F", //15 - Recon JTAC (Grenadier)
	"B_recon_F", //16 - Recon Scout (Rifleman)
	"B_recon_exp_F", //17 - Recon demo specialist (Engineer)
	"B_sniper_F" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names