/*
	Author: Generated for Ukraine 2025

	Description:
		Ukraine 2025 Faction Vehicles
		Mod_Faction_Environment_V_(Side).hpp

	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\UA2025_RHS_W_V.hpp";
*/

//WEST (WOODLAND, jungle) - Ukraine 2025
BikeW=[["B_G_Quadbike_01_F",""]]; //quad bike
CarW=["buggy_ukr","buhanka_noarmor_ukr","buhanka_armor_ukr","bushmaster_ukr_unarmed","tahoe_ukr_krest","tahoe_ukr_krest_mat","cougar_triangle","dingo_krest","kozak_krest","kozak_triangle","kozak_ukr_krest","landcruiser_ukr_krest","pickup_krest","pickup_triangle","pickup_covered_krest","pickup_covered_triangle","tundra_ukr_krest","tundra_triangle","uaz2206_ukr_krest","uaz451_krest","varta_krest","varta_triangle"]; //car
CarDlcW=[]; //car apex dlc
CarArW=["bushmaster_ukr_127","bushmaster_ukr_medical","stugna_p_ukr","hmmwv_pickup_ukr_krest","hmmwv_pickup_krest","hmmwv_m998_triangle","hmmwv_halftop_m998_triangle","hmmwv_m2_triangle","hmmwv_m2_ukr_krest","hmmwv_m2_krest","matv_krest_cage","SBR_Ukr_Matv_1","matv_ukr_krest","maxxpro_krest","maxxpro_triangle","novator_krest","pickup_m2_krest","pickup_m2_triangle"]; //armed car
CarArDlcW=[]; //armed car apex dlc
TruckW=["gaz66_ukr_krest","gaz66_ukr_krest_ap2","gaz66_ukr_krest_med","gaz66_ukr_krest_open","gaz66_ukr_krest_r142","gaz66_ukr_krest_zu","kamaz_ukr_krest","kamaz_krest","kraz_ukr_tent","kraz_ukr_open","kraz_ukr_radar_command","kraz_ukr_radar","ural_ukr_krest","ural4320_triangle_new","ural_triangle","ural_ukr_krest_med","ural_ukr_krest_open","ural4320_krest_new","ural_ukr_krest_zu","zil_ukr_krest","zil131_krest_new","zil_ukr_pixel","zil131_ukr_krest_new","pickup_medical","pickup_service_krest","pickup_service_triangle"]; //truck - pašalintos RHS USAF transporto priemonės (rhsusf_M1078*, rhsusf_M1083*, rhsusf_M977*)
ArmorW1=["brdm2_krest","brdm2_atgm_krest","btr60_triangle","btr70_krest","btr70_ukr_krest","btr80_ukr_krest","btr80_triangle","btr80a_krest","btr80a_ukr_krest","stryker_m1126_triangle","stryker_krest","stryker_ukr_krest","m113_triangle","m113_medical","m113_krest","m113_ukr_krest","stryker_m1132_triangle","rosomak_ukr_krest","bmd4_krest","bmd4_ukr_krest","bmp1_krest","bmp1_triangle","bmp2_ukr_krest","bmp2m_krest","bmp3_ukr_krest","bmp3m_ukr_krest","bmp3mera_ukr_krest","m2a2_krest","m2a2_pixel_krest","m2a2_ukr_krest"]; //apc, ifv
ArmorW2=["abrams_krest","abrams_ukr_krest","abrams_ol_krest","amx10_krest","t64bv_triangles","t64bv_krest","t72bb_ukr_krest","t72bb_krest","t72bd_ukr_krest","t72be_triangle","t80u_krest","t80u_ukr_krest","t80uk_krest","t80uk_ukr_krest"]; //tank
ArmorDlcW2=[]; //tank tanks dlc

HeliTrW=["uh60_gur","uh60_gur_gun"]; //transport heli - pašalintos RHS USAF transporto priemonės (RHS_UH60M*, RHS_CH_47F)
HeliTrDlcW=[]; //transport heli helicopters dlc
HeliArW=["mi24_ukr_p","mi24_ukr_v","mi8_afg_ukr","mi8_ukr_mtv3"]; //gunship (armed heli) - pašalintos RHS USAF transporto priemonės (RHS_AH64D*, RHS_AH1Z*)
PlaneW=["mig29_ua","su24_ua","su24_ua_storm","su25_ua"]; //jet - pašalintos RHS USAF transporto priemonės (RHS_A10, rhsusf_f22)
PlaneDlcW=[]; //jets dlc

