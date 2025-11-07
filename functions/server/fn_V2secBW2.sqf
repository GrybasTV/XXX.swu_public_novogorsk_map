/*
	Author: IvosH
	
	Description:
		Create sector on the base if the enemy is close, base position is revealed and can be captured
		respawn markers:
		G: BaseW2 - resBaseW / resBaseWE / secBW2
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2secBW2;
*/


while {!secBW2} do 
{
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW2 < 200) then {secBW2=true;};
		};
	}  forEach allUnits;
	sleep 5;
};
publicvariable "secBW2";

["mBaseW"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker
deleteMarker resBaseW;
_nme=format ['G: %1',nameBW2];
_des=format ['Capture/Defend %1 base',nameBW2];
"ModuleSector_F" createUnit [posBaseW2,createGroup sideLogic,format
["
	sectorBW2=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name',_nme];
	this setVariable ['Designation','G'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resBaseW!='''')exitWith{};
				_mrkRaW = createMarker [resBaseW, posBaseW2];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBW2;
				deleteMarker resBaseWE;

				_eBW2=true;
				{
					_unit=_x;
					if (side _unit==sideE) then
					{
						if (_unit distance posBaseW2 < 250) then {_eBW2=false;};
					};
				}  forEach allUnits;
				if((getMarkerColor resBaseW!='''')&&(_eBW2))
				then{
					{_x hideObjectGlobal false,} forEach hideVehBW2;
					hideVehBW2=[];
				};
				if(dBW2)then{[posBaseW2,sideW] call wrm_fnc_V2secDefense;};
			 };
			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resBaseWE!='''')exitWith{};
				_mrkRaW = createMarker [resBaseWE, posBaseW2];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBW2;
				deleteMarker resBaseW;
				if(dBW2)then{[posBaseW2,sideE] call wrm_fnc_V2secDefense;};
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
	this setVariable ['TaskTitle',nameBW2];
	this setVariable ['taskDescription',_des];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
"]];	
[sectorBW2, sideW] call BIS_fnc_moduleSector; //initialize sector
[2] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBW2 = true;