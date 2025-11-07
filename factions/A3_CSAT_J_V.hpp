/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_CSAT_J_V.hpp";
*/

//EAST (woodland, JUNGLE)
BikeE=["O_T_Quadbike_01_ghex_F"]; //quad bike
CarE=["O_T_MRAP_02_ghex_F"]; //car
CarDlcE=["O_T_LSV_02_unarmed_F"]; //car apex dlc
CarArE=["O_T_MRAP_02_gmg_ghex_F", "O_T_MRAP_02_hmg_ghex_F"]; //armed car
CarArDlcE=["O_T_LSV_02_armed_F","O_T_LSV_02_AT_F"]; //armed car apex dlc
TruckE=["O_T_Truck_03_transport_ghex_F", "O_T_Truck_03_covered_ghex_F"]; //truck
ArmorE1=["O_T_APC_Wheeled_02_rcws_ghex_F", "O_T_APC_Tracked_02_cannon_ghex_F"]; //apc, ifv
ArmorE2=["O_T_MBT_02_cannon_ghex_F"]; //tank
ArmorDlcE2=["O_T_MBT_04_command_F","O_T_MBT_04_cannon_F"]; //tank tanks dlc

HeliTrE=[["O_Heli_Light_02_unarmed_F","Black"]]; //transport heli
HeliTrDlcE=[["O_Heli_Transport_04_bench_F","Black"],["O_Heli_Transport_04_covered_F","Black"]]; //transport heli helicopters dlc

if(factionW=="NATO")then{HeliArE = [["O_Heli_Attack_02_F","Black"]];}; //gunship (armed heli)
if(factionW=="AAF"||factionW=="LDF")then{HeliArE = [["O_Heli_Light_02_F","Black"]];};

PlaneE=["O_Plane_CAS_02_F"]; //jet
PlaneDlcE=["O_Plane_Fighter_02_Cluster_F"]; //jets dlc

aaE=["O_T_APC_Tracked_02_AA_ghex_F"]; //Anti Air
artiE=["O_T_MBT_02_arty_ghex_F"]; //artillery
mortE = ["O_G_Mortar_01_F"]; //mortar
if(env=="jungle")then{crewE="O_T_crew_F";}else{crewE="O_crew_F";}; //crew

boatTrE=["O_T_Boat_Transport_01_F"]; //small boat
boatArE=["O_T_Boat_Armed_01_hmg_F"]; //patrol boat

divEe=["U_O_Wetsuit","V_RebreatherIR","G_O_Diving"]; //diver gear (boat cargo) 
divWe="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMe="30Rnd_556x45_Stanag_green"; //diver ammo (boat cargo)

uavsE=["O_UAV_02_F"]; //UAV
uavsDlcE=["O_T_UAV_04_CAS_F"]; //UAV apex dlc
ugvsE=["O_T_UGV_01_rcws_ghex_F"]; //UGV

supplyE=["O_supplyCrate_F","O_CargoNet_01_ammo_F"];
flgE = "Flag_CSAT_F";

endE = "EndCSAT"; 

if(env=="woodland")then //Woodland
{
	unitsE=
	[
		"EAST393", //0 - Squad leader
		"EAST392", //1 - Rifleman AT
		"EAST377", //2 - Autorifleman
		"EAST378", //3 - Combat life saver
		"EAST394", //4 - Team leader
		"EAST391", //5 - Rifleman
		"EAST379", //6 - Engineer
		"EAST385", //7 - Marksman
		"EAST387", //8 - Missile specialist AT
		"EAST381", //9 - Grenadier
		"EAST386", //10 - Missile specialist AA							
		"EAST409", //11 - Recon team leader
		"EAST408", //12 - Recon scout AT (Rifleman AT)
		"EAST405", //13 - Recon Marksman (Autorifleman)
		"EAST406", //14 - Recon Paramedic (Medic)
		"EAST404", //15 - Recon JTAC (Grenadier)
		"EAST407", //16 - Recon Scout (Rifleman)
		"EAST403", //17 - Recon demo specialist (Engineer)
		"EAST410" //18 - Sniper (Marksman)
	];
	
	faceE='Persian'; //faces (config)
	voiceE='PER_'; //voices
	nameE="TakistaniMen"; //names
}else //Jungle
{
	unitsE=
	[
		"O_T_Soldier_SL_F", //0 - Squad leader
		"O_T_Soldier_LAT_F", //1 - Rifleman AT
		"O_T_Soldier_AR_F", //2 - Autorifleman
		"O_T_Medic_F", //3 - Combat life saver
		"O_T_Soldier_TL_F", //4 - Team leader
		"O_T_Soldier_F", //5 - Rifleman
		"O_T_Engineer_F", //6 - Engineer
		"O_T_Soldier_M_F", //7 - Marksman
		"O_T_Soldier_AT_F", //8 - Missile specialist AT
		"O_T_Soldier_GL_F", //9 - Grenadier
		"O_T_Soldier_AA_F", //10 - Missile specialist AA
		"O_T_Recon_TL_F", //11 - Recon team leader
		"O_T_Recon_LAT_F", //12 - Recon scout AT (Rifleman AT)
		"O_T_Recon_M_F", //13 - Recon Marksman (Autorifleman)
		"O_T_Recon_Medic_F", //14 - Recon Paramedic (Medic)
		"O_T_Recon_JTAC_F", //15 - Recon JTAC (Grenadier)
		"O_T_Recon_F", //16 - Recon Scout (Rifleman)
		"O_T_Recon_Exp_F", //17 - Recon demo specialist (Engineer)
		"O_T_Sniper_F" //18 - Sniper (Marksman)
	];
	
	faceE='Asian'; //faces (config)
	voiceE='CHI_'; //voices
	nameE="AsianMen"; //names
};