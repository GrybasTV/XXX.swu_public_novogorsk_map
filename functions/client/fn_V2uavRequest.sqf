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
		//Tikrinti ar naudojama per-squad sistema (Ukraine 2025 / Russia 2025)
		_usePerSquad = false;
		if (modA == "RHS") then {
			if (_sde == sideW && factionW == "Ukraine 2025") then {_usePerSquad = true;};
			if (_sde == sideE && factionE == "Russia 2025") then {_usePerSquad = true;};
		};

		call
		{
			if(_sde==sideW)exitWith
			{
				//Patikrinti ar bazė neprarasta
				if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBW1];};

				if (_usePerSquad) then {
					//PER-SQUAD SISTEMA (Ukraine 2025) - PAGERINTA VERSIJA SU UAV TERMINAL
					_playerUID = getPlayerUID player;

					//Server-side apsauga nuo greito karto jimo naudojant player UID
					private _cooldownKey = format ["uav_cooldown_%1", _playerUID];
					private _currentTime = diag_tickTime;
					private _lastRequestTime = missionNamespace getVariable [_cooldownKey, 0];

					//Patikrinti ar nepraėjo pakankamai laiko nuo paskutinio užklausimo (1 sekundė apsauga)
					if (_currentTime - _lastRequestTime < 1) exitWith {
						hint "Please wait before requesting another UAV...";
						systemChat "[UAV] Request cooldown active";
					};
					missionNamespace setVariable [_cooldownKey, _currentTime, true];

					_index = -1;

					//Patikrinti aktyvių UAV limitą (maksimaliai 4 per pusę)
					_activeUavCount = 0;
					{
						if (!isNull (_x select 1) && alive (_x select 1)) then {
							_activeUavCount = _activeUavCount + 1;
						};
					} forEach uavSquadW;

					if (_activeUavCount >= 4) exitWith {
						//Atstatyti cooldown timestamp kad žaidėjas galėtų bandyti vėl
						missionNamespace setVariable [_cooldownKey, _currentTime - 1, true];
						hint "UAV limit reached\nMaximum 4 active UAVs per faction";
						systemChat "[UAV] Maximum 4 active UAVs per faction reached";
					};

					//Rasti žaidėjo įrašą masyve
					{
						if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
					} forEach uavSquadW;

					//Patikrinti ar žaidėjas jau turi aktyvų droną
					if (_index >= 0) then {
						_uavData = uavSquadW select _index;
						_uavObj = _uavData select 1;
						_cooldown = _uavData select 2;

						if (!isNull _uavObj && alive _uavObj) exitWith {
							//Cooldown atstatytas automatiskai per missionNamespace
							hint "You already have an active drone deployed";
							systemChat "[UAV] You already have an active drone deployed";
						};

						if (_cooldown > 0) exitWith {
							//Cooldown atstatytas automatiskai per missionNamespace
							_t = _cooldown; _s = "sec";
							if (_cooldown > 60) then {_t = floor (_cooldown / 60); _s = "min";};
							hint parseText format ["Drone cooldown<br/>Ready in %1 %2", _t, _s];
							systemChat format ["[UAV] Drone cooldown: %1 %2 remaining", _t, _s];
						};
					};

					//Validacija: patikrinti ar UAV masyvas nėra tuščias
					if (count uavsW == 0) exitWith {
						hint "UAV service is unavailable<br/>No UAVs available for this faction";
						systemChat "[UAV ERROR] uavsW array is empty";
					};

					//Sukurti UAV virš kviečiančio žaidėjo (50-100m aukštyje)
					_playerPos = getPosATL player;
					_spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
					_uav = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];

					//Validacija: patikrinti ar dronas sėkmingai sukurtas
					if (isNull _uav) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV";
						systemChat "[UAV ERROR] Failed to create UAV";
					};

					//Sukurti crew ir priskirti būrio vado grupei
					createVehicleCrew _uav;
					(group driver _uav) setGroupOwner (owner player); //Priskirti būrio vadui

					//Validacija: patikrinti ar crew sukurtas
					if (isNull driver _uav) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV crew";
						systemChat "[UAV ERROR] Failed to create UAV crew";
						deleteVehicle _uav;
					};

					//Nustatyti duomenis dronui (naudojama event handler'yje)
					_uav setVariable ["wrm_uav_cooldownType", 11, true];
					_uav setVariable ["wrm_uav_playerUID", _playerUID, true];
					_uav setVariable ["wrm_uav_side", _sde, true];

					//Pridėti į masyvą arba atnaujinti esamą įrašą
					if (_index >= 0) then {
						uavSquadW set [_index, [_playerUID, _uav, 0]];
					} else {
						uavSquadW pushBack [_playerUID, _uav, 0];
					};
					publicvariable "uavSquadW";

					//Nustatyti droną būti kontroliuojamą būrio vado
					//UAV iš pradžių skrenda į centrą, bet gali būti kontroliuojamas per terminalą
					(group driver _uav) move posCenter;

					//FPV dronai nepalaiko UAV terminalų - jie yra autonominiai ginklai

					//Pridėti event handler'į su setVariable informacija
					_uav addMPEventHandler ["MPKilled", {
						params ["_uav"];
						private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
						private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
						private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

						if (_cooldownType > 0 && _playerUID != "") then {
							[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
						};
					}];

					//UAV sukurtas sėkmingai - atstatyti apsaugą nuo greito karto jimo
					//Cooldown atstatytas automatiskai per missionNamespace

					//Pranešimai
					[11] remoteExec ["wrm_fnc_V2hints", 0, false];
					sleep 1;
					[z1,[[_uav],true]] remoteExec ["addCuratorEditableObjects", 2, false];

					systemChat format ["[UAV] Ukraine 2025 drone deployed for player %1", name player];

				} else {
					//ORIGINALI SISTEMA (A3 modas arba kitos RHS frakcijos)
					if(alive uavW)exitWith{hint "UAV is already deployed";};
					if(uavWr>0)exitWith
					{
						_t=uavWr; _s="sec"; if(uavWr>60)then{_t=floor (uavWr/60); _s="min";};
						hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
					};

					//Validacija: patikrinti ar UAV masyvas nėra tuščias
					if (count uavsW == 0) exitWith {
						hint "UAV service is unavailable<br/>No UAVs available for this faction";
						systemChat "[UAV ERROR] uavsW array is empty";
					};

					//Sukurti UAV virš kviečiančio žaidėjo (50-100m aukštyje)
					_playerPos = getPosATL player;
					_spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
					uavW = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];

					//Validacija: patikrinti ar dronas sėkmingai sukurtas
					if (isNull uavW) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV";
						systemChat "[UAV ERROR] Failed to create UAV";
					};

					//Sukurti crew
					createVehicleCrew uavW;

					//Validacija: patikrinti ar crew sukurtas
					if (isNull driver uavW) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV crew";
						systemChat "[UAV ERROR] Failed to create UAV crew";
						deleteVehicle uavW;
						uavW = objNull;
					};

					publicvariable "uavW";
					(group driver uavW) move posCenter;

					//Nustatyti duomenis dronui (naudojama event handler'yje)
					uavW setVariable ["wrm_uav_cooldownType", 5, true];
					uavW setVariable ["wrm_uav_playerUID", getPlayerUID player, true];
					uavW setVariable ["wrm_uav_side", _sde, true];

					//Pridėti event handler'į su setVariable informacija
					uavW addMPEventHandler ["MPKilled", {
						params ["_uav"];
						private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
						private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
						private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

						if (_cooldownType > 0 && _playerUID != "") then {
							[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
						};
					}];

					[5] remoteExec ["wrm_fnc_V2hints", 0, false];
					sleep 1;
					[z1,[[uavW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
				};
			};

			if(_sde==sideE)exitWith
			{
				//Patikrinti ar bazė neprarasta
				if(getMarkerColor resFobE=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBE1];};

				if (_usePerSquad) then {
					//PER-SQUAD SISTEMA (Russia 2025) - PATAISYTA VERSIJA
					_playerUID = getPlayerUID player;

					//Papildoma apsauga nuo greito karto jimo - patikrinti ar žaidėjas jau turi aktyvų kūrimo procesą
					if (player getVariable ["uav_creation_in_progress", false]) exitWith {
						hint "UAV creation already in progress...";
						systemChat "[UAV] UAV creation already in progress";
					};
					player setVariable ["uav_creation_in_progress", true, true];

					_index = -1;

					//Patikrinti aktyvių UAV limitą (maksimaliai 4 per pusę)
					_activeUavCount = 0;
					{
						if (!isNull (_x select 1) && alive (_x select 1)) then {
							_activeUavCount = _activeUavCount + 1;
						};
					} forEach uavSquadE;

					if (_activeUavCount >= 4) exitWith {
						//Cooldown atstatytas automatiskai per missionNamespace
						hint "UAV limit reached\nMaximum 4 active UAVs per faction";
						systemChat "[UAV] Maximum 4 active UAVs per faction reached";
					};

					//Rasti žaidėjo įrašą masyve
					{
						if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
					} forEach uavSquadE;

					//Patikrinti ar žaidėjas jau turi aktyvų droną
					if (_index >= 0) then {
						_uavData = uavSquadE select _index;
						_uavObj = _uavData select 1;
						_cooldown = _uavData select 2;

						if (!isNull _uavObj && alive _uavObj) exitWith {
							//Cooldown atstatytas automatiskai per missionNamespace
							hint "You already have an active drone deployed";
							systemChat "[UAV] You already have an active drone deployed";
						};

						if (_cooldown > 0) exitWith {
							//Cooldown atstatytas automatiskai per missionNamespace
							_t = _cooldown; _s = "sec";
							if (_cooldown > 60) then {_t = floor (_cooldown / 60); _s = "min";};
							hint parseText format ["Drone cooldown<br/>Ready in %1 %2", _t, _s];
							systemChat format ["[UAV] Drone cooldown: %1 %2 remaining", _t, _s];
						};
					};

					//Validacija: patikrinti ar UAV masyvas nėra tuščias
					if (count uavsE == 0) exitWith {
						//Cooldown atstatytas automatiskai per missionNamespace
						hint "UAV service is unavailable<br/>No UAVs available for this faction";
						systemChat "[UAV ERROR] uavsE array is empty";
					};

					//Sukurti UAV virš kviečiančio žaidėjo (50-100m aukštyje)
					_playerPos = getPosATL player;
					_spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
					_uav = createVehicle [(selectRandom uavsE), _spawnPos, [], 0, "FLY"];

					//Validacija: patikrinti ar dronas sėkmingai sukurtas
					if (isNull _uav) exitWith {
						//Cooldown atstatytas automatiskai per missionNamespace
						hint "UAV service is unavailable<br/>Failed to create UAV";
						systemChat "[UAV ERROR] Failed to create UAV";
					};

					//Sukurti crew
					createVehicleCrew _uav;

					//FPV kamikadze dronai - MANUALUS valdymas per UAV terminalą (kaip originalas)
					//Žaidėjai patys turi atsidaryti UAV terminalą ir prisijungti prie drono
					//Nėra automatines kontrolės - leidžiama žaidėjams pasirinkti kada ir kaip kontroliuoti
					systemChat "[UAV] FPV drone deployed - connect manually via UAV terminal to control";

					//Validacija: patikrinti ar crew sukurtas
					if (isNull driver _uav) exitWith {
						//Cooldown atstatytas automatiskai per missionNamespace
						hint "UAV service is unavailable<br/>Failed to create UAV crew";
						systemChat "[UAV ERROR] Failed to create UAV crew";
						deleteVehicle _uav;
					};

					//Nustatyti duomenis dronui (naudojama event handler'yje)
					_uav setVariable ["wrm_uav_cooldownType", 12, true];
					_uav setVariable ["wrm_uav_playerUID", _playerUID, true];
					_uav setVariable ["wrm_uav_side", _sde, true];

					//Pridėti į masyvą arba atnaujinti esamą įrašą
					if (_index >= 0) then {
						uavSquadE set [_index, [_playerUID, _uav, 0]];
					} else {
						uavSquadE pushBack [_playerUID, _uav, 0];
					};
					publicvariable "uavSquadE";

					//Nustatyti droną būti kontroliuojamą būrio vado
					//UAV iš pradžių skrenda į centrą, bet gali būti kontroliuojamas per terminalą
					(group driver _uav) move posCenter;

					//FPV dronai nepalaiko UAV terminalų - jie yra autonominiai ginklai

					//Pridėti event handler'į su setVariable informacija
					_uav addMPEventHandler ["MPKilled", {
						params ["_uav"];
						private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
						private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
						private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

						if (_cooldownType > 0 && _playerUID != "") then {
							[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
						};
					}];

					//UAV sukurtas sėkmingai - atstatyti apsaugą nuo greito karto jimo
					//Cooldown atstatytas automatiskai per missionNamespace

					//Pranešimai
					[12] remoteExec ["wrm_fnc_V2hints", 0, false];
					sleep 1;
					[z1,[[_uav],true]] remoteExec ["addCuratorEditableObjects", 2, false];

					systemChat format ["[UAV] Russia 2025 drone deployed for player %1", name player];

				} else {
					//ORIGINALI SISTEMA (A3 modas arba kitos RHS frakcijos)
					if(alive uavE)exitWith{hint "UAV is already deployed";};
					if(uavEr>0)exitWith
					{
						_t=uavEr; _s="sec"; if(uavEr>60)then{_t=floor (uavEr/60); _s="min";};
						hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
					};

					//Validacija: patikrinti ar UAV masyvas nėra tuščias
					if (count uavsE == 0) exitWith {
						hint "UAV service is unavailable<br/>No UAVs available for this faction";
						systemChat "[UAV ERROR] uavsE array is empty";
					};

					//Sukurti UAV virš kviečiančio žaidėjo (50-100m aukštyje)
					_playerPos = getPosATL player;
					_spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
					uavE = createVehicle [(selectRandom uavsE), _spawnPos, [], 0, "FLY"];

					//Validacija: patikrinti ar dronas sėkmingai sukurtas
					if (isNull uavE) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV";
						systemChat "[UAV ERROR] Failed to create UAV";
					};

					//Sukurti crew
					createVehicleCrew uavE;

					//Validacija: patikrinti ar crew sukurtas
					if (isNull driver uavE) exitWith {
						hint "UAV service is unavailable<br/>Failed to create UAV crew";
						systemChat "[UAV ERROR] Failed to create UAV crew";
						deleteVehicle uavE;
						uavE = objNull;
					};

					publicvariable "uavE";
					(group driver uavE) move posCenter;

					//Nustatyti duomenis dronui (naudojama event handler'yje)
					uavE setVariable ["wrm_uav_cooldownType", 6, true];
					uavE setVariable ["wrm_uav_playerUID", getPlayerUID player, true];
					uavE setVariable ["wrm_uav_side", _sde, true];

					//Pridėti event handler'į su setVariable informacija
					uavE addMPEventHandler ["MPKilled", {
						params ["_uav"];
						private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
						private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
						private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

						if (_cooldownType > 0 && _playerUID != "") then {
							[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
						};
					}];

					[6] remoteExec ["wrm_fnc_V2hints", 0, false];
					sleep 1;
					[z1,[[uavE],true]] remoteExec ["addCuratorEditableObjects", 2, false];
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
