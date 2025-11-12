/*
Author: IvosH
- MISSION SETUP - 16
- VARIABLES - 21
- STRUCTURES - 36
- STRUCTURE SELECT - 75
- VEHICLES - 317
- SIDE SPECIFICATION - 819
- LOBBY PARAMETERS - 954
- BRIEFING - 989
- SERVER - 992
- LOADOUTS - 995
- ARSENAL - 1132
- CLIENT - 1211
*/

//MISSION SETUP
#include "WMinit.sqf";
systemChat "Terrain specifications loaded";

#include "V2factionsSetup.sqf";
systemChat "Factons selection read";

//VARIABLES
dSel = 0; //default dialog selection
AOcreated = 0; //area of operation is NOT selected
bExist = 0; //sector bravo is NOT created
cExist = 0; //sector charlie is NOT created
sideA = civilian;
sideD = civilian;
rTime = 100;

//MIN artillery range
artiRange = [830,1060]; //A3, GM
if(modA=="VN")then{artiRange = [741,826];};
if(modA=="CSLA")then{artiRange = [430,940];};
if(modA=="SPE")then{artiRange = [340,940];};
if(modA=="RHS")then{artiRange = [830,1060];};
if(modA=="IFA3")then{artiRange = [790,950];};

systemChat "Variables loaded";

//STRUCTURES--------------------------------------------------EDITABLE//
strAlpha=[];strBravo=[];strCharlie=[];
strFobWest=[];strBaseWest=[];strFobEast=[];strBaseEast=[];
strFobC="";strFob=[];
supplyW=[];supplyE=[];
flgW="";flgE="";
endW="";endE="";

//V2 CAS tower
tower = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"]; //A3, RHS, GM
if(modA=="IFA3")then{tower = ["LIB_Static_OpelBlitz_Radio","Land_Vysilac_FM2","LIB_Static_Zis6_Radar"];}; //IFA3
if(modA=="SPE")then{tower = ["Land_Communication_F"];};

//structures, buildings FOB / BASE
_grnCrStr=["Land_Cargo_House_V1_F","Land_Cargo_Patrol_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_Tower_V1_F"]; //cargo
_brwCrStr=["Land_Cargo_House_V3_F","Land_Cargo_Tower_V3_F","Land_Cargo_HQ_V3_F","Land_Cargo_Tower_V3_F"];
_junCrStr=["Land_Cargo_House_V4_F","Land_Cargo_Patrol_V4_F","Land_Cargo_HQ_V4_F","Land_Cargo_Tower_V4_F"];
_desBgStr=["Land_BagBunker_Large_F","Land_BagBunker_Small_F"]; //bags
_junBgStr=["Land_BagBunker_01_large_green_F","Land_BagBunker_01_small_green_F"];
_desHbStr=["Land_BagBunker_Tower_F","Land_HBarrierTower_F"]; //hesco
_junHbStr=["Land_HBarrier_01_tower_green_F","Land_HBarrier_01_big_tower_green_F"];
_ifaBgStr=["Land_BagBunker_Large_F","Land_BagBunker_Small_F"];
_gmBgStr=["gm_gc_tent_5x5m","land_gm_woodbunker_01_bags","land_gm_sandbags_02_bunker_high","land_gm_euro_deerstand_01","land_gm_woodbunker_01"]; //global mobilisation
_vnBgStr=["Land_vn_bunker_big_01","Land_vn_bunker_big_02","Land_vn_bunker_small_01","Land_vn_pillboxbunker_01_big_f","Land_vn_b_trench_firing_01"]; //SOG prairie fire
_speBgStr=["Land_BagBunker_Small_F","Land_BagBunker_Large_F"];

//fortification corners FOB
_desCorFor="Land_HBarrierWall_corner_F";
_junCorFor="Land_HBarrier_01_wall_corner_green_F";
_ifaCorFor="Land_fort_bagfence_corner";
_vnCorFor="Land_vn_czechhedgehog_01_f"; //"Land_vn_b_trench_90_02"
_cslaCorFor="Land_csla_jehlan_cs";
_speCorFor="Land_CzechHedgehog_01_old_F";

