/*
	Author: IvosH
	
	Description:
		Event handler for MPrespawn. Set position of the respawned AI unit. Depends on the position of the _men (group leader or another group member). Simulates squad respawn for AI.

		
	Parameter(s):
		0: VARIABLE respawned unit
		
	Returns:
		BOOL
		
	Dependencies:
		initServer.sqf
		fn_resGrpsUpdate.sqf
		fn_aiMove.sqf

	Execution:
		[_unit,_corpse] spawn wrm_fnc_V2respawnEH;
*/
params ["_unit","_corpse"];

if (isPlayer _unit) exitWith {}; //unit is player script stops here

if(_unit in playableUnits)then
{
	_unit setSpeaker (speaker _corpse);
	[_unit, (speaker _corpse)] remoteExec ["setSpeaker",0,false];
	[_unit, (face _corpse)] remoteExec ["setFace",0,false];
	[_unit] call wrm_fnc_V2loadoutChange;
	[_unit] spawn wrm_fnc_equipment;
	[z1,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 2, false]; //add unit to zeus
};

if(progress<2)exitWith{};

//AI Respawn Delay Sistema - tik ne-vehicle AI
if (!(_unit in playableUnits)) then {
    // Tikrinti ar sistema įjungta
    private _aiDelayEnabled = ("asp14" call BIS_fnc_getParamValue) == 1;
    if (!_aiDelayEnabled) exitWith {}; // Jei išjungta - nedelsiant visiems

    private _playerDelay = [30, 60, 120, 120, 200] select ("asp12" call BIS_fnc_getParamValue);
    private _playerDelay = _playerDelay max 30;

    // Tikriname ar tai vehicle crew
    private _isVehicleCrew = false;
    if (!isNull objectParent _unit) then {
        _isVehicleCrew = true;
    };

    // Jei vehicle crew - nedelsiant respawn (transportas turi būti su įgula)
    if (_isVehicleCrew) exitWith {};

    // Gauname konfigūruotus delay'us
    private _squadDelayMultiplier = [0.1, 0.25, 0.5, 0.75, 1.0, 2.0] select ("asp15" call BIS_fnc_getParamValue);
    private _combatDelayMultiplier = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0] select ("asp16" call BIS_fnc_getParamValue);
    private _baseDefenseDelayMultiplier = [0.0, 0.25, 0.5, 0.75, 1.0, 2.0] select ("asp17" call BIS_fnc_getParamValue);

    // Base Defense AI - dinaminis delay pagal bazės būklę
    private _baseDelay = _playerDelay;
    if (_unit in (defW + defE)) then {
        // Nustatyti bazės poziciją pagal grupę
        private _basePos = [];
        private _enemySide = sideE;
        private _friendlySide = sideW;
        
        if (_unit in defW) then {
            // Rasti kurią bazę gina (W1 ar W2)
            if (count defW > 0 && {_unit in units (defW select 0)}) then {
                _basePos = posBaseW1;
            } else {
                _basePos = posBaseW2;
            };
            _enemySide = sideE;
            _friendlySide = sideW;
        } else {
            // EAST base defense
            if (count defE > 0 && {_unit in units (defE select 0)}) then {
                _basePos = posBaseE1;
            } else {
                _basePos = posBaseE2;
            };
            _enemySide = sideW;
            _friendlySide = sideE;
        };
        
        // Tikrinti ar bazė puolama (ta pati logika kaip "BASE UNDER ATTACK")
        private _en = [];
        {if((side _x==_enemySide)&&((_x distance _basePos)<250))then{_en pushBackUnique _x;};} forEach allUnits;
        private _df = [];
        {if((side _x==_friendlySide)&&((_x distance _basePos)<250))then{_df pushBackUnique _x;};} forEach allUnits;
        
        // Tikrinti ar bazė contestinama (priešai bazėje - negalima spawn'inti)
        private _enemiesInBase = [];
        {if((side _x==_enemySide)&&((_x distance _basePos)<100))then{_enemiesInBase pushBackUnique _x;};} forEach allUnits;
        private _baseContested = (count _enemiesInBase) > 0;
        
        // Jei bazė contestinama - negalima spawn'inti (išvengti spawn priešais žaidėjus)
        if (_baseContested) then {
            // Bazė contestinama - visai negalima spawn'inti kol bazė neužvaldyta
            // Vienetas neatsiras kol priešai nepaliks bazės
            _baseDelay = -1; // Flag kad praleisti respawn
        } else if((count _df)<((count _en)*1.5) && (count _en) > 0) then {
            // Bazė puolama bet necontestinama - nedelsiant respawn (gynėjai už bazės ribų)
            _baseDelay = 0; // Bazė puolama - nedelsiant!
        } else {
            // Bazė saugi - naudoti konfigūruotą delay
            _baseDelay = _baseDelay * _baseDefenseDelayMultiplier;
        };
    };

    // Jei bazė contestinama - praleisti respawn (neatsiras kol bazė neužvaldyta)
    if (_baseDelay < 0) exitWith {}; // Bazė contestinama - negalima spawn'inti

    // Nustatyti galutinį delay pagal AI tipą (jei ne base defense)
    if (!(_unit in (defW + defE))) then {
        // Tikrinti ar tai squad AI (maži būriai) ar combat groups
        private _isSquadAI = (count units group _unit) <= 4;
        if (_isSquadAI) then {
            _baseDelay = _playerDelay * _squadDelayMultiplier;
        } else {
            _baseDelay = _playerDelay * _combatDelayMultiplier;
        };
    };

    // Progress scaling
    private _progressMultiplier = 1 + (progress * 0.2);
    _baseDelay = _baseDelay * _progressMultiplier;

    // Proximity bonus
    private _nearPlayers = {(_x distance _unit) < 200} count allPlayers;
    _baseDelay = _baseDelay + (_nearPlayers * 10);

    // Squad wipe penalty
    if ({alive _x} count units group _unit == 0) then {
        _baseDelay = _baseDelay * 1.3;
    };

    sleep _baseDelay;
};

