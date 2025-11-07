/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_NATO_J_V.hpp";
*/

//WEST (woodland, JUNGLE)
BikeW=["B_T_Quadbike_01_F"]; //quad bike
CarW=["B_T_MRAP_01_F"]; //car
CarDlcW=["B_T_LSV_01_unarmed_F"]; //car apex dlc
CarArW=["B_T_MRAP_01_gmg_F", "B_T_MRAP_01_hmg_F"]; //armed car
CarArDlcW=["B_T_LSV_01_armed_F","B_T_LSV_01_AT_F"]; //armed car apex dlc
TruckW=["B_T_Truck_01_transport_F", "B_T_Truck_01_covered_F"]; //truck
ArmorW1=["B_T_APC_Wheeled_01_cannon_F", "B_T_APC_Tracked_01_rcws_F"]; //apc, ifv
ArmorW2=["B_T_MBT_01_TUSK_F"]; //tank
ArmorDlcW2=["B_T_AFV_Wheeled_01_cannon_F","B_T_AFV_Wheeled_01_up_cannon_F"]; //tank tanks dlc

HeliTrW=["B_CTRG_Heli_Transport_01_tropic_F", "B_Heli_Light_01_F"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc

if(factionE=="CSAT")then{HeliArW=["B_Heli_Attack_01_F"];}; //gunship (armed heli)
if(factionE=="AAF"||factionE=="LDF")then{HeliArW=["B_Heli_Light_01_armed_F"];};

PlaneW=["B_Plane_CAS_01_F"]; //jet
PlaneDlcW=["B_Plane_Fighter_01_Cluster_F"]; //jets dlc

aaW=["B_T_APC_Tracked_01_AA_F"]; //Anti Air
artiW=["B_T_MBT_01_arty_F","B_T_MBT_01_mlrs_F"]; //artillery
mortW = ["B_T_Mortar_01_F"]; //mortar
crewW="B_T_crew_F"; //crew

boatTrW=["B_Boat_Transport_01_F"]; //small boat
boatArW=["B_T_Boat_Armed_01_minigun_F"]; //patrol boat

divEw=["U_B_Wetsuit","V_RebreatherB","G_B_Diving"]; //diver gear (boat cargo) 
divWw="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMw="30Rnd_556x45_Stanag_red"; //diver ammo (boat cargo)

uavsW=["B_UAV_02_F", "B_UAV_05_F", "B_T_UAV_03_F"]; //UAV
uavsDlcW=["B_T_UAV_03_F"]; //UAV apex dlc
uavsDlc2W=["B_UAV_05_F"]; //UAV jets dlc
ugvsW=["B_T_UGV_01_rcws_olive_F"]; //UGV

supplyW=["B_supplyCrate_F","B_CargoNet_01_ammo_F"]; //supply box for airdrop & arsenal
flgW = "Flag_NATO_F"; //faction flag

endW = "EndNATO"; //end screen (description.ext)

if(env=="woodland")then //woodland
{
	unitsW=
	[
		"B_W_Soldier_SL_F", //0 - Squad leader
		"B_W_Soldier_AT_F", //1 - Rifleman AT
		"B_W_Soldier_AR_F", //2 - Autorifleman
		"B_W_Medic_F", //3 - Combat life saver
		"B_W_Soldier_GL_F", //4 - Team leader
		"B_W_Soldier_AA_F", //5 - Rifleman
		"B_W_Engineer_F", //6 - Engineer
		"B_W_soldier_M_F", //7 - Marksman
		"B_W_Soldier_LAT2_F", //8 - Missile specialist AT
		"B_W_Soldier_TL_F", //9 - Grenadier
		"B_W_Soldier_AA_F", //10 - Missile specialist AA
		"B_W_Soldier_SL_F", //11 - Recon team leader
		"B_W_Soldier_LAT_F", //12 - Recon scout AT (Rifleman AT)
		"B_W_Soldier_AR_F", //13 - Recon Marksman (Autorifleman)
		"B_W_Medic_F", //14 - Recon Paramedic (Medic)
		"B_W_Soldier_TL_F", //15 - Recon JTAC (Grenadier)
		"B_W_Soldier_F", //16 - Recon Scout (Rifleman)
		"B_W_Engineer_F", //17 - Recon demo specialist (Engineer)
		"B_W_soldier_M_F" //18 - Sniper (Marksman)
	];
}else //Jungle
{
	unitsW=
	[
		"B_T_Soldier_SL_F", //0 - Squad leader
		"B_T_Soldier_LAT_F", //1 - Rifleman AT
		"B_T_Soldier_AR_F", //2 - Autorifleman
		"B_T_Medic_F", //3 - Combat life saver
		"B_T_Soldier_TL_F", //4 - Team leader
		"B_T_Soldier_F", //5 - Rifleman
		"B_T_Engineer_F", //6 - Engineer
		"B_T_soldier_M_F", //7 - Marksman
		"B_T_Soldier_AT_F", //8 - Missile specialist AT
		"B_T_Soldier_GL_F", //9 - Grenadier
		"B_T_Soldier_AA_F", //10 - Missile specialist AA
		"B_T_Recon_TL_F", //11 - Recon team leader
		"B_T_Recon_LAT_F", //12 - Recon scout AT (Rifleman AT)
		"B_T_Recon_M_F", //13 - Recon Marksman (Autorifleman)
		"B_T_Recon_Medic_F", //14 - Recon Paramedic (Medic)
		"B_T_Recon_JTAC_F", //15 - Recon JTAC (Grenadier)
		"B_T_Recon_F", //16 - Recon Scout (Rifleman)
		"B_T_Recon_Exp_F", //17 - Recon demo specialist (Engineer)
		"B_T_Sniper_F" //18 - Sniper (Marksman)
	];
};

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names