/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_CSAT_A_V.hpp";
*/

//EAST (desert, ARID, winter)
BikeE=["O_Quadbike_01_F"]; //quad bike
CarE=["O_MRAP_02_F"]; //car
CarDlcE=["O_LSV_02_unarmed_F"]; //car apex dlc
CarArE=["O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"]; //armed car
CarArDlcE=["O_LSV_02_armed_F","O_LSV_02_AT_F"]; //armed car apex dlc
TruckE=["O_Truck_03_transport_F", "O_Truck_03_covered_F"]; //truck
ArmorE1=["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F"]; //apc, ifv
ArmorE2=["O_MBT_02_cannon_F"]; //tank
ArmorDlcE2=["O_MBT_04_command_F","O_MBT_04_cannon_F"]; //tank tanks dlc

HeliTrE=["O_Heli_Light_02_unarmed_F"]; //transport heli
HeliTrDlcE=["O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F"]; //transport heli helicopters dlc

if(factionW=="NATO")then{HeliArE = ["O_Heli_Attack_02_F"];}; //gunship (armed heli)
if(factionW=="AAF"||factionW=="LDF")then{HeliArE = ["O_Heli_Light_02_F"];};

PlaneE=["O_Plane_CAS_02_F"]; //jet 
PlaneDlcE=["O_Plane_Fighter_02_Cluster_F"]; //jets dlc

aaE=["O_APC_Tracked_02_AA_F"]; //Anti Air
artiE=["O_MBT_02_arty_F"]; //artillery
mortE = ["O_Mortar_01_F"]; //mortar
crewE="O_crew_F"; //crew

boatTrE=["O_Boat_Transport_01_F"]; //small boat
boatArE=["O_Boat_Armed_01_hmg_F"]; //patrol boat

divEe=["U_O_Wetsuit","V_RebreatherIR","G_O_Diving"]; //diver gear (boat cargo) 
divWe="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMe="30Rnd_556x45_Stanag_green"; //diver ammo (boat cargo)

uavsE=["O_UAV_02_F"]; //UAV
uavsDlcE=["O_T_UAV_04_CAS_F"]; //UAV apex dlc
ugvsE=["O_UGV_01_rcws_F"]; //UGV

supplyE=["O_supplyCrate_F","O_CargoNet_01_ammo_F"];
flgE = "Flag_CSAT_F";

endE = "EndCSAT"; 

unitsE=
[
	"O_Soldier_SL_F", //0 - Squad leader
	"O_soldier_LAT_F", //1 - Rifleman AT
	"O_soldier_AR_F", //2 - Autorifleman
	"O_medic_F", //3 - Combat life saver
	"O_Soldier_TL_F", //4 - Team leader
	"O_Soldier_F", //5 - Rifleman
	"O_engineer_F", //6 - Engineer
	"O_soldier_M_F", //7 - Marksman
	"O_soldier_AT_F", //8 - Missile specialist AT
	"O_Soldier_GL_F", //9 - Grenadier
	"O_soldier_AA_F", //10 - Missile specialist AA
	"O_recon_TL_F", //11 - Recon team leader
	"O_recon_LAT_F", //12 - Recon scout AT (Rifleman AT)
	"O_recon_M_F", //13 - Recon Marksman (Autorifleman)
	"O_recon_medic_F", //14 - Recon Paramedic (Medic)
	"O_recon_JTAC_F", //15 - Recon JTAC (Grenadier)
	"O_recon_F", //16 - Recon Scout (Rifleman)
	"O_recon_exp_F", //17 - Recon demo specialist (Engineer)
	"O_sniper_F" //18 - Sniper (Marksman)
];

faceE='Persian'; //faces (config)
voiceE='PER_'; //voices
nameE="TakistaniMen"; //names