//unit is AI
params [["_grp",[]],["_ldrPl",[]],["_players",[]],["_ldrAI",[]],["_AIs",[]]];
_placed=false; _grp=[];_ldrPl=[];_players=[];_ldrAI=[];_AIs=[];

//side WEST
_posBaseW1=posBaseW1;
_posBaseW2=posBaseW2;
_vehicles=BikeW+CarW+TruckW+HeliTrW+boatTrW+boatArW;
_secBW2=secBW2;
_sideW=sideW;
_sideE=sideE;
_resBaseW2W=resBaseW2W;
_secBW1=secBW1;
_resBaseW1W=resBaseW1W;
_resAAW=resAAW;
_resArtiW=resArtiW;
_resCasW=resCasW;
_resBaseW1=resBaseW1;
_resBaseW2=resBaseW2;
_posBaseE1=posBaseE1;
_secBE1=secBE1;
_resBaseE1W=resBaseE1W;
_resBaseE1=resBaseE1;
_posBaseE2=posBaseE2;
_secBE2=secBE2;
_resBaseE2W=resBaseE2W;
_resBaseE2=resBaseE2;
_resAW=resAW;
_resBW=resBW;
_resCW=resCW;
_resFobW=resFobW;
_resBaseW=resBaseW;
_resFobEW=resFobEW;
_resBaseEW=resBaseEW;
_nameBW1=nameBW1;
_nameBW2=nameBW2;

//side EAST
if (side _unit==sideE) then 
{
	_posBaseW1=posBaseE1;
	_posBaseW2=posBaseE2;
	_vehicles=BikeE+CarE+TruckE+HeliTrE+boatTrE+boatArE;
	_secBW2=secBE2;
	_sideW=sideE;
	_sideE=sideW;
	_resBaseW2W=resBaseE2E;
	_secBW1=secBE1;
	_resBaseW1W=resBaseE1E;
	_resAAW=resAAE;
	_resArtiW=resArtiE;
	_resCasW=resCasE;
	_resBaseW1=resBaseE1;
	_resBaseW2=resBaseE2;
	_posBaseE1=posBaseW1;
	_secBE1=secBW1;
	_resBaseE1W=resBaseW1E;
	_resBaseE1=resBaseW1;
	_posBaseE2=posBaseW2;
	_secBE2=secBW2;
	_resBaseE2W=resBaseW2E;
	_resBaseE2=resBaseW2;
	_resAW=resAE;
	_resBW=resBE;
	_resCW=resCE;
	_resFobW=resFobE;
	_resBaseW=resBaseE;
	_resFobEW=resFobWE;
	_resBaseEW=resBaseWE;
	_nameBW1=nameBE1;
	_nameBW2=nameBE2;
};

