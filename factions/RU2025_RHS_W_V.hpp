/*
	Author: Generated for Russia 2025

	Description:
		Russia 2025 Faction Vehicles
		Mod_Faction_Environment_V_(Side).hpp

	Dependencies:
		init.sqf

	Execution:(example)
		#include "factions\RU2025_RHS_W_V.hpp";
*/

//EAST (WOODLAND, jungle) - Russia 2025
BikeE=[["O_G_Quadbike_01_F",""]]; //quad bike
CarE=["RUS_MSV_West_r142n","pickup_ru_z","uaz_pickup_z","uaz_suv_z","uaz2206_ru_z_opfor","uaz451_ru_z","novator_ru_trophy","uaz2206_ru_z"]; //car - pašalintos RHS_AFRF transporto priemonės (rhs_tigr*, rhs_uaz*)
CarDlcE=[]; //car apex dlc
CarArE=["kord_tigr_z_opfor","atgm_tigr_z_opfor","vpk_tiger_ru_z","uaz_ags_z","uaz_kord_z","uaz_atgm_z","kord_tigr_z"]; //armed car - pašalinta RHS_AFRF transporto priemonė (rhs_tigr_sts_msv)
CarArDlcE=[]; //armed car apex dlc
TruckE=["RUS_MSV_West_kamaz4310","RUS_MSV_West_mtoat","RUS_MSV_West_bmkt","RUS_MSV_West_ptsm","RUS_MSV_West_snl8","ural4320_vtn_ru","kamaz_typhoon_z_opfor","kamaz_typhoon_bm_z_opfor","kamaz_typhoon_krest","kamaz_typhoon_z","kamaz_bm_typhoon_v"]; //truck - pašalintos RHS_AFRF transporto priemonės (rhs_gaz66*, rhs_kamaz5350*, RHS_Ural_*, rhs_zil131*)
ArmorE1=["RUS_MSV_West_btr80","RUS_MSV_West_btr82a","RUS_MSV_West_brdm2a","RUS_MSV_West_prp3","RUS_MSV_West_ap2","RUS_MSV_West_bmp2","RUS_MSV_West_bmp2k","RUS_MSV_West_bmp3","RUS_MSV_West_bmp3m","RUS_MSV_West_brm1k","bmp1_ru_z_opfor","bmp2m_z_opfor","bmp1_ru_z","bmp2m_z"]; //apc, ifv - pašalintos RHS_AFRF transporto priemonės (rhs_btr*, rhs_bmp*, rhs_brm1k_msv, rhs_prp3_msv, rhs_t15_tv)
ArmorE2=["RUS_MSV_West_t72b","RUS_MSV_West_t72b3","RUS_MSV_West_t72b3m","RUS_MSV_West_t72bm","RUS_MSV_West_t80bv","RUS_MSV_West_t90a","RUS_MSV_West_t90m","t62_z_opfor","t64bv_z_opfor","t64bv_z","t62_z"]; //tank - pašalintos RHS_AFRF transporto priemonės (rhs_t14_tv, rhs_t72*, rhs_t80*, rhs_t90*, rhs_sprut_vdv)
ArmorDlcE2=[]; //tank tanks dlc

HeliTrE=["RUS_VKS_south_mi8amtsh","RUS_VKS_south_mi8mt","RUS_VKS_south_mi8mtv2"]; //transport heli - pašalintos RHS_AFRF transporto priemonės (rhs_ka60_c, RHS_Mi8mt_vvsc)
HeliTrDlcE=[]; //transport heli helicopters dlc
HeliArE=["RUS_VKS_south_ka52","RUS_VKS_south_mi24p","RUS_VKS_south_mi28n"]; //gunship (armed heli) - pašalintos RHS_AFRF transporto priemonės (RHS_Ka52_vvsc, RHS_Mi24P_vvsc, rhs_mi28n_vvsc)
PlaneE=["RUS_VKS_south_su25sm","RUS_VKS_south_su57"]; //jet - pašalintos RHS_AFRF transporto priemonės (RHS_Su25SM_vvs, rhs_mig29sm_vmf, RHS_T50_vvs_*)
PlaneDlcE=[]; //jets dlc

aaE=["RUS_MP_east_zsu234","RUS_MP_east_zu232"]; //Anti Air - pašalinta RHS_AFRF transporto priemonė (rhs_zsu234_aa)
artiE=["RUS_MP_east_prp3","RUS_MSV_West_2s3m1","RUS_MSV_West_2s1"]; //artillery - pašalintos RHS_AFRF transporto priemonės (rhs_2s1_tv, rhs_2s3_tv)
mortE = ["RUS_MSV_South_2b14"]; //mortar - pašalinta RHS_AFRF transporto priemonė (rhs_2b14_82mm_vmf)
crewE="RUS_MSV_West_mechanikdriver"; //crew - pašalinta RHS_AFRF klasė (rhs_vmf_flora_armoredcrew), naudojama RUS_MSV_east_private kaip laikinas sprendimas

boatTrE=[]; //small boat - pašalinta iš airdropų
boatArE=[]; //patrol boat - pašalinta iš airdropų

divEe=["U_O_Wetsuit","V_RebreatherIR","G_O_Diving"]; //diver gear (boat cargo)
divWe="arifle_SDAR_F"; //diver weapon (boat cargo)
divMe="30Rnd_556x45_Stanag_green"; //diver ammo (boat cargo)

uavsE=["O_Crocus_AP","O_Crocus_AT"]; //UAV - FPV kamikadze dronai
uavsDlcE=[]; //UAV apex dlc - not used for Russia 2025
ugvsE=[]; //UGV - not used for Russia 2025

supplyE=["rhs_weapon_crate"];
flgE = "RHS_Flag_Russia_F";

endE = "EndRussia";

unitsE=
[
	"RUS_MSV_east_lieutenant", //0 - Squad leader
	"RUS_MSV_east_operatormanpad", //1 - Rifleman AT
	"RUS_MSV_east_machinegunner", //2 - Autorifleman
	"RUS_MSV_east_riflemancombatlifesaver", //3 - Combat life saver
	"RUS_MSV_east_sergeant", //4 - Team leader
	"RUS_MSV_east_private", //5 - Rifleman
	"RUS_MSV_east_sapper", //6 - Engineer
	"RUS_MSV_east_sniper", //7 - Marksman
	"RUS_MSV_east_operatormanpad", //8 - Missile specialist AT
	"RUS_MSV_east_grenadier", //9 - Grenadier
	"RUS_MSV_east_operatormanpad", //10 - Missile specialist AA
	"RUS_gru_seniorrecon", //11 - Recon team leader
	"RUS_GRU_center_recongrenadier", //12 - Recon scout AT (Rifleman AT)
	"RUS_spn_reconmachinegunner", //13 - Recon Marksman (Autorifleman)
	"RUS_spn_reconsanitar", //14 - Recon Paramedic (Medic)
	"RUS_spn_reconoperatoruav", //15 - Recon JTAC (Grenadier)
	"RUS_spn_recon", //16 - Recon Scout (Rifleman)
	"RUS_spn_reconsapper", //17 - Recon demo specialist (Engineer)
	"RUS_spn_reconsniper" //18 - Sniper (Marksman)
];

faceE='NATO'; //faces (config)
voiceE='RUS_'; //voices
nameE="LIB_RussianMen"; //names
