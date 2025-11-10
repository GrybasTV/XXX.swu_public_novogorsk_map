/*
Author: IvosH

Description:
	Add actions for airdrop

Parameter(s):
	none

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf

Execution:
	[] call wrm_fnc_airDrop
*/

if(progress<2)exitWith{};

//Boat drop pašalintas - nenaudojame
call
{
	if (side player == sideW) exitWith {supply=supplyW; car=CarW; truck=TruckW;};
	If (side player == sideE) exitWith {supply=supplyE; car=CarE; truck=TruckE;};
};

////////////////
if (suppUsed==0) then
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
						[_box,(str profileName),(side player)] remoteExec ["wrm_fnc_V2suppMrk", 0, false];
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

if (carUsed==0) then
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

if (truckUsed==0) then
{
	truckAction = player addAction 
	[
		"- Truck airdrop", //title
		{
			openMap [true, false];
			["TruckDrop"] spawn wrm_fnc_removeDrop;
			hint "Select TRUCK airdrop location";
			["TruckDrop", "onMapSingleClick", 
				{
					if(!surfaceIsWater _pos)then
					{
						_car = createVehicle [selectRandom truck, [_pos select 0, _pos select 1, 60], [], 0, "NONE"];
						[_car] call wrm_fnc_parachute;
						_car setDir (getPos player getDir _pos);
						[z1,[[_car],true]] remoteExec ["addCuratorEditableObjects", 2, false];
						truckUsed = 1;
						player removeAction truckAction;
						["TruckDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						hint "Truck deployed";
					}else{hint "Select position above ground";};
				}
			] call BIS_fnc_addStackedEventHandler;
		}, 
		nil, 0.6, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
	]; 
};

//Boat drop funkcijos pašalintos - nenaudojame