//any group members alive
if(({alive _x} count units group _unit) > 1)then
{
	//sort group members
	{
		if(_unit!=_x)then{ //is not unit it self
			if(alive _x)then{ //is alive
				call
				{
					if(isPlayer _x && leader _unit==_x)exitWith{_ldrPl pushBackUnique _x}; //is player and leader
					if(isPlayer _x && leader _unit!=_x)exitWith{_players pushBackUnique _x}; //another players
					if(!(isPlayer _x) && leader _unit==_x)exitWith{_ldrAI pushBackUnique _x}; //is AI and leader
					if(!(isPlayer _x) && leader _unit!=_x)exitWith{_AIs pushBackUnique _x}; //another Ai units
				};
			};
		};
	}forEach units group _unit;
	
	//RESPAWN IN THE VEHICLE
	_grp=_ldrPl+_players+_ldrAI+_AIs;	
	{
		if(_placed)exitWith{};
		_man=_x;
		if(vehicle _man != _man)then //is in the vehicle
		{
			_inBase=false; //check distance from base
			if(resType==0)then
			{
				{if((_x distance _man)<200)then{_inBase=true;};}forEach [_posBaseW1,_posBaseW2];
			}else{_inBase=true;};
			if(!_inBase)exitWith{};

			_seat=["Driver","Gunner","Commander"];//check if cargo will be used
			if(isPlayer _man)then //is player
			{
				if(_man==leader _man)then //is leader
				{
					//check if he is in the transport vehicle
					_c=false;
					{
						if(_c)exitWith{};
						//_x gali būti stringas arba masyvas [type, texture] - reikia patikrinti
						_vehType = if (_x isEqualType []) then {_x select 0} else {_x};
						//Naudoti _man, ne player, nes tai serverio funkcija
						if(typeOf vehicle _man == _vehType)then{_seat=["Driver","Gunner","Commander","Cargo"];_c=true;};
					} forEach _vehicles;
				};
			};
			//check for seat
			{
				if(_placed)exitWith{};
				if (vehicle _man emptyPositions _x > 0) 
				then {_unit moveInAny vehicle _man;_placed = true;}; //respawn in the vehicle
			} forEach _seat;
		};
	}forEach _grp;		
};
if(_placed)exitWith
{
	//Pritaikyti loadout ir nation change AI squado nariams (jei ne playableUnits)
	if(!(_unit in playableUnits))then
	{
		[_unit] call wrm_fnc_V2loadoutChange;
		[_unit] call wrm_fnc_V2nationChange;
	};
	sleep 0.1;
	if(_unit==leader _unit)then{[] call wrm_fnc_V2aiMove;};
	if(DBG)then{[format ["%1 - Vehicle respawn",(group _unit)]] remoteExec ["systemChat", 0, false];};
};

//BASE UNDER ATTACK
if(_secBW2&&(getMarkerColor _resBaseW!=""))then //armors
{
	_en=[]; {if((side _x==_sideE)&&((_x distance _posBaseW2)<250))then{_en pushBackUnique _x;};} forEach allUnits;
	_df=[]; {if((side _x==_sideW)&&((_x distance _posBaseW2)<250))then{_df pushBackUnique _x;};} forEach allUnits;
	if((count _df)<((count _en)*1.5))then{_placed = true;};
	if(_placed)then{_unit setVehiclePosition [(selectRandom _resBaseW2W), [], 0, "NONE"];};
};
if(_placed)exitWith
{
	//Pritaikyti loadout ir nation change AI squado nariams (jei ne playableUnits)
	if(!(_unit in playableUnits))then
	{
		[_unit] call wrm_fnc_V2loadoutChange;
		[_unit] call wrm_fnc_V2nationChange;
	};
	sleep 0.1;
	if(_unit==leader _unit)then{[] call wrm_fnc_V2aiMove;};
	if(DBG)then{[format ["%1 - %2 respawn",(group _unit),_nameBW2]] remoteExec ["systemChat", 0, false];};
};

