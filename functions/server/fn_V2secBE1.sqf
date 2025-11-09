/*
	Author: IvosH
	
	Description:
		Create sector on the base if the enemy is close, base position is revealed and can be captured
		respawn markers:
		D: BaseE1 - resFobE / resFobEW / secBE1
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2secBE1;
*/


while {!secBE1} do 
{
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE1 < 200) then {secBE1=true;};
		};
	}  forEach allUnits;
	sleep 5;
};
publicvariable "secBE1";

//Pašalinti lokalius marker'ius TIK tada, kai sektorius sukurtas ir aktyvus
["mFobE"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker (užtikrina, kad nepradėtų dubliuotis mFobE)
deleteMarker resFobE;
_nme=format ['D: %1',nameBE1];
_des=format ['Capture/Defend %1 base',nameBE1];
"ModuleSector_F" createUnit [posBaseE1,createGroup sideLogic,format
["
	sectorBE1=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name',_nme];
	this setVariable ['Designation','D'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resFobEW!='''')exitWith{};
				_mrkRaW = createMarker [resFobEW, posBaseE1];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBE1;
				deleteMarker resFobE;
				if(dBE1)then{[posBaseE1,sideW] call wrm_fnc_V2secDefense;};
			 };
			 
			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resFobE!='''')exitWith{};
				_mrkRaW = createMarker [resFobE, posBaseE1];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText nameBE1;
				deleteMarker resFobEW;

				_eBE1=true;
				{
					_unit=_x;
					if (side _unit==sideW) then
					{
						if (_unit distance posBaseE1 < 250) then {_eBE1=false;};
					};
				}  forEach allUnits;	
				if((getMarkerColor resFobE!='''')&&(_eBE1))
				then{
					{_x hideObjectGlobal false,} forEach hideVehBE1;
					hideVehBE1=[];
				};
				if(dBE1)then{[posBaseE1,sideE] call wrm_fnc_V2secDefense;};
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
	this setVariable ['TaskTitle',nameBE1];
	this setVariable ['taskDescription',_des];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
"]];	
[sectorBE1, sideE] call BIS_fnc_moduleSector; //initialize sector
[3] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBE1 = true;