//fortification linear FOB
_desLinFor=["Land_HBarrier_5_F", "Land_Barricade_01_10m_F"];
_junLinFor=["Land_HBarrier_01_line_5_green_F", "Land_Barricade_01_10m_F"];
_ifaLinFor=["Land_Barricade_01_10m_F","Land_BagFence_Long_F"];
_gmLinFor=["land_gm_sandbags_01_wall_01","Land_HBarrier_5_F"]; //"land_gm_sandbags_02_wall"
_vnLinFor=["Land_vn_b_trench_revetment_05_01", "Land_Barricade_01_10m_F"]; //"Land_vn_czechhedgehog_01_f"
_cslaLinFor=["Land_csla_wood_baricade_big","Land_csla_wood_baricade_small","Land_csla_wood_baricade_small2","Land_Barricade_01_10m_F"];
_speLinFor=["Land_SPE_Sandbag_Long"];

//STRUCTURE SELECT
//basic NATO vs CSAT
strFobWest=_desBgStr+_desHbStr;
strFobEast=_desBgStr+_desHbStr;
strFobC=_desCorFor;
strFob=_desLinFor;

if(env=="jungle")then
{
	strFobWest=_junBgStr+_junHbStr;
	strFobEast=strFobWest;
	strFobC=_junCorFor;
	strFob=_junLinFor;
};

if(modA=="A3")then
{
	if(env=="jungle")then
	{
		strFobWest=strFobWest+_junCrStr;
		strFobEast=strFobWest;
	}else
	{
		if(env=="woodland")then
		{
			strFobWest=strFobWest+_grnCrStr;
			strFobEast=strFobWest;
		}else
		{
			if(factionE=="CSAT")then
			{
				strFobWest=strFobWest+_grnCrStr;
				strFobEast=strFobEast+_brwCrStr;	
			}else
			{
				strFobWest=strFobWest+_brwCrStr;
				strFobEast=strFobEast+_grnCrStr;
			};
		};
	};	
};

if(modA=="GM")then
{
	strFobWest = _gmBgStr+_desHbStr;
	strFobEast = strFobWest;
};

if(modA=="VN")then
{
	strFobWest = _vnBgStr;
	strFobEast = strFobWest;
	strFobC=_vnCorFor;
	strFob=_vnLinFor;
};

if(modA=="WS")then
{
	call
	{
		if(env=="desert"||env=="arid")exitWith
		{
			strFobWest=strFobWest+_brwCrStr;
			strFobEast=strFobWest;
		};
		if(env=="woodland"||env=="winter")exitWith
		{
			strFobWest=strFobWest+_grnCrStr;
			strFobEast=strFobWest;
		};
		if(env=="jungle")exitWith
		{
			strFobWest=strFobWest+_junCrStr;
			strFobEast=strFobWest;
		};
	};
};
if(modA=="CSLA")then
{
	strFobWest=_desBgStr;
	strFobEast=strFobWest;
	strFobC=_desCorFor;
	strFob=_desLinFor;
	strFobC=_cslaCorFor;
	strFob=_cslaLinFor;

	if(env=="jungle")then
	{
		strFobWest=_junBgStr;
		strFobEast=strFobWest;
	};
};
if(modA=="RHS")then
{
	if(env=="desert")then
	{
		strFobWest=strFobWest+_brwCrStr;
		strFobEast=strFobWest;
	};
	if(env=="arid")then
	{
		strFobWest=strFobWest+_brwCrStr;
		strFobEast=strFobEast+_grnCrStr;
	};
	if(env=="woodland"||env=="winter")then
	{
		strFobWest=strFobWest+_grnCrStr;
		strFobEast=strFobWest;
	};
	if(env=="jungle")then
	{
		strFobWest=strFobWest+_junCrStr;
		strFobEast=strFobWest;
	};
};

if(modA=="IFA3")then
{
	strFobWest = _ifaBgStr;
	strFobEast = strFobWest;
	strFobC=_ifaCorFor;
	strFob=_ifaLinFor;
};

if(modA=="SPE")then
{
	strFobWest = _speBgStr;
	strFobEast = strFobWest;
	strFobC=_speCorFor;
	strFob=_speLinFor;
};

strBaseWest = strFobWest;
strBaseEast = strFobWest;

systemChat "Structures loaded";

