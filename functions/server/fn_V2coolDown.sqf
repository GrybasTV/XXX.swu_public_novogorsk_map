/*
Author: IvosH

Description:
	Add actions (action menu) after time delay

Parameter(s):
	0: number

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf
	fn_airDrop
	fn_fortification
	fn_V2uavRequest
	
Execution:
	[1] spawn wrm_fnc_V2coolDown;
*/

//Patikrinti, ar funkcija gavo parametrus
//Funkcija gali būti kviečiama su vienu parametru (pvz., [1]) arba su trim parametrais (per-squad sistema: [11, playerUID, side])
if (isNil "_this" || {typeName _this != "ARRAY"} || {count _this == 0}) exitWith {};
private _tpe = _this select 0;

//Patikrinti, ar _tpe yra skaičius
if (isNil "_tpe" || {typeName _tpe != "SCALAR"}) exitWith {};

call
{
	//fortification
	if(_tpe<4)exitWith
	{
		sleep arTime;

		call
		{
			if(_tpe==1)exitWith{fort1 = 0; systemChat"Sandbags barricade tall is available";};
			if(_tpe==2)exitWith{fort2 = 0; systemChat"Sandbags barricade low is available";};
			if(_tpe==3)exitWith{fort3 = 0; systemChat"Sandbags barricade low is available";};
		};
		
		if(fort==1 && player==leader player)then
		{				
			fort=0;
			fortAction = player addAction 
			[
				"Fortification", //title
				{
					player removeAction fortAction;
					fort=1;
				}, //script
				nil, //arguments (Optional)
				0.3, //priority (Optional)
				false, //showWindow (Optional)
				false, //hideOnUse (Optional)
				"", //shortcut, (Optional) 
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection (Optional)
			];
		};
	};
	
	//UAV - atskiras 3 minučių cooldown (180 sekundžių)
	if(_tpe==5)exitWith
	{
		uavWr=180; //3 minutės cooldown
		publicvariable "uavWr";
		while {uavWr>0} do 
		{
			sleep 1;
			uavWr=uavWr-1;
			publicvariable "uavWr";
		};
		uavWr=0;
		publicvariable "uavWr";	
	};
	if(_tpe==6)exitWith
	{
		uavEr=180; //3 minutės cooldown
		publicvariable "uavEr";
		while {uavEr>0} do 
		{
			sleep 1;
			uavEr=uavEr-1;
			publicvariable "uavEr";
		};
		uavEr=0;
		publicvariable "uavEr";	
	};
	//UGV
	if(_tpe==7)exitWith
	{
		ugvWr=arTime; 
		publicvariable "ugvWr";
		while {ugvWr>0} do 
		{
			sleep 10;
			ugvWr=ugvWr-10;
			publicvariable "ugvWr";
		};
		ugvWr=0;
		publicvariable "ugvWr";	
	};
	if(_tpe==8)exitWith
	{
		ugvEr=arTime; 
		publicvariable "ugvEr";
		while {ugvEr>0} do 
		{
			sleep 10;
			ugvEr=ugvEr-10;
			publicvariable "ugvEr";
		};
		ugvEr=0;
		publicvariable "ugvEr";	
	};
	
	//Per-squad dronų cooldown (Ukraine 2025 / Russia 2025)
	//Parametrai: [cooldownType, playerUID, side]
	if(_tpe==11)exitWith //UAV WEST per-squad
	{
		//Patikrinti, ar yra antrasis parametras (playerUID)
		if (count _this < 2) exitWith {};
		_playerUID = _this select 1;
		if (isNil "_playerUID" || {typeName _playerUID != "STRING"}) exitWith {};
		_cooldownTime = droneCooldownTime;

		[format ["[UAV COOLDOWN] Starting cooldown for WEST player %1: %2 seconds", _playerUID, _cooldownTime]] remoteExec ["systemChat", 0, false];

		//Rasti žaidėjo droną masyve
		_index = -1;
		{
			if((_x select 0) == _playerUID)exitWith{_index = _forEachIndex;};
		}forEach uavSquadW;

		if(_index >= 0)then
		{
			_uavData = uavSquadW select _index;
			uavSquadW set [_index, [_playerUID, objNull, _cooldownTime]];
			publicvariable "uavSquadW"; //Sinchronizuoti pradžią

			//Cooldown loop - OPTIMALIZACIJA: nenaudoti publicVariable loop'e
			while {(uavSquadW select _index) select 2 > 0} do
			{
				sleep 10;
				_currentCooldown = (uavSquadW select _index) select 2;
				uavSquadW set [_index, [_playerUID, objNull, _currentCooldown - 10]];
				//Čia nekviečiame publicVariable - mažiname network overhead
			};

			//Cooldown baigtas
			uavSquadW set [_index, [_playerUID, objNull, 0]];
			publicvariable "uavSquadW"; //Sinchronizuoti pabaigą
			[format ["[UAV COOLDOWN] Cooldown finished for WEST player %1", _playerUID]] remoteExec ["systemChat", 0, false];
		} else {
			["[UAV COOLDOWN] ERROR: Could not find WEST player entry for cooldown"] remoteExec ["systemChat", 0, false];
		};
	};
	if(_tpe==12)exitWith //UAV EAST per-squad
	{
		//Patikrinti, ar yra antrasis parametras (playerUID)
		if (count _this < 2) exitWith {};
		_playerUID = _this select 1;
		if (isNil "_playerUID" || {typeName _playerUID != "STRING"}) exitWith {};
		_cooldownTime = droneCooldownTime;

		[format ["[UAV COOLDOWN] Starting cooldown for EAST player %1: %2 seconds", _playerUID, _cooldownTime]] remoteExec ["systemChat", 0, false];

		//Rasti žaidėjo droną masyve
		_index = -1;
		{
			if((_x select 0) == _playerUID)exitWith{_index = _forEachIndex;};
		}forEach uavSquadE;

		if(_index >= 0)then
		{
			_uavData = uavSquadE select _index;
			uavSquadE set [_index, [_playerUID, objNull, _cooldownTime]];
			publicvariable "uavSquadE"; //Sinchronizuoti pradžią

			//Cooldown loop - OPTIMALIZACIJA: nenaudoti publicVariable loop'e
			while {(uavSquadE select _index) select 2 > 0} do
			{
				sleep 10;
				_currentCooldown = (uavSquadE select _index) select 2;
				uavSquadE set [_index, [_playerUID, objNull, _currentCooldown - 10]];
				//Čia nekviečiame publicVariable - mažiname network overhead
			};

			//Cooldown baigtas
			uavSquadE set [_index, [_playerUID, objNull, 0]];
			publicvariable "uavSquadE"; //Sinchronizuoti pabaigą
			[format ["[UAV COOLDOWN] Cooldown finished for EAST player %1", _playerUID]] remoteExec ["systemChat", 0, false];
		} else {
			["[UAV COOLDOWN] ERROR: Could not find EAST player entry for cooldown"] remoteExec ["systemChat", 0, false];
		};
	};

	//AirDrop
	//Supplyes air drop
	if(_tpe==9)exitWith
	{
		sleep arTime;
		suppUsed = 0;
		if(player==leader player)then
		{
			systemChat "Supply airdrop is available";
			if(airDrop==1)then
			{
				supplyAction = player addAction 
				[
					"- Supply drop", //title
					{		
						openMap [true, false];
						["SupplyDrop"] spawn wrm_fnc_removeDrop;
						hint "Select SUPPLY drop location";
						["SupplyDrop", "onMapSingleClick", 
							{
								if(!surfaceIsWater _pos)then
								{
									_box = createVehicle [selectRandom supply, [_pos select 0, _pos select 1, 60], [], 0, "NONE"];
									[_box] call wrm_fnc_parachute;
									[z1,[[_box],true]] remoteExec ["addCuratorEditableObjects", 2, false];
									[_box,(str profileName),(side player)] remoteExec ["wrm_fnc_V2suppMrk", 0, true];
									suppUsed = 1;
									player removeAction supplyAction;
									if (modA=="GM") then {[_box,(side player)] call wrm_fnc_supplyBox};
									["SupplyDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
									[9] spawn wrm_fnc_V2coolDown;
									hint "Supplies delivered";
								}else{hint "Select position above ground";};
							}
						] call BIS_fnc_addStackedEventHandler;
					}, 
					nil, 0.8, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
				];
			};
		};
	};

	//Car air drop
	if(_tpe==10)exitWith
	{	
		sleep arTime;
		carUsed = 0;
		if(player==leader player)then
		{
			systemChat "Car airdrop is available";
			if(airDrop==1)then
			{	
				carAction = player addAction 
				[
					"- Car airdrop", //title
					{
						openMap [true, false];
						["CarDrop"] spawn wrm_fnc_removeDrop;
						hint "Select CAR airdrop location";
						["CarDrop", "onMapSingleClick", 
							{
								if(!surfaceIsWater _pos)then
								{
									_car = createVehicle [selectRandom car, [_pos select 0, _pos select 1, 60], [], 0, "NONE"];
									[_car] call wrm_fnc_parachute;
									_car setDir (getPos player getDir _pos);
									[z1,[[_car],true]] remoteExec ["addCuratorEditableObjects", 2, false];
									carUsed = 1;
									player removeAction carAction;
									["CarDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
									[10] spawn wrm_fnc_V2coolDown;
									hint "Car deployed";
								}else{hint "Select position above ground";};
							}
						] call BIS_fnc_addStackedEventHandler;
					}, 
					nil, 0.7, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
				];
			};
		};
	};

	//Boat air drop - pašalinta, nenaudojame	
	
};
