/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\CSLA_CSLA_W_V.hpp";
*/

//EAST (desert, ARID, winter)
BikeE=["CSLA_JARA250"]; //quad bike
CarE=["CSLA_AZU","CSLA_AZU_para","CSLA_AZU_R2"]; //car
CarDlcE=[]; //car apex dlc
CarArE=CarE; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["CSLA_F813o","CSLA_F813","CSLA_V3So","CSLA_V3S"]; //truck
ArmorE1=["CSLA_BVP1","CSLA_BPzV","CSLA_OT62","CSLA_OT64C","CSLA_OT65A"]; //apc, ifv
ArmorE2=["CSLA_T72","CSLA_T72M","CSLA_T72M1"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["CSLA_Mi17","CSLA_Mi17mg"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE = ["CSLA_Mi24V","CSLA_Mi17pylons"]; //gunship (armed heli)

PlaneE=[]; //jet
PlaneDlcE=[]; //jets dlc

aaE=["CSLA_PLdvK59V3S"]; //Anti Air
artiE=["CSLA_ShKH77","CSLA_RM51"]; //artillery
mortE = ["CSLA_M52_Stat"]; //mortar
crewE="CSLA_tnkEnl"; //crew

boatTrE=["CSLA_lodka"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["CSLA_ammobox_firearms"];
flgE = "Flag_CSLA";

endE = "EndCSLA"; 

unitsE=
[
	"CSLA_mrSgt", //0 - Squad leader
	"CSLA_mrRPG7", //1 - Rifleman AT
	"CSLA_mrUK59", //2 - Autorifleman
	"CSLA_mrMedi", //3 - Combat life saver
	"CSLA_mrRPG75", //4 - Team leader
	"CSLA_mrSa58P", //5 - Rifleman
	"CSLA_engLA", //6 - Engineer
	"CSLA_mrSa58Pp", //7 - Marksman
	"CSLA_mrRPG7", //8 - Missile specialist AT
	"CSLA_mrVG70", //9 - Grenadier
	"CSLA_mr9K32", //10 - Missile specialist AA	
	"CSLA_ptSgt", //11 - Recon team leader
	"CSLA_ptRPG75", //12 - Recon scout AT (Rifleman AT)
	"CSLA_ptSa58Pp", //13 - Recon Marksman (Autorifleman)
	"CSLA_ptMedi", //14 - Recon Paramedic (Medic)
	"CSLA_ptUK59", //15 - Recon JTAC (Machinegunner)
	"CSLA_ptBaseman", //16 - Recon Scout (Rifleman)
	"CSLA_ptSpr", //17 - Recon demo specialist (Engineer)
	"CSLA_mrOP63" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='ENGB_'; //voices
nameE="CzechMen"; //names
