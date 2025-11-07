/*
	Author: IvosH
	
	Description:
		Change face, voice of the unit/player (mission start and respawn) 

	Parameter(s):
		0: VARIABLE unit
		
	Returns:
		NA
		
	Dependencies:
		V2factionChange.sqf
		V2playerSideChange.sqf
		fn_respawnEH.sqf ([_unit, (face _corpse), (speaker _corpse)] call BIS_fnc_setIdentity;)

	Execution:
	[_unit] call wrm_fnc_V2nationChange;
	[_x] execVM "V2nationChange";
*/
//Apgaubti visą skriptą call bloku, kad galėtume naudoti exitWith bet kurioje vietoje
call {
_un=_this select 0;

//Patikrinti, ar unit'as nėra null prieš naudojant
if (isNull _un) exitWith {}; //Jei unit'as yra null, išeiti

//Laukti, kol unit'as taps ne civilinis su timeout'u (jei niekada netampa, išeiti)
//Taip pat patikrinti, ar unit'as vis dar ne null
private _timeout = time + 10; //10 sekundžių timeout
waitUntil{(side _un!=civilian && !isNull _un) || time > _timeout};
if (time > _timeout || isNull _un) exitWith {}; //Jei timeout'as pasiektas arba unit'as null, išeiti

_conF=''; _conV=''; _conN="";
//Patikrinti, ar unit'as vis dar ne null prieš naudojant side
if (!isNull _un) then {
	call
	{
		if(side _un==sideW)exitWith
		{
			_conF=faceW;_conV=voiceW;_conN=nameW;
		};
		if(side _un==sideE)exitWith
		{
			_conF=faceE;_conV=voiceE;_conN=nameE;
		};
	};
} else {
	//Jei unit'as null, išeiti
	//exitWith negalima naudoti if-else bloke, todėl tiesiog išeiname iš skripto
};

//Patikrinti, ar gavome teisingas reikšmes (jei ne, reiškia unit'as buvo null arba neatitiko jokios pusės)
//Jei _conF yra tuščias, reiškia, kad nepavyko nustatyti frakcijos, todėl negalime tęsti
if (_conF == '' || _conV == '' || _conN == '') exitWith {
	//Jei reikšmės nėra nustatytos, išeiti iš funkcijos (jei kviečiama su call)
	//Jei vykdoma su execVM, tiesiog nebus vykdoma tolesnė logika
};

//voice
_voices=[];
//_cfgV="((getText(_x >> 'displayName') find _conV >= 0)&&(getText(_x >> 'displayName') find 'VR' == -1))" configClasses (configFile>>"cfgVoice");
if (_conV isEqualType [])
then {_voices = _conV;}
else {
		_cfgV="((str(getArray(_x >> 'identityTypes')) find _conV >= 0))" configClasses (configFile>>"cfgVoice");
		{
			_v = configName (_x);
			_voices pushBack _v;
		} forEach _cfgV;
	};
//Laukti, kol balsai bus rasti su timeout'u (jei niekada nerandami, naudoti default)
private _timeout = time + 5; //5 sekundžių timeout
waitUntil{count _voices!=0 || time > _timeout};
if (time > _timeout && count _voices == 0) exitWith {}; //Jei timeout'as pasiektas ir nėra balsų, išeiti
_voice=selectRandom _voices;

//Patikrinti, ar unit'as vis dar ne null prieš naudojant remoteExec
if (!isNull _un) then {
	[_un, _voice] remoteExec ["setSpeaker",0,true];
};

//face
_faces=[];
//Palaiikome ir masyvus (konkretūs veidų klasės) ir string'us (ieško config'e)
if (_conF isEqualType [])
then {
	//Jei masyvas, patikriname, ar visi veidai egzistuoja config'e
	{
		_faceClass = _x;
		if (typeName _faceClass == "STRING" && _faceClass != "") then
		{
			//Patikrinti, ar veidas egzistuoja config'e
			if (isClass (configFile >> "cfgFaces" >> "Man_A3" >> _faceClass)) then
			{
				_faces pushBack _faceClass;
			};
		};
	} forEach _conF;
	//Jei po filtravimo nėra veidų, naudojame default
	if (count _faces == 0) then
	{
		//Naudojame default NATO veidus
		_cfgF="(getText(_x >> 'head') find 'NATO' >= 0)" configClasses (configFile>>"cfgFaces">>"Man_A3");
		{
			_f = configName (_x);
			_faces pushBack _f;
		} forEach _cfgF;
	};
} else {
	//Jei string'as, ieškome config'e
	_cfgF="(getText(_x >> 'head') find _conF >= 0)" configClasses (configFile>>"cfgFaces">>"Man_A3");
	{
		_f = configName (_x);
		_faces pushBack _f;
	} forEach _cfgF;
};
//Laukti, kol veidai bus rasti su timeout'u (jei niekada nerandami, naudoti default)
_timeout = time + 5; //5 sekundžių timeout
waitUntil{count _faces!=0 || time > _timeout};
if (time > _timeout && count _faces == 0) exitWith {}; //Jei timeout'as pasiektas ir nėra veidų, išeiti
_face=selectRandom _faces;

//Patikrinti, ar veidas nėra tuščias ir unit'as ne null prieš naudojant
if (_face != "" && typeName _face == "STRING" && !isNull _un) then
{
	[_un, _face] remoteExec ["setFace",0,true];
};

//first name
_Fnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "FirstNames")];
{
	_n = getText (_x);
	_Fnames pushBackUnique _n;
} forEach _cfgN;
//Laukti, kol vardai bus rasti su timeout'u (jei niekada nerandami, naudoti default)
_timeout = time + 5; //5 sekundžių timeout
waitUntil{count _Fnames!=0 || time > _timeout};
if (time > _timeout && count _Fnames == 0) exitWith {}; //Jei timeout'as pasiektas ir nėra vardų, išeiti
_first=selectRandom _Fnames;

//second name
_Lnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "LastNames")];
{
	_n = getText (_x);
	_Lnames pushBackUnique _n;
} forEach _cfgN;
//Laukti, kol pavardės bus rastos su timeout'u (jei niekada nerandamos, naudoti default)
_timeout = time + 5; //5 sekundžių timeout
waitUntil{count _Lnames!=0 || time > _timeout};
if (time > _timeout && count _Lnames == 0) exitWith {}; //Jei timeout'as pasiektas ir nėra pavardių, išeiti
_second=selectRandom _Lnames;

//Patikrinti, ar unit'as ne null prieš naudojant setName
if (!isNull _un) then {
	[_un,[([_first," ",_second] joinString ""),_first,_second]] remoteExec ["setName", 0, true];
};
//systemChat "TEST";
}; //Uždaryti call bloką, kuris prasideda 23 eilutėje ir apgaubia visą skriptą