//FACTIONS SELECT--------------------------------------------------EDITABLE//
BikeW=[];CarW=[];CarDlcW=[];CarArW=[];CarArDlcW=[];TruckW=[];ArmorW1=[];ArmorW2=[];ArmorDlcW2=[];HeliTrW=[];HeliTrDlcW=[];HeliArW=[];PlaneW=[];PlaneDlcW=[];aaW=[];artiW=[];crewW="";boatTrW=[];boatArW=[];divEw=[];divWw="";divMw="";uavsW=[];uavsDlcW=[];uavsDlc2W=[];ugvsW=[];

BikeE=[];CarE=[];CarDlcE=[];CarArE=[];CarArDlcE=[];TruckE=[];ArmorE1=[];ArmorE2=[];ArmorDlcE2=[];HeliTrE=[];HeliTrDlcE=[];HeliArE=[];PlaneE=[];PlaneDlcE=[];aaE=[];artiE=[];crewE="";boatTrE=[];boatArE=[];divEe=[];divWe="";divMe="";uavsE=[];uavsDlcE=[];ugvsE=[];

call
{
	if(modA=="A3")exitWith
	{
		if(factionW=="NATO")then
		{
			if(env=="desert"||env=="arid"||env=="winter")then{
			#include "factions\A3_NATO_A_V.hpp";
			};
			if(env=="woodland"||env=="jungle")then{
			#include "factions\A3_NATO_J_V.hpp";
			};
		};
		
		if(factionE=="CSAT")then
		{			
			if(env=="desert"||env=="arid"||env=="winter")then{
			#include "factions\A3_CSAT_A_V.hpp";
			};
			if(env=="woodland"||env=="jungle")then{
			#include "factions\A3_CSAT_J_V.hpp";
			};
		};
	
		if(factionW=="AAF")
		then{
		#include "factions\A3_AAF_W_V_w.hpp";
		};
		
		if(factionE=="AAF")
		then{
		#include "factions\A3_AAF_W_V_e.hpp";
		};
		
		if(factionW=="LDF")
		then{
		#include "factions\A3_LDF_W_V_w.hpp";
		};	
		
		if(factionE=="LDF")
		then{
		#include "factions\A3_LDF_W_V_e.hpp";
		};
	};

	if(modA=="GM")exitWith
	{
		if(factionW=="West Germany"||factionW=="West Germany 90")then
		{
			if(env!="winter")
			then{
			#include "factions\GM_WestGermany_W_V.hpp";
			}
			else{
			#include "factions\GM_WestGermany_S_V.hpp";
			};
		};
		
		if(factionE=="East Germany")then
		{
			if(env!="winter")
			then{
			#include "factions\GM_EastGermany_W_V.hpp";
			}
			else{
			#include "factions\GM_EastGermany_S_V.hpp";
			};
		};
		
	};

	if(modA=="VN")exitWith
	{
		if(factionW=="US Army")
		then{
		#include "factions\VN_USarmy_J_V.hpp";
		};
		
		if(factionE=="PAVN")
		then{
		#include "factions\VN_PAVN_J_V.hpp";
		};
	};
	
	if(modA=="WS")exitWith
	{
		#include "factions\WS_NATO_D_V.hpp";
		#include "factions\WS_SFIA_D_V.hpp";
	};
	
	if(modA=="CSLA")exitWith
	{
		if(factionW=="US Army")
		then{
			if(env=="woodland"||env=="jungle"||env=="winter"||env=="arid")
			then{
			#include "factions\CSLA_USarmy_W_V.hpp";
			};
			
			if(env=="desert")
			then{
			#include "factions\CSLA_USarmy_D_V.hpp";
			};
		};
		
		if(factionE=="CSLA")
		then{
			if(env=="woodland"||env=="jungle"||env=="winter"||env=="arid")
			then{
			#include "factions\CSLA_CSLA_W_V.hpp";
			};
			
			if(env=="desert")
			then{
			#include "factions\CSLA_CSLA_D_V.hpp";
			};
		};
	};
	
	if(modA=="SPE")exitWith
	{
		#include "factions\SPE_Wehrmacht_W_V.hpp";
		#include "factions\SPE_USarmy_W_V.hpp";
	};
	
	if(modA=="RHS")exitWith
	{
		if(factionW=="USAF")then
		{
			if(env=="desert"||env=="arid")
			then{
			#include "factions\RHS_USAF_D_V.hpp";
			};
			
			if(env=="woodland"||env=="jungle")
			then{
			#include "factions\RHS_USAF_W_V.hpp";
			};
			
			if(env=="winter")
			then{
			#include "factions\RHS_USAF_S_V.hpp";
			};
		};
		
		if(factionE=="AFRF")then
		{
			if(env=="desert")
			then{
			#include "factions\RHS_AFRF_D_V.hpp";
			};
			
			if(env=="arid"||env=="winter")
			then{
			#include "factions\RHS_AFRF_A_V.hpp";
			};
			
			if(env=="woodland"||env=="jungle")
			then{
			#include "factions\RHS_AFRF_W_V.hpp";
			};
		};		
	};

	if(modA=="IFA3")exitWith
	{
		if(factionW=="Wehrmacht")then
		{
			if(env!="winter")
			then{
			#include "factions\IFA3_Wehrmacht_W_V.hpp";
			}
			else{
			#include "factions\IFA3_Wehrmacht_S_V.hpp";
			};
		};
		
		if(factionW=="Afrikakorps")
		then{
		#include "factions\IFA3_Afrikakorps_D_V.hpp";
		};
		
		if(factionE=="Red army")then
		{
			if(env!="winter")
			then{
			#include "factions\IFA3_RedArmy_W_V.hpp";
			}
			else{
			#include "factions\IFA3_RedArmy_S_V.hpp";
			};			
		};
		
		if(factionE=="UK Army")then
		{
			if(env!="winter")
			then{
			#include "factions\IFA3_UKarmy_W_V.hpp";
			}
			else{
			#include "factions\IFA3_UKarmy_S_V.hpp";
			};
		};
		
		if(factionE=="Desert rats")
		then{
		#include "factions\IFA3_DesertRats_D_V.hpp";
		};
		
		if(factionE=="US Army")then
		{
			if(env!="winter")
			then{
			#include "factions\IFA3_USarmy_W_V.hpp";
			}
			else{
			#include "factions\IFA3_USarmy_S_V.hpp";
			};
		};
	};

	if(modA=="UA2025_RU2025")exitWith
	{
		if(factionW=="Ukraine 2025")then
		{
			#include "factions\UA2025_RHS_W_V.hpp";
		};

		if(factionE=="Russia 2025")then
		{
			#include "factions\RU2025_RHS_W_V.hpp";
		};
	};

};
systemChat "Vehicles loaded";

