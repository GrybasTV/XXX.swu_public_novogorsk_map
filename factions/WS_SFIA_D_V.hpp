/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\WS_SFIA_D_V.hpp";
*/

//EAST (desert, ARID, winter)
BikeE=["O_Quadbike_01_F"]; //quad bike
CarE=["O_SFIA_Offroad_lxWS"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["O_SFIA_Offroad_AT_lxWS", "O_SFIA_Offroad_armed_lxWS"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["O_SFIA_Truck_02_transport_lxWS", "O_SFIA_Truck_02_covered_lxWS"]; //truck
ArmorE1=["O_SFIA_APC_Tracked_02_cannon_lxWS"]; //apc, ifv
ArmorE2=["O_SFIA_MBT_02_cannon_lxWS"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[["O_Heli_Light_02_unarmed_F","Black"]]; //transport heli
HeliTrDlcE=[["O_Heli_Transport_04_bench_F","Black"],["O_Heli_Transport_04_covered_F","Black"]]; //transport heli helicopters dlc
HeliArE = ["O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"]; //gunship (armed heli)

PlaneE=["O_Plane_CAS_02_F"]; //jet
PlaneDlcE=[["O_Plane_Fighter_02_Cluster_F","CamoGreyHex"]]; //jets dlc

aaE=["O_SFIA_APC_Tracked_02_AA_lxWS","O_SFIA_Truck_02_aa_lxWS"]; //Anti Air
artiE=["O_SFIA_Truck_02_MRL_lxWS"]; //artillery
mortE = ["O_SFIA_Mortar_lxWS"]; //mortar
crewE="O_SFIA_crew_lxWS"; //crew

boatTrE=["O_Boat_Transport_01_F"]; //small boat
boatArE=["O_Boat_Armed_01_hmg_F"]; //patrol boat

divEe=["U_O_Wetsuit","V_RebreatherIR","G_O_Diving"]; //diver gear (boat cargo) 
divWe="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMe="30Rnd_556x45_Stanag_green"; //diver ammo (boat cargo)

uavsE=["O_UAV_02_F"]; //UAV
uavsDlcE=["O_T_UAV_04_CAS_F"]; //UAV apex dlc
ugvsE=["O_UGV_01_rcws_F"]; //UGV

supplyE=["SFIA_Box_Wps_lxWS"];
flgE = "Flag_SFIA_lxWS";

endE = "EndSFIA"; 

unitsE=
[
	"O_SFIA_Soldier_TL_lxWS", //0 - Squad leader
	"O_SFIA_soldier_at_lxWS", //1 - Rifleman AT
	"O_SFIA_Soldier_AR_lxWS", //2 - Autorifleman
	"O_SFIA_medic_lxWS", //3 - Combat life saver
	"O_SFIA_Soldier_GL_lxWS", //4 - Team leader
	"O_SFIA_soldier_lxWS", //5 - Rifleman
	"O_SFIA_repair_lxWS", //6 - Engineer
	"O_SFIA_sharpshooter_lxWS", //7 - Marksman
	"O_SFIA_soldier_at_lxWS", //8 - Missile specialist AT
	"O_SFIA_Soldier_GL_lxWS", //9 - Grenadier
	"O_SFIA_soldier_aa_lxWS", //10 - Missile specialist AA
	"O_SFIA_Soldier_TL_lxWS", //11 - Recon team leader
	"O_SFIA_soldier_at_lxWS", //12 - Recon scout AT (Rifleman AT)
	"O_SFIA_Soldier_AR_lxWS", //13 - Recon Marksman (Autorifleman)
	"O_SFIA_medic_lxWS", //14 - Recon Paramedic (Medic)
	"O_SFIA_Soldier_GL_lxWS", //15 - Recon JTAC (Grenadier)
	"O_SFIA_soldier_lxWS", //16 - Recon Scout (Rifleman)
	"O_SFIA_exp_lxWS", //17 - Recon demo specialist (Engineer)
	"O_SFIA_sharpshooter_lxWS" //18 - Sniper (Marksman)
];

faceE='Persian'; //faces (config)
voiceE='eFRE_'; //voices
nameE="lxWS_WSaharaMen"; //names