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
_un=_this select 0;

waitUntil{side _un!=civilian};

_conF=''; _conV=''; _conN="";
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

//voice
_voices=[];
//_cfgV="((getText(_x >> 'displayName') find _conV >= 0)&&(getText(_x >> 'displayName') find 'VR' == -1))" configClasses (configFile>>"cfgVoice");
if (voiceW isEqualType [])
then {_voices = voiceW;}
else {
		_cfgV="((str(getArray(_x >> 'identityTypes')) find _conV >= 0))" configClasses (configFile>>"cfgVoice");
		{
			_v = configName (_x);
			_voices pushBack _v;
		} forEach _cfgV;
	};
waitUntil{count _voices!=0};
_voice=selectRandom _voices;

[_un, _voice] remoteExec ["setSpeaker",0,true];

//face
_faces=[];
_cfgF="(getText(_x >> 'head') find _conF >= 0)" configClasses (configFile>>"cfgFaces">>"Man_A3");
{
	_f = configName (_x);
	_faces pushBack _f;
} forEach _cfgF;
waitUntil{count _faces!=0};
_face=selectRandom _faces;

[_un, _face] remoteExec ["setFace",0,true];

//first name
_Fnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "FirstNames")];
{
	_n = getText (_x);
	_Fnames pushBackUnique _n;
} forEach _cfgN;
waitUntil{count _Fnames!=0};
_first=selectRandom _Fnames;

//second name
_Lnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "LastNames")];
{
	_n = getText (_x);
	_Lnames pushBackUnique _n;
} forEach _cfgN;
waitUntil{count _Lnames!=0};
_second=selectRandom _Lnames;

[_un,[([_first," ",_second] joinString ""),_first,_second]] remoteExec ["setName", 0, true];
//systemChat "TEST";