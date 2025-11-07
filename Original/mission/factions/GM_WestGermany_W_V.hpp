/*
	Author: IvosH
	
	Description:
		Factions Vehicles
		Mod_Faction_Environment_V_(Side).hpp
		
	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\GM_WestGermany_W_V.hpp";
*/

//WEST (desert, arid, WOODLAND, jungle)
BikeW=["gm_ge_army_k125"]; //quad bike
CarW=["gm_ge_army_iltis_cargo","gm_ge_army_typ1200_cargo"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["gm_ge_army_iltis_milan","gm_ge_army_iltis_mg3"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["gm_ge_army_u1300l_container","gm_ge_army_u1300l_cargo","gm_ge_army_kat1_451_container","gm_ge_army_kat1_451_cargo"]; //truck
ArmorW1=["gm_ge_army_m113a1g_apc","gm_ge_army_m113a1g_apc_milan","gm_ge_army_luchsa1","gm_ge_army_luchsa2","gm_ge_army_marder1a1plus","gm_ge_army_marder1a1a","gm_ge_army_marder1a2","gm_ge_army_fuchsa0_engineer","gm_ge_army_fuchsa0_reconnaissance"]; //apc, ifv
ArmorW2=["gm_ge_army_Leopard1a1","gm_ge_army_Leopard1a1a1","gm_ge_army_Leopard1a1a2","gm_ge_army_Leopard1a3","gm_ge_army_Leopard1a3a1","gm_ge_army_Leopard1a5"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["gm_ge_army_ch53g","gm_ge_army_ch53gs","gm_ge_army_bo105m_vbh","gm_ge_army_bo105p1m_vbh_swooper"]; //transport heli
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["gm_ge_army_bo105p_pah1","gm_ge_army_bo105p_pah1a1"]; //gunship (armed heli)
PlaneW=[]; //jet
PlaneDlcW=[]; //jets dlc

aaW=["gm_ge_army_gepard1a1"]; //Anti Air
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
		"gm_ge_army_squadleader_g3a3_p2a1_80_ols", //0 - Squad leader
		"gm_ge_army_antitank_g3a3_pzf44_80_ols", //1 - Rifleman AT
		"gm_ge_army_machinegunner_mg3_80_ols", //2 - Autorifleman
		"gm_ge_army_medic_g3a3_80_ols", //3 - Combat life saver
		"gm_ge_army_grenadier_g3a3_80_ols", //4 - Team leader
		"gm_ge_army_rifleman_g3a3_80_ols", //5 - Rifleman
		"gm_ge_army_engineer_g3a4_80_ols", //6 - Engineer
		"gm_ge_army_marksman_g3a3_80_ols", //7 - Marksman
		"gm_ge_army_antitank_g3a3_pzf44_80_ols", //8 - Missile specialist AT
		"gm_ge_army_grenadier_g3a3_80_ols", //9 - Grenadier
		"gm_ge_army_rifleman_g3a3_80_ols", //10 - Missile specialist AA
		"gm_ge_army_squadleader_g3a3_p2a1_80_ols", //11 - Recon team leader
		"gm_ge_army_antitank_g3a3_pzf44_80_ols", //12 - Recon scout AT (Rifleman AT)
		"gm_ge_army_machinegunner_mg3_80_ols", //13 - Recon Marksman (Autorifleman)
		"gm_ge_army_medic_g3a3_80_ols", //14 - Recon Paramedic (Medic)
		"gm_ge_army_grenadier_g3a3_80_ols", //15 - Recon JTAC (Grenadier)
		"gm_ge_army_antiair_g3a3_fim43_80_ols", //16 - Recon Scout (Rifleman)
		"gm_ge_army_engineer_g3a4_80_ols", //17 - Recon demo specialist (Engineer)
		"gm_ge_army_marksman_g3a3_80_ols" //18 - Sniper (Marksman)
	];
}else //"West Germany 90"
{
	unitsW=
	[
		"gm_ge_army_squadleader_g36a1_p2a1_90_flk", //0 - Squad leader
		"gm_ge_army_antitank_g36a1_pzf3_90_flk", //1 - Rifleman AT
		"gm_ge_army_machinegunner_mg3_90_flk", //2 - Autorifleman
		"gm_ge_army_medic_g36a1_90_flk", //3 - Combat life saver
		"gm_ge_army_grenadier_hk69a1_90_flk", //4 - Team leader
		"gm_ge_army_rifleman_g36a1_90_flk", //5 - Rifleman
		"gm_ge_army_engineer_g36a1_90_flk", //6 - Engineer
		"gm_ge_army_marksman_g3a3_90_flk", //7 - Marksman
		"gm_ge_army_antitank_g36a1_pzf3_90_flk", //8 - Missile specialist AT
		"gm_ge_army_grenadier_hk69a1_90_flk", //9 - Grenadier
		"gm_ge_army_rifleman_g36a1_90_flk", //10 - Missile specialist AA
		"gm_ge_army_squadleader_g36a1_p2a1_90_flk", //11 - Recon team leader
		"gm_ge_army_antitank_g36a1_pzf3_90_flk", //12 - Recon scout AT (Rifleman AT)
		"gm_ge_army_machinegunner_mg3_90_flk", //13 - Recon Marksman (Autorifleman)
		"gm_ge_army_medic_g36a1_90_flk", //14 - Recon Paramedic (Medic)
		"gm_ge_army_grenadier_hk69a1_90_flk", //15 - Recon JTAC (Grenadier)
		"gm_ge_army_antiair_g36a1_fim43_90_flk", //16 - Recon Scout (Rifleman)
		"gm_ge_army_engineer_g36a1_90_flk", //17 - Recon demo specialist (Engineer)
		"gm_ge_army_marksman_g3a3_90_flk" //18 - Sniper (Marksman)
	];
};

faceW='NATO'; //faces (config)
voiceW='deu_'; //voices
nameW="gm_names_deu_male"; //names