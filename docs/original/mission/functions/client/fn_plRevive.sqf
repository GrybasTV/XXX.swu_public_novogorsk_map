/*
Author: IvosH

Description:
	AI revives player, runs on the players (_unit) PC

Parameter(s):
	_this: event handler parameters

Returns:
	nothing

Dependencies:
	markers.sqf
	revOn==2
	fn_aiRevive.sqf
	
Execution:
	[_this] spawn wrm_fnc_plRevive;
*/
params ["_unit","_selection","_damage","_hitIndex","_hitPoint","_shooter","_projectile",["_grp",[]],["_gpl",[]],["_dis",[]],["_min",0],["_inx",0],["_d",0],["_c",0]];
if(_unit in corpses)exitWith{};
if(!hasInterface)exitWith{};
if!(_damage>=1 && _hitPoint=="Incapacitated")exitWith{};

_t=
[
	"Help me. I'm down",
	"I need a medic",
	"Oh no, I'm bleeding. Help me",
	"My god, it hurts. I need help",
	"Give me some morphine, Help",
	"I'm hit. Somebody help me",
	"Don't leave me here",
	"I don't wanna die. Medic!"
];
[_unit,(selectRandom _t)] remoteExec ["groupChat", 0, false];

//sort AI team mates
{
	if(alive _x && !isPlayer _x && !(_x in healers) && !(_x in stuck))then{_grp PushBackUnique _x};
	if(alive _x && isPlayer _x)then{_gpl PushBackUnique _x};
} forEach ((units group _unit)-[_unit]);
if(count _grp<1)exitWith
{
	if(count _gpl<1)then{hint parseText format ["Nobody will help you dude<br/>Time to die"];};
	stuck=[];
};

//find closest AI team mate
{_dis PushBackUnique (_x distance _unit);} forEach _grp;
_min=selectMin _dis;
if(_min>300)exitWith
{
	if(count _gpl<1)then{hint parseText format ["Your friends are too far<br/>Game over man... Game over!"];};
	stuck=[];
};
{if(_x==_min)then{_inx=_forEachIndex;};}forEach _dis;
_healer = _grp select _inx;
corpses PushBackUnique _unit;
publicVariable "corpses";
healers PushBackUnique _healer;
publicVariable "healers";

//make healer dumb
[_unit,_healer,0] remoteExec ["wrm_fnc_aiRevive", 0, false];

if(vehicle _unit!=vehicle _healer) then //not in the same vehicle
{
	if(vehicle _unit!=_unit)then //pull player out of the vehicle
	{
		if((speed vehicle _unit<30)&&((getPos vehicle _unit select 2)<2))then{moveOut _unit;}else
		{
			_w=0;
			while {_w==0} do {
				if(((speed vehicle _unit<30)&&((getPos vehicle _unit select 2)<2))||(lifeState _unit != "INCAPACITATED"))then{_w=1;}
			};
			moveOut _unit;
		};
	};
	//move healer to player
	_w=0; _d=0;
	while {_w<10} do {			
		if((floor (_healer distance _unit)) >= _d)then
		{
			[_unit,_healer,1] remoteExec ["wrm_fnc_aiRevive", 0, false];
			_w=_w+1;
			//_tx=format["healer called %1. time",_w]; //DEBUG
			//systemChat _tx; //DEBUG
		};
		_d=floor (_healer distance _unit);
		if((_d<=2.5)||(!alive _healer)||(lifeState _unit != "INCAPACITATED"))then{_w=10;};
		hintSilent format ["%1 is %2 m away",(name _healer),_d];
		sleep 2;
	};

	if((_d>3)&&(alive _healer)&&(lifeState _unit == "INCAPACITATED"))exitWith{}; //healer is stuck
	if(!alive _healer)exitWith{}; //healer died
	if(lifeState _unit != "INCAPACITATED")exitWith{}; //player don't need revive (is alive or dead)
	//start healing
	[_unit,_healer,2] remoteExec ["wrm_fnc_aiRevive", 0, false];
}else{_c=1;};

if((_d>3)&&(alive _healer)&&(lifeState _unit == "INCAPACITATED"))exitWith //healer is stuck
{
	//make healer clever
	[_unit,_healer,3] remoteExec ["wrm_fnc_aiRevive", 0, false];
	corpses=corpses-[_unit]; 
	publicVariable "corpses";
	healers=healers-[_healer]; 
	publicVariable "healers";
	stuck PushBackUnique _healer;
	_t=
	[
		"Looks like he's busy",
		"He can't get to you",
		"He's pinned down?",
		"He's scared to death"
	];
	hint format ["%1",(selectRandom _t)];
	sleep 3; 
	_this spawn wrm_fnc_plRevive;
};

if(!alive _healer)exitWith //healer died
{
	//make healer clever
	[_unit,_healer,3] remoteExec ["wrm_fnc_aiRevive", 0, false];
	hint format ["Oh no! %1 is dead",(name _healer)];
	corpses=corpses-[_unit]; 
	publicVariable "corpses";
	healers=healers-[_healer]; 
	publicVariable "healers";
	sleep 3; 
	_this spawn wrm_fnc_plRevive;
};

if(lifeState _unit != "INCAPACITATED")exitWith //player don't need revive (is alive or dead)
{
	if((lifeState _unit == "HEALTHY")||(lifeState _unit == "INJURED"))then{hint "Welcome back";}else{hintSilent "";};
	//make healer clever
	[_unit,_healer,3] remoteExec ["wrm_fnc_aiRevive", 0, false];
	corpses=corpses-[_unit]; 
	publicVariable "corpses";
	healers=healers-[_healer]; 
	publicVariable "healers";
	stuck=[];
};

//revive player
_t=[
	"Don't worry. You're gonna make it",
	"Come on. Get up!",
	"Hold still. I'll fix it",
	"It's only a flesh wound. You're gonna be fine",
	"Keep it together dude. Not dying on me",
	"Some drugs for you sir",
	"Get back on your feet soldier!",
	"On your feet soldier, we still got a war to win"
];
hint format ["%1",(selectRandom _t)];
sleep 6;

if(!alive _healer)exitWith //healer died
{
	//make healer clever
	[_unit,_healer,3] remoteExec ["wrm_fnc_aiRevive", 0, false];
	hint format ["Oh no! %1 is dead",(name _healer)];
	corpses=corpses-[_unit]; 
	publicVariable "corpses";
	healers=healers-[_healer]; 
	publicVariable "healers";
	sleep 3;
	_this spawn wrm_fnc_plRevive;
};

if(lifeState _unit == "INCAPACITATED")then{["#rev",1,_unit] call BIS_fnc_reviveOnState;}; //revive player

//make healer clever
[_unit,_healer,3] remoteExec ["wrm_fnc_aiRevive", 0, false];
corpses=corpses-[_unit]; 
publicVariable "corpses";
healers=healers-[_healer]; 
publicVariable "healers";
stuck=[];
hintSilent "";

if(_c==1)then //ends Unconscious animation in the car
{
	_veh= vehicle player;
	moveOut player;
	player moveInAny _veh;
};