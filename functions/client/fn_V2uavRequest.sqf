/*
Author: IvosH (Modified by AI GyrbasTV)

Description:
	Client-side UAV/UGV request handler
	Sends request to server for UAV/UGV creation

Parameter(s):
	0: NUMBER type of the UAV/UGV (0=UAV, 1=UGV)
	1: SIDE player side

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf
	fn_V2uavRequest_srv.sqf (server-side)

Execution:
	[_typ, _side] spawn wrm_fnc_V2uavRequest
*/

params ["_typ","_sde"];

//Patikrinti ar žaidėjas yra būrio vadas - tik būrio vadai gali kviesti dronus
if (leader player != player) exitWith {
    hint "Only squad leaders can request UAVs";
    systemChat "[UAV] Only squad leaders can request UAVs";
};

//GLOBAL APSAUGA: Patikrinti ar jau vyksta UAV užklausa (anti-spam protection)
private _requestKey = format ["uav_request_progress_%1", getPlayerUID player];
if (missionNamespace getVariable [_requestKey, false]) exitWith {
    hint "UAV request already in progress...";
    systemChat "[UAV] Request already in progress - please wait";
};
missionNamespace setVariable [_requestKey, true, true];

//Tikrinti ar naudojama per-squad sistema (Ukraine 2025 / Russia 2025)
private _usePerSquad = false;
if (modA == "RHS") then {
    if (_sde == sideW && factionW == "Ukraine 2025") then {_usePerSquad = true;};
    if (_sde == sideE && factionE == "Russia 2025") then {_usePerSquad = true;};
};

