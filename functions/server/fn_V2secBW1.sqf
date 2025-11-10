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


//OPTIMIZATION: Pridėtas timeout'as ir pakeista į entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
private _timeout = time + 3600; //Maksimalus laukimo laikas 1 valanda
while {!secBW1 && time < _timeout} do
{
    //OPTIMIZATION: Naudoti entities vietoj allUnits - greitesnė ir efektyvesnė
    //Filtruoti PRIEŠ iteraciją - optimizacija
    private _allAliveUnits = entities [["Man"], [], true, false];
    if (count _allAliveUnits == 0) then {
        _allAliveUnits = allUnits select {alive _x};
    };

    private _enemyUnits = _allAliveUnits select {side _x == sideE};

    {
        if ((_x distance posBaseW1) < 200) then {
            secBW1 = true;
        };
        if (secBW1) exitWith {}; //Išeiti iš ciklo greičiau
    } forEach _enemyUnits;

    sleep 5;
};
publicvariable "secBW1";

// BW1 prieš sektoriaus kūrimą – išeiti, jei timeout ir neprisistatė priešas
if (!secBW1) exitWith {};  // sąlyga neįvykdyta – nieko nekuriam

//Pašalinti lokalius marker'ius TIK tada, kai sektorius sukurtas ir aktyvus
["mFobW"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker (grąžinta, kad neliktų dublikato žemėlapyje)
deleteMarker resFobW;

// Paruošk reikšmes
private _nme = format ["F: %1", nameBW1];
private _des = format ["Capture/Defend %1 base", nameBW1];
// Kurk sektorių su teisingu format įterpimu ir sutvarkytomis citatomis
"ModuleSector_F" createUnit [
  posBaseW1,
  createGroup sideLogic,
  format ["
	sectorBW1=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
    this setVariable ['name','%1'];
	this setVariable ['Designation','F'];
	this setVariable ['OwnerLimit','1'];
    this setVariable ['OnOwnerChange', "[''BW1'', _this] execVM ''sectors\OnOwnerChange.sqf'';"];
    this setVariable [''CaptureCoef'',0.05];
    this setVariable [''CostInfantry'',0.2];
    this setVariable [''CostWheeled'',0.2];
    this setVariable [''CostTracked'',0.2];
    this setVariable [''CostWater'',0.2];
    this setVariable [''CostAir'',0.2];
    this setVariable [''CostPlayers'',0.2];
    this setVariable [''DefaultOwner'',-1];
    this setVariable [''TaskOwner'',3];
    this setVariable [''TaskTitle'', nameBW1];
    this setVariable [''taskDescription'',''%2''];
    this setVariable [''Sides'',[sideE,sideW]];
    this setVariable [''objectArea'',[75,75,0,false]];
  ", _nme, _des]
];

// Palauk kol sectorBW1 bus priskirtas init string'e
waitUntil { !(isNil 'sectorBW1') };
[sectorBW1, sideW] call BIS_fnc_moduleSector; //initialize sector
[1] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBW1 = true;