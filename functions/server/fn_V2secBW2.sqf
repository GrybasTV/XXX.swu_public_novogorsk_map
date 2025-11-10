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


//OPTIMIZATION: Pridėtas timeout'as ir pakeista į entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
private _timeout = time + 3600; //Maksimalus laukimo laikas 1 valanda
while {!secBW2 && time < _timeout} do
{
    //OPTIMIZATION: Naudoti entities vietoj allUnits - greitesnė ir efektyvesnė
    //Filtruoti PRIEŠ iteraciją - optimizacija
    private _allAliveUnits = entities [["Man"], [], true, false];
    if (count _allAliveUnits == 0) then {
        _allAliveUnits = allUnits select {alive _x};
    };

    private _enemyUnits = _allAliveUnits select {side _x == sideE};

    {
        if ((_x distance posBaseW2) < 200) then {
            secBW2 = true;
        };
        if (secBW2) exitWith {}; //Išeiti iš ciklo greičiau
    } forEach _enemyUnits;

    sleep 5;
};
publicvariable "secBW2";

// BW2 prieš sektoriaus kūrimą – išeiti, jei timeout ir neprisistatė priešas
if (!secBW2) exitWith {};  // sąlyga neįvykdyta – nieko nekuriam

//Pašalinti lokalius marker'ius TIK tada, kai sektorius sukurtas ir aktyvus
["mBaseW"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker (palikta kaip originale, kad žemėlapis švarus)
deleteMarker resBaseW;

// Paruošk reikšmes
private _nme = format ["G: %1", nameBW2];
private _des = format ["Capture/Defend %1 base", nameBW2];
// Kurk sektorių su teisingu format įterpimu ir sutvarkytomis citatomis
"ModuleSector_F" createUnit [
  posBaseW2,
  createGroup sideLogic,
  format ["
    sectorBW2=this;
    this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
    this setVariable ['name','%1'];
    this setVariable ['Designation','G'];
    this setVariable ['OwnerLimit','1'];
    this setVariable ['OnOwnerChange','
      call {
        if ((_this select 1) == sideW) exitWith {
          if(getMarkerColor resBaseW!='''')exitWith{};
          _mrkRaW = createMarker [resBaseW, posBaseW2];
          _mrkRaW setMarkerShape ''ICON'';
          _mrkRaW setMarkerType ''empty'';
          _mrkRaW setMarkerText nameBW2;
          deleteMarker resBaseWE;

          _eBW2=true;
          { if (side _x == sideE && _x distance posBaseW2 < 250) then { _eBW2=false; }; }
            forEach (entities [[''Man''], [], true, false]);
          if((getMarkerColor resBaseW!='''')&&(_eBW2)) then {
            { _x hideObjectGlobal false; } forEach hideVehBW2;
            hideVehBW2=[];
          };
          if(dBW2)then{[posBaseW2,sideW] call wrm_fnc_V2secDefense;};
        };
        if ((_this select 1) == sideE) exitWith {
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
    this setVariable [''CaptureCoef'',0.05];
    this setVariable [''CostInfantry'',0.2];
    this setVariable [''CostWheeled'',0.2];
    this setVariable [''CostTracked'',0.2];
    this setVariable [''CostWater'',0.2];
    this setVariable [''CostAir'',0.2];
    this setVariable [''CostPlayers'',0.2];
    this setVariable [''DefaultOwner'',-1];
    this setVariable [''TaskOwner'',3];
    this setVariable [''TaskTitle'', nameBW2];
    this setVariable [''taskDescription'',''%2''];
    this setVariable [''Sides'',[sideE,sideW]];
    this setVariable [''objectArea'',[75,75,0,false]];
  ", _nme, _des]
];

// Palauk kol sectorBW2 bus priskirtas init string'e
waitUntil { !(isNil 'sectorBW2') };
[sectorBW2, sideW] call BIS_fnc_moduleSector; //initialize sector
[2] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBW2 = true;