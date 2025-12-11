/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\CSLA_USarmy_W_V.hpp";
*/

//WEST (desert, arid, WOODLAND, jungle, winter)
BikeW=["US85_M1030"]; //quad bike
CarW=[["US85_M1008","NATOd"],["US85_M1025_ua","NATOd"],["US85_M1043_ua","NATOd"]]; //car
CarDlcW=[]; //car apex dlc
CarArW=[["US85_M1025_M60","NATOd"],["US85_M1025_M2","NATOd"],["US85_M998SFGT","NATOd"],["US85_M1043_M60","NATOd"]]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=[["US85_M923o","NATOd"],["US85_M923c","NATOd"],["US85_M923a1o","NATOd"],["US85_M923a1om2","NATOd"],["US85_M923a1c","NATOd"],["US85_M923a1cm2","NATOd"]]; //truck
ArmorW1=[["US85_LAV25","NATOd"],["US85_M113","NATOd"]]; //apc, ifv
ArmorW2=[["US85_M1A1","NATOd"],["US85_M1IP","NATOd"]]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=[["US85_MH60M134","NATOd"],["US85_UH60","NATOd"],["US85_UH60M240","NATOd"]]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=[["US85_AH1F","NATOd"],["US85_MH60FFAR","NATOd"]]; //gunship (armed heli)
PlaneW=[]; //jet
PlaneDlcW=[]; //jets dlc

aaW=[["US85_M163","NATOd"]]; //Anti Air
artiW=[]; //artillery "US85_M270"
mortW = ["US85_M252_Stat"]; //mortar
crewW="US85_crw"; //crew

boatTrW=["US85_zodiac"]; //small boat
boatArW=[]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["US85_ammobox_firearms"];
flgW = "Flag_US85";

endW = "EndUsarmy85";

unitsW=
[
	"US85_mcSgt", //0 - Squad leader
	"US85_mcM136", //1 - Rifleman AT
	"US85_mcM249", //2 - Autorifleman
	"US85_mcCprs", //3 - Combat life saver
	"US85_mcM16GL", //4 - Team leader
	"US85_mcM16", //5 - Rifleman
	"US85_mcDrv", //6 - Engineer
	"US85_mcM21", //7 - Marksman
	"US85_mcCG", //8 - Missile specialist AT
	"US85_mcM16GL", //9 - Grenadier
	"US85_mcFIM92", //10 - Missile specialist AA
	"US85_sfGL", //11 - Recon team leader
	"US85_sfLAW", //12 - Recon scout AT (Rifleman AT)
	"US85_sfM21", //13 - Recon Marksman (Autorifleman)
	"US85_sfMdc", //14 - Recon Paramedic (Medic)
	"US85_sfAR", //15 - Recon JTAC (Grenadier)
	"US85_sfBaseman", //16 - Recon Scout (Rifleman)
	"US85_sfSpr", //17 - Recon demo specialist (Engineer)
	"US85_sfM21G" //18 - Sniper (Marksman)
];

faceW='NATO'; //faces (config)
voiceW='ENG_'; //voices
nameW="NATOMen"; //names