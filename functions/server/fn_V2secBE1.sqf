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

// BE1 prieš sektoriaus kūrimą – išeiti, jei timeout ir neprisistatė priešas
if (!secBE1) exitWith {
    if(DBG)then{diag_log "[SECTOR_CREATION] BE1 sector creation skipped - timeout reached"};
};  // sąlyga neįvykdyta – nieko nekuriam

//Pašalinti lokalius marker'ius TIK tada, kai sektorius sukurtas ir aktyvus
["mFobE"] remoteExec ["deleteMarkerLocal", 0, true]; //delete local marker (užtikrina, kad nepradėtų dubliuotis mFobE)
deleteMarker resFobE;

// Paruošk reikšmes
private _nme = format ["D: %1", nameBE1];
private _des = format ["Capture/Defend %1 base", nameBE1];
if(DBG)then{diag_log format ["[SECTOR_CREATION] Starting BE1 sector creation at %1", posBaseE1]};
// Kurk sektorių su teisingu format įterpimu ir sutvarkytomis citatomis
"ModuleSector_F" createUnit [
  posBaseE1,
  createGroup sideLogic,
  format ["
    sectorBE1=this;
    this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
    this setVariable ['name','%1'];
    this setVariable ['Designation','D'];
    this setVariable ['OwnerLimit','1'];
    this setVariable ['OnOwnerChange', format ["['%1', _this] execVM 'sectors\OnOwnerChange.sqf';", 'BE1']];
    this setVariable [''CaptureCoef'',0.05];
    this setVariable [''CostInfantry'',0.2];
    this setVariable [''CostWheeled'',0.2];
    this setVariable [''CostTracked'',0.2];
    this setVariable [''CostWater'',0.2];
    this setVariable [''CostAir'',0.2];
    this setVariable [''CostPlayers'',0.2];
    this setVariable [''DefaultOwner'',-1];
    this setVariable [''TaskOwner'',3];
    this setVariable [''TaskTitle'', nameBE1];
    this setVariable [''taskDescription'',''%2''];
    this setVariable [''Sides'',[sideE,sideW]];
    this setVariable [''objectArea'',[75,75,0,false]];
  ", _nme, _des]
];

// Palauk kol sectorBE1 bus priskirtas init string'e
waitUntil { !(isNil 'sectorBE1') };
[sectorBE1, sideE] call BIS_fnc_moduleSector; //initialize sector
if(DBG)then{diag_log "[SECTOR_CREATION] BE1 sector created and initialized successfully"};
[3] remoteExec ["wrm_fnc_V2hints", 0, false]; //hint
sleep 7;
dBE1 = true;