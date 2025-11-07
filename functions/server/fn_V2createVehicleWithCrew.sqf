/*
	Author: Modified for Warmachine Conquest
	Based on: Crew System Analysis
	
	Description:
		Sukuria transporto priemonę su tinkamu crew naudojant crewW/crewE
		Vietoj createVehicleCrew, kuris naudoja predefined crew iš transporto priemonės config'o
		
	Parameter(s):
		0: _vehicleClass - transporto priemonės klasė (string arba array [class, texture])
		1: _position - pozicija (array [x, y, z] arba position)
		2: _side - pusė (sideW arba sideE)
		3: _crewClass - crew klasė (crewW arba crewE)
		4: _special - specialus tipas "NONE", "FLY", "CAN_COLLIDE" (default: "NONE")
		5: _texture - tekstūra (optional, jei _vehicleClass yra array)
		6: _dir - kryptis (optional)
		
	Returns:
		_vehicle - sukurta transporto priemonė su crew
		
	Dependencies:
		crewW / crewE iš frakcijų failų
		
	Execution:
		[_vehicleClass, _position, sideW, crewW, "NONE"] call wrm_fnc_V2createVehicleWithCrew;
*/

//Patikrinti, ar _this yra masyvas prieš naudojant
//Jei _this nėra masyvas arba yra nil, grąžiname objNull iškart
//Naudojame atskirus patikrinimus, kad būtų aišku
if (isNil "_this") exitWith {objNull;};
private _thisType = typeName _this;
if (_thisType != "ARRAY") exitWith {objNull;};

//Naudojame select sintaksę, kaip kitose vietose kode, su default reikšmėmis
//Tai yra saugiau, nes select nebus klaida, jei elemento nėra
//Papildomas patikrinimas su try-catch logika
private _thisCount = count _this;
_vehicleClass = if (_thisCount > 0) then {_this select 0} else {""};
_position = if (_thisCount > 1) then {_this select 1} else {[]};
_side = if (_thisCount > 2) then {_this select 2} else {sideW};
_crewClass = if (_thisCount > 3) then {_this select 3} else {""};
_special = if (_thisCount > 4) then {_this select 4} else {"NONE"};
_texture = if (_thisCount > 5) then {_this select 5} else {""};
_dir = if (_thisCount > 6) then {_this select 6} else {0};

//Patikrinti parametrus
if(_vehicleClass == "") exitWith {objNull;};
if(_crewClass == "") exitWith {objNull;};

//Konvertuoti Object poziciją į Array (jei _position yra Object, naudojame getPos)
//REIKIA PATIKRINTI TIPĄ PIRMA, PRIEŠ BANDANT count, KAD IŠVENGTI KLAIDŲ
if (isNil "_position") exitWith {objNull;};
private _positionType = typeName _position;
if (_positionType == "OBJECT") then
{
	//Konvertuoti Object į Array poziciją
	_position = getPos _position;
	_positionType = typeName _position;
};
//Patikrinti, ar pozicija yra Array su bent 2 elementais
if (_positionType != "ARRAY") exitWith {objNull;};
if (count _position < 2) exitWith {objNull;};

//Gauti vehicle class ir texture
_typ = "";
_tex = "";
if (_vehicleClass isEqualType []) then
{
	_typ = _vehicleClass select 0;
	_tex = _vehicleClass select 1;
} else
{
	_typ = _vehicleClass;
	_tex = _texture;
};

//Sukurti transporto priemonę
_vehicle = createVehicle [_typ, _position, [], 0, _special];

//Patikrinti, ar transporto priemonė sėkmingai sukurta
if (isNull _vehicle) exitWith {objNull;};

//Inicializuoti tekstūrą (jei yra)
if(_tex != "") then
{
	[_vehicle, [_tex, 1]] call bis_fnc_initVehicle;
};

//Nustatyti kryptį (jei nurodyta)
if(_dir != 0) then
{
	_vehicle setDir _dir;
};

