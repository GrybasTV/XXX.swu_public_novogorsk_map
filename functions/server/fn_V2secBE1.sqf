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
	sleep 10; //Padidintas intervalas nuo 5 iki 10 sek. mažinti apkrovą
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE1 < 200) then {
				secBE1=true;
				diag_log format ["[V2secBE1] Sector activation triggered by unit: %1 at distance: %2", _unit, _unit distance posBaseE1];
			};
		};
	}  forEach (allUnits + allPlayers); // Include both AI and players
};
publicvariable "secBE1";

diag_log "[V2secBE1] Starting sector creation";
["mFobE"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker
deleteMarker resFobE;
_nme=format ['D: %1',nameBE1];
_des=format ['Capture/Defend %1 base',nameBE1];
"ModuleSector_F" createUnit [posBaseE1,createGroup sideLogic,format
["
	sectorBE1=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name','%1'];
	this setVariable ['Designation','D'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith
			 {
				if(getMarkerColor resFobWE != '''') exitWith {};
				_mrkRaE = createMarker [resFobWE, posBaseE1];
				_mrkRaE setMarkerShape ''ICON'';
				_mrkRaE setMarkerType ''empty'';
				_mrkRaE setMarkerText nameBE1;
				deleteMarker resFobE;
				if(dBE1)then{[posBaseE1,sideW] call wrm_fnc_V2secDefense;};
			 };

			 if ((_this select 1) == sideE) exitWith
			 {
				if(getMarkerColor resFobE != '''') exitWith {};
				_mrkRaE = createMarker [resFobE, posBaseE1];
				_mrkRaE setMarkerShape ''ICON'';
				_mrkRaE setMarkerType ''empty'';
				_mrkRaE setMarkerText nameBE1;
				deleteMarker resFobWE;

				_eBE1=true;
				{
					_unit=_x;
					if (side _unit==sideW) then
					{
						if (_unit distance posBaseE1 < 250) then {_eBE1=false;};
					};
				}  forEach (allUnits + allPlayers); // Include both AI and players
				if((getMarkerColor resFobE != '''')&&(_eBE1))
				then{
					{_x hideObjectGlobal false;} forEach hideVehBE1;
					hideVehBE1=[];
				};
				if(dBE1)then{[posBaseE1,sideE] call wrm_fnc_V2secDefense;};
			 };
		};
		if (AIon>0) then {[] spawn wrm_fnc_V2aiMove;};
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
	this setVariable ['taskDescription','%2'];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
",_nme,_des]];

diag_log format ["[V2secBE1] Sector object created: %1", sectorBE1];
if (!isNil "sectorBE1") then {
	diag_log "[V2secBE1] Initializing sector with BIS_fnc_moduleSector";
	[sectorBE1, sideE] call BIS_fnc_moduleSector; //initialize sector
	diag_log "[V2secBE1] Sector initialization completed";
} else {
	diag_log "[V2secBE1] ERROR: sectorBE1 is nil - sector creation failed";
};

[3] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBE1 = true;
diag_log "[V2secBE1] Sector setup completed successfully";