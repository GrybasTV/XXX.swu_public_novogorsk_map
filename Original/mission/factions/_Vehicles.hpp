/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\A3_NATO_A_V.hpp";
		#include "factions\A3_AAF_W_V_e.hpp";
*/

//WEST (desert, arid, woodland, jungle, winter)
BikeW=[]; //quad bike
CarW=[]; //car
CarDlcW=[]; //car apex dlc
CarArW=[]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=[]; //truck
ArmorW1=[]; //apc, ifv
ArmorW2=[]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[]; //gunship (armed heli)
PlaneW=[]; //jet
PlaneDlcW=[]; //jets dlc

aaW=[]; //Anti Air
artiW=[]; //artillery
mortW = []; //mortar
crewW=""; //crew

boatTrW=[]; //small boat
boatArW=[]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=[]; //supply box for airdrop & arsenal
flgW = ""; //faction flag

endW = ""; //end screen (description.ext)

unitsW=
[
	"", //0 - Squad leader
	"", //1 - Rifleman AT
	"", //2 - Autorifleman
	"", //3 - Combat life saver
	"", //4 - Team leader
	"", //5 - Rifleman
	"", //6 - Engineer
	"", //7 - Marksman
	"", //8 - Missile specialist AT
	"", //9 - Grenadier
	"", //10 - Missile specialist AA
	"", //11 - Recon team leader
	"", //12 - Recon scout AT (Rifleman AT)
	"", //13 - Recon Marksman (Autorifleman)
	"", //14 - Recon Paramedic (Medic)
	"", //15 - Recon JTAC (Grenadier)
	"", //16 - Recon Scout (Rifleman)
	"", //17 - Recon demo specialist (Engineer)
	"" //18 - Sniper (Marksman)
];

faceW=''; //faces (config)
voiceW=''; //voices
nameW=""; //names

//EAST (desert, arid, woodland, jungle, winter)
BikeE=[]; //quad bike
CarE=[]; //car
CarDlcE=[]; //car apex dlc
CarArE=[]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=[]; //truck
ArmorE1=[]; //apc, ifv
ArmorE2=[]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=[]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=[]; //gunship (armed heli)
PlaneE=[]; //jet
PlaneDlcE=[]; //jets dlc

aaE=[]; //Anti Air
artiE=[]; //artillery
mortE = []; //mortar
crewE=""; //crew

boatTrE=[]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=[]; //supply box for airdrop & arsenal
flgE = ""; //faction flag

endE = ""; //end screen (description.ext)

unitsE=
[
	"", //0 - Squad leader
	"", //1 - Rifleman AT
	"", //2 - Autorifleman
	"", //3 - Combat life saver
	"", //4 - Team leader
	"", //5 - Rifleman
	"", //6 - Engineer
	"", //7 - Marksman
	"", //8 - Missile specialist AT
	"", //9 - Grenadier
	"", //10 - Missile specialist AA
	"", //11 - Recon team leader
	"", //12 - Recon scout AT (Rifleman AT)
	"", //13 - Recon Marksman (Autorifleman)
	"", //14 - Recon Paramedic (Medic)
	"", //15 - Recon JTAC (Grenadier)
	"", //16 - Recon Scout (Rifleman)
	"", //17 - Recon demo specialist (Engineer)
	"" //18 - Sniper (Marksman)
];

faceE=''; //faces (config)
voiceE=''; //voices ( ENG_ , ENGB_ , ENGFRE_ , eFRE_ , GRE_ , CHI_ , PER_ , POL_ , RUS_ ) cDLC ( VIE_ , deu_ ) IFA3 ( _FR , _GER , _PL , _RU ) 
nameE=""; //names