/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_LDF_W_V_e.hpp";
*/

//EAST (desert, arid, WOODLAND, jungle, winter)
BikeE=["I_E_Quadbike_01_F"]; //quad bike
CarE=["I_E_Offroad_01_F","I_E_Offroad_01_covered_F","I_E_Van_02_transport_F"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["I_E_Offroad_01_F","I_E_Offroad_01_covered_F","I_E_Van_02_transport_F"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["I_E_Truck_02_transport_F", "I_E_Truck_02_F"]; //truck
ArmorE1=["I_E_APC_tracked_03_cannon_F"]; //apc, ifv
ArmorE2=["I_E_APC_tracked_03_cannon_F"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["I_E_Heli_light_03_unarmed_F"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["I_E_Heli_light_03_dynamicLoadout_F"]; //gunship (armed heli)
PlaneE=["I_Plane_Fighter_03_CAS_F"]; //jet
PlaneDlcE=["I_Plane_Fighter_04_Cluster_F"]; //jets dlc

aaE=[["I_LT_01_AA_F","Indep_Olive"]]; //Anti Air
artiE=["I_E_Truck_02_MRL_F"]; //artillery
mortE = ["I_E_Mortar_01_F"]; //mortar
crewE="I_E_Crew_F"; //crew

boatTrE=["I_G_Boat_Transport_01_F"]; //small boat
boatArE=["I_Boat_Armed_01_minigun_F"]; //patrol boat

divEe=["U_I_Wetsuit","V_RebreatherIA","G_I_Diving"]; //diver gear (boat cargo) 
divWe="arifle_SDAR_F"; //diver weapon (boat cargo) 
divMe="30Rnd_556x45_Stanag"; //diver ammo (boat cargo)

uavsE=["I_UAV_02_F"]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=["I_E_UGV_01_rcws_F"]; //UGV

supplyE=["I_EAF_supplyCrate_F","I_E_CargoNet_01_ammo_F"];
flgE = "Flag_EAF_F";

endE = "EndLDF";

unitsE=
[
	"I_E_Soldier_SL_F", //0 - Squad leader
	"I_E_Soldier_LAT_F", //1 - Rifleman AT
	"I_E_Soldier_AR_F", //2 - Autorifleman
	"I_E_Medic_F", //3 - Combat life saver
	"I_E_Soldier_TL_F", //4 - Team leader
	"I_E_Soldier_F", //5 - Rifleman
	"I_E_Engineer_F", //6 - Engineer
	"I_E_soldier_M_F", //7 - Marksman
	"I_E_Soldier_AT_F", //8 - Missile specialist AT
	"I_E_Soldier_GL_F", //9 - Grenadier
	"I_E_Soldier_AA_F", //10 - Missile specialist AA
	"I_E_Soldier_SL_F", //11 - Recon team leader
	"I_E_Soldier_LAT_F", //12 - Recon scout AT (Rifleman AT)
	"I_E_Soldier_AR_F", //13 - Recon Marksman (Autorifleman)
	"I_E_Medic_F", //14 - Recon Paramedic (Medic)
	"I_E_Soldier_TL_F", //15 - Recon JTAC (Grenadier)
	"I_E_Soldier_F", //16 - Recon Scout (Rifleman)
	"I_E_Engineer_F", //17 - Recon demo specialist (Engineer)
	"I_E_soldier_M_F" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='POL_'; //voices
nameE="EnochMen"; //names