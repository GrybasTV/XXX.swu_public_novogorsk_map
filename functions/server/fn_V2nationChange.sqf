/*
	Author: IvosH
	Modified: CRITICAL FIX - Added timeout to ALL waitUntil to prevent scheduler deadlock
	
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

private _un = _this select 0;

// ========== TIMEOUT #1: Unit Side Change ==========
private _startTime1 = time;
waitUntil {
	sleep 0.5;
	(side _un != civilian) || (time - _startTime1 > 30)
};

if ((time - _startTime1 > 30) && (side _un == civilian)) exitWith {
	// ["ERROR: Unit did not change side - exiting nationChange"] remoteExec ["systemChat", 0, false];
};

// ========== Determine Configuration ==========
private _conF = '';
private _conV = '';
private _conN = '';

call {
	if (side _un == sideW) exitWith {
		_conF = faceW;
		_conV = voiceW;
		_conN = nameW;
	};
	if (side _un == sideE) exitWith {
		_conF = faceE;
		_conV = voiceE;
		_conN = nameE;
	};
	// Fallback
	_conN = "NATO";
};

// ========== VOICE Configuration ==========
private _voices = [];

if (voiceW isEqualType []) then {
	_voices = voiceW;
} else {
	private _cfgV = "((str(getArray(_x >> 'identityTypes')) find _conV >= 0))" configClasses (configFile >> "cfgVoice");
	{
		_voices pushBack (configName _x);
	} forEach _cfgV;
};

// TIMEOUT #2: Voices
private _startTime2 = time;
waitUntil {
	sleep 0.5;
	(count _voices != 0) || (time - _startTime2 > 10)
};

if (count _voices == 0) then {
	// ["WARNING: No voices found - using default"] remoteExec ["systemChat", 0, false];
	_voices = ["Male01ENG"];
};

private _voice = selectRandom _voices;
[_un, _voice] remoteExec ["setSpeaker", 0, true];

// ========== FACE Configuration ==========
private _faces = [];
private _cfgF = "(getText(_x >> 'head') find _conF >= 0)" configClasses (configFile >> "cfgFaces" >> "Man_A3");
{
	_faces pushBack (configName _x);
} forEach _cfgF;

// TIMEOUT #3: Faces
private _startTime3 = time;
waitUntil {
	sleep 0.5;
	(count _faces != 0) || (time - _startTime3 > 10)
};

if (count _faces == 0) then {
	// ["WARNING: No faces found - using default"] remoteExec ["systemChat", 0, false];
	_faces = ["WhiteHead_01"];
};

private _face = selectRandom _faces;
[_un, _face] remoteExec ["setFace", 0, true];

// ========== FIRST NAME Configuration ==========
private _Fnames = [];
if !(_conN isEqualTo "") then {
	private _cfgN = configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "FirstNames")];
	{
		_Fnames pushBackUnique (getText _x);
	} forEach _cfgN;
};

// TIMEOUT #4: First Names
private _startTime4 = time;
waitUntil {
	sleep 0.5;
	(count _Fnames != 0) || (time - _startTime4 > 10)
};

	// Fallback to custom names if config names are missing
	if (side _un == east) then {
		_Fnames = ["Aleksandr", "Sergei", "Vladimir", "Andrei", "Dmitri", "Alexei", "Maxim", "Yevgeny", "Ivan", "Mikhail", "Nikolai", "Yuri", "Vitaly", "Oleg", "Pavel", "Konstantin", "Viktor", "Igor", "Ruslan", "Vadim", "Artem", "Boris", "Gennady", "Stanislav", "Valery", "Anatoly", "Kirill", "Roman", "Denis", "Anton"];
	};
	if (side _un == west) then {
		_Fnames = ["Oleksandr", "Andriy", "Artem", "Bohdan", "Dmytro", "Ihor", "Maksym", "Oleh", "Pavlo", "Petro", "Sergiy", "Stepan", "Vasyl", "Viktor", "Vladyslav", "Yevhen", "Yuri", "Taras", "Mykola", "Volodymyr", "Ivan", "Mykhailo", "Roman", "Vitaliy", "Yaroslav", "Kyrylo", "Nazar", "Ruslan", "Vadym"];
	};
	// If still empty (e.g. civilian/resistance), fallback to John
	if (count _Fnames == 0) then { _Fnames = ["John"]; };


private _first = selectRandom _Fnames;

// ========== LAST NAME Configuration ==========
private _Lnames = [];
if !(_conN isEqualTo "") then {
	private _cfgN = configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "LastNames")];
	{
		_Lnames pushBackUnique (getText _x);
	} forEach _cfgN;
};

// TIMEOUT #5: Last Names
private _startTime5 = time;
waitUntil {
	sleep 0.5;
	(count _Lnames != 0) || (time - _startTime5 > 10)
};

if (count _Lnames == 0) then {
	// Fallback to custom names if config names are missing
	if (side _un == east) then {
		_Lnames = ["Ivanov", "Smirnov", "Kuznetsov", "Popov", "Vasilyev", "Petrov", "Sokolov", "Mikhailov", "Novikov", "Fedorov", "Morozov", "Volkov", "Alekseev", "Lebedev", "Semenov", "Egorov", "Pavlov", "Kozlov", "Stepanov", "Nikolaev", "Orlov", "Andreev", "Makarov", "Nikitin", "Zakharov", "Zaitsev", "Solovyov", "Borisov", "Yakovlev", "Grigoryev"];
	};
	if (side _un == west) then {
		_Lnames = ["Bondarenko", "Kovalenko", "Shevchenko", "Melnyk", "Kovalchuk", "Tkachenko", "Savchenko", "Oliynyk", "Boyko", "Rudenko", "Kravchenko", "Lysenko", "Petrenko", "Moroz", "Klymenko", "Pavlenko", "Vovk", "Kozak", "Polishchuk", "Ivanenko", "Symonenko", "Tkachuk", "Havrylyuk", "Danylenko"];
	};
	// If still empty, fallback to Doe
	if (count _Lnames == 0) then { _Lnames = ["Doe"]; };
};

private _second = selectRandom _Lnames;

// ========== Apply Name ==========
[_un, [([_first, " ", _second] joinString ""), _first, _second]] remoteExec ["setName", 0, true];