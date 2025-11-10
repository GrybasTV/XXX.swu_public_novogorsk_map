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


//OPTIMIZATION: Pridėtas timeout'as ir pakeista į entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
private _timeout = time + 3600; //Maksimalus laukimo laikas 1 valanda
while {!secBE1 && time < _timeout} do
{
    //OPTIMIZATION: Naudoti entities vietoj allUnits - greitesnė ir efektyvesnė
    //Filtruoti PRIEŠ iteraciją - optimizacija
    private _allAliveUnits = entities [["Man"], [], true, false];
    if (count _allAliveUnits == 0) then {
        _allAliveUnits = allUnits select {alive _x};
    };

    private _enemyUnits = _allAliveUnits select {side _x == sideW};

    {
        if ((_x distance posBaseE1) < 200) then {
            secBE1 = true;
        };
        if (secBE1) exitWith {}; //Išeiti iš ciklo greičiau
    } forEach _enemyUnits;

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

				//OPTIMIZATION: Pakeisti allUnits į entities su filtravimu - VALIDUOTA SU ARMA 3 BEST PRACTICES
				_eBE1=true;
				{
					if (side _x == sideW && _x distance posBaseE1 < 250) then {_eBE1=false;};
				} forEach (entities [["Man"], [], true, false]);	
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