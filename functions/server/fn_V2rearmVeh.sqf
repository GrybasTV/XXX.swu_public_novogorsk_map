/*
	Author: IvosH
	
	Description:
		Rearm, repair and refuel the vehicle at the base or runway
		
	Parameter(s):
		0: VARIABLE player
		
	Returns:
		NA
		
	Dependencies:
		V2startServer.sqf

	Execution:
		[player] call wrm_fnc_V2rearmVeh;
*/

_player=_this select 0;
_veh=vehicle _player;

if(progress<2)exitWith{};

_zone=[]; _side=sideE;
// Patikriname, ar kintamieji yra apibrėžti prieš juos naudojant
_plHWDefined = !isNil "plHW";
_plHEDefined = !isNil "plHE";

if(_veh isKindOf "air")then
{
	if(_plHWDefined) then {
		_zone=[getPos plHW]+rHeliTrW+rHeliArW;
	};
	if(side _player==sideE && _plHEDefined)then{_zone=[getPos plHE]+rHeliTrE+rHeliArE; _side=sideW;};
};
if(_veh isKindOf "landVehicle")then
{
	if(_plHWDefined) then {
		_zone=[(getPos plHW),posBaseW1,posBaseW2];
	};
	if(side _player==sideE && _plHEDefined)then{_zone=[(getPos plHE),posBaseE1,posBaseE2]; _side=sideW;};
};

_exit=true;
{if((_veh distance _x)<100)then{_exit=false;};}forEach _zone;
if(_exit)exitWith{hint "You can rearm at the base";};

{if((_veh distance _x)<250)then{_exit=true;};} forEach units _side;
if(_exit)exitWith{hint "Enemy is too close. There is no time to rearm.";};

//rearm
[_veh,1] remoteExec ["setVehicleAmmoDef", 0, false];
_mags=getPylonMagazines _veh;
if(count _mags>0)then
{
	for "_i" from 1 to (count _mags) step 1 do
	{
		[_veh,[_i,(_mags select (_i-1))]] remoteExec ["setPylonLoadout", 0, false];
		//_veh setPylonLoadout [_i,(_mags select (_i-1))];
	};
};
//repair
_veh setDamage 0;
//refuel
[_veh,1] remoteExec ["setFuel", 0, false];
hint "Vehicle rearmed";