/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\GM_EastGermany_W_V.hpp";
*/

//EAST (desert, arid, WOODLAND, jungle)
BikeE=["gm_ge_army_k125"]; //quad bike
CarE=["gm_gc_army_uaz469_cargo"]; //car
CarDlcE=[]; //car apex dlc
CarArE=["gm_gc_army_brdm2","gm_gc_army_uaz469_dshkm","gm_gc_army_uaz469_spg9"]; //armed car
CarArDlcE=[]; //armed car apex dlc
TruckE=["gm_gc_army_ural4320_cargo","gm_gc_army_ural375d_cargo"]; //truck
ArmorE1=["gm_gc_army_bmp1sp2","gm_gc_army_btr60pb"]; //apc, ifv
ArmorE2=["gm_gc_army_pt76b","gm_gc_army_t55","gm_gc_army_t55a","gm_gc_army_t55ak","gm_gc_army_t55am2","gm_gc_army_t55am2b"]; //tank
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["gm_gc_airforce_mi2p","gm_gc_airforce_mi2t"]; //transport heli
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["gm_gc_airforce_mi2urn","gm_gc_airforce_mi2us"]; //gunship (armed heli)
PlaneE=[]; //jet
PlaneDlcE=[]; //jets dlc

aaE=["gm_gc_army_zsu234v1"]; //Anti Air
artiE=[]; //artillery
mortE = []; //mortar
crewE="gm_gc_army_crew_mpiaks74nk_80_blk"; //crew

boatTrE=["O_G_Boat_Transport_01_F"]; //small boat
boatArE=[]; //patrol boat

divEe=[]; //diver gear (boat cargo) 
divWe=""; //diver weapon (boat cargo) 
divMe=""; //diver ammo (boat cargo)

uavsE=[]; //UAV
uavsDlcE=[]; //UAV apex dlc
ugvsE=[]; //UGV

supplyE=["O_supplyCrate_F"];
flgE = "gm_flag_GC";

endE = "EndEastGermany";

unitsE=
[
	"gm_gc_army_squadleader_mpiak74n_80_str", //0 - Squad leader
	"gm_gc_army_antitank_mpiak74n_rpg7_80_str", //1 - Rifleman AT
	"gm_gc_army_machinegunner_pk_80_str", //2 - Autorifleman
	"gm_gc_army_medic_mpiak74n_80_str", //3 - Combat life saver
	"gm_gc_army_rifleman_mpiak74n_80_str", //4 - Team leader
	"gm_gc_army_rifleman_mpiak74n_80_str", //5 - Rifleman
	"gm_gc_army_engineer_mpiaks74n_80_str", //6 - Engineer
	"gm_gc_army_marksman_svd_80_str", //7 - Marksman
	"gm_gc_army_antitank_mpiak74n_rpg7_80_str", //8 - Missile specialist AT
	"gm_gc_army_rifleman_mpiak74n_80_str", //9 - Grenadier
	"gm_gc_army_antiair_mpiak74n_9k32m_80_str", //10 - Missile specialist AA
	"gm_gc_army_squadleader_mpiak74n_80_str", //11 - Recon team leader
	"gm_gc_army_antitank_mpiak74n_rpg7_80_str", //12 - Recon scout AT (Rifleman AT)
	"gm_gc_army_machinegunner_pk_80_str", //13 - Recon Marksman (Autorifleman)
	"gm_gc_army_medic_mpiak74n_80_str", //14 - Recon Paramedic (Medic)
	"gm_gc_army_rifleman_mpiak74n_80_str", //15 - Recon JTAC (Grenadier)
	"gm_gc_army_rifleman_mpiak74n_80_str", //16 - Recon Scout (Rifleman)
	"gm_gc_army_engineer_mpiaks74n_80_str", //17 - Recon demo specialist (Engineer)
	"gm_gc_army_marksman_svd_80_str" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='deu_'; //voices
nameE="gm_names_deu_male"; //names