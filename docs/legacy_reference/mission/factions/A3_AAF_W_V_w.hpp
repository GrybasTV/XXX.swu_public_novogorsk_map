/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_AAF_W_V_w.hpp";
*/

//WEST (desert, arid, WOODLAND, jungle, winter)
BikeW=["I_Quadbike_01_F"]; //quad bike
CarW=["I_MRAP_03_F"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["I_MRAP_03_gmg_F", "I_MRAP_03_hmg_F"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["I_Truck_02_transport_F", "I_Truck_02_covered_F"]; //truck
ArmorW1=["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"]; //apc, ifv
ArmorW2=["I_MBT_03_cannon_F"]; //tank
ArmorDlcW2=["I_LT_01_AT_F","I_LT_01_cannon_F"]; //tank tanks dlc

HeliTrW=["I_Heli_light_03_unarmed_F"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["I_Heli_light_03_F"]; //gunship (armed heli)
PlaneW=["I_Plane_Fighter_03_CAS_F"]; //jet
PlaneDlcW=["I_Plane_Fighter_04_Cluster_F"]; //jets dlc

aaW=["I_LT_01_AA_F"]; //Anti Air
artiW=["I_Truck_02_MRL_F"]; //artillery
mortW = ["I_Mortar_01_F"]; //mortar
crewW="I_crew_F"; //crew

boatTrW=["I_Boat_Transport_01_F"]; //small boat
boatArW=["I_Boat_Armed_01_minigun_F"]; //patrol boat

divEw=["U_I_Wetsuit","V_RebreatherIA","G_I_Diving"]; //diver gear (boat cargo) 
divWw="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMw="30Rnd_556x45_Stanag"; //diver ammo (boat cargo)

uavsW=["I_UAV_02_F"]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=["I_UGV_01_rcws_F"]; //UGV

supplyW=["I_supplyCrate_F","I_CargoNet_01_ammo_F"];
flgW = "Flag_AAF_F";

endW = "EndAAF";

unitsW=
[
	"I_Soldier_SL_F", //0 - Squad leader
	"I_Soldier_LAT_F", //1 - Rifleman AT
	"I_Soldier_AR_F", //2 - Autorifleman
	"I_medic_F", //3 - Combat life saver
	"I_Soldier_TL_F", //4 - Team leader
	"I_soldier_F", //5 - Rifleman
	"I_engineer_F", //6 - Engineer
	"I_Soldier_M_F", //7 - Marksman
	"I_Soldier_AT_F", //8 - Missile specialist AT
	"I_Soldier_GL_F", //9 - Grenadier
	"I_Soldier_AA_F", //10 - Missile specialist AA
	"I_Soldier_SL_F", //11 - Recon team leader
	"I_Soldier_LAT2_F", //12 - Recon scout AT (Rifleman AT)
	"I_Soldier_M_F", //13 - Recon Marksman (Autorifleman)
	"I_medic_F", //14 - Recon Paramedic (Medic)
	"I_Soldier_TL_F", //15 - Recon JTAC (Grenadier)
	"I_soldier_F", //16 - Recon Scout (Rifleman)
	"I_Soldier_exp_F", //17 - Recon demo specialist (Engineer)
	"I_Sniper_F" //18 - Sniper (Marksman)
];

faceW='Greek'; //faces (config)
voiceW='GRE_'; //voices
nameW="GreekMen"; //names