//Patikrinti, ar transporto priemonė yra UAV/UGV tipo (neturėtų turėti crew)
//UAV/UGV dronai yra automatiniai ir neturėtų turėti pilotų ar crew
//Naudojame config patikrinimą ir klasės pavadinimo patikrinimą
private _isUAV = false;
private _isUGV = false;
if (!isNil "_typ" && _typ != "") then
{
	//Tikrinti config'e, ar transporto priemonė yra UAV
	_isUAV = getNumber (configFile >> "CfgVehicles" >> _typ >> "isUav") > 0;
	//Papildomas patikrinimas - jei klasės pavadinime yra UAV, UAFPV, FPV arba Crocus (dėl modų)
	if (!_isUAV) then
	{
		_isUAV = (str _typ find "UAV" >= 0) || (str _typ find "UAFPV" >= 0) || (str _typ find "FPV" >= 0) || (str _typ find "Crocus" >= 0);
	};
	//Tikrinti, ar transporto priemonė yra UGV (jei klasės pavadinime yra UGV)
	if (!_isUAV) then
	{
		_isUGV = (str _typ find "UGV" >= 0);
	};
};
//Patikrinti, ar transporto priemonė turi bet kokias crew pozicijas
//Jei neturi jokių crew pozicijų (Driver, Gunner, Commander), tai tikriausiai UAV/UGV ir neturėtų turėti crew
private _hasCrewPositions = (_vehicle emptyPositions "Driver" > 0) || (_vehicle emptyPositions "Gunner" > 0) || (_vehicle emptyPositions "Commander" > 0);
//Crew reikia tik jei transporto priemonė NĖRA UAV/UGV IR turi crew pozicijas
private _needsCrew = !(_isUAV || _isUGV) && _hasCrewPositions;

//Pašalinti seną crew (jei yra) - tik jei ne UAV/UGV
//createVehicleCrew gali sukurti crew automatiškai, jei transporto priemonė turi predefined crew config'e
//Todėl pašaliname visą crew prieš sukurdami naują
//Patikrinti, ar transporto priemonė turi crew prieš bandant pašalinti
if (_needsCrew && !isNull _vehicle && {count crew _vehicle > 0}) then
{
	{ _vehicle deleteVehicleCrew _x } forEach crew _vehicle;
};

//Sukurti crew tik jei transporto priemonė nėra UAV/UGV
if (_needsCrew) then
{
	//Sukurti naują grupę
	_grp = createGroup [_side, true];

	//Driver (jei transporto priemonė turi Driver poziciją)
	if (_vehicle emptyPositions "Driver" > 0) then
	{
		_unit = _grp createUnit [_crewClass, _position, [], 0, "NONE"];
		_unit moveInDriver _vehicle;
	};

	//Gunner (jei yra) - ciklas per visas šaulio pozicijas (naudinga technikai su keliais bokšteliais)
	//Naudojame tą pačią sintaksę kaip kitose vietose kode - moveInGunner automatiškai užpildo pirmą laisvą poziciją
	for "_i" from 1 to (_vehicle emptyPositions "Gunner") do
	{
		_unit = _grp createUnit [_crewClass, _position, [], 0, "NONE"];
		_unit moveInGunner _vehicle;
	};

	//Commander (jei yra) - ciklas per visas komanduotojo pozicijas (retai, bet gali būti kelios)
	//Naudojame tą pačią sintaksę kaip kitose vietose kode - moveInCommander automatiškai užpildo pirmą laisvą poziciją
	for "_i" from 1 to (_vehicle emptyPositions "Commander") do
	{
		_unit = _grp createUnit [_crewClass, _position, [], 0, "NONE"];
		_unit moveInCommander _vehicle;
	};

	//Cargo (jei yra) - tik pirmas cargo, daugiau cargo dažniausiai nereikia AI transporto priemonėms
	//Bet jei reikia, galima pridėti daugiau
	if (_vehicle emptyPositions "Cargo" > 0) then
	{
		_unit = _grp createUnit [_crewClass, _position, [], 0, "NONE"];
		_unit moveInCargo [_vehicle, 0];
	};
} else
{
	//UAV/UGV - pašalinti visą crew, jei sukurtas automatiškai
	if (!isNull _vehicle && {count crew _vehicle > 0}) then
	{
		{ _vehicle deleteVehicleCrew _x } forEach crew _vehicle;
	};
};

//Grąžinti transporto priemonę
_vehicle;