call
{
    //UAV
    if (_typ == 0) exitWith
    {
        call
        {
            if (_sde == sideW) exitWith
            {
                //Patikrinti ar bazė neprarasta
                if (getMarkerColor resFobW == "") exitWith {
                    hint parseText format ["UAV service is unavailable<br/>You lost %1 base", nameBW1];
                };

                if (_usePerSquad) then {
                    //PER-SQUAD SISTEMA (Ukraine 2025) - naudoti missionNamespace throttling
                    private _playerUID = getPlayerUID player;
                    private _cooldownKey = format ["uav_cooldown_%1", _playerUID];
                    private _currentTime = diag_tickTime;
                    private _lastRequestTime = missionNamespace getVariable [_cooldownKey, 0];

                    //Patikrinti ar nepraėjo pakankamai laiko nuo paskutinio užklausimo (1 sekundė apsauga)
                    if (_currentTime - _lastRequestTime < 1) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        hint "Please wait before requesting another UAV...";
                        systemChat "[UAV] Request cooldown active";
                    };
                    missionNamespace setVariable [_cooldownKey, _currentTime, true];

                    //Patikrinti aktyvių UAV limitą (maksimaliai 4 per pusę)
                    //OPTIMALIZACIJA: naudoti entity komandą vietoj allUnits kad būtų greičiau
                    private _activeUavCount = 0;
                    {
                        if (!isNull (_x select 1) && alive (_x select 1)) then {
                            _activeUavCount = _activeUavCount + 1;
                        };
                    } forEach uavSquadW;

                    if (_activeUavCount >= 4) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        //Atstatyti cooldown timestamp kad žaidėjas galėtų bandyti vėl
                        missionNamespace setVariable [_cooldownKey, _currentTime - 1, true];
                        hint "UAV limit reached\nMaximum 4 active UAVs per faction";
                        systemChat format ["[UAV] Maximum 4 active UAVs per faction reached (current: %1)", _activeUavCount];
                        if (DBG) then {
                            diag_log format ["[UAV_CLIENT] Limit exceeded for WEST: %1 active UAVs", _activeUavCount];
                        };
                    };

                    //Patikrinti ar žaidėjas jau turi aktyvų droną
                    private _index = -1;
                    {
                        if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
                    } forEach uavSquadW;

                    if (_index >= 0) then {
                        private _uavData = uavSquadW select _index;
                        private _uavObj = _uavData select 1;
                        private _cooldown = _uavData select 2;

                        if (!isNull _uavObj && alive _uavObj) exitWith {
                            missionNamespace setVariable [_requestKey, false, true];
                            hint "You already have an active drone deployed";
                            systemChat "[UAV] You already have an active drone deployed";
                            if (DBG) then {
                                diag_log format ["[UAV_CLIENT] Player %1 already has active UAV", _playerUID];
                            };
                        };

                        if (_cooldown > 0) exitWith {
                            missionNamespace setVariable [_requestKey, false, true];
                            private _t = _cooldown; private _s = "sec";
                            if (_cooldown > 60) then {_t = floor (_cooldown / 60); _s = "min";};
                            hint parseText format ["Drone cooldown<br/>Ready in %1 %2", _t, _s];
                            systemChat format ["[UAV] Drone cooldown: %1 %2 remaining", _t, _s];
                        };
                    };

                    //Validacija: patikrinti ar UAV masyvas nėra tuščias
                    if (count uavsW == 0) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        hint "UAV service is unavailable<br/>No UAVs available for this faction";
                        systemChat "[UAV ERROR] uavsW array is empty";
                    };

                    //Siųsti užklausą serveriui
                    private _playerPos = getPosATL player;
                    private _spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
                    [_typ, _sde, _playerUID, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];

                    //Užklausa išsiųsta - atstatyti vėliavėlę po trumpos pauzės
                    [] spawn {
                        sleep 2;
                        private _requestKey = format ["uav_request_progress_%1", getPlayerUID player];
                        missionNamespace setVariable [_requestKey, false, true];
                    };

                } else {
                    //ORIGINALI SISTEMA (A3 modas arba kitos RHS frakcijos)
                    if (alive uavW) exitWith {
                        hint "UAV is already deployed";
                    };
                    if (uavWr > 0) exitWith
                    {
                        private _t = uavWr;
                        private _s = "sec";
                        if (uavWr > 60) then {
                            _t = floor (uavWr / 60);
                            _s = "min";
                        };
                        hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
                    };

                    //Validacija: patikrinti ar UAV masyvas nėra tuščias
                    if (count uavsW == 0) exitWith {
                        hint "UAV service is unavailable<br/>No UAVs available for this faction";
                        systemChat "[UAV ERROR] uavsW array is empty";
                    };

                    //Siųsti užklausą serveriui
                    private _playerPos = getPosATL player;
                    private _spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
                    [_typ, _sde, getPlayerUID player, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];
                };
            };

            if (_sde == sideE) exitWith
            {
                //Patikrinti ar bazė neprarasta
                if (getMarkerColor resFobE == "") exitWith {
                    hint parseText format ["UAV service is unavailable<br/>You lost %1 base", nameBE1];
                };

                if (_usePerSquad) then {
                    //PER-SQUAD SISTEMA (Russia 2025) - naudoti missionNamespace throttling
                    private _playerUID = getPlayerUID player;

                    //Papildoma apsauga nuo greito karto jimo - naudoti tą pačią schemą kaip WEST
                    private _cooldownKey = format ["uav_cooldown_%1", _playerUID];
                    private _currentTime = diag_tickTime;
                    private _lastRequestTime = missionNamespace getVariable [_cooldownKey, 0];

                    //Patikrinti ar nepraėjo pakankamai laiko nuo paskutinio užklausimo (1 sekundė apsauga)
                    if (_currentTime - _lastRequestTime < 1) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        hint "Please wait before requesting another UAV...";
                        systemChat "[UAV] UAV creation cooldown active";
                    };
                    missionNamespace setVariable [_cooldownKey, _currentTime, true];

                    private _finish = { missionNamespace setVariable [_cooldownKey, _currentTime - 1, true]; };

                    //Patikrinti aktyvių UAV limitą (maksimaliai 4 per pusę)
                    private _activeUavCount = 0;
                    {
                        if (!isNull (_x select 1) && alive (_x select 1)) then {
                            _activeUavCount = _activeUavCount + 1;
                        };
                    } forEach uavSquadE;

                    if (_activeUavCount >= 4) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        call _finish;
                        hint "UAV limit reached\nMaximum 4 active UAVs per faction";
                        systemChat format ["[UAV] Maximum 4 active UAVs per faction reached (current: %1)", _activeUavCount];
                        if (DBG) then {
                            diag_log format ["[UAV_CLIENT] Limit exceeded for EAST: %1 active UAVs", _activeUavCount];
                        };
                    };

                    //Patikrinti ar žaidėjas jau turi aktyvų droną
                    private _index = -1;
                    {
                        if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
                    } forEach uavSquadE;

                    if (_index >= 0) then {
                        private _uavData = uavSquadE select _index;
                        private _uavObj = _uavData select 1;
                        private _cooldown = _uavData select 2;

                        if (!isNull _uavObj && alive _uavObj) exitWith {
                            missionNamespace setVariable [_requestKey, false, true];
                            call _finish;
                            hint "You already have an active drone deployed";
                            systemChat "[UAV] You already have an active drone deployed";
                            if (DBG) then {
                                diag_log format ["[UAV_CLIENT] Player %1 already has active UAV", _playerUID];
                            };
                        };

                        if (_cooldown > 0) exitWith {
                            missionNamespace setVariable [_requestKey, false, true];
                            call _finish;
                            private _t = _cooldown; private _s = "sec";
                            if (_cooldown > 60) then {_t = floor (_cooldown / 60); _s = "min";};
                            hint parseText format ["Drone cooldown<br/>Ready in %1 %2", _t, _s];
                            systemChat format ["[UAV] Drone cooldown: %1 %2 remaining", _t, _s];
                        };
                    };

                    //Validacija: patikrinti ar UAV masyvas nėra tuščias
                    if (count uavsE == 0) exitWith {
                        missionNamespace setVariable [_requestKey, false, true];
                        call _finish;
                        hint "UAV service is unavailable<br/>No UAVs available for this faction";
                        systemChat "[UAV ERROR] uavsE array is empty";
                    };

                    //Siųsti užklausą serveriui
                    private _playerPos = getPosATL player;
                    private _spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
                    [_typ, _sde, _playerUID, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];

                    //Užklausa išsiųsta - atstatyti vėliavėlę po trumpos pauzės
                    [] spawn {
                        sleep 2;
                        private _requestKey = format ["uav_request_progress_%1", getPlayerUID player];
                        missionNamespace setVariable [_requestKey, false, true];
                    };

                } else {
                    //ORIGINALI SISTEMA (A3 modas arba kitos RHS frakcijos)
                    if (alive uavE) exitWith {
                        hint "UAV is already deployed";
                    };
                    if (uavEr > 0) exitWith
                    {
                        private _t = uavEr;
                        private _s = "sec";
                        if (uavEr > 60) then {
                            _t = floor (uavEr / 60);
                            _s = "min";
                        };
                        hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
                    };

                    //Validacija: patikrinti ar UAV masyvas nėra tuščias
                    if (count uavsE == 0) exitWith {
                        hint "UAV service is unavailable<br/>No UAVs available for this faction";
                        systemChat "[UAV ERROR] uavsE array is empty";
                    };

                    //Siųsti užklausą serveriui
                    private _playerPos = getPosATL player;
                    private _spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
                    [_typ, _sde, getPlayerUID player, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];
                };
            };
        };
    };

    //UGV
    if (_typ == 1) exitWith
    {
        call
        {
            if (_sde == sideW) exitWith
            {
                if (getMarkerColor resFobW == "") exitWith {
                    hint parseText format ["UGV service is unavailable<br/>You lost %1 base", nameBW1];
                };
                if (alive ugvW) exitWith {
                    hint "UGV is already deployed";
                };
                if (ugvWr > 0) exitWith
                {
                    private _t = ugvWr;
                    private _s = "sec";
                    if (ugvWr > 60) then {
                        _t = floor (ugvWr / 60);
                        _s = "min";
                    };
                    hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
                };

                //Validacija: patikrinti ar UGV masyvas nėra tuščias
                if (count ugvsW == 0) exitWith {
                    hint "UGV service is unavailable\nNo UGVs available for this faction";
                    systemChat "[UGV ERROR] ugvsW array is empty";
                };

                //Siųsti užklausą serveriui
                private _spawnPos = objBaseW1 getRelPos [75, random 360];
                [_typ, _sde, getPlayerUID player, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];
            };

            if (_sde == sideE) exitWith
            {
                if (getMarkerColor resFobE == "") exitWith {
                    hint parseText format ["UGV service is unavailable<br/>You lost %1 base", nameBE1];
                };
                if (alive ugvE) exitWith {
                    hint "UGV is already deployed";
                };
                if (ugvEr > 0) exitWith
                {
                    private _t = ugvEr;
                    private _s = "sec";
                    if (ugvEr > 60) then {
                        _t = floor (ugvEr / 60);
                        _s = "min";
                    };
                    hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
                };

                //Validacija: patikrinti ar UGV masyvas nėra tuščias
                if (count ugvsE == 0) exitWith {
                    hint "UGV service is unavailable\nNo UGVs available for this faction";
                    systemChat "[UGV ERROR] ugvsE array is empty";
                };

                //Siųsti užklausą serveriui
                private _spawnPos = objBaseE1 getRelPos [75, random 360];
                [_typ, _sde, getPlayerUID player, _spawnPos] remoteExec ["wrm_fnc_V2uavRequest_srv", 2];
            };
        };
    };
};