//SIDE SPECIFICATION
call
{
	if (sideW == west) exitWith 
	{
		colorW = "colorBLUFOR"; 
		iconW = "b_hq"; 
		resStartW = "respawn_west_start"; 
		resBaseW = "respawn_west_base";
		resBaseEW = "respawn_west_baseE";
		resFobW = "respawn_west_fob"; 
		resFobEW = "respawn_west_fobE";
		resAW = "respawn_west_a"; 
		resBW = "respawn_west_b"; 
		resCW = "respawn_west_c"; 
	};
	if (sideW == east) exitWith 
	{
		colorW = "colorOPFOR";
		iconW = "o_hq";
		resStartW = "respawn_east_start";
		resBaseW = "respawn_east_base";
		resBaseEW = "respawn_east_baseE";
		resFobW = "respawn_east_fob";
		resFobEW = "respawn_east_fob";
		resAW = "respawn_east_a";
		resBW = "respawn_east_b";
		resCW = "respawn_east_c";
	};
	if (sideW == independent) exitWith 
	{
		colorW = "colorIndependent";
		iconW = "n_hq";
		resStartW = "respawn_guerrila_start";
		resBaseW = "respawn_guerrila_base";
		resBaseEW = "respawn_guerrila_baseE";
		resFobW = "respawn_guerrila_fob";
		resFobEW = "respawn_guerrila_fobE";
		resAW = "respawn_guerrila_a";
		resBW = "respawn_guerrila_b";
		resCW = "respawn_guerrila_c";
	};
};
call
{
	if (sideE == west) exitWith 
	{
		colorE = "colorBLUFOR";
		iconE = "b_hq";
		resStartE = "respawn_west_start";
		resBaseE = "respawn_west_base";
		resBaseWE = "respawn_west_baseW";
		resFobE = "respawn_west_fob";
		resFobWE = "respawn_west_fobW";
		resAE = "respawn_west_a";
		resBE = "respawn_west_b";
		resCE = "respawn_west_c";
	};
	if (sideE == east) exitWith 
	{
		colorE = "colorOPFOR";
		iconE = "o_hq";
		resStartE = "respawn_east_start";
		resBaseE = "respawn_east_base";
		resBaseWE = "respawn_east_baseW";
		resFobE = "respawn_east_fob";
		resFobWE = "respawn_east_fobW";
		resAE = "respawn_east_a";
		resBE = "respawn_east_b";
		resCE = "respawn_east_c";
	};
	if (sideE == independent) exitWith 
	{
		colorE = "colorIndependent";
		iconE = "n_hq";
		resStartE = "respawn_guerrila_start";
		resBaseE = "respawn_guerrila_base";
		resBaseWE = "respawn_guerrila_baseW";
		resFobE = "respawn_guerrila_fob";
		resFobWE = "respawn_guerrila_fobW";
		resAE = "respawn_guerrila_a";
		resBE = "respawn_guerrila_b";
		resCE = "respawn_guerrila_c";
	};
};

