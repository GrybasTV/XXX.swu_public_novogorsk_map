/*
	Author: IvosH
	
	Description:
		Control condition of the cotinuously spawn AI vehicles
		aiVehW, aiArmW, aiCasW, aiVehE, aiArmE, aiCasE
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		fn_V2aiVehicles.sqf
		
	Execution:
		[] spawn wrm_fnc_V2aiVehUpdate;
*/

if !( isServer ) exitWith {}; //run on the dedicated server or server host

//Inicijuojame mortar masyvus (saugumas - jei neapibrėžti frakcijų failuose)
if(isNil "mortW")then{mortW = [];};
if(isNil "mortE")then{mortE = [];};

objAAWr=false; objArtiWr=false; objAAEr=false; objArtiEr=false; objMortWr=false; objMortEr=false;//sector vehicles
if(missType>1&&AIon>0)then
{
	aiVehWr=false; aiArmWr=false; aiCasWr=false; aiVehEr=false; aiArmEr=false; aiCasEr=false;
	if (AIon>2) then {aiArmWr2=false; aiArmEr2=false;};
}; //AI vehicles

//infinite loop
for "_i" from 0 to 1 step 0 do 
{
	sleep 30; //30 sec default
	
	//AI vehicles (autonomous, spawned at the base)
	if(missType>1&&AIon>0)then
	{
		call
		{
			if(aiVehWr)exitWith{};
			if(!alive aiVehW)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(!canMove aiVehW)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(aiVehW getHitPointDamage "hitGun"==1)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(aiVehW getHitPointDamage "hitTurret"==1)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
			if(({alive _x} count (crew aiVehW))==0)exitWith{[1] spawn wrm_fnc_V2aiVehicle; aiVehWr=true;};
		};
		
		call
		{
			if(aiArmWr)exitWith{};
			if(!alive aiArmW)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(!canMove aiArmW)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(aiArmW getHitPointDamage "hitGun"==1)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(aiArmW getHitPointDamage "hitTurret"==1)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
			if(({alive _x} count (crew aiArmW))==0)exitWith{[2] spawn wrm_fnc_V2aiVehicle; aiArmWr=true;};
		};
		
		call
		{
			if(aiVehEr)exitWith{};
			if(!alive aiVehE)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(!canMove aiVehE)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(aiVehE getHitPointDamage "hitGun"==1)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(aiVehE getHitPointDamage "hitTurret"==1)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
			if(({alive _x} count (crew aiVehE))==0)exitWith{[4] spawn wrm_fnc_V2aiVehicle; aiVehEr=true;};
		};
		
		call
		{
			if(aiArmEr)exitWith{};
			if(!alive aiArmE)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
			if(!canMove aiArmE)exitWith{[5] spawn wrm_fnc_V2aiVehicle; aiArmEr=true;};
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
				if(!canMove aiArmW2)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				if(aiArmW2 getHitPointDamage "hitGun"==1)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				if(aiArmW2 getHitPointDamage "hitTurret"==1)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
				if(({alive _x} count (crew aiArmW2))==0)exitWith{[13] spawn wrm_fnc_V2aiVehicle; aiArmWr2=true;};
			};
			
			call
			{
				if(aiArmEr2)exitWith{};
				if(!alive aiArmE2)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
				if(!canMove aiArmE2)exitWith{[14] spawn wrm_fnc_V2aiVehicle; aiArmEr2=true;};
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
				if(!canMove aiCasW)exitWith{[3] spawn wrm_fnc_V2aiVehicle; aiCasWr=true;};
			};
			
			call
			{
				if(aiCasEr)exitWith{};
				if(!alive aiCasE)exitWith{[6] spawn wrm_fnc_V2aiVehicle; aiCasEr=true;};
				if(!canMove aiCasE)exitWith{[6] spawn wrm_fnc_V2aiVehicle; aiCasEr=true;};
			};
		};
	};
	
	//AAW (sector vehicles)
	call
	{
		if(!(getMarkerColor resAW!=""))exitWith{};
		if(objAAWr)exitWith{};
		if(!alive objAAW)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true; [9] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(!canMove objAAW)exitWith{[7] spawn wrm_fnc_V2aiVehicle; objAAWr=true; [10] remoteExec ["wrm_fnc_V2hints", 0, false];};
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
		if(!canMove objAAE)exitWith{[8] spawn wrm_fnc_V2aiVehicle; objAAEr=true; [12] remoteExec ["wrm_fnc_V2hints", 0, false];};
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
		if(!canMove objArtiW)exitWith{[9] spawn wrm_fnc_V2aiVehicle; objArtiWr=true; [14] remoteExec ["wrm_fnc_V2hints", 0, false];};
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
		if(!canMove objArtiE)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [16] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objArtiE getHitPointDamage "hitGun"==1)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [16] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if(objArtiE getHitPointDamage "hitTurret"==1)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true; [16] remoteExec ["wrm_fnc_V2hints", 0, false];};
		if((objArtiE emptyPositions "Gunner" > 0)||(objArtiE emptyPositions "Commander" > 0))exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true;};
		if(!someAmmo objArtiE)exitWith{[10] spawn wrm_fnc_V2aiVehicle; objArtiEr=true;};
	};
	
	if ((count mortW > 0)||(count mortE > 0)) then
	{
		//MortarW
		call
		{
			if(!(getMarkerColor resBW!=""))exitWith{};
			if(objMortWr)exitWith{};
			if(!alive objMortW)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true; [21] remoteExec ["wrm_fnc_V2hints", 0, false];};
			if(!canMove objMortW)exitWith{[11] spawn wrm_fnc_V2aiVehicle; objMortWr=true;};
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
			if(!canMove objMortE)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if(objMortE getHitPointDamage "hitGun"==1)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if(objMortE getHitPointDamage "hitTurret"==1)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if((objMortE emptyPositions "Gunner" > 0)||(objMortE emptyPositions "Commander" > 0))exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
			if(!someAmmo objMortE)exitWith{[12] spawn wrm_fnc_V2aiVehicle; objMortEr=true;};
		};
	};

	if(DBG)then{["AI Vehicles update"] remoteExec ["systemChat", 0, false];};
};