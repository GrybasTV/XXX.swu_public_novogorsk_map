/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\WS_NATO_D_V.hpp";
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
HeliArW=["B_Heli_Attack_01_F"]; //gunship
PlaneW=["B_Plane_CAS_01_F"]; //jet
PlaneDlcW=["B_Plane_Fighter_01_Cluster_F"]; //jets dlc

aaW=["B_APC_Tracked_01_AA_F"]; //Anti Air
artiW=["B_MBT_01_arty_F","B_MBT_01_mlrs_F"]; //artillery
mortW = ["B_D_Mortar_01_lxWS"]; //mortar
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
	"B_D_Soldier_SL_lxWS", //0 - Squad leader
	"B_D_soldier_LAT_lxWS", //1 - Rifleman AT
	"B_D_soldier_AR_lxWS", //2 - Autorifleman
	"B_D_medic_lxWS", //3 - Combat life saver
	"B_D_Soldier_TL_lxWS", //4 - Team leader
	"B_D_Soldier_lxWS", //5 - Rifleman
	"B_D_engineer_lxWS", //6 - Engineer
	"B_D_soldier_M_lxWS", //7 - Marksman
	"B_D_soldier_AT_lxWS", //8 - Missile specialist AT
	"B_D_Soldier_GL_lxWS", //9 - Grenadier
	"B_D_soldier_AA_lxWS", //10 - Missile specialist AA
	"B_D_recon_TL_lxWS", //11 - Recon team leader
	"B_D_recon_LAT_lxWS", //12 - Recon scout AT (Rifleman AT)
	"B_D_soldier_AR_lxWS", //13 - Recon Marksman (Autorifleman)
	"B_D_recon_medic_lxWS", //14 - Recon Paramedic (Medic)
	"B_D_recon_JTAC_lxWS", //15 - Recon JTAC (Grenadier)
	"B_D_recon_lxWS", //16 - Recon Scout (Rifleman)
	"B_D_recon_exp_lxWS", //17 - Recon demo specialist (Engineer)
	"B_D_recon_M_lxWS" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names