fobW = format ["FOB %1", factionW];
fobE = format ["FOB %1", factionE];
baseW = format ["BASE %1", factionW];
baseE = format ["BASE %1", factionE];
taskW = format ["Secure %1 forward operating base", factionW];
taskE = format ["Secure %1 forward operating base", factionE];
systemChat "Sides loaded";

//LOBBY PARAMETERS
if(modA=="A3")then
{
	if ("apexOn" call BIS_fnc_getParamValue == 0||island == "TANOA") then 
	{
		CarW = CarW + CarDlcW;
		CarArW = CarArW + CarArDlcW;
		CarE = CarE + CarDlcE;
		CarArE = CarArE + CarArDlcE;
		uavsW = uavsW + uavsDlcW;
		uavsE = uavsE + uavsDlcE;
	};

	if ("heliOn" call BIS_fnc_getParamValue == 0) then 
	{
		HeliTrE = HeliTrE + HeliTrDlcE;
	};

	if ("jetsOn" call BIS_fnc_getParamValue == 0) then 
	{
		PlaneW = PlaneW + PlaneDlcW;
		PlaneE = PlaneE + PlaneDlcE;
		uavsW = uavsW + uavsDlc2W;
	};
	if ("TankOn" call BIS_fnc_getParamValue == 0) then 
	{
		ArmorW2 = ArmorW2 + ArmorDlcW2;
		ArmorE2 = ArmorE2 + ArmorDlcE2;
	};
};
systemChat "Lobby parameters read";

//DEBUG (V2)
DBG = false; 
if ("DebugOn" call BIS_fnc_getParamValue == 0) then {DBG = true; systemChat "Debug messages ON";};

//ADD BRIEFING
call compile preProcessFileLineNumbers "diary.sqf";
systemChat "Briefing loaded";

