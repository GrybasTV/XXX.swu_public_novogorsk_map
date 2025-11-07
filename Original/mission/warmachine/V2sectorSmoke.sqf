/*
	Author: IvosH
	
	Description:
		Create smoke when player is close to the sector for the first time
	
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf

	Execution:
		[] execVM "warmachine\V2sectorSmoke.sqf";
*/
_a=true; _b=true; _c=true;

while {_a||_b||_c} do
{
	{
		if(!alive _x)exitWith{};
		if(_a)then{if((_x distance posAA < 300)&&(!alive objAAW)&&(!alive objAAE))then{"SmokeShellBlue" createVehicle posAA; _a=false;};};
		if(_b)then{if((_x distance posArti < 300)&&(!alive objArtiW)&&(!alive objArtiE))then{"SmokeShellYellow" createVehicle posArti; _b=false;};};
		if(_c)then{if((_x distance posCas < 300)&&(getMarkerColor resCW=="")&&(getMarkerColor resCE==""))then{"SmokeShellRed" createVehicle posCas; _c=false;};};
		
		if(_a)then{if((alive objAAW)||(alive objAAE))then{_a=false;};};
		if(_b)then{if((alive objArtiW)||(alive objArtiE))then{_b=false;};};
		if(_c)then{if((getMarkerColor resCW!="")||(getMarkerColor resCE!=""))then{_c=false;};};
	} forEach allPlayers;
	sleep 7;
};