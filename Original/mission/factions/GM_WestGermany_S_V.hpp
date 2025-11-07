/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\GM_WestGermany_S_V.hpp";
*/

//WEST (WINTER)
BikeW=["gm_ge_army_k125"]; //quad bike
CarW=["gm_ge_army_iltis_cargo_win","gm_ge_army_typ1200_cargo_olw"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["gm_ge_army_iltis_milan_win","gm_ge_army_iltis_mg3_win"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["gm_ge_army_u1300l_container_win","gm_ge_army_u1300l_cargo_win","gm_ge_army_kat1_451_container_win","gm_ge_army_kat1_451_cargo_win"]; //truck
ArmorW1=["gm_ge_army_m113a1g_apc_win","gm_ge_army_m113a1g_apc_milan_win","gm_ge_army_luchsa1_olw","gm_ge_army_luchsa2_win","gm_ge_army_marder1a1plus_win","gm_ge_army_marder1a1a_win","gm_ge_army_marder1a2_win","gm_ge_army_fuchsa0_engineer_win","gm_ge_army_fuchsa0_reconnaissance_win"]; //apc, ifv
ArmorW2=["gm_ge_army_Leopard1a1_olw","gm_ge_army_Leopard1a1a1_win","gm_ge_army_Leopard1a1a2_win","gm_ge_army_Leopard1a3_win","gm_ge_army_Leopard1a3a1_win","gm_ge_army_Leopard1a5_win"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["gm_ge_army_ch53g","gm_ge_army_ch53gs","gm_ge_army_bo105m_vbh","gm_ge_army_bo105p1m_vbh_swooper"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["gm_ge_army_bo105p_pah1","gm_ge_army_bo105p_pah1a1"]; //gunship (armed heli)
PlaneW=[]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["gm_ge_army_gepard1a1_win"]; //Anti Air
artiW=["B_T_MBT_01_mlrs_F"]; //artillery
mortW = []; //mortar
crewW="gm_ge_army_crew_mp2a1_80_oli"; //crew

boatTrW=["B_Boat_Transport_01_F"]; //small boat
boatArW=[]; //patrol boat

divEw=[]; //diver gear (boat cargo) 
divWw=""; //diver weapon (boat cargo) 
divMw=""; //diver ammo (boat cargo)

uavsW=[]; //UAV
uavsDlcW=[]; //UAV apex dlc
uavsDlc2W=[]; //UAV jets dlc
ugvsW=[]; //UGV

supplyW=["B_supplyCrate_F"];
flgW = "gm_flag_GE";

endW = "EndWestGermany";

if(factionW=="West Germany")then
{
	unitsW=
	[
		"gm_ge_army_squadleader_g3a3_p2a1_parka_80_win", //0 - Squad leader
		"gm_ge_army_antitank_g3a3_pzf44_parka_80_win", //1 - Rifleman AT
		"gm_ge_army_machinegunner_mg3_parka_80_win", //2 - Autorifleman
		"gm_ge_army_medic_g3a3_parka_80_win", //3 - Combat life saver
		"gm_ge_army_grenadier_g3a3_parka_80_win", //4 - Team leader
		"gm_ge_army_rifleman_g3a3_parka_80_win", //5 - Rifleman
		"gm_ge_army_engineer_g3a4_parka_80_win", //6 - Engineer
		"gm_ge_army_marksman_g3a3_parka_80_win", //7 - Marksman
		"gm_ge_army_antitank_g3a3_pzf84_parka_80_win", //8 - Missile specialist AT
		"gm_ge_army_grenadier_g3a3_parka_80_win", //9 - Grenadier
		"gm_ge_army_antiair_g3a3_fim43_parka_80_win", //10 - Missile specialist AA
		"gm_ge_army_squadleader_g3a3_p2a1_parka_80_win", //11 - Recon team leader
		"gm_ge_army_antitank_g3a3_pzf44_parka_80_win", //12 - Recon scout AT (Rifleman AT)
		"gm_ge_army_machinegunner_mg3_parka_80_win", //13 - Recon Marksman (Autorifleman)
		"gm_ge_army_medic_g3a3_parka_80_win", //14 - Recon Paramedic (Medic)
		"gm_ge_army_grenadier_g3a3_parka_80_win", //15 - Recon JTAC (Grenadier)
		"gm_ge_army_rifleman_g3a3_parka_80_win", //16 - Recon Scout (Rifleman)
		"gm_ge_army_engineer_g3a4_parka_80_win", //17 - Recon demo specialist (Engineer)
		"gm_ge_army_marksman_g3a3_parka_80_win" //18 - Sniper (Marksman)
	];
}else //"West Germany 90"
{
	unitsW=
	[
		"gm_ge_army_squadleader_g36a1_p2a1_90_flk_win", //0 - Squad leader
		"gm_ge_army_antitank_g36a1_pzf3_90_flk_win", //1 - Rifleman AT
		"gm_ge_army_machinegunner_mg3_90_flk_win", //2 - Autorifleman
		"gm_ge_army_medic_g36a1_90_flk_win", //3 - Combat life saver
		"gm_ge_army_grenadier_hk69a1_90_flk_win", //4 - Team leader
		"gm_ge_army_rifleman_g36a1_90_flk_win", //5 - Rifleman
		"gm_ge_army_engineer_g36a1_90_flk_win", //6 - Engineer
		"gm_ge_army_marksman_g3a3_90_flk_win", //7 - Marksman
		"gm_ge_army_antitank_g36a1_pzf3_90_flk_win", //8 - Missile specialist AT
		"gm_ge_army_grenadier_hk69a1_90_flk_win", //9 - Grenadier
		"gm_ge_army_rifleman_g36a1_90_flk_win", //10 - Missile specialist AA
		"gm_ge_army_squadleader_g36a1_p2a1_90_flk_win", //11 - Recon team leader
		"gm_ge_army_antitank_g36a1_pzf3_90_flk_win", //12 - Recon scout AT (Rifleman AT)
		"gm_ge_army_machinegunner_mg3_90_flk_win", //13 - Recon Marksman (Autorifleman)
		"gm_ge_army_medic_g36a1_90_flk_win", //14 - Recon Paramedic (Medic)
		"gm_ge_army_grenadier_hk69a1_90_flk_win", //15 - Recon JTAC (Grenadier)
		"gm_ge_army_antiair_g36a1_fim43_90_flk_win", //16 - Recon Scout (Rifleman)
		"gm_ge_army_engineer_g36a1_90_flk_win", //17 - Recon demo specialist (Engineer)
		"gm_ge_army_marksman_g3a3_90_flk_win" //18 - Sniper (Marksman)
	];
};

faceW='NATO'; //faces (config)
voiceW='deu_'; //voices
nameW="gm_names_deu_male"; //names