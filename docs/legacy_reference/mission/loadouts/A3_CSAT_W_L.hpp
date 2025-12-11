/*
	Author: IvosH
	
	Description:
		A3_CSAT_woodland_Loadouts (custom)
		Mod_Faction_environment_L
		
	Dependencies:
		description.ext

	Execution:
		#include "factions\A3_CSAT_W_L.hpp" //EAST 371 - 415
*/

//regular
	class EAST371
	{
		displayName = "Ammo Bearer";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Rifleman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTAmmo_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","100Rnd_580x42_Mag_F","RPG32_F","HandGrenade","HandGrenade","MiniGrenade","MiniGrenade","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F"};
		items[] = {"FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST372
	{
		displayName = "Asst. Autorifleman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTAAR_AAR_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Rangefinder","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","100Rnd_580x42_Mag_F","100Rnd_580x42_Mag_Tracer_F","150Rnd_93x64_Mag","150Rnd_93x64_Mag"};
		items[] = {"FirstAidKit","optic_tws_mg","bipod_02_F_blk","muzzle_snds_93mmg"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Sport_Checkered","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST373
	{
		displayName = "Asst. Gunner (HMG/GMG)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_HMG_01_support_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Shades_Black","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST374
	{
		displayName = "Asst. Gunner (Mk6)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_Mortar_01_support_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST375
	{
		displayName = "Asst. Missile Specialist (AA)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTAAA_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Rangefinder","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Titan_AA","Titan_AA","Titan_AA"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST376
	{
		displayName = "Asst. Missile Specialist (AT)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTAAT_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Rangefinder","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Titan_AT","Titan_AT","Titan_AP","Titan_AP"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Shades_Green","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST377
	{
		displayName = "Autorifleman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MachineGunner";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"LMG_Zafir_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell","150Rnd_762x54_Box","150Rnd_762x54_Box","SmokeShellRed","Chemlight_red","Chemlight_red","150Rnd_762x54_Box"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","G_Sport_BlackWhite","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","","","","","",""};
	};

	class EAST378
	{
		displayName = "Combat Life Saver";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "CombatLifeSaver";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTMedic_F";
		weapons[] = {"arifle_Katiba_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit","Medikit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Sport_Greenblack","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","","","","","",""};
	};

	class EAST379
	{
		displayName = "Engineer";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Sapper";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTEng_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red","SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","DemoCharge_Remote_Mag"};
		items[] = {"FirstAidKit","ToolKit","MineDetector"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST380
	{
		displayName = "Explosive Specialist";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Sapper";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTExp_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","APERSMine_Range_Mag","APERSMine_Range_Mag","APERSMine_Range_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SLAMDirectionalMine_Wire_Mag","DemoCharge_Remote_Mag"};
		items[] = {"FirstAidKit","ToolKit","MineDetector"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Squares","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST381
	{
		displayName = "Grenadier";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Grenadier";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_GL_ACO_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","Chemlight_red","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","MiniGrenade","MiniGrenade","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell","SmokeShellRed","Chemlight_red","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessOGL_ghex_F","H_HelmetLeaderO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","optic_ACO_grn","","","","",""};
	};

	class EAST382
	{
		displayName = "Gunner (GMG)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_GMG_01_weapon_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST383
	{
		displayName = "Gunner (HMG)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_HMG_01_weapon_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Sport_BlackWhite","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST384
	{
		displayName = "Gunner (Mk6)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_Mortar_01_weapon_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Sport_Red","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST385
	{
		displayName = "Marksman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Marksman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"srifle_DMR_07_blk_DMS_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","SmokeShell","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Shades_Green","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","optic_DMS","","","","",""};
	};

	class EAST386
	{
		displayName = "Missile Specialist (AA)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MissileSpecialist";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTAA_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","launch_O_Titan_ghex_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Titan_AA","Titan_AA"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Sport_Checkered","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST387
	{
		displayName = "Missile Specialist (AT)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MissileSpecialist";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTAT_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","launch_O_Titan_short_ghex_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Titan_AT","Titan_AT"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST388
	{
		displayName = "Officer";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Rifleman";
		show = "true";
		uniformClass = "U_O_T_Officer_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_C_ACO_F","hgun_Pistol_heavy_02_Yorris_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","6Rnd_45ACP_Cylinder","6Rnd_45ACP_Cylinder","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_BandollierB_ghex_F","H_Beret_blk","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","","","optic_ACO_grn","","","","",""};
	};

	class EAST389
	{
		displayName = "Para Trooper";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "SpecialOperative";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Parachute";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST390
	{
		displayName = "Repair Specialist";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Sapper";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTRepair_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit","ToolKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST391
	{
		displayName = "Rifleman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Rifleman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST392
	{
		displayName = "Rifleman (AT)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MissileSpecialist";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTLAT_F";
		weapons[] = {"arifle_Katiba_ACO_F","launch_RPG32_ghex_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","RPG32_F","RPG32_F","RPG32_HE_F","RPG32_HE_F"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Sport_Blackred","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","optic_ACO_grn","","","","",""};
	};

	class EAST393
	{
		displayName = "Squad Leader";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Rifleman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_ARCO_pointer_F","hgun_Rook40_F","Binocular","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetLeaderO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_Arco_blk_F","","","","",""};
	};

	class EAST394
	{
		displayName = "Team Leader";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Grenadier";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_GL_ARCO_pointer_F","hgun_Rook40_F","Binocular","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","Chemlight_red","1Rnd_SmokeYellow_Grenade_shell","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_green_mag_Tracer","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","1Rnd_Smoke_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessOGL_ghex_F","H_HelmetLeaderO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_Arco_blk_F","","","","",""};
	};

	class EAST395
	{
		displayName = "UAV Operator";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "SpecialOperative";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "O_UAV_01_backpack_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_UavTerminal","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	//crew
	class EAST396
	{
		displayName = "Crewman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Crewman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_C_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_BandollierB_ghex_F","H_HelmetCrew_O_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","","","","","",""};
	};

	class EAST397
	{
		displayName = "Helicopter Crew";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Crewman";
		show = "true";
		uniformClass = "U_O_PilotCoveralls";
		backpack = "";
		weapons[] = {"arifle_Katiba_C_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_CrewHelmetHeli_O","G_Spectacles_Tinted","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","","","","","",""};
	};

	class EAST398
	{
		displayName = "Helicopter Pilot";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Crewman";
		show = "true";
		uniformClass = "U_O_PilotCoveralls";
		backpack = "";
		weapons[] = {"SMG_02_ACO_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Green","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_CrewHelmetHeli_O","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","optic_ACO_grn_smg","","","","",""};
	};

	class EAST399
	{
		displayName = "Pilot";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Crewman";
		show = "true";
		uniformClass = "U_O_PilotCoveralls";
		backpack = "B_Parachute";
		weapons[] = {"SMG_02_ACO_F","Throw","Put"};
		magazines[] = {"30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Green","SmokeShell","SmokeShellRed","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"","H_PilotHelmetFighter_O","","ItemMap","ItemCompass","ItemWatch","ItemRadio","","","optic_ACO_grn_smg","","","","",""};
	};

//divers
	class EAST400 {vehicle = "O_Diver_F";};
	class EAST401 {vehicle = "O_Diver_Exp_F";};
	class EAST402 {vehicle = "O_Diver_TL_F";};

//special
	class EAST403
	{
		displayName = "Recon Demo Specialist";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Sapper";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTReconExp_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_snds_F","hgun_Rook40_snds_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","APERSMine_Range_Mag","APERSMine_Range_Mag","APERSMine_Range_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SLAMDirectionalMine_Wire_Mag","DemoCharge_Remote_Mag"};
		items[] = {"FirstAidKit","ToolKit","MineDetector"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetSpecO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST404
	{
		displayName = "Recon JTAC";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "SpecialOperative";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_GL_ACO_pointer_snds_F","hgun_Rook40_snds_F","Laserdesignator_02","Throw","Put"};
		magazines[] = {"16Rnd_9x21_Mag","16Rnd_9x21_Mag","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","MiniGrenade","MiniGrenade","O_IR_Grenade","O_IR_Grenade","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","1Rnd_Smoke_Grenade_shell"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessOGL_ghex_F","H_HelmetSpecO_ghex_F","G_Sport_Greenblack","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST405
	{
		displayName = "Recon Marksman";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Marksman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"srifle_DMR_07_blk_DMS_Snds_F","hgun_Rook40_snds_F","Rangefinder","Throw","Put"};
		magazines[] = {"20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","SmokeShell","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","20Rnd_650x39_Cased_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetSpecO_ghex_F","G_Sport_Checkered","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_65_TI_blk_F","","optic_DMS","","","","",""};
	};

	class EAST406
	{
		displayName = "Recon Paramedic";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "CombatLifeSaver";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTReconMedic_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_snds_F","hgun_Rook40_snds_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","SmokeShellRed","SmokeShellBlue","SmokeShellOrange"};
		items[] = {"FirstAidKit","Medikit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetSpecO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST407
	{
		displayName = "Recon Scout";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Rifleman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_ACO_pointer_snds_F","hgun_Rook40_snds_F","Binocular","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetSpecO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST408
	{
		displayName = "Recon Scout (AT)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MissileSpecialist";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTRPG_AT_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_snds_F","launch_RPG32_ghex_F","hgun_Rook40_snds_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","RPG32_F","RPG32_F","RPG32_HE_F","RPG32_HE_F"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetSpecO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST409
	{
		displayName = "Recon Team Leader";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Grenadier";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_ARCO_pointer_snds_F","hgun_Rook40_snds_F","Rangefinder","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessOGL_ghex_F","H_HelmetLeaderO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","muzzle_snds_58_blk_F","acc_pointer_IR","optic_Arco_blk_F","","","","",""};
	};

	class EAST410
	{
		displayName = "Sniper";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Marksman";
		show = "true";
		uniformClass = "U_O_T_Sniper_F";
		backpack = "";
		weapons[] = {"srifle_GM6_ghex_LRPS_F","hgun_Rook40_snds_F","Rangefinder","Throw","Put"};
		magazines[] = {"5Rnd_127x108_Mag","Chemlight_red","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","","","optic_LRPS_ghex_F","","","","",""};
	};

	class EAST411
	{
		displayName = "Spotter";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Marksman";
		show = "true";
		uniformClass = "U_O_T_Sniper_F";
		backpack = "";
		weapons[] = {"arifle_Katiba_ARCO_F","hgun_Rook40_snds_F","Laserdesignator_02","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","MiniGrenade","MiniGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","Chemlight_red"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","O_NVGoggles_ghex_F","","","optic_Arco_blk_F","","","","",""};
	};

//DLC CSAT marksmen
	class EAST412
	{
		displayName = "Heavy Gunner";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MachineGunner";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"MMG_01_tan_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","150Rnd_93x64_Mag","150Rnd_93x64_Mag"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_Arco","bipod_02_F_hex","","","",""};
	};

	class EAST413
	{
		displayName = "Sharpshooter";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Marksman";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "";
		weapons[] = {"srifle_DMR_05_KHS_LP_F","hgun_Rook40_F","Binocular","Throw","Put"};
		magazines[] = {"10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","HandGrenade","HandGrenade"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_HarnessO_ghex_F","H_HelmetO_ghex_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_KHS_blk","bipod_02_F_blk","","","",""};
	};

//DLC CSAT tanks
	class EAST414
	{
		displayName = "Asst. Heavy AT";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "Assistant";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_Carryall_ghex_OTAHAT_F";
		weapons[] = {"arifle_Katiba_ACO_pointer_F","hgun_Rook40_F","Rangefinder","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Vorona_HEAT","Vorona_HEAT"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacChestrig_oli_F","H_HelmetO_ghex_F","G_Aviator","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","acc_pointer_IR","optic_ACO_grn","","","","",""};
	};

	class EAST415
	{
		displayName = "Rifleman (Heavy AT)";
		icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
		role = "MissileSpecialist";
		show = "true";
		uniformClass = "U_O_T_Soldier_F";
		backpack = "B_FieldPack_ghex_OTHAT_F";
		weapons[] = {"arifle_Katiba_ACO_F","launch_O_Vorona_green_F","hgun_Rook40_F","Throw","Put"};
		magazines[] = {"30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red","Vorona_HEAT"};
		items[] = {"FirstAidKit"};
		linkedItems[] = {"V_TacVest_oli","H_HelmetO_ghex_F","G_Aviator","ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F","","","optic_ACO_grn","","","","",""};
	};
