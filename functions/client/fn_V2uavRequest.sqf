/*
Author: IvosH

Description:
	Add actions for UAV request
	obj = uavW, uavE, ugvW, ugvE
	[] = uavsW, ugvsW, uavsE, ugvsE
	
Parameter(s):
	0: NUMBER type of the UAV/UGV
	1: SIDE	player side

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf

Execution:
	[] spawn wrm_fnc_V2uavRequest
*/

_typ = _this select 0;
_sde = _this select 1;

call
{
	//UAV
	if(_typ==0)exitWith
	{
		//Patikrinti, ar tai Ukraine/Russia frakcija - jei taip, naudoti grupės-based sistemą
		_isUkraineRussia = (modA=="UA2025_RU2025" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"));
		
		if(_isUkraineRussia)then
		{
			//Grupės-based sistema Ukraine/Russia frakcijoms
			_grp = group player;
			_grpId = str _grp; //Unikalus grupės identifikatorius
			
			call
			{
				if(_sde==sideW)exitWith
				{
					//Patikrinti, ar grupė jau turi aktyvų UAV - naudojame param saugesniam masyvo elementų pasiekimui
					_groupUavIndex = uavGroupObjects findIf {(_x param [0, ""]) == _grpId};
					if(_groupUavIndex != -1)then
					{
						_groupUav = uavGroupObjects param [_groupUavIndex, []] param [1, objNull];
						if(!isNull _groupUav && alive _groupUav)exitWith{hint "Your squad already has an active UAV";};
					};
					
					//Patikrinti cooldown - naudojame param saugesniam masyvo elementų pasiekimui
					_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};
					if(_groupCooldownIndex != -1)then
					{
						_groupCooldown = uavGroupCooldowns param [_groupCooldownIndex, []] param [1, 0];
						if(_groupCooldown > 0)exitWith
						{
							_t = _groupCooldown; _s = "sec";
							if(_groupCooldown >= 60)then{_t = floor (_groupCooldown / 60); _s = "min";};
							hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
						};
					};
					
					//Papildomas tikrinimas: patikrinti, ar grupė jau turi aktyvų UAV prieš sukurdamas naują
					//Tai apsaugo nuo greitų paspaudimų, kurie gali sukurti kelis UAV
					_groupUavIndex = uavGroupObjects findIf {(_x param [0, ""]) == _grpId};
					if(_groupUavIndex != -1)then
					{
						_groupUav = uavGroupObjects param [_groupUavIndex, []] param [1, objNull];
						if(!isNull _groupUav && alive _groupUav)exitWith{hint "Your squad already has an active UAV";};
					};
					
					//Sukurti UAV virš žaidėjo galvos
					_playerPos = getPos player;
					_uavSpawnPos = [_playerPos param [0, 0], _playerPos param [1, 0], (_playerPos param [2, 0]) + 100]; //100m virš žaidėjo galvos
					_groupUav = createVehicle [(selectRandom uavsW), _uavSpawnPos, [], 0, "FLY"];
					createVehicleCrew _groupUav;
					
					//Išsaugoti grupės UAV masyve serverio pusėje
					//Serverio pusėje bus papildomas tikrinimas, ar grupė jau turi aktyvų UAV
					[_grpId, _groupUav] remoteExec ["wrm_fnc_V2uavGroupAdd", 2, false];
					
					//Pridėti event handler, kad sunaikinus UAV pradėtų cooldown
					_groupUav addMPEventHandler ["MPKilled", {
						params ["_uav"];
						//Pašalinti UAV ir pradėti cooldown serverio pusėje
						[_uav] remoteExec ["wrm_fnc_V2uavGroupRemove", 2, false];
					}];
					
					//Pridėti Zeus redagavimui - sleep reikalingas, nes funkcija vykdoma per spawn
					// Pagal SQF geriausias praktikas: spawn sukuria izoliuotą apimtį, todėl reikia perduoti parametrus per _this
					[_groupUav] spawn {
						params ["_groupUavLocal"];
						sleep 1;
						if(!isNull _groupUavLocal) then {
							[z1,[[_groupUavLocal],true]] remoteExec ["addCuratorEditableObjects", 2, false];
						};
					};
					
					hint "UAV deployed above your position";
				};
				
				if(_sde==sideE)exitWith
				{
					//Patikrinti, ar grupė jau turi aktyvų UAV - naudojame param saugesniam masyvo elementų pasiekimui
					_groupUavIndex = uavGroupObjects findIf {(_x param [0, ""]) == _grpId};
					if(_groupUavIndex != -1)then
					{
						_groupUav = uavGroupObjects param [_groupUavIndex, []] param [1, objNull];
						if(!isNull _groupUav && alive _groupUav)exitWith{hint "Your squad already has an active UAV";};
					};
					
					//Patikrinti cooldown - naudojame param saugesniam masyvo elementų pasiekimui
					_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};
					if(_groupCooldownIndex != -1)then
					{
						_groupCooldown = uavGroupCooldowns param [_groupCooldownIndex, []] param [1, 0];
						if(_groupCooldown > 0)exitWith
						{
							_t = _groupCooldown; _s = "sec";
							if(_groupCooldown >= 60)then{_t = floor (_groupCooldown / 60); _s = "min";};
							hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
						};
					};
					
					//Papildomas tikrinimas: patikrinti, ar grupė jau turi aktyvų UAV prieš sukurdamas naują
					//Tai apsaugo nuo greitų paspaudimų, kurie gali sukurti kelis UAV
					_groupUavIndex = uavGroupObjects findIf {(_x param [0, ""]) == _grpId};
					if(_groupUavIndex != -1)then
					{
						_groupUav = uavGroupObjects param [_groupUavIndex, []] param [1, objNull];
						if(!isNull _groupUav && alive _groupUav)exitWith{hint "Your squad already has an active UAV";};
					};
					
					//Sukurti UAV virš žaidėjo galvos
					_playerPos = getPos player;
					_uavSpawnPos = [_playerPos param [0, 0], _playerPos param [1, 0], (_playerPos param [2, 0]) + 100]; //100m virš žaidėjo galvos
					_groupUav = createVehicle [(selectRandom uavsE), _uavSpawnPos, [], 0, "FLY"];
					createVehicleCrew _groupUav;
					
					//Išsaugoti grupės UAV masyve serverio pusėje
					//Serverio pusėje bus papildomas tikrinimas, ar grupė jau turi aktyvų UAV
					[_grpId, _groupUav] remoteExec ["wrm_fnc_V2uavGroupAdd", 2, false];
					
					//Pridėti event handler, kad sunaikinus UAV pradėtų cooldown
					_groupUav addMPEventHandler ["MPKilled", {
						params ["_uav"];
						//Pašalinti UAV ir pradėti cooldown serverio pusėje
						[_uav] remoteExec ["wrm_fnc_V2uavGroupRemove", 2, false];
					}];
					
					//Pridėti Zeus redagavimui - sleep reikalingas, nes funkcija vykdoma per spawn
					// Pagal SQF geriausias praktikas: spawn sukuria izoliuotą apimtį, todėl reikia perduoti parametrus per _this
					[_groupUav] spawn {
						params ["_groupUavLocal"];
						sleep 1;
						if(!isNull _groupUavLocal) then {
							[z1,[[_groupUavLocal],true]] remoteExec ["addCuratorEditableObjects", 2, false];
						};
					};
					
					hint "UAV deployed above your position";
				};
			};
		}else
		{
			//Senoji sistema kitoms frakcijoms
			call
			{
				if(_sde==sideW)exitWith
				{
					if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBW1];};
					if(alive uavW)exitWith{hint "UAV is already deployed";};
					if(uavWr>0)exitWith
					{ 
						_t=uavWr; _s="sec"; if(uavWr>60)then{_t=floor (uavWr/60); _s="min";};
						hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
					};
					// Patikriname, ar plHW yra apibrėžtas prieš jį naudojant
					if(!isNil "plHW") then {
						uavW = createVehicle [(selectRandom uavsW), plHW, [], 0, "FLY"];
						createVehicleCrew uavW;
						publicvariable "uavW";
						(group driver uavW) move posCenter;
						
						uavW addMPEventHandler ["MPKilled",{[5] spawn wrm_fnc_V2coolDown;}];
						[5] remoteExec ["wrm_fnc_V2hints", 0, false];
						sleep 1;
						[z1,[[uavW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
					} else {
						hint "UAV service is unavailable - Air base not available";
					};
				};
				
				if(_sde==sideE)exitWith
				{
					if(getMarkerColor resFobE=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBE1];};
					if(alive uavE)exitWith{hint "UAV is already deployed";};
					if(uavEr>0)exitWith
					{ 
						_t=uavEr; _s="sec"; if(uavEr>60)then{_t=floor (uavEr/60); _s="min";};
						hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
					};
					// Patikriname, ar plHE yra apibrėžtas prieš jį naudojant
					if(!isNil "plHE") then {
						uavE = createVehicle [(selectRandom uavsE), plHE, [], 0, "FLY"];
						createVehicleCrew uavE;
						publicvariable "uavE";
						(group driver uavE) move posCenter;
						
						uavE addMPEventHandler ["MPKilled",{[6] spawn wrm_fnc_V2coolDown;}];
						[6] remoteExec ["wrm_fnc_V2hints", 0, false];
						sleep 1;
						[z1,[[uavE],true]] remoteExec ["addCuratorEditableObjects", 2, false];
					} else {
						hint "UAV service is unavailable - Air base not available";
					};
				};
			};
		};

	};
	
	//UGV
	if(_typ==1)exitWith
	{
		call
		{
			if(_sde==sideW)exitWith
			{
				if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UGV service is unavailable<br/>You lost %1 base",nameBW1];};
				if(alive ugvW)exitWith{hint "UGV is already deployed";};
				if(ugvWr>0)exitWith
				{ 
					_t=ugvWr; _s="sec"; if(ugvWr>60)then{_t=floor (ugvWr/60); _s="min";};
					hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
				};
				
				_s = (selectRandom ugvsW); 
				_pr =  objBaseW1 getRelPos [75, random 360];
				_p =  _pr findEmptyPosition [0, 50, _s];
				if(count _p==0)then{_p=_pr;};
				
				ugvW = createVehicle [_s, [_p select 0, _p select 1, 50], [], 0, "NONE"];
				createVehicleCrew ugvW;
				[ugvW] call wrm_fnc_parachute;
				publicvariable "ugvW";
				
				ugvW addMPEventHandler ["MPKilled",{[7] spawn wrm_fnc_V2coolDown;}];
				[7] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[ugvW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
			
			if(_sde==sideE)exitWith
			{
				if(getMarkerColor resFobE=="")exitWith{hint parseText format ["UGV service is unavailable<br/>You lost %1 base",nameBE1];};
				if(alive ugvE)exitWith{hint "UGV is already deployed";};
				if(ugvEr>0)exitWith
				{ 
					_t=ugvEr; _s="sec"; if(ugvEr>60)then{_t=floor (ugvEr/60); _s="min";};
					hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
				};
				
				_s = (selectRandom ugvsE); 
				_pr =  objBaseE1 getRelPos [75, random 360];
				_p =  _pr findEmptyPosition [0, 50, _s];
				if(count _p==0)then{_p=_pr;};
				
				ugvE = createVehicle [_s, [_p select 0, _p select 1, 50], [], 0, "NONE"];
				createVehicleCrew ugvE;
				[ugvE] call wrm_fnc_parachute;
				publicvariable "ugvE";
				
				ugvE addMPEventHandler ["MPKilled",{[8] spawn wrm_fnc_V2coolDown;}];
				[8] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[ugvE],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
		};
	};
};
