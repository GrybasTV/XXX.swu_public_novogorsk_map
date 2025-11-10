/*
	Author: IvosH
	
	Description:
		Create sector on the base if the enemy is close, base position is revealed and can be captured
		respawn markers:
		F: BaseW1 - resFobW / resFobWE / secBW1
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2secBW1;
*/


while {!secBW1} do 
{
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW1 < 200) then {secBW1=true;};
		};
	}  forEach allUnits;
	sleep 5;
};
publicvariable "secBW1";

["mFobW"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker
deleteMarker resFobW;
_nme=format ['F: %1',nameBW1];
_des=format ['Capture/Defend %1 base',nameBW1];
"ModuleSector_F" createUnit [posBaseW1,createGroup sideLogic,format
["
	sectorBW1=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name',_nme];
	this setVariable ['Designation','F'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resFobW!='''')exitWith{};
				_mrkRaW = createMarker [resFobW, posBaseW1];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBW1;
				deleteMarker resFobWE;
				
				_eBW1=true;
				{
					_unit=_x;
					if (side _unit==sideE) then
					{
						if (_unit distance posBaseW1 < 250) then {_eBW1=false;};
					};
				}  forEach allUnits;
				if((getMarkerColor resFobW!='''')&&(_eBW1))
				then{
					{_x hideObjectGlobal false,} forEach hideVehBW1;
					hideVehBW1=[];
				};
				if(dBW1)then{[posBaseW1,sideW] call wrm_fnc_V2secDefense;};
			 };
			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resFobWE!='''')exitWith{};
				_mrkRaW = createMarker [resFobWE, posBaseW1];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBW1;
				deleteMarker resFobW;
				if(dBW1)then{[posBaseW1,sideE] call wrm_fnc_V2secDefense;};
			 };
		};
		if (AIon>0) then {[] call wrm_fnc_V2aiMove;};
	'];
	this setVariable ['CaptureCoef','0.05']; 	
	this setVariable ['CostInfantry','0.2'];
	this setVariable ['CostWheeled','0.2'];
	this setVariable ['CostTracked','0.2'];
	this setVariable ['CostWater','0.2'];
	this setVariable ['CostAir','0.2'];
	this setVariable ['CostPlayers','0.2'];
	this setVariable ['DefaultOwner','-1'];
	this setVariable ['TaskOwner','3'];
	this setVariable ['TaskTitle',nameBW1];
	this setVariable ['taskDescription',_des];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
"]];	
[sectorBW1, sideW] call BIS_fnc_moduleSector; //initialize sector
[1] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBW1 = true;