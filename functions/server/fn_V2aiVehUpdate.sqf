/*
	Author: IvosH
	Modified: Auto-generated from SQF_SYNTAX_BEST_PRACTICES.md audit

	Description:
		Control condition of the continuously spawn AI vehicles
		aiVehW, aiArmW, aiCasW, aiVehE, aiArmE, aiCasE
		Pagal dokumentacijos rekomendacijas pakeista canMove į pozicijos delta stebėjimą

	Parameter(s):
		none

	Returns:
		nothing

	Dependencies:
		V2aiStart.sqf
		fn_V2aiVehicles.sqf
		fn_V2aiStuckCheck.sqf - naujai pridėta įstrigimo aptikimo funkcija

	Execution:
		[] spawn wrm_fnc_V2aiVehUpdate;
*/

if !( isServer ) exitWith {}; //run on the dedicated server or server host

objAAWr=false; objArtiWr=false; objAAEr=false; objArtiEr=false; objMortWr=false; objMortEr=false;//sector vehicles
if(missType>1&&AIon>0)then
{
	aiVehWr=false; aiArmWr=false; aiCasWr=false; aiVehEr=false; aiArmEr=false; aiCasEr=false;
	if (AIon>2) then {aiArmWr2=false; aiArmEr2=false;};
}; //AI vehicles

//infinite loop - pagal SQF geriausias praktikas naudojame aiškią while sintaksę
while {true} do 
{
	sleep 45; //Padidintas intervalas nuo 30 iki 45 sek. pagal našumo optimizavimo rekomendacijas
	
	//AI vehicles (autonomous, spawned at the base)
	if(missType>1&&AIon>0)then
	{
		call
		{
			if(aiVehWr)exitWith{};
			if(!alive aiVehW)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[aiVehW] call wrm_fnc_V2aiStuckCheck;
			if(aiVehW getHitPointDamage "hitGun"==1)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(aiVehW getHitPointDamage "hitTurret"==1)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(({alive _x} count (crew aiVehW))==0)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
		};
		
		call
		{
			if(aiArmWr)exitWith{};
			if(!alive aiArmW)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[aiArmW] call wrm_fnc_V2aiStuckCheck;
			if(aiArmW getHitPointDamage "hitGun"==1)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(aiArmW getHitPointDamage "hitTurret"==1)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(({alive _x} count (crew aiArmW))==0)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
		};
		
		call
		{
			if(aiVehEr)exitWith{};
			if(!alive aiVehE)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[aiVehE] call wrm_fnc_V2aiStuckCheck;
			if(aiVehE getHitPointDamage "hitGun"==1)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(aiVehE getHitPointDamage "hitTurret"==1)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(({alive _x} count (crew aiVehE))==0)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
		};
		
		call
		{
			if(aiArmEr)exitWith{};
			if(!alive aiArmE)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[aiArmE] call wrm_fnc_V2aiStuckCheck;
			if(aiArmE getHitPointDamage "hitGun"==1)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
			if(aiArmE getHitPointDamage "hitTurret"==1)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
			if(({alive _x} count (crew aiArmE))==0)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
		};
		
		if(AIon>2)then
		{
			call
			{
				if(aiArmWr2)exitWith{};
				if(!alive aiArmW2)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
				[aiArmW2] call wrm_fnc_V2aiStuckCheck;
				if(aiArmW2 getHitPointDamage "hitGun"==1)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				if(aiArmW2 getHitPointDamage "hitTurret"==1)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				if(({alive _x} count (crew aiArmW2))==0)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
			};
			
			call
			{
				if(aiArmEr2)exitWith{};
				if(!alive aiArmE2)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
				// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
				[aiArmE2] call wrm_fnc_V2aiStuckCheck;
				if(aiArmE2 getHitPointDamage "hitGun"==1)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
				if(aiArmE2 getHitPointDamage "hitTurret"==1)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
				if(({alive _x} count (crew aiArmE2))==0)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
			};
		};
		
		if(missType==3)then
		{
			call
			{
				if(aiCasWr)exitWith{};
				if(!alive aiCasW)exitWith{[3] spawn wrm_fnc_V2aiVehicle; aiCasWr=true;};
				// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
				[aiCasW] call wrm_fnc_V2aiStuckCheck;
			};
			
			call
			{
				if(aiCasEr)exitWith{};
				if(!alive aiCasE)exitWith{[6] spawn wrm_fnc_V2aiVehicle; aiCasEr=true;};
				// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
				[aiCasE] call wrm_fnc_V2aiStuckCheck;
			};
		};
	};
	
	//AAW (sector vehicles)
	call
	{
		if(!(getMarkerColor resAW!=""))exitWith{};
		if(objAAWr)exitWith{};
		if(!alive objAAW)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true; [9] remoteExec ["wrm_fnc_V2hints", 0, false];};
		// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
		[objAAW] call wrm_fnc_V2aiStuckCheck;
		if(objAAW getHitPointDamage "hitGun"==1)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true; [10] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objAAW getHitPointDamage "hitTurret"==1)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true; [10] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if((objAAW emptyPositions "Gunner" > 0)||(objAAW emptyPositions "Commander" > 0))exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true;};
		if(!someAmmo objAAW)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true;};
	};
	//AAE
	call
	{
		if(!(getMarkerColor resAE!=""))exitWith{};
		if(objAAEr)exitWith{};
		if(!alive objAAE)exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true; [11] remoteExec ["wrm_fnc_V2hints", 0, false];};
		// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
		[objAAE] call wrm_fnc_V2aiStuckCheck;
		if(objAAE getHitPointDamage "hitGun"==1)exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true; [12] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objAAE getHitPointDamage "hitTurret"==1)exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true; [12] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if((objAAE emptyPositions "Gunner" > 0)||(objAAE emptyPositions "Commander" > 0))exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true;};
		if(!someAmmo objAAE)exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true;};
	};
	
	//ArtiW
	call
	{
		if(!(getMarkerColor resBW!=""))exitWith{};
		if(objArtiWr)exitWith{};
		if(!alive objArtiW)exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true; [13] remoteExec ["wrm_fnc_V2hints", 0, false];};
		// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
		[objArtiW] call wrm_fnc_V2aiStuckCheck;
		if(objArtiW getHitPointDamage "hitGun"==1)exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true; [14] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objArtiW getHitPointDamage "hitTurret"==1)exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true; [14] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if((objArtiW emptyPositions "Gunner" > 0)||(objArtiW emptyPositions "Commander" > 0))exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true;};
		if(!someAmmo objArtiW)exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true;};
	};
	//ArtiE
	call
	{
		if(!(getMarkerColor resBE!=""))exitWith{};
		if(objArtiEr)exitWith{};
		if(!alive objArtiE)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [15] remoteExec ["wrm_fnc_V2hints", 0, false];};
		// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
		[objArtiE] call wrm_fnc_V2aiStuckCheck;
		if(objArtiE getHitPointDamage "hitGun"==1)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [16] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objArtiE getHitPointDamage "hitTurret"==1)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [16] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if((objArtiE emptyPositions "Gunner" > 0)||(objArtiE emptyPositions "Commander" > 0))exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true;};
		if(!someAmmo objArtiE)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true;};
	};
	
	if ((count mortW>0)||(count mortE>0)) then
	{
		//MortarW
		call
		{
			if(!(getMarkerColor resBW!=""))exitWith{};
			if(objMortWr)exitWith{};
			if(!alive objMortW)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true; [21] remoteExec ["wrm_fnc_V2hints", 0, false];};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[objMortW] call wrm_fnc_V2aiStuckCheck;
			if(objMortW getHitPointDamage "hitGun"==1)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true;};
			if(objMortW getHitPointDamage "hitTurret"==1)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true;};
			if((objMortW emptyPositions "Gunner" > 0)||(objMortW emptyPositions "Commander" > 0))exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true;};
			if(!someAmmo objMortW)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true;};
		};
		//MortarE
		call
		{
			if(!(getMarkerColor resBE!=""))exitWith{};
			if(objMortEr)exitWith{};
			if(!alive objMortE)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true; [22] remoteExec ["wrm_fnc_V2hints", 0, false];};
			// Pakeista canMove į pozicijos delta stebėjimą pagal dokumentacijos rekomendacijas
			[objMortE] call wrm_fnc_V2aiStuckCheck;
			if(objMortE getHitPointDamage "hitGun"==1)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if(objMortE getHitPointDamage "hitTurret"==1)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if((objMortE emptyPositions "Gunner" > 0)||(objMortE emptyPositions "Commander" > 0))exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if(!someAmmo objMortE)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
		};
	};


	if(DBG)then{["AI Vehicles update"] remoteExec ["systemChat", 0, false];};
};