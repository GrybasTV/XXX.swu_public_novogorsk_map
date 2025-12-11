/*
[0] remoteExec ["wrm_fnc_V2hints", 0, false];

1 west transport
2 west armors
3 east transport
4 east armors
*/
if (!hasInterface) exitWith {};

// TIMEOUT #1: Laukti kol player != null
private _startTime1 = time;
waitUntil {
    sleep 0.5;
    (!isNull player) || (time - _startTime1 > 10)
};

if (time - _startTime1 > 10 && isNull player) exitWith {
    // Timeout - išeiname, nes negalime rodyti hint be player
};

// TIMEOUT #2: Laukti kol player alive
private _startTime2 = time;
waitUntil {
    sleep 0.5;
    (alive player) || (time - _startTime2 > 30)
};

if (time - _startTime2 > 30 && !alive player) exitWith {
    // Timeout - išeiname, nes negalime rodyti hint be alive player
};

_i=_this select 0;

call
{
	if(_i==1)exitWith{if(side player==sideW)then{hint format ["Your %1 base is under attack",nameBW1];};};
	if(_i==2)exitWith{if(side player==sideW)then{hint format ["Your %1 base is under attack",nameBW2];};};
	if(_i==3)exitWith{if(side player==sideE)then{hint format ["Your %1 base is under attack",nameBE1];};};
	if(_i==4)exitWith{if(side player==sideE)then{hint format ["Your %1 base is under attack",nameBE2];};};
	
	if(_i==5)exitWith{if(side player==sideW)then{hint parseText format ["UAV deployed<br/>Use UAV terminal for access"];};};
	if(_i==6)exitWith{if(side player==sideE)then{hint parseText format ["UAV deployed<br/>Use UAV terminal for access"];};};
	if(_i==7)exitWith{if(side player==sideW)then{hint parseText format ["UGV deployed<br/>Use UAV terminal for access"];};};
	if(_i==8)exitWith{if(side player==sideE)then{hint parseText format ["UGV deployed<br/>Use UAV terminal for access"];};};
	
	if(_i==9)exitWith{if(side player==sideW)then{hint format ["ANTI AIR destroyed"];};};
	if(_i==10)exitWith{if(side player==sideW)then{hint parseText format ["ANTI AIR damaged<br/>Needs repair"];};};
	if(_i==11)exitWith{if(side player==sideE)then{hint format ["ANTI AIR destroyed"];};};
	if(_i==12)exitWith{if(side player==sideE)then{hint parseText format ["ANTI AIR damaged<br/>Needs repair"];};};
	
	if(_i==13)exitWith{if(side player==sideW)then{hint format ["ARTILLERY destroyed"];};};
	if(_i==14)exitWith{if(side player==sideW)then{hint parseText format ["ARTILLERY damaged<br/>Needs repair"];};};
	if(_i==15)exitWith{if(side player==sideE)then{hint format ["ARTILLERY destroyed"];};};
	if(_i==16)exitWith{if(side player==sideE)then{hint parseText format ["ARTILLERY damaged<br/>Needs repair"];};};
	
	if(_i==17)exitWith{if(side player==sideW)then{hint parseText format ["ANTI AIR deployed"];};};
	if(_i==18)exitWith{if(side player==sideE)then{hint parseText format ["ANTI AIR deployed"];};};
	if(_i==19)exitWith{if(side player==sideW)then{hint parseText format ["ARTILLERY deployed"];};};
	if(_i==20)exitWith{if(side player==sideE)then{hint parseText format ["ARTILLERY deployed"];};};
	
	if(_i==21)exitWith{if(side player==sideW)then{hint format ["MORTAR destroyed"];};};
	if(_i==22)exitWith{if(side player==sideE)then{hint format ["MORTAR destroyed"];};};
	if(_i==23)exitWith{if(side player==sideW)then{hint parseText format ["MORTAR deployed"];};};
	if(_i==24)exitWith{if(side player==sideE)then{hint parseText format ["MORTAR deployed"];};};
};
