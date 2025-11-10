/*
	Author: IvosH
	
	Description:
		Create sector on the base if the enemy is close, base position is revealed and can be captured
		respawn markers:
		E: BaseE2 - resBaseE / resBaseEW / secBE2
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2secBE2;
*/


//OPTIMIZATION: Pridėtas timeout'as ir pakeista į entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
private _timeout = time + 3600; //Maksimalus laukimo laikas 1 valanda
while {!secBE2 && time < _timeout} do
{
    //OPTIMIZATION: Naudoti entities vietoj allUnits - greitesnė ir efektyvesnė
    //Filtruoti PRIEŠ iteraciją - optimizacija
    private _allAliveUnits = entities [["Man"], [], true, false];
    if (count _allAliveUnits == 0) then {
        _allAliveUnits = allUnits select {alive _x};
    };

    private _enemyUnits = _allAliveUnits select {side _x == sideW};

    {
        if ((_x distance posBaseE2) < 200) then {
            secBE2 = true;
        };
        if (secBE2) exitWith {}; //Išeiti iš ciklo greičiau
    } forEach _enemyUnits;

    sleep 5;
};
publicvariable "secBE2";

// BE2 prieš sektoriaus kūrimą – išeiti, jei timeout ir neprisistatė priešas
if (!secBE2) exitWith {};  // sąlyga neįvykdyta – nieko nekuriam

//Pašalinti lokalius marker'ius TIK tada, kai sektorius sukurtas ir aktyvus
["mBaseE"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker (leidžia išvengti seno markerio „užšalimo“)
deleteMarker resBaseE;

// Paruošk reikšmes
private _nme = format ["E: %1", nameBE2];
private _des = format ["Capture/Defend %1 base", nameBE2];
// Kurk sektorių su teisingu format įterpimu ir sutvarkytomis citatomis
"ModuleSector_F" createUnit [
  posBaseE2,
  createGroup sideLogic,
  format ["
	sectorBE2=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
    this setVariable ['name','%1'];
	this setVariable ['Designation','E'];
	this setVariable ['OwnerLimit','1'];
    this setVariable ['OnOwnerChange', "['BE2', _this] execVM 'sectors\OnOwnerChange.sqf';"];
    this setVariable [''CaptureCoef'',0.05];
    this setVariable [''CostInfantry'',0.2];
    this setVariable [''CostWheeled'',0.2];
    this setVariable [''CostTracked'',0.2];
    this setVariable [''CostWater'',0.2];
    this setVariable [''CostAir'',0.2];
    this setVariable [''CostPlayers'',0.2];
    this setVariable [''DefaultOwner'',-1];
    this setVariable [''TaskOwner'',3];
    this setVariable [''TaskTitle'', nameBE2];
    this setVariable [''taskDescription'',''%2''];
    this setVariable [''Sides'',[sideE,sideW]];
    this setVariable [''objectArea'',[75,75,0,false]];
  ", _nme, _des]
];

// Palauk kol sectorBE2 bus priskirtas init string'e
waitUntil { !(isNil 'sectorBE2') };
[sectorBE2, sideE] call BIS_fnc_moduleSector; //initialize sector
[4] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBE2 = true;