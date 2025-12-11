////////////////////////////////////////////////////////////////////
//DeRap: config.bin
//Produced from mikero's Dos Tools Dll version 9.98
//https://mikero.bytex.digital/Downloads
//'now' is Sun Oct 26 19:04:27 2025 : 'file' last modified on Mon Oct 28 17:03:06 2024
////////////////////////////////////////////////////////////////////

#define _ARMA_

class cfgPatches
{
	class UA_Azov_Azov
	{
		units[] = {"UA_Azov_seniorlieutenant","UA_Azov_lieutenant","UA_Azov_mainsergeant","UA_Azov_sergeant","UA_Azov_juniorsergeant","UA_Azov_riflemancombatlifesaver","UA_Azov_jtac","UA_Azov_forwardobserver","UA_Azov_radiotelephonist","UA_Azov_sniper","UA_Azov_grenadier","UA_Azov_riflemangrenadierassistant","UA_Azov_gunner","UA_Azov_rifleman","UA_Azov_machinegunner","UA_Azov_operatoratgm","UA_Azov_operatormanpad","UA_Azov_rangefinder","UA_Azov_sapper","UA_Azov_operatoruav","UA_Azov_driver","UA_Azov_mechanikdriver","UA_Azov_squadcommander","UA_Azov_reconsniper","UA_Azov_reconmachinegunner","UA_Azov_reconradiotelephonist","UA_Azov_reconoperator","UA_Azov_reconoperatoruav","UA_Azov_recondriver","UA_Azov_btr70","UA_Azov_btr80","UA_Azov_btr3da","UA_Azov_btr4e1","UA_Azov_brdm2","UA_Azov_9p135","UA_Azov_spg9m","UA_Azov_ags17","UA_Azov_dshkm","UA_Azov_2b14","UA_Azov_zu232","UA_Azov_t64bm","UA_Azov_2a18m","UA_Azov_9p148","UA_Azov_krazspartanarmed","UA_Azov_r142n","UA_Azov_zil131","UA_Azov_ural4320","UA_Azov_ural43202","UA_Azov_atmz54320","UA_Azov_mtoat","UA_Azov_gaz66","UA_Azov_ap2","UA_Azov_krazshrek","UA_Azov_krazfiona","UA_Azov_mitsubishil200","UA_Azov_uaz3151"};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F_Items","A3_Weapons_F","rhs_c_weapons"};
	};
};
class cfgFactionClasses
{
	class UA_Azov_Azov
	{
		displayName = "$STR_UA_Azov";
		flag = "\FA_UAF_Core\data\flags\flag_ua_co.paa";
		icon = "\AFU_icons\data\flags\azov.paa";
		side = 1;
		priority = 1;
	};
};
class cfgVehicles
{
	class rhs_msv_officer;
	class rhs_msv_medic;
	class rhs_msv_rifleman;
	class rhs_msv_marksman;
	class rhs_msv_grenadier_rpg;
	class rhs_msv_machinegunner;
	class rhs_msv_aa;
	class rhs_msv_engineer;
	class rhs_btr70_msv;
	class rhs_btr80_msv;
	class FA_UAF_BTR3;
	class FA_UAF_BTR4;
	class rhsgref_BRDM2_msv;
	class TU_9P135;
	class rhs_SPG9M_MSV;
	class RHS_AGS30_TriPod_MSV;
	class rhsgref_cdf_DSHKM_Mini_TriPod;
	class rhs_2b14_82mm_msv;
	class RHS_ZU23_MSV;
	class FA_UAF_T64BM;
	class rhs_D30_msv;
	class rhsgref_BRDM2_ATGM_msv;
	class Kraz_Spartan_dshk;
	class rhs_gaz66_r142_msv;
	class rhs_zil131_msv;
	class RHS_Ural_MSV_01;
	class RHS_Ural_Ammo_MSV_01;
	class RHS_Ural_Fuel_MSV_01;
	class RHS_Ural_Repair_MSV_01;
	class rhs_gaz66_msv;
	class rhs_gaz66_ap2_msv;
	class FA_UAF_Shrek;
	class FA_UAF_Fiona;
	class C_Offroad_01_F;
	class RHS_UAZ_MSV_01;
	class UA_Azov_seniorlieutenant: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_seniorlieutenant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","VTN_B8","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","VTN_B8","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","ItemGPS","VTN_B8","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","ItemGPS","VTN_B8","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\platoon_commander.sqf';};";
		};
	};
	class UA_Azov_lieutenant: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_lieutenant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\officer.sqf';};";
		};
	};
	class UA_Azov_mainsergeant: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_mainsergeant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","rhs_weap_makarov_pm","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\officer.sqf';};";
		};
	};
	class UA_Azov_sergeant: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_sergeant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_aks74_gp25","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_aks74_gp25","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v4","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v4","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\senior_rifleman.sqf';};";
		};
	};
	class UA_Azov_juniorsergeant: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_juniorsergeant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\rifleman.sqf';};";
		};
	};
	class UA_Azov_riflemancombatlifesaver: rhs_msv_medic
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_riflemancombatlifesaver";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_aks74_gp25","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_aks74_gp25","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25","rhs_VOG25"};
		linkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v4","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v4","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\rifleman_combat_life_saver.sqf';};";
		};
	};
	class UA_Azov_jtac: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_jtac";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_nspn_green","rhs_mag_nspn_red","afou_mag_gd01_orange","afou_mag_gd01_black"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_nspn_green","rhs_mag_nspn_red","afou_mag_gd01_orange","afou_mag_gd01_black"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\jtac.sqf';};";
		};
	};
	class UA_Azov_forwardobserver: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_forwardobserver";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_nspn_green","rhs_mag_nspn_red","afou_mag_gd01_orange","afou_mag_gd01_black"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_nspn_green","rhs_mag_nspn_red","afou_mag_gd01_orange","afou_mag_gd01_black"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN4700","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\jtac.sqf';};";
		};
	};
	class UA_Azov_radiotelephonist: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_radiotelephonist";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "TFAR_aselsan9661_sage";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\soldier.sqf';};";
		};
	};
	class UA_Azov_sniper: rhs_msv_marksman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_sniper";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_svdp","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_svdp","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1"};
		linkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\sniper.sqf';};";
		};
	};
	class UA_Azov_grenadier: rhs_msv_grenadier_rpg
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_grenadier";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\grenadier.sqf';};";
		};
	};
	class UA_Azov_riflemangrenadierassistant: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_riflemangrenadierassistant";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\rifleman_grenadier_assistant.sqf';};";
		};
	};
	class UA_Azov_gunner: rhs_msv_machinegunner
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_mggunner";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"afou_weapons_km_762_plastik_2_F","Put","Throw"};
		respawnWeapons[] = {"afou_weapons_km_762_plastik_2_F","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\gunner.sqf';};";
		};
	};
	class UA_Azov_machinegunner: rhs_msv_machinegunner
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_machinegunner";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_rpk74m","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_rpk74m","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front03_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front03_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\machinegunner.sqf';};";
		};
	};
	class UA_Azov_operatoratgm: rhs_msv_aa
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_operatoratgm";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\operator_atgm.sqf';};";
		};
	};
	class UA_Azov_operatormanpad: rhs_msv_aa
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_operatormanpad";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","TFAR_ASELSAN4700","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\operator_manpad.sqf';};";
		};
	};
	class UA_Azov_rangefinder: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_rangefinder";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","VTN_LPR1","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\rangefinder.sqf';};";
		};
	};
	class UA_Azov_sapper: rhs_msv_engineer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_sapper";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\sapper.sqf';};";
		};
	};
	class UA_Azov_operatoruav: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_operatoruav";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","B_UavTerminal","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","B_UavTerminal","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\operator_uav.sqf';};";
		};
	};
	class UA_Azov_driver: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_driver";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_aks74u","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_aks74u","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\driver.sqf';};";
		};
	};
	class UA_Azov_rifleman: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_soldier";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\soldier.sqf';};";
		};
	};
	class UA_Azov_mechanikdriver: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_mechanikdriver";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_infantry";
		uniformClass = "MMM_xILno_MM14Winter_gl2_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_aks74u","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_aks74u","Put","Throw"};
		items[] = {};
		respawnItems[] = {};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK"};
		linkedItems[] = {"ItemWatch","rhs_tsh4","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemWatch","rhs_tsh4","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\mechanik_driver.sqf';};";
		};
	};
	class UA_Azov_squadcommander: rhs_msv_officer
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_squadcommander";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","rhs_weap_pb_6p9","VTN_LPR1","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","rhs_weap_pb_6p9","VTN_LPR1","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S","rhs_mag_9x18_8_57N181S"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","ItemGPS","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","TFAR_ASELSAN9651","ItemGPS","VTN_LPR1","MMM_UA_TorD_CMultiCam_ESS_TapeNone","Dick_Azov_v2","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\squad_commander.sqf';};";
		};
	};
	class UA_Azov_reconsniper: rhs_msv_marksman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_reconsniper";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_svdp","VTN_B8","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_svdp","VTN_B8","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1","rhs_10Rnd_762x54mmR_7N1"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","VTN_B8","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","VTN_B8","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front00_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_sniper.sqf';};";
		};
	};
	class UA_Azov_reconmachinegunner: rhs_msv_machinegunner
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_reconmachinegunner";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_rpk74m","rhs_tr8_periscope","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_rpk74m","rhs_tr8_periscope","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK"};
		respawnMagazines[] = {"rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK","rhs_45Rnd_545X39_7N6M_AK"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","rhs_tr8_periscope","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front03_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","rhs_tr8_periscope","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front03_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_machinegunner.sqf';};";
		};
	};
	class UA_Azov_reconradiotelephonist: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_reconradiotelephonist";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "TFAR_aselsan9661_sage";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_radiotelephonist.sqf';};";
		};
	};
	class UA_Azov_reconoperator: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_reconoperator";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "FARA_PV_RUCK";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_radiotelephonist.sqf';};";
		};
	};
	class UA_Azov_reconoperatoruav: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_reconoperatoruav";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_alta_MultiCamtop_MultiCambot";
		weapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		respawnWeapons[] = {"NMG_weapons_akHohTk","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","B_UavTerminal","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","B_UavTerminal","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot02_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_operator_uav.sqf';};";
		};
	};
	class UA_Azov_recondriver: rhs_msv_rifleman
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_recondriver";
		identityTypes[] = {"LanguageRUS_F","Head_Enoch"};
		genericNames = "UkrainianNames";
		editorPreview = "";
		editorSubcategory = "AFU_recon";
		uniformClass = "MMM_xILno_MM14Winter_gl2_MultiCamtop_MultiCambot";
		weapons[] = {"rhs_weap_aks74u","Put","Throw"};
		respawnWeapons[] = {"rhs_weap_aks74u","Put","Throw"};
		items[] = {"FirstAidKit","FirstAidKit"};
		respawnItems[] = {"FirstAidKit","FirstAidKit"};
		magazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		respawnMagazines[] = {"rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","rhs_mag_rgd5","afou_mag_gd01_white"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","MMM_BaoUV5R","MMM_UA_TorD_CMultiCam_ESS_TapeNone","MMM_TMC6094A_545_MultiCam_top04_front02_sides02_bot00_tape01","UA_Scarf_Neck_b3"};
		backpack = "";
		class EventHandlers
		{
			init = "if (isServer) then	{_this select 0 execVM '\ua_macro\AZOV\recon_driver.sqf';};";
		};
	};
	class UA_Azov_btr70: rhs_btr70_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_btr70";
		editorSubcategory = "EdSubcat_BTR";
		rhs_habarType = 0;
		rhs_decalParameters[] = {"['Number', cBTR3NumberPlaces, 'Default']","['Label', cBTRBackArmSymPlaces, 'Army', [0,0]]","['Label', cBTRPlnSymPlaces, 'Army', [0,0]]"};
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\btr70\afou_btr70_1_newcamo_02.paa","ua_vehicle_textures\data\vehicles\btr70\afou_btr70_2_newcamo_02.paa","","rhsafrf\addons\rhs_btr70\habar\data\sa_gear_02_co.paa","rhsafrf\addons\rhs_btr70\habar\data\sa_gear_02_co.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\honor\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\honor\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa"};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_btr80: rhs_btr80_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_btr80";
		editorSubcategory = "EdSubcat_BTR";
		rhs_habarType = 0;
		rhs_decalParameters[] = {"['Number', cBTR3NumberPlaces, 'Default']","['Label', cBTRBackArmSymPlaces, 'Army', [0,0]]","['Label', cBTRPlnSymPlaces, 'Army', [0,0]]"};
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\gsb_rhs_btr80_01_co.paa","ua_vehicle_textures\data\gsb_rhs_btr80_02_co.paa","ua_vehicle_textures\data\gsb_rhs_btr80_03_co.paa","rhsafrf\addons\rhs_btr70\habar\data\sa_gear_02_co.paa","rhsafrf\addons\rhs_btr70\habar\data\sa_gear_02_co.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","","","rhsafrf\addons\rhs_decals\data\labels\honor\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","","","","","","","","","","","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa"};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_btr3da: FA_UAF_BTR3
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_btr3da";
		editorSubcategory = "EdSubcat_BTR";
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\body_azov_btr3_co.paa","ua_vehicle_textures\data\turret_azov_btr3_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_btr4e1: FA_UAF_BTR4
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_btr4e1";
		editorSubcategory = "EdSubcat_BTR";
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"fa_uaf_btr4\data\textures\body_camo_green_unmarked_co.paa","fa_uaf_btr4\data\textures\turret_camo_green_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_brdm2: rhsgref_BRDM2_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_brdm2";
		editorSubcategory = "EdSubcat_BRDM";
		rhs_decalParameters[] = {"['Number', [], 'Default']","['Label', [], 'Army',[0,0]]"};
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"rhsgref\addons\rhsgref_a2port_armor\brdm2\data\brdm2_ru_01_co.paa","rhsgref\addons\rhsgref_a2port_armor\brdm2\data\brdm2_02_co.paa","rhsgref\addons\rhsgref_a2port_armor\brdm2\data\zbik_04_co.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa"};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_9p135: TU_9P135
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_9p135";
		editorSubcategory = "EdSubcat_Stationary";
		hiddenSelectionsTextures[] = {};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_spg9m: rhs_SPG9M_MSV
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_spg9m";
		editorSubcategory = "EdSubcat_Stationary";
		hiddenSelectionsTextures[] = {};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_ags17: RHS_AGS30_TriPod_MSV
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_ags17";
		editorSubcategory = "EdSubcat_Stationary";
		hiddenSelectionsTextures[] = {};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_dshkm: rhsgref_cdf_DSHKM_Mini_TriPod
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_dshkm";
		editorSubcategory = "EdSubcat_Stationary";
		hiddenSelectionsTextures[] = {};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_2b14: rhs_2b14_82mm_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_2b14";
		editorSubcategory = "EdSubcat_Mortar";
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\podnos\afou_podnos_01.paa"};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_zu232: RHS_ZU23_MSV
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_zu232";
		editorSubcategory = "EdSubcat_Zu";
		hiddenSelectionsTextures[] = {};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_t64bm: FA_UAF_T64BM
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_t64bm";
		editorSubcategory = "EdSubcat_Tank";
		class TransportMagazines
		{
			class _xx_rhs_30Rnd_545x39_7N6M_plum_AK
			{
				magazine = "rhs_30Rnd_545x39_7N6M_plum_AK";
				count = 10;
			};
			class _xx_rhs_mag_nspn_red
			{
				magazine = "rhs_mag_nspn_red";
				count = 4;
			};
			class _xx_rhs_mag_nspn_yellow
			{
				magazine = "rhs_mag_nspn_yellow";
				count = 4;
			};
			class _xx_rhs_mag_nspn_green
			{
				magazine = "rhs_mag_nspn_green";
				count = 4;
			};
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 10;
			};
		};
		class TransportWeapons
		{
			class _xx_rhs_weap_aks74
			{
				weapon = "rhs_weap_aks74";
				count = 1;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\body_azov_64bm_co.paa","ua_vehicle_textures\data\body_azov_64bm_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_2a18m: rhs_D30_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_2a18m";
		editorSubcategory = "EdSubcat_Arty";
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\d30\afou_d30_01.paa"};
		crew = "UA_Azov_rifleman";
		typicalCargo[] = {"UA_Azov_rifleman"};
	};
	class UA_Azov_9p148: rhsgref_BRDM2_ATGM_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_9p148";
		editorSubcategory = "EdSubcat_SPTRK";
		rhs_decalParameters[] = {"['Number', [], 'Default']","['Label', [], 'Army',[0,0]]"};
		class TransportMagazines
		{
			class _xx_rhs_mag_f1
			{
				magazine = "rhs_mag_f1";
				count = 6;
			};
		};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
			class _xx_rhs_tsh4
			{
				name = "rhs_tsh4";
				count = 1;
			};
		};
		class TransportWeapons{};
		class TransportBackpacks{};
		hiddenSelectionsTextures[] = {"rhsgref\addons\rhsgref_a2port_armor\brdm2\data\brdm2_atgm_ru_01_co.paa","rhsgref\addons\rhsgref_a2port_armor\brdm2\data\brdm2_02_co.paa","rhsgref\addons\rhsgref_a2port_armor\brdm2\data\zbik_04_co.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","a3\data_f\clear_empty.paa","rhsafrf\addons\rhs_decals\data\labels\platoon\no_ca.paa"};
		crew = "UA_Azov_mechanikdriver";
		typicalCargo[] = {"UA_Azov_mechanikdriver"};
	};
	class UA_Azov_krazspartanarmed: Kraz_Spartan_dshk
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_krazspartanarmed";
		editorSubcategory = "EdSubcat_Car";
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"kraz_spartan\ua\azov.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_r142n: rhs_gaz66_r142_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_r142n";
		editorSubcategory = "EdSubcat_Signal";
		rhs_decalParameters[] = {"['Number', cTrucksGaz4NumberPlaces, 'Default']","['Label', cTrucksGazRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.55,3.14,0.68};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_tent_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_kung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_medkung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_repkung_co.paa","rhsafrf\addons\rhs_decals\data\numbers\default\4_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\8_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\9_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_zil131: rhs_zil131_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_zil131";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', [5,6,7,8], 'Default']","['Label', [9,10], 'Army', [5,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",0.014,4.195,-0.99};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\afou_zil131_cargo_green01.paa","ua_vehicle_textures\data\vehicles\zil131\afou_zil131_cabin_green.paa","rhsafrf\addons\rhs_zil131\data\rhs_zil131_interior_co.paa","ua_vehicle_textures\data\vehicles\zil131\afou_zil131_base_01.paa","ua_vehicle_textures\data\vehicles\zil131\afou_zil131_base_01.paa","rhsafrf\addons\rhs_decals\data\numbers\default\9_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\0_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\9_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_ural4320: RHS_Ural_MSV_01
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_ural4320";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cDecals4CarsNumberPlaces, 'LicensePlate']","['Label', cDecalsCarsRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.32,4.2,-0.65};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\afou_ural_kabina_green.paa","ua_vehicle_textures\data\afou_ural_plachta_green.paa","rhsafrf\addons\rhs_decals\data\numbers\default\3_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\9_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\0_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_ural43202: RHS_Ural_Ammo_MSV_01
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_ural43202";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cDecals4CarsNumberPlaces, 'LicensePlate']","['Label', cDecalsCarsRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.32,4.2,-0.65};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\afou_ural_kabina_green.paa","ua_vehicle_textures\data\afou_ural_plachta_green.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\8_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_atmz54320: RHS_Ural_Fuel_MSV_01
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_atmz54320";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cDecals4CarsNumberPlaces, 'LicensePlate']","['Label', cDecalsCarsRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.32,4.343,-0.656};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\afou_ural_kabina_green.paa","ua_vehicle_textures\data\afou_ural_open_green.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\0_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","ua_vehicle_textures\data\afou_ural_fuel_khk.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_mtoat: RHS_Ural_Repair_MSV_01
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_mtoat";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cDecals4CarsNumberPlaces, 'LicensePlate']","['Label', cDecalsCarsRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.32,4.2,-0.65};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\afou_ural_kabina_green.paa","ua_vehicle_textures\data\afou_ural_repair_green.paa","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\4_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_gaz66: rhs_gaz66_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_gaz66";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cTrucksGaz4NumberPlaces, 'Default']","['Label', cTrucksGazRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.55,3.365,-0.77};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_tent_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_kung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_medkung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_repkung_co.paa","rhsafrf\addons\rhs_decals\data\numbers\default\7_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\3_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_ap2: rhs_gaz66_ap2_msv
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_ap2";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cTrucksGaz4NumberPlaces, 'Default']","['Label', cTrucksGazRightArmyPlaces, 'Army', [0,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.55,3.082,-0.625};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_MedKit
			{
				name = "Medikit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 9;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_tent_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_kung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_medkung_co.paa","ua_vehicle_textures\data\vehicles\gaz66\afou_gaz66_repkung_co.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\7_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\4_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\3_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_krazshrek: FA_UAF_Shrek
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_krazshrek";
		editorSubcategory = "EdSubcat_Car";
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"fa_uaf_shrek\data\textures\body_green_unmarked_co.paa","fa_uaf_shrek\data\textures\interior_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_krazfiona: FA_UAF_Fiona
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_krazfiona";
		editorSubcategory = "EdSubcat_Car";
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_ToolKit
			{
				name = "ToolKit";
				count = 1;
			};
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"fa_uaf_shrek\data\textures\body_green_unmarked_co.paa","fa_uaf_shrek\data\textures\interior_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_mitsubishil200: C_Offroad_01_F
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_mitsubishil200";
		editorSubcategory = "EdSubcat_Car";
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\offroad_01_ext_gsb_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"};
		textureList[] = {"maincamo",1};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
	class UA_Azov_uaz3151: RHS_UAZ_MSV_01
	{
		faction = "UA_Azov_Azov";
		side = 1;
		displayName = "$STR_uaz3151";
		editorSubcategory = "EdSubcat_Car";
		rhs_decalParameters[] = {"['Number', cDecals4CarsNumberPlaces, 'LicensePlate']","['Label', cDecalsCarsRightArmyPlaces, 'Army', [5,0]]"};
		class Attributes
		{
			class AFOU_LicensePlateNums
			{
				displayName = "$STR_AFOU_LicensePlateNumber";
				tooltip = "$STR_AFOU_LicensePlateNumberTooltip";
				property = "AFOU_LicensePlateNums";
				control = "EditShort";
				defaultValue = "-1";
				expression = "_this setVariable ['%s', _value]; [_this] call afou_main_fnc_licensePlateInit;";
				typeName = "STRING";
			};
		};
		attachComponents[] = {"AFOU_LicensePlate_01_F",-0.05,1.945,-0.523,"AFOU_LicensePlate_02_F",-0.43,-1.8,-0.22};
		class EventHandlers
		{
			class CBA_Extended_EventHandlers;
			class afougf_attachTo
			{
				init = "if (is3DEN || isServer) then { 0 = _this spawn afou_main_fnc_attachTo; };";
				killed = "0 = _this spawn afou_main_fnc_vehicleKilled;";
				deleted = "0 = _this spawn afou_main_fnc_vehicleDeleted;";
			};
		};
		class TransportMagazines{};
		class TransportWeapons{};
		class TransportItems
		{
			class _xx_FAK
			{
				name = "FirstAidKit";
				count = 3;
			};
		};
		hiddenSelectionsTextures[] = {"ua_vehicle_textures\data\vehicles\uaz\afou_uaz_main_green_co.paa","","rhsafrf\addons\rhs_decals\data\numbers\default\1_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\5_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\6_ca.paa","rhsafrf\addons\rhs_decals\data\numbers\default\8_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa","rhsafrf\addons\rhs_decals\data\labels\army\no_ca.paa"};
		crew = "UA_Azov_driver";
		typicalCargo[] = {"UA_Azov_driver"};
	};
};
class CfgGroups
{
	class WEST
	{
		class UA_Azov_Azov
		{
			name = "$STR_UA_Azov";
			class SpecOps
			{
				name = "$STR_reconnaissance";
				class ua_azov_recondetachment
				{
					name = "$STR_recondetachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_squadcommander";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_reconsniper";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_reconmachinegunner";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_reconradiotelephonist";
					};
					class Unit4
					{
						position[] = {-10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_reconoperator";
					};
					class Unit5
					{
						position[] = {17,-20,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_brdm2";
					};
				};
			};
			class Motorized
			{
				name = "$STR_securityinfantry";
				class ua_azov_securitydetachment
				{
					name = "$STR_securitydetachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_sergeant";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_juniorsergeant";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_grenadier";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_riflemangrenadierassistant";
					};
					class Unit4
					{
						position[] = {-10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_gunner";
					};
					class Unit5
					{
						position[] = {15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_rifleman";
					};
					class Unit6
					{
						position[] = {-15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_machinegunner";
					};
					class Unit7
					{
						position[] = {20,-20,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_riflemancombatlifesaver";
					};
					class Unit8
					{
						position[] = {-20,-20,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_krazshrek";
					};
				};
				class ua_azov_securitydetachmentbtr80
				{
					name = "$STR_securitydetachmentbtr80";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_sergeant";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_juniorsergeant";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_btr80";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_grenadier";
					};
					class Unit4
					{
						position[] = {-10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_machinegunner";
					};
					class Unit5
					{
						position[] = {15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_riflemangrenadierassistant";
					};
					class Unit6
					{
						position[] = {-15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_rifleman";
					};
				};
			};
			class Motorized_MTP
			{
				name = "$STR_firesupport";
				class ua_azov_antiaircraftdetachment
				{
					name = "$STR_antiaircraftdetachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_antiair.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_operatormanpad";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_operatormanpad";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_operatormanpad";
					};
					class Unit3
					{
						position[] = {11,-18,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_ural4320";
					};
				};
			};
			class Support
			{
				name = "$STR_combatsupport";
				class ua_azov_engineersapperdetachment
				{
					name = "$STR_engineersapperdetachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\a3\UI_F_Orange\Data\CfgMarkers\b_Ordnance_ca.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_juniorsergeant";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_sapper";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_sapper";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_sapper";
					};
				};
			};
			class Mechanized
			{
				name = "$STR_assaultinfantry";
				class ua_azov_detachment
				{
					name = "$STR_detachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_mech_inf.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_sergeant";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_sniper";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_btr3da";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_grenadier";
					};
					class Unit4
					{
						position[] = {-10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_machinegunner";
					};
					class Unit5
					{
						position[] = {15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_riflemangrenadierassistant";
					};
					class Unit6
					{
						position[] = {-15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_radiotelephonist";
					};
				};
			};
			class Artillery
			{
				name = "$STR_antitankartillery";
				class ua_azov_antitankdetachment
				{
					name = "$STR_antitankdetachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_art.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
					class Unit1
					{
						position[] = {6,-10,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_krazspartanarmed";
					};
					class Unit2
					{
						position[] = {-6,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
					class Unit3
					{
						position[] = {11,-15,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
					class Unit4
					{
						position[] = {-11,-15,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_krazspartanarmed";
					};
					class Unit5
					{
						position[] = {16,-20,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
					class Unit6
					{
						position[] = {-16,-20,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
					class Unit7
					{
						position[] = {22,-26,0};
						rank = "CORPORAL";
						side = 1;
						vehicle = "UA_Azov_krazspartanarmed";
					};
					class Unit8
					{
						position[] = {-22,-26,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_operatoratgm";
					};
				};
			};
			class Dismounted
			{
				name = "$STR_Infantry";
				class ua_azov_dismounted_detachment
				{
					name = "$STR_detachment";
					side = 1;
					faction = "UA_Azov_Azov";
					icon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
					rarityGroup = 0.5;
					class Unit0
					{
						position[] = {0,0,0};
						rank = "SERGEANT";
						side = 1;
						vehicle = "UA_Azov_sergeant";
					};
					class Unit1
					{
						position[] = {5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_sniper";
					};
					class Unit2
					{
						position[] = {-5,-5,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_grenadier";
					};
					class Unit3
					{
						position[] = {10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_machinegunner";
					};
					class Unit4
					{
						position[] = {-10,-10,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_riflemangrenadierassistant";
					};
					class Unit5
					{
						position[] = {15,-15,0};
						rank = "PRIVATE";
						side = 1;
						vehicle = "UA_Azov_radiotelephonist";
					};
				};
			};
		};
	};
};
class cfgMods
{
	author = "(пѕ’пїЈв–ЅпїЈ)пё»  дёЂ";
	timepacked = "1730138586";
};
