/*
	Author: IvosH

	Description:
		AI use artillery

	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		[] spawn wrm_fnc_V2aiArtillery;
*/
//loop
for "_i" from 0 to 1 step 0 do 
{
	//random timer
	sleep (random[(arTime/2),arTime,(arTime*2)]);
	//sleep 40;
	if(count allPlayers>0)then
	{
		_t=true;
		while {_t} do
		{
			{if((side _x==sideW)||(side _x==sideE)) exitWith {_t=false;};} forEach allPlayers;	
			sleep 1;
		};
	};
	_plw={side _x==sideW} count allplayers;
	_ple={side _x==sideE} count allplayers;
	_nlW=true;
	{if((side _x==sideW)&&(_x==leader _x)) then {_nlW=false;};} forEach allPlayers;
	_nlE=true;
	{if((side _x==sideE)&&(_x==leader _x)) then {_nlE=false;};} forEach allPlayers;
	
	//call
	//{
		if((_plw==0)||((_plw>0)&&_nlW))then
		{
			_objs=[];
			if(alive objArtiW)then{_objs pushBackUnique objArtiW};
			if(alive objMortW)then{_objs pushBackUnique objMortW};
			
			if(count _objs > 0) then
			{
				_arti=selectRandom _objs;
				_tar=[];

				//AA
				if(alive objAAE)then
				{
					_fr=[];
					{if((side _x==sideW)&&((_x distance posAA)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique (getPos objAAE);};
				};
				
				//CAS
				if(getMarkerColor resCE!="")then
				{
					_fr=[];
					{if((side _x==sideW)&&((_x distance posCas)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posCas;};
				};
				
				//Base 1
				if((secBE1)&&(getMarkerColor resFobE!=""))then
				{
					_fr=[];
					{if((side _x==sideW)&&((_x distance posBaseE1)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posBaseE1;};
				};
				
				//Base 2
				if((secBE2)&&(getMarkerColor resBaseE!=""))then
				{
					_fr=[];
					{if((side _x==sideW)&&((_x distance posBaseE2)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posBaseE2;};
				};
				
				if(count _tar > 0) then
				{
					_t = selectRandom _tar;
					_arti doArtilleryFire [_t, (getArtilleryAmmo [_arti] select 0), 8];
					if(DBG)then{["West AI call Artillery"] remoteExec ["systemChat", 0, false];};
				};
			};
		};
		
		if((_plE==0)||((_plE>0)&&_nlE))then
		{
			_objs=[];
			if(alive objArtiE)then{_objs pushBackUnique objArtiE};
			if(alive objMortE)then{_objs pushBackUnique objMortE};
			
			if(count _objs > 0) then
			{
				_arti=selectRandom _objs;
				_tar=[];

				//AA
				if(alive objAAW)then
				{
					_fr=[];
					{if((side _x==sideE)&&((_x distance posAA)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique (getPos objAAW);};
				};

				//CAS
				if(getMarkerColor resCW!="")then
				{
					_fr=[];
					{if((side _x==sideE)&&((_x distance posCas)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posCas;};
				};

				//Base 1
				if((secBW1)&&(getMarkerColor resFobW!=""))then
				{
					_fr=[];
					{if((side _x==sideE)&&((_x distance posBaseW1)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posBaseW1;};
				};
				
				//Base 2
				if((secBW2)&&(getMarkerColor resBaseW!=""))then
				{
					_fr=[];
					{if((side _x==sideE)&&((_x distance posBaseW2)<75))then{_fr pushBackUnique _x;};} forEach allUnits;
					if(count _fr==0)then{_tar pushBackUnique posBaseW2;};
				};

				if(count _tar > 0) then
				{
					_t = selectRandom _tar;
					_arti doArtilleryFire [_t, (getArtilleryAmmo [_arti] select 0), 8];
					if(DBG)then{["East AI call Artillery"] remoteExec ["systemChat", 0, false];};
				};
			};
		};
	//};
};