if(_secBW1&&(getMarkerColor _resFobW!=""))then //transport
{
	_en=[]; {if((side _x==_sideE)&&((_x distance _posBaseW1)<250))then{_en pushBackUnique _x;};} forEach allUnits;
	_df=[]; {if((side _x==_sideW)&&((_x distance _posBaseW1)<250))then{_df pushBackUnique _x;};} forEach allUnits;
	if((count _df)<((count _en)*1.5))then{_placed = true;};
	if(_placed)then{_unit setVehiclePosition [(selectRandom _resBaseW1W), [], 0, "NONE"];};
};
if(_placed)exitWith
{
	//Pritaikyti loadout ir nation change AI squado nariams (jei ne playableUnits)
	if(!(_unit in playableUnits))then
	{
		[_unit] call wrm_fnc_V2loadoutChange;
		[_unit] call wrm_fnc_V2nationChange;
	};
	sleep 0.1;
	if(_unit==leader _unit)then{[] call wrm_fnc_V2aiMove;};
	if(DBG)then{[format ["%1 - %2 respawn",(group _unit),_nameBW1]] remoteExec ["systemChat", 0, false];};
};

//SQUAD RESPAWN
if(resType>0)then
{
	if(({alive _x} count units group _unit) > 1)then
	{
		_grp=_ldrPl+_ldrAI+_players+_AIs;
		_man=_grp select 0;
		
		//find position behind _man
		_pR = _man getRelPos [100,random [135,180,225]];	
		_res = _pR findEmptyPosition [0,30,(typeOf vehicle _unit)];
		if(count _res==0)then{_res=_pR;};
		
		//check if respawn position is in the water
		if(!(_res isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))then
		{
			if( (!(getPos _man isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) && (!(isTouchingGround _man)) ) //is in the water and swims
			then{_res=[];}
			else{_res = (getPos _man) findEmptyPosition [0,20,(typeOf vehicle _unit)];};
		};
		if(count _res==0)exitWith{};
		
		//check if _man is flying
		if(vehicle _man isKindOf "air")exitWith{};
	
		//check if respawn position not colide with sector zones	
		if((_res distance posAA)<75)then{_res=selectRandom _resAAW;};
		if((_res distance posArti)<75)then{_res=selectRandom _resArtiW;};
		if((_res distance posCas)<75)then{_res=selectRandom _resCasW;};

		if((_res distance _posBaseW1)<75)then{if(_secBW1)then{_res=selectRandom _resBaseW1W;}else{_res=selectRandom _resBaseW1;};};
		if((_res distance _posBaseW2)<75)then{if(_secBW2)then{_res=selectRandom _resBaseW2W;}else{_res=selectRandom _resBaseW2;};};
		if((_res distance _posBaseE1)<75)then{if(_secBE1)then{_res=selectRandom _resBaseE1W;}else{_res=selectRandom _resBaseE1;};};
		if((_res distance _posBaseE2)<75)then{if(_secBE2)then{_res=selectRandom _resBaseE2W;}else{_res=selectRandom _resBaseE2;};};
		
		_unit setVehiclePosition [_res, [], 0, "NONE"]; //place _unit
		_placed = true;
	};
};
if(_placed)exitWith
{
	//Pritaikyti loadout ir nation change AI squado nariams (jei ne playableUnits)
	if(!(_unit in playableUnits))then
	{
		[_unit] call wrm_fnc_V2loadoutChange;
		[_unit] call wrm_fnc_V2nationChange;
	};
	sleep 0.1;
	if(_unit==leader _unit)then{[] call wrm_fnc_V2aiMove;};
	if(DBG)then{[format ["%1 - Squad respawn",(group _unit)]] remoteExec ["systemChat", 0, false];};
};

//SECTORS & BASES
if(({alive _x} count units group _unit) > 1)then
{
	_dis=[]; _res=[];
	_grp=_ldrPl+_ldrAI+_players+_AIs;
	_man=_grp select 0;
	
	//find closest sector to leader (_man)
	_dA=_man distance posAA;
	_dB=_man distance posArti;
	_dC=_man distance posCas;
	_dW1=_man distance _posBaseW1;
	_dW2=_man distance _posBaseW2;
	_dE1=_man distance _posBaseE1;
	_dE2=_man distance _posBaseE2;

	if(getMarkerColor _resAW!="")then{_dis pushBackUnique _dA; _res pushBackUnique _resAAW;};
	if(getMarkerColor _resBW!="")then{_dis pushBackUnique _dB; _res pushBackUnique _resArtiW;};
	if(getMarkerColor _resCW!="")then{_dis pushBackUnique _dC; _res pushBackUnique _resCasW;};
	if(getMarkerColor _resFobW!="")then{_dis pushBackUnique _dW1; if(_secBW1)then{_res pushBackUnique _resBaseW1W;}else{_res pushBackUnique _resBaseW1;};};
	if(getMarkerColor _resBaseW!="")then{_dis pushBackUnique _dW2; if(_secBW2)then{_res pushBackUnique _resBaseW2W;}else{_res pushBackUnique _resBaseW2;};};
	if(getMarkerColor _resFobEW!="")then{_dis pushBackUnique _dE1; _res pushBackUnique _resBaseE1W;};
	if(getMarkerColor _resBaseEW!="")then{_dis pushBackUnique _dE2; _res pushBackUnique _resBaseE2W;};
	
	_index = 0;
	_min = selectMin _dis;
	{if (_x == _min) then {_index = _forEachIndex};} forEach _dis;
	_r = _res select _index;
	
	_unit setVehiclePosition [(selectRandom _r), [], 0, "NONE"]; //place _unit
	_placed = true;
} else
{
	//sectors
	_res=[];
	if(getMarkerColor _resAW!="")then{_res pushBackUnique _resAAW;};
	if(getMarkerColor _resBW!="")then{_res pushBackUnique _resArtiW;};
	if(getMarkerColor _resCW!="")then{_res pushBackUnique _resCasW;};
	
	if(count _res!=0) then 
	{
		_unit setVehiclePosition [(selectRandom (selectRandom _res)), [], 0, "NONE"]; //place _unit
		_placed = true;
	};
	if(_placed)exitWith{};
	
	//bases
	_res=[];
	if(getMarkerColor _resFobW!="")then{if(_secBW1)then{_res pushBackUnique _resBaseW1W;}else{_res pushBackUnique _resBaseW1;};};
	if(getMarkerColor _resBaseW!="")then{if(_secBW2)then{_res pushBackUnique _resBaseW2W;}else{_res pushBackUnique _resBaseW2;};};
	if(getMarkerColor _resFobEW!="")then{_res pushBackUnique _resBaseE1W;};
	if(getMarkerColor _resBaseEW!="")then{_res pushBackUnique _resBaseE2W;};
	
	if(count _res!=0) then 
	{
		_unit setVehiclePosition [(selectRandom (selectRandom _res)), [], 0, "NONE"]; //place _unit
		_placed = true;
	};
};
if(_placed)exitWith
{
	//Pritaikyti loadout ir nation change AI squado nariams (jei ne playableUnits)
	if(!(_unit in playableUnits))then
	{
		[_unit] call wrm_fnc_V2loadoutChange;
		[_unit] call wrm_fnc_V2nationChange;
	};
	sleep 0.1;
	if(_unit==leader _unit)then{[] call wrm_fnc_V2aiMove;};
	if(DBG)then{[format ["%1 - Sector respawn",(group _unit)]] remoteExec ["systemChat", 0, false];};
};

if(DBG)then{[format ["%1 - Default respawn",(group _unit)]] remoteExec ["systemChat", 0, false];};