aaW=["UA_GPV_zsu234","UA_DShV_zu232"]; //Anti Air - pašalinta RHS USAF transporto priemonė (RHS_M6_wd)
artiW=["himars_krest","himars_ukr_krest","m109_krest","m109_ukr_krest"]; //artillery - pašalinta RHS USAF transporto priemonė (rhsusf_m109_usarmy)
mortW = ["UA_Azov_2b14"]; //mortar - pašalinta RHS USAF transporto priemonė (RHS_M252_USMC_WD)
crewW="UA_RTV_crewmember"; //crew - pašalinta RHS USAF klasė (rhsusf_army_ucp_crewman), naudojama UA_Azov_rifleman kaip laikinas sprendimas

boatTrW=[]; //small boat - pašalinta iš airdropų
boatArW=[]; //patrol boat - pašalinta iš airdropų

divEw=["U_B_Wetsuit","V_RebreatherB","G_B_Diving"]; //diver gear (boat cargo)
divWw="arifle_SDAR_F"; //diver weapon (boat cargo)
divMw="20Rnd_556x45_UW_mag"; //diver ammo (boat cargo)

uavsW=["B_Crocus_AP","B_Crocus_AT"]; //UAV - FPV kamikadze dronai
uavsDlcW=[]; //UAV apex dlc - not used for Ukraine 2025
uavsDlc2W=[]; //UAV jets dlc - not used for Ukraine 2025
ugvsW=[]; //UGV - not used for Ukraine 2025

supplyW=["rhsusf_weapon_crate"];
flgW = "FA_UAF_Flag";

endW = "EndUkraine";

unitsW=
[
	"UA_SSO_squadcommander", //0 - Squad leader - MODIFIED: Replaced UA_Azov_lieutenant with UA_SSO_squadcommander
	"UA_SSO_recon", //1 - Rifleman AT - MODIFIED: Replaced UA_Azov_operatormanpad with UA_SSO_recon
	"UA_TRO_il_reconmachinegunner", //2 - Autorifleman - MODIFIED: Replaced UA_Azov_machinegunner with UA_TRO_il_reconmachinegunner
	"UA_MV_combatmedic", //3 - Combat life saver - MODIFIED: Replaced UA_Azov_riflemancombatlifesaver with UA_MV_combatmedic
	"UA_SSO_seniorrecon", //4 - Team leader - MODIFIED: Replaced UA_Azov_sergeant with UA_SSO_seniorrecon
	"UA_MV_rifleman", //5 - Rifleman - MODIFIED: Replaced UA_Azov_rifleman with UA_MV_rifleman
	"UA_SSO_reconsapper", //6 - Engineer - MODIFIED: Replaced UA_Azov_sapper with UA_SSO_reconsapper
	"UA_SSO_reconsniper", //7 - Marksman - MODIFIED: Replaced UA_Azov_sniper with UA_SSO_reconsniper
	"UA_MV_operatoratgm", //8 - Missile specialist AT - MODIFIED: Replaced UA_Azov_operatoratgm with UA_MV_operatoratgm
	"UA_MV_grenadier", //9 - Grenadier - MODIFIED: Replaced UA_Azov_grenadier with UA_MV_grenadier
	"UA_MV_operatormanpad", //10 - Missile specialist AA - MODIFIED: Replaced UA_Azov_operatormanpad with UA_MV_operatormanpad
	"UA_TRO_il_seniorrecon", //11 - Recon team leader - MODIFIED: Replaced UA_Azov_squadcommander with UA_TRO_il_seniorrecon
	"UA_TRO_il_recon", //12 - Recon scout AT (Rifleman AT) - MODIFIED: Replaced UA_Azov_reconoperator with UA_TRO_il_recon
	"UA_SSO_reconsniper", //13 - Recon Marksman (Autorifleman) - MODIFIED: Replaced UA_Azov_reconmachinegunner with UA_SSO_reconsniper
	"UA_MV_riflemancombatlifesaver", //14 - Recon Paramedic (Medic) - MODIFIED: Replaced UA_Azov_riflemancombatlifesaver with UA_MV_riflemancombatlifesaver
	"UA_SSO_reconradiotelephonist", //15 - Recon JTAC (Grenadier) - MODIFIED: Replaced UA_Azov_jtac with UA_SSO_reconradiotelephonist
	"UA_TRO_il_recon", //16 - Recon Scout (Rifleman) - MODIFIED: Replaced UA_Azov_rangefinder with UA_TRO_il_recon
	"UA_SSO_reconsapper", //17 - Recon demo specialist (Engineer) - MODIFIED: Replaced UA_Azov_sapper with UA_SSO_reconsapper
	"UA_MV_sniper" //18 - Sniper (Marksman) - MODIFIED: Replaced UA_Azov_reconsniper with UA_MV_sniper
];

faceW='NATO'; //faces (config) - FIXED: Turėjo būti faceW, ne faceE (WEST frakcija)
voiceW='RUS_'; //voices - FIXED: Turėjo būti voiceW, ne voiceE
nameW="LIB_RussianMen"; //names - FIXED: Turėjo būti nameW, ne nameE
