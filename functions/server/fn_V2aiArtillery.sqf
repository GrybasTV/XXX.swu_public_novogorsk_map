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
	//AI veikia visada, nepriklausomai nuo žaidėjų buvimo (žaidėjai gali naudoti artileriją per support sistemą)
	//AI artilerijos logika veikia nepriklausomai nuo žaidėjų - žaidėjai naudoja artileriją per BIS_fnc_addSupportLink
	//West pusės AI artilerija
	call
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
				
				//Priešo transporto priemonės ir didelės grupės (Ukrainos karas - realistiškas artilerijos naudojimas)
				_enemyVehicles=[];
				_enemyGroups=[];
				{
					if((side _x==sideE)&&alive _x)then
					{
						//Tikriname, ar tai transporto priemonė (tankai, BTR, BMP, sunkioji technika)
						_isVehicle=(_x isKindOf "Tank"||_x isKindOf "Wheeled_APC_F"||_x isKindOf "Tracked_APC"||_x isKindOf "Car"||_x isKindOf "Armored");
						//Tikriname, ar tai didelė grupė (4 ar daugiau vienetų)
						_isLargeGroup=((count units group _x)>=4);
						
						if(_isVehicle||_isLargeGroup)then
						{
							//Tikriname, ar netoli nėra savų vienetų (saugumo spindulys - 100m)
							_fr=[];
							_unit=_x;
							{if((side _x==sideW)&&((_x distance _unit)<100))then{_fr pushBackUnique _x;};} forEach allUnits;
							if(count _fr==0)then
							{
								if(_isVehicle)then{_enemyVehicles pushBackUnique (getPos _unit);};
								if(_isLargeGroup)then{_enemyGroups pushBackUnique (getPos leader group _unit);};
							};
						};
					};
				} forEach allUnits;
				
				//Pridedame priešo transporto priemones su prioritetu (pirmiau nei grupės)
				_tar=_tar+_enemyVehicles+_enemyGroups;
				
				if(count _tar > 0) then
				{
					_t = selectRandom _tar;
					_arti doArtilleryFire [_t, (getArtilleryAmmo [_arti] select 0), 8];
					if(DBG)then{["West AI call Artillery"] remoteExec ["systemChat", 0, false];};
				};
			};
	};
		
	//East pusės AI artilerija
	call
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
				
				//Priešo transporto priemonės ir didelės grupės (Ukrainos karas - realistiškas artilerijos naudojimas)
				_enemyVehicles=[];
				_enemyGroups=[];
				{
					if((side _x==sideW)&&alive _x)then
					{
						//Tikriname, ar tai transporto priemonė (tankai, BTR, BMP, sunkioji technika)
						_isVehicle=(_x isKindOf "Tank"||_x isKindOf "Wheeled_APC_F"||_x isKindOf "Tracked_APC"||_x isKindOf "Car"||_x isKindOf "Armored");
						//Tikriname, ar tai didelė grupė (4 ar daugiau vienetų)
						_isLargeGroup=((count units group _x)>=4);
						
						if(_isVehicle||_isLargeGroup)then
						{
							//Tikriname, ar netoli nėra savų vienetų (saugumo spindulys - 100m)
							_fr=[];
							_unit=_x;
							{if((side _x==sideE)&&((_x distance _unit)<100))then{_fr pushBackUnique _x;};} forEach allUnits;
							if(count _fr==0)then
							{
								if(_isVehicle)then{_enemyVehicles pushBackUnique (getPos _unit);};
								if(_isLargeGroup)then{_enemyGroups pushBackUnique (getPos leader group _unit);};
							};
						};
					};
				} forEach allUnits;
				
				//Pridedame priešo transporto priemones su prioritetu (pirmiau nei grupės)
				_tar=_tar+_enemyVehicles+_enemyGroups;
				
				if(count _tar > 0) then
				{
					_t = selectRandom _tar;
					_arti doArtilleryFire [_t, (getArtilleryAmmo [_arti] select 0), 8];
					if(DBG)then{["East AI call Artillery"] remoteExec ["systemChat", 0, false];};
				};
			};
	};
};