//SERVER
if(isServer)then
{	
	//LOADOUTS--------------------------------------------------EDITABLE//
	call
	{
		_Load="";_n1=0;_n2=0;
		if(modA=="A3")exitWith
		{
			//sideW
			call
			{
				if(factionW=="NATO"&&(env=="desert"||env=="arid"||env=="winter"))exitWith{_Load="WEST%1";_n1=1;_n2=41;};
				if(factionW=="NATO"&&env=="woodland")exitWith{_Load="WEST%1";_n1=49;_n2=79;};
				if(factionW=="NATO"&&env=="jungle")exitWith{_Load="WEST%1";_n1=83;_n2=132;};
				if(factionW=="AAF")exitWith{_Load="GUER%1";_n1=1;_n2=33;};
				if(factionW=="LDF")exitWith{_Load="GUER%1";_n1=38;_n2=70;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			call
			{
				if(factionE=="CSAT"&&(env=="desert"||env=="arid"||env=="winter"))exitWith{_Load="EAST%1";_n1=1;_n2=41;};
				if(factionE=="CSAT"&&env=="woodland")exitWith{_Load="EAST%1";_n1=371;_n2=411;};
				if(factionE=="CSAT"&&env=="jungle")exitWith{_Load="EAST%1";_n1=50;_n2=98;};
				if(factionE=="AAF")exitWith{_Load="GUER%1";_n1=1;_n2=33;};
				if(factionE=="LDF")exitWith{_Load="GUER%1";_n1=38;_n2=70;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//marksmen DLC - A3, arid, woodland (altis, stratis, malden, livonia)
			if ("markOn" call BIS_fnc_getParamValue == 0) then 
			{
				call //sideW
				{
					if(factionW=="NATO"&&(env=="desert"||env=="arid"||env=="winter"))exitWith{_Load="WEST%1";_n1=42;_n2=47;};
					if(factionW=="NATO"&&env=="woodland")exitWith{_Load="WEST%1";_n1=80;_n2=82;};
					if(factionW=="NATO"&&env=="jungle")exitWith{_Load="WEST%1";_n1=133;_n2=138;};
					if(factionW=="AAF")exitWith{_Load="GUER%1";_n1=34;_n2=36;};
					if(factionW=="LDF")exitWith{_Load="GUER%1";_n1=71;_n2=73;};
					if(factionW=="LDF")exitWith{_Load="GUER%1";_n1=71;_n2=73;};
				};
				for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
				
				call //sideE
				{
					if(factionE=="CSAT"&&(env=="desert"||env=="arid"||env=="winter"))exitWith{_Load="EAST%1";_n1=42;_n2=47;};
					if(factionE=="CSAT"&&env=="woodland")exitWith{_Load="EAST%1";_n1=412;_n2=413;};
					if(factionE=="CSAT"&&env=="jungle")exitWith{_Load="EAST%1";_n1=99;_n2=106;};
					if(factionE=="AAF")exitWith{_Load="GUER%1";_n1=34;_n2=36;};
					if(factionE=="LDF")exitWith{_Load="GUER%1";_n1=71;_n2=73;};
				};
				for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			};			
			//tanks DLC - A3, arid, jungle (altis, stratis, malden, tanoa)
			if ("TankOn" call BIS_fnc_getParamValue == 0) then 
			{
				call //sideW
				{
					if(factionW=="NATO"&&env!="jungle")exitWith{_Load="WEST%1";_n1=48;_n2=48;};
					if(factionW=="NATO"&&env=="jungle")exitWith{_Load="WEST%1";_n1=139;_n2=139;};
					if(factionW=="AAF")exitWith{_Load="GUER%1";_n1=37;_n2=37;};
					if(factionW=="LDF")exitWith{_Load="GUER%1";_n1=74;_n2=74;};
				};
				for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		
				call //sideE
				{
					if(factionE=="CSAT"&&(env=="desert"||env=="arid"||env=="winter"))exitWith{_Load="EAST%1";_n1=48;_n2=49;};
					if(factionE=="CSAT"&&env=="woodland")exitWith{_Load="EAST%1";_n1=414;_n2=415;};
					if(factionE=="CSAT"&&env=="jungle")exitWith{_Load="EAST%1";_n1=107;_n2=108;};
					if(factionE=="AAF")exitWith{_Load="GUER%1";_n1=37;_n2=37;};
					if(factionE=="LDF")exitWith{_Load="GUER%1";_n1=74;_n2=74;};
				};
				for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			};
		};
		
		if(modA=="RHS")exitWith
		{
			//sideW
			call
			{
				if(factionW=="USAF"&&(env=="woodland"||env=="jungle"))exitWith{_Load="WEST%1";_n1=140;_n2=198;};
				if(factionW=="USAF"&&(env=="desert"||env=="arid"))exitWith{_Load="WEST%1";_n1=199;_n2=236;};
				if(factionW=="USAF"&&env=="winter")exitWith{_Load="WEST%1";_n1=237;_n2=276;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			call
			{
				if(factionE=="AFRF"&&(env=="woodland"||env=="jungle"))exitWith{_Load="EAST%1";_n1=109;_n2=154;};
				if(factionE=="AFRF"&&env=="desert")exitWith{_Load="EAST%1";_n1=155;_n2=185;};
				if(factionE=="AFRF"&&(env=="arid"||env=="winter"))exitWith{_Load="EAST%1";_n1=186;_n2=218;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
		
		if(modA=="IFA3")exitWith
		{
			//sideW
			call
			{
				if(factionW=="Wehrmacht"&&env!="winter")exitWith{_Load="WEST%1";_n1=277;_n2=315;};
				if(factionW=="Wehrmacht"&&env=="winter")exitWith{_Load="WEST%1";_n1=316;_n2=350;};
				if(factionW=="Afrikakorps")exitWith{_Load="WEST%1";_n1=351;_n2=369;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			call
			{
				if(factionE=="Red army"&&env!="winter")exitWith{_Load="EAST%1";_n1=219;_n2=259;};
				if(factionE=="Red army"&&env=="winter")exitWith{_Load="EAST%1";_n1=260;_n2=293;};
				if(factionE=="UK Army"&&env!="winter")exitWith{_Load="GUER%1";_n1=75;_n2=92;};
				if(factionE=="UK Army"&&env=="winter")exitWith{_Load="GUER%1";_n1=142;_n2=153;};
				if(factionE=="Desert rats")exitWith{_Load="GUER%1";_n1=93;_n2=105;};
				if(factionE=="US Army"&&env!="winter")exitWith{_Load="GUER%1";_n1=106;_n2=123;};
				if(factionE=="US Army"&&env=="winter")exitWith{_Load="GUER%1";_n1=124;_n2=141;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
		
		if(modA=="GM")exitWith
		{
			//sideW
			call
			{
				if(factionW=="West Germany"&&env!="winter")exitWith{_Load="WEST%1";_n1=370;_n2=387;};
				if(factionW=="West Germany"&&env=="winter")exitWith{_Load="WEST%1";_n1=398;_n2=415;}; 
				if(factionW=="West Germany 90"&&env!="winter")exitWith{_Load="WEST%1";_n1=425;_n2=440;};
				if(factionW=="West Germany 90"&&env=="winter")exitWith{_Load="WEST%1";_n1=441;_n2=457;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			call
			{
				if(factionE=="East Germany"&&env!="winter")exitWith{_Load="EAST%1";_n1=294;_n2=310;};
				if(factionE=="East Germany"&&env=="winter")exitWith{_Load="EAST%1";_n1=321;_n2=338;};
			};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
		
		if(modA=="VN")exitWith
		{
			//sideW
			if(factionW=="US Army")then{_Load="WEST%1";_n1=458;_n2=485;};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			if(factionE=="PAVN")then{_Load="EAST%1";_n1=349;_n2=370;};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
		
		if(modA=="WS")exitWith
		{
			//sideW

			if(factionW=="NATO")then{_Load="WEST%1";_n1=486;_n2=528;};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			//DLC NATO marksmen
			if ("markOn" call BIS_fnc_getParamValue == 0) then
			{
				_Load="WEST%1";_n1=529;_n2=529;
				for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			};
			
			//sideE
			if(factionE=="SFIA")then{_Load="EAST%1";_n1=416;_n2=435;};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			//DLC NATO marksmen
			if ("markOn" call BIS_fnc_getParamValue == 0) then
			{
				_Load="EAST%1";_n1=436;_n2=436;
				for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			};
		};
		
		if(modA=="CSLA")exitWith
		{
			//sideW
			if(factionW=="US Army")then{_Load="WEST%1";_n1=530;_n2=557;};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			if(factionE=="CSLA")then{_Load="EAST%1";_n1=437;_n2=478;};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
		
		if(modA=="SPE")exitWith
		{
			//sideW
			if(factionW=="Wehrmacht")then{_Load="WEST%1";_n1=558;_n2=591;};
			for "_i" from _n1 to _n2 step 1 do {[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
			
			//sideE
			if(factionE=="US Army")then{_Load="GUER%1";_n1=154;_n2=179;};
			for "_i" from _n1 to _n2 step 1 do {[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;};
		};
	};
	["Loadouts ready"] remoteExec ["systemChat", 0, false];
	
	//ARSENAL
	if ("Param2" call BIS_fnc_getParamValue > 0)then 
	{
		AmmoW = (selectRandom supplyW) createVehicle (getMarkerPos "respawn_west_start");
		AmmoW setDir (markerDir "respawn_west_start");
		AmmoW setPos (AmmoW getRelPos [12, 0]);
		publicVariable "AmmoW";

		clearItemCargoGlobal AmmoW;
		clearMagazineCargoGlobal AmmoW;
		clearWeaponCargoGlobal AmmoW;
		clearBackpackCargoGlobal AmmoW;

		AmmoE = (selectRandom supplyE) createVehicle (getMarkerPos "respawn_east_start");
		AmmoE setDir (markerDir "respawn_east_start");
		AmmoE setPos (AmmoE getRelPos [12, 0]);
		publicVariable "AmmoE";

		clearItemCargoGlobal AmmoE;
		clearMagazineCargoGlobal AmmoE;
		clearWeaponCargoGlobal AmmoE;
		clearBackpackCargoGlobal AmmoE;
		call
		{
			if ("Param2" call BIS_fnc_getParamValue == 1)exitWith
			{		
				["AmmoboxInit",AmmoW] spawn BIS_fnc_arsenal;
				["AmmoboxInit",AmmoE] spawn BIS_fnc_arsenal;
			};
			
			if ("Param2" call BIS_fnc_getParamValue == 2)exitWith
			{
				["AmmoboxInit",[AmmoW,true]] spawn BIS_fnc_arsenal;
				["AmmoboxInit",[AmmoE,true]] spawn BIS_fnc_arsenal;
			};
		};
	};
	["Arsenal boxes created"] remoteExec ["systemChat", 0, false];
	
	//Change AI units by the Faction 
	#include "V2factionChange.sqf";
	
	//RESPAWN EVENT HANDLER, tels what will playable unit do after respawn 
	{_x addMPEventHandler
		["MPRespawn", 
			{
				params ["_unit","_corpse"];
				if(version==2)then{[_unit,_corpse] spawn wrm_fnc_V2respawnEH;}else{[_unit] spawn wrm_fnc_respawnEH;};
			}
		];
	} forEach playableUnits;
	
	//killed event handler
	_unW=[]; _unE=[]; 
	{
		call
		{
			if(side _x==sideW)exitWith{_unW pushBackUnique _x;};
			if(side _x==sideE)exitWith{_unE pushBackUnique _x;};
		};
	} forEach playableUnits;

	{ _x addMPEventHandler
		["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
	} forEach _unW;

	{ _x addMPEventHandler
		["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
	} forEach _unE;
	["Event handlers loaded"] remoteExec ["systemChat", 0, false];
	
	//names of the bases V2
	//_t="Transport";
	//if(modA=="A3")then{_t="Transport, UAV";};
	nameBW1 = format ["%1 Transport base",factionW]; publicvariable "nameBW1";
	nameBW2 = format ["%1 Armor base",factionW]; publicvariable "nameBW2";
	nameBE1 = format ["%1 Transport base",factionE]; publicvariable "nameBE1";
	nameBE2 = format ["%1 Armor base",factionE]; publicvariable "nameBE2";
	["Server initialised"] remoteExec ["systemChat", 0, false];
};
	
//CLIENT
if(hasInterface)then
{
	#include "V2playerSideChange.sqf";
	//[] execVM "V2playerSideChange.sqf";
	
	//ARSENAL
	if ("Param2" call BIS_fnc_getParamValue == 1)then
	{			
		if(progress<2)then
		{
			[AmmoW,sideW] call wrm_fnc_arsInit; //preload arsenal
			[AmmoE,sideE] call wrm_fnc_arsInit;
		};
	};
	systemChat "Arsenal loaded";
	//hint, informations for players
	if (progress<2) then
	{
		sleep 1;
		_a="Wait for the admin to create a mission";_b="";_c="";
		call
		{
			if("wmgenerator" call BIS_fnc_getParamValue == 2)exitWith{_a="MISSION GENERATOR<br/>is available in the action menu";}; //2
			if(serverCommandAvailable "#kick")exitWith{_a="MISSION GENERATOR<br/>is available in the action menu";}; //0
			if(("wmgenerator" call BIS_fnc_getParamValue == 1)&&(count(allPlayers - entities "HeadlessClient_F")==1))exitWith{_a="MISSION GENERATOR<br/>is available in the action menu";}; //1
		};
		if("param2" call BIS_fnc_getParamValue != 0)then{_b="<br/><br/>VIRTUAL ARSENAL<br/>is accessible at the supply box";};
		if !(isPlayer leader player) then {_c="<br/><br/>BECOME SQUAD LEADER<br/>(actions menu)<br/><br/>Recommended. Squad will follow you. Allows access to: Squad command | Artillery | CAS | Air drop | Build fortifications";};
	
		hint parseText format ["%1%2%3",_a,_b,_c];
	};
	systemChat "Client initialised";
	
	//Units placed by ZEUS will respawn 
	z1 addEventHandler ["CuratorObjectPlaced", {
		params ["_curator", "_entity"];
		[_entity] call wrm_fnc_V2entityPlaced;	
	}];
	
	z1 addEventHandler ["CuratorObjectDeleted", {
		params ["_curator", "_entity"];
		if((count units group _entity)==0)then{group _entity deleteGroupWhenEmpty true;};
	}];
};

systemChat "Initialisation successful";