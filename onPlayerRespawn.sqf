//Author: IvosH
_corpse=_this select 1;
player setSpeaker (speaker _corpse);
[player, (speaker _corpse)] remoteExec ["setSpeaker",0,false];
[player, (face _corpse)] remoteExec ["setFace",0,false];

//Pritaikyti loadout'ą pagal žaidėjo klasę (Ukraine 2025 / Russia 2025)
[player] call wrm_fnc_V2loadoutChange;

[z1,[[player],true]] remoteExec ["addCuratorEditableObjects", 2, false]; //add unit to zeus

//variables setup
lUpdate = 0;
airDrop=0;
fort = 0;
//boatTrUsed = 0;
if(progress>1)then{hintSilent"";};

//respawn at the sector, random position around the sector
if (progress>1) then 
{
	sleep 0.015;
	call
	{
		if(version==2)exitWith
		{
			if(vehicle player != player)exitWith{};
			
			//side WEST
			_posBaseW1=posBaseW1;
			_posBaseW2=posBaseW2;
			_secBW2=secBW2;
			_resBaseW2W=resBaseW2W;
			_secBW1=secBW1;
			_resBaseW1W=resBaseW1W;
			_resAAW=resAAW;
			_resArtiW=resArtiW;
			_resCasW=resCasW;
			_resBaseW1=resBaseW1;
			_resBaseW2=resBaseW2;
			_posBaseE1=posBaseE1;
			_secBE1=secBE1;
			_resBaseE1W=resBaseE1W;
			_resBaseE1=resBaseE1;
			_posBaseE2=posBaseE2;
			_secBE2=secBE2;
			_resBaseE2W=resBaseE2W;
			_resBaseE2=resBaseE2;

			//side EAST
			if (side player==sideE) then 
			{
				_posBaseW1=posBaseE1;
				_posBaseW2=posBaseE2;
				_secBW2=secBE2;
				_resBaseW2W=resBaseE2E;
				_secBW1=secBE1;
				_resBaseW1W=resBaseE1E;
				_resAAW=resAAE;
				_resArtiW=resArtiE;
				_resCasW=resCasE;
				_resBaseW1=resBaseE1;
				_resBaseW2=resBaseE2;
				_posBaseE1=posBaseW1;
				_secBE1=secBW1;
				_resBaseE1W=resBaseW1E;
				_resBaseE1=resBaseW1;
				_posBaseE2=posBaseW2;
				_secBE2=secBW2;
				_resBaseE2W=resBaseW2E;
				_resBaseE2=resBaseW2;
			};

			_res=[];
			//sector
			if((player distance posAA)<75)then{_res=selectRandom _resAAW;};
			if((player distance posArti)<75)then{_res=selectRandom _resArtiW;};
			if((player distance posCas)<75)then{_res=selectRandom _resCasW;};
			//friendly bases
			if((player distance _posBaseW1)<75)then{if(_secBW1)then{_res=selectRandom _resBaseW1W;}else{_res=selectRandom _resBaseW1;};};
			if((player distance _posBaseW2)<75)then{if(_secBW2)then{_res=selectRandom _resBaseW2W;}else{_res=selectRandom _resBaseW2;};};
			//enemy bases
			if((player distance _posBaseE1)<75)then{_res=selectRandom _resBaseE1W;};
			if((player distance _posBaseE2)<75)then{_res=selectRandom _resBaseE2W;};
			
			if(count _res!=0)then{player setVehiclePosition [_res, [], 0, "NONE"];};
		};
		
		if(version==1)exitWith
		{
			if (resType>0) then
			{
				_r=0;
				if((player distance posAlpha)<50)then{_r=1;};
				if(secNo>0)then{if((player distance posBravo)<50)then{_r=2;};};
				if(secNo>1)then{if((player distance posCharlie)<50)then{_r=3;};};
				if(_r==0)exitWith{};
				_posR=[];
				call
				{
					if(_r==1)exitWith{if(side player==sideW)then{_posR=RpAw;}else{_posR=RpAe;};};
					if(_r==2)exitWith{if(side player==sideW)then{_posR=RpBw;}else{_posR=RpBe;};};
					if(_r==3)exitWith{if(side player==sideW)then{_posR=RpCw;}else{_posR=RpCe;};};
				};
				player setVehiclePosition [(selectRandom _posR), [], 0, "NONE"];
			};
		};
	};
};

sleep 1;
[] spawn wrm_fnc_leaderActions;
[] call wrm_fnc_fortification;

flipAction = player addAction 
[
	"Flip vehicle", //title
	{[] spawn wrm_fnc_flipVeh;}, //script 
	nil, 6, true, true, "", //arguments, priority, showWindow, hideOnUse, shortcut, 
	"(cursorTarget isKindOf ""LandVehicle"")&&(cursorTarget distance player<10)&&(vectorUP cursorTarget select 2 < 0.5)", //condition,
	-1, false, "" //radius, unconscious, selection
];

pushAction = player addAction 
[
	"Push boat", //title
	{
		[cursorTarget,player,(cursorTarget getRelDir player)] remoteExec ["wrm_fnc_pushVeh", 0, false];
	}, //script
	nil, 6, true, true, "", //arguments, priority, showWindow, hideOnUse, shortcut,
	"(cursorTarget isKindOf ""ship"") && (cursorTarget distance player<10) && (isTouchingGround cursortarget)", //condition,
	-1, false, "" //radius, unconscious, selection
];

rearmAction = player addAction 
[
	"Rearm", //title
	{
		//[player]execVM "test.sqf";
		[player] call wrm_fnc_V2rearmVeh;
	}, //script
	nil, 0, false, true, "", //arguments, priority, showWindow, hideOnUse, shortcut,
	"(vehicle player!=player)", //condition,
	-1, false, "" //radius, unconscious, selection
];

if !(isPlayer leader player) then 
{
	if (progress>1) then
	{
		if (AIon==0)
		then {hint parseText format ["BECOME SQUAD LEADER<br/>(actions menu)<br/><br/>AI units need to be led by the player. Squad will follow you. Allows access to: Squad command | Artillery | CAS | Air drop | Build fortifications"];}
		else {hint parseText format ["BECOME SQUAD LEADER<br/>(actions menu)<br/><br/>Recommended. Squad will follow you. Allows access to: Squad command | Artillery | CAS | Air drop | Build fortifications"];};
	};
};
if ("Param2" call BIS_fnc_getParamValue == 1) then{[] call wrm_fnc_arsenal;};
[player] spawn wrm_fnc_equipment;
if(version==1)then{[player] spawn wrm_fnc_safeZone;};

if(progress>1)then{if(revOn==0)then{if([player] call BIS_fnc_reviveEnabled)then{[player] call bis_fnc_disableRevive;};};};