/*
	Author: IvosH
	
	Description:
		Continuously spawn AI vehicles
		aiVehW, aiArmW, aiCasW, aiVehE, aiArmE, aiCasE
		posW1, posW2, posE1, posE2
		
		objAAW, objAAE, objArtiW, objArtiE
		posAA, posArti
		
	Parameter(s):
		0: parameter number 
		
	Returns:
		nothing
		
	Dependencies:
		fn_V2aiVehUpdate.sqf
		V2aiStart.sqf
		
	Execution:
		[0] call wrm_fnc_aiVehicle;
*/
_par = _this select 0; //what vehicle to spawn

call
{
	//WEST
	//aiVehW
	if(_par==1)exitWith
	{
		//check condition again
		sleep trTime; //3 min default
		if(getMarkerColor resFobWE!="")exitWith{aiVehWr=false;};
		
		_liv=true;
		call
		{
			if(!alive aiVehW)exitWith{_liv=false;};
			if(!canMove aiVehW)exitWith{_liv=false;};
			if(aiVehW getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiVehW getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiVehW))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiVehWr=false;};

		//destroy
		aiVehW setDamage 1;

		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==2) then
		{
			//is base under attack?
			_eBW1=true;
			while {_eBW1} do 
			{
				_eBW1=false;
				{
					_unit=_x;
					if (side _unit==sideE) then
					{
						if (_unit distance posBaseW1 < 250) then {_eBW1=true;};
					};
				}  forEach allUnits;
				if (_eBW1) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom CarArW;
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiVehW = createVehicle [_typ, posW1, [], 0, "NONE"];
			[aiVehW,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiVehW;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiVehW);
			publicvariable "aiVehW";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiVehW],true];
			if(DBG)then{["AI car west respawned"] remoteExec ["systemChat", 0, false];};
		};		
		aiVehWr=false;
	};
	
	//aiArmW
	if(_par==2)exitWith
	{
		//check condition again
		sleep arTime; //9 min default
		if(getMarkerColor resBaseWE!="")exitWith{aiArmWr=false;};
		
		_liv=true;
		call
		{
			if(!alive aiArmW)exitWith{_liv=false;};
			if(!canMove aiArmW)exitWith{_liv=false;};
			if(aiArmW getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiArmW getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiArmW))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiArmWr=false;};

		//destroy
		aiArmW setDamage 1;

		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==2) then
		{
			//is base under attack?
			_eBW2=true;
			while {_eBW2} do 
			{
				_eBW2=false;
				{
					_unit=_x;
					if (side _unit==sideE) then
					{
						if (_unit distance posBaseW2 < 250) then {_eBW2=true;};
					};
				}  forEach allUnits;
				if (_eBW2) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom (ArmorW1+ArmorW2);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiArmW = createVehicle [_typ, posW2, [], 0, "NONE"];
			[aiArmW,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiArmW;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiArmW);
			publicvariable "aiArmW";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiArmW],true];
			if(DBG)then{["AI armor west respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiArmWr=false;
	};

	//aiArmW2
	if(_par==13)exitWith
	{
		//check condition again
		sleep (arTime+30); //9 min default
		if(getMarkerColor resBaseWE!="")exitWith{aiArmWr2=false;};
		
		_liv=true;
		call
		{
			if(!alive aiArmW2)exitWith{_liv=false;};
			if(!canMove aiArmW2)exitWith{_liv=false;};
			if(aiArmW2 getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiArmW2 getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiArmW2))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiArmWr2=false;};

		//destroy
		aiArmW2 setDamage 1;

		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==2) then
		{
			//is base under attack?
			_eBW2=true;
			while {_eBW2} do 
			{
				_eBW2=false;
				{
					_unit=_x;
					if (side _unit==sideE) then
					{
						if (_unit distance posBaseW2 < 250) then {_eBW2=true;};
					};
				}  forEach allUnits;
				if (_eBW2) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom (ArmorW1+ArmorW2);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiArmW2 = createVehicle [_typ, posW2, [], 0, "NONE"];
			[aiArmW2,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiArmW2;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiArmW2);
			publicvariable "aiArmW2";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiArmW2],true];
			if(DBG)then{["AI armor west 2 respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiArmWr2=false;
	};

	//aiCasW
	if(_par==3)exitWith
	{
		//check condition again
		sleep arTime; //9 min default
		
		_liv=true;
		call
		{
			if(!alive aiCasW)exitWith{_liv=false;};
			if(!canMove aiCasW)exitWith{_liv=false;};
			if(({alive _x} count (crew aiCasW))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiCasWr=false;};

		//destroy
		aiCasW setDamage 1;
		{if(alive _x)then{_x setDamage 1;};} forEach pltW;
		
		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==2) then
		{
			//west armed vehicle
			_vSel = selectRandom (HeliArW+PlaneW+HeliArW);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiCasW = createVehicle [_typ, plHW, [], 0, "FLY"];
			[aiCasW,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiCasW;	
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiCasW);
			pltW = crew aiCasW;
			(group driver aiCasW) move posCenter;
			publicvariable "aiCasW";
			sleep 1;
			z1 addCuratorEditableObjects [[aiCasW],true];
			if(DBG)then{["AI heli/jet west respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiCasWr=false;
	};	
	
	//EAST
	//aiVehE
	if(_par==4)exitWith
	{
		//check condition again
		sleep trTime; //3 min default
		if(getMarkerColor resFobEW!="")exitWith{aiVehEr=false;};
		
		_liv=true;
		call
		{
			if(!alive aiVehE)exitWith{_liv=false;};
			if(!canMove aiVehE)exitWith{_liv=false;};
			if(aiVehE getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiVehE getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiVehE))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiVehEr=false;};
		
		//destroy
		aiVehE setDamage 1;
		
		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};

		if(coop==0 || coop==1) then
		{
			//is base under attack?
			_eBE1=true;
			while {_eBE1} do 
			{
				_eBE1=false;
				{
					_unit=_x;
					if (side _unit==sideW) then
					{
						if (_unit distance posBaseE1 < 250) then {_eBE1=true;};
					};
				}  forEach allUnits;
				if (_eBE1) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom CarArE;
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiVehE = createVehicle [_typ, posE1, [], 0, "NONE"];
			[aiVehE,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiVehE;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiVehE);
			publicvariable "aiVehE";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiVehE],true];
			if(DBG)then{["AI car east respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiVehEr=false;
	};

	//aiArmE
	if(_par==5)exitWith
	{
		//check condition again
		sleep arTime; //9 min default
		if(getMarkerColor resBaseEW!="")exitWith{aiArmEr=false;};		
		
		_liv=true;
		call
		{
			if(!alive aiArmE)exitWith{_liv=false;};
			if(!canMove aiArmE)exitWith{_liv=false;};
			if(aiArmE getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiArmE getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiArmE))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiArmEr=false;};
		
		//destroy
		aiArmE setDamage 1;
		
		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==1) then
		{
			//is base under attack?
			_eBE2=true;
			while {_eBE2} do 
			{
				_eBE2=false;
				{
					_unit=_x;
					if (side _unit==sideW) then
					{
						if (_unit distance posBaseE2 < 250) then {_eBE2=true;};
					};
				}  forEach allUnits;
				if (_eBE2) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom (ArmorE1+ArmorE2);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiArmE = createVehicle [_typ, posE2, [], 0, "NONE"];
			[aiArmE,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiArmE;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiArmE);
			publicvariable "aiArmE";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiArmE],true];
			if(DBG)then{["AI armor east respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiArmEr=false;
	};

	//aiArmE2
	if(_par==14)exitWith
	{
		//check condition again
		sleep (arTime+60); //9 min default
		if(getMarkerColor resBaseEW!="")exitWith{aiArmEr2=false;};		
		
		_liv=true;
		call
		{
			if(!alive aiArmE2)exitWith{_liv=false;};
			if(!canMove aiArmE2)exitWith{_liv=false;};
			if(aiArmE2 getHitPointDamage "hitGun"==1)exitWith{_liv=false;};
			if(aiArmE2 getHitPointDamage "hitTurret"==1)exitWith{_liv=false;};
			if(({alive _x} count (crew aiArmE2))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiArmEr2=false;};
		
		//destroy
		aiArmE2 setDamage 1;
		
		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==1) then
		{
			//is base under attack?
			_eBE2=true;
			while {_eBE2} do 
			{
				_eBE2=false;
				{
					_unit=_x;
					if (side _unit==sideW) then
					{
						if (_unit distance posBaseE2 < 250) then {_eBE2=true;};
					};
				}  forEach allUnits;
				if (_eBE2) then {sleep 30;};
			};
			//create new vehicle
			_vSel = selectRandom (ArmorE1+ArmorE2);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiArmE2 = createVehicle [_typ, posE2, [], 0, "NONE"];
			[aiArmE2,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiArmE2;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiArmE2);
			publicvariable "aiArmE2";
			[] call wrm_fnc_V2aiMove;
			sleep 1;
			z1 addCuratorEditableObjects [[aiArmE2],true];
			if(DBG)then{["AI armor east 2 respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiArmEr2=false;
	};

	//aiCasE
	if(_par==6)exitWith
	{
		//check condition again
		sleep arTime; //9 min default
		
		_liv=true;
		call
		{
			if(!alive aiCasE)exitWith{_liv=false;};
			if(!canMove aiCasE)exitWith{_liv=false;};
			if(({alive _x} count (crew aiCasE))==0)exitWith{_liv=false;};
		};
		if(_liv)exitWith{aiCasEr=false;};

		//destroy
		aiCasE setDamage 1;
		{if(alive _x)then{_x setDamage 1;};} forEach pltE;
		
		//count players
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
		call
		{
			if(AIon==1)exitWith{coop=0; publicvariable "coop";};
			if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
			if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
			if(_plw>0)exitWith{coop=1; publicvariable "coop";};
			if(_ple>0)exitWith{coop=2; publicvariable "coop";};
		};
			
		if(coop==0 || coop==1) then
		{
			//east armed vehicle
			_vSel = selectRandom (HeliArE+PlaneE+HeliArE);
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	

			aiCasE = createVehicle [_typ, plHe, [], 0, "FLY"];
			[aiCasE,[_tex,1]] call bis_fnc_initVehicle;
			createVehicleCrew aiCasE;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew aiCasE);
			publicvariable "aiCasE";
			(group driver aiCasE) move posCenter;
			pltE = crew aiCasE;
			sleep 1;
			z1 addCuratorEditableObjects [[aiCasE],true];
			if(DBG)then{["AI heli/jet east respawned"] remoteExec ["systemChat", 0, false];};
		};
		aiCasEr=false;
	};

	//AAW
	if(_par==7)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resAW!=""))exitWith{objAAWr=false;};

		//respawn
		if(!alive objAAW)then
		{			
			deleteVehicle objAAW;
			if(count aaW!=0)then
			{
				_vSel = selectRandom aaW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objAAW = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, "NONE"];
				[objAAW,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom aaE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objAAW = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, "NONE"];
				[objAAW,[_tex,1]] call bis_fnc_initVehicle;
			};
			objAAW lockDriver true;
			objAAW allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objAAW],true];
			[objAAW] call wrm_fnc_parachute;	
			publicvariable "objAAW";
			[17] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["AA west respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objAAW)||(objAAW getHitPointDamage "hitGun"==1)||(objAAW getHitPointDamage "hitTurret"==1))then
		{
			objAAW setDamage 0; 
			if(DBG)then{["AA west repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objAAW)then
		{
			objAAW setVehicleAmmoDef 1; 
			if(DBG)then{["AA west rearmed"] remoteExec ["systemChat", 0, false];};
		};

		//new crew
		if((objAAW emptyPositions "Gunner" > 0)||(objAAW emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objAAW))>0)then
			{
				{ objAAW deleteVehicleCrew _x } forEach crew objAAW;
			};
			
			_grpAAW=createGroup [sideW, true];			
			for "_i" from 1 to (objAAW emptyPositions "Gunner") step 1 do
			{
				_unit = _grpAAW createUnit [crewW, posAA, [], 0, "NONE"];
				_unit moveInGunner objAAW;
			};
			for "_i" from 1 to (objAAW emptyPositions "Commander") step 1 do
			{
				_unit = _grpAAW createUnit [crewW, posAA, [], 0, "NONE"];
				_unit moveInCommander objAAW;
			};
			objAAW allowCrewInImmobile true;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew objAAW);
			sleep 1;
			z1 addCuratorEditableObjects [[objAAW],true];
			if(DBG)then{["AA west new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objAAWr=false;
	};

	//AAE
	if(_par==8)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resAE!=""))exitWith{objAAEr=false;};

		//respawn
		if(!alive objAAE)then
		{			
			deleteVehicle objAAE;
			if(count aaE!=0)then
			{
				_vSel = selectRandom aaE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objAAE = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, "NONE"];
				[objAAE,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom aaW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objAAE = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, "NONE"];
				[objAAE,[_tex,1]] call bis_fnc_initVehicle;
			};
			objAAE lockDriver true;
			objAAE allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objAAE],true];
			[objAAE] call wrm_fnc_parachute;	
			publicvariable "objAAE";
			[18] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["AA east respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objAAE)||(objAAE getHitPointDamage "hitGun"==1)||(objAAE getHitPointDamage "hitTurret"==1))then
		{
			objAAE setDamage 0; 
			if(DBG)then{["AA east repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objAAE)then
		{
			objAAE setVehicleAmmoDef 1; 
			if(DBG)then{["AA east rearmed"] remoteExec ["systemChat", 0, false];};
		};

		//new crew
		if((objAAE emptyPositions "Gunner" > 0)||(objAAE emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objAAE))>0)then
			{
				{ objAAE deleteVehicleCrew _x } forEach crew objAAE;
			};
			
			_grpAAE=createGroup [sideE, true];			
			for "_i" from 1 to (objAAE emptyPositions "Gunner") step 1 do
			{
				_unit = _grpAAE createUnit [crewE, posAA, [], 0, "NONE"];
				_unit moveInGunner objAAE;
			};
			for "_i" from 1 to (objAAE emptyPositions "Commander") step 1 do
			{
				_unit = _grpAAE createUnit [crewE, posAA, [], 0, "NONE"];
				_unit moveInCommander objAAE;
			};
			objAAE allowCrewInImmobile true;
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew objAAE);
			sleep 1;
			z1 addCuratorEditableObjects [[objAAE],true];
			if(DBG)then{["AA east new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objAAEr=false;
	};

	//ArtiW
	if(_par==9)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resBW!=""))exitWith{objArtiWr=false;};		

		//respawn
		if(!alive objArtiW)then
		{						
			[objArtiW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
			deleteVehicle objArtiW;
			if(count artiW!=0)then
			{
				_vSel = selectRandom artiW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objArtiW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objArtiW,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom artiE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objArtiW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objArtiW,[_tex,1]] call bis_fnc_initVehicle;
			};
			objArtiW lockDriver true;
			objArtiW allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objArtiW],true];
			[objArtiW] call wrm_fnc_parachute;	
			publicvariable "objArtiW";
			[19] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["Artillery west respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objArtiW)||(objArtiW getHitPointDamage "hitGun"==1)||(objArtiW getHitPointDamage "hitTurret"==1))then
		{
			objArtiW setDamage 0; 
			if(DBG)then{["Artillery west repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objArtiW)then
		{
			objArtiW setVehicleAmmoDef 1;
			_mag=getPylonMagazines objArtiW;
			if(count _mag>0)then
			{
				for "_i" from 1 to (count _mag) step 1 do
				{
					objArtiW setPylonLoadout [_i,(_mag select (_i-1))];
				};
			};
			if(DBG)then{["Artillery west rearmed"] remoteExec ["systemChat", 0, false];};			
		};

		//new crew
		if((objArtiW emptyPositions "Gunner" > 0)||(objArtiW emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objArtiW))>0)then
			{
				[objArtiW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
				{ objArtiW deleteVehicleCrew _x } forEach crew objArtiW;
			};
			
			_grpArtiW=createGroup [sideW, true];			
			for "_i" from 1 to (objArtiW emptyPositions "Gunner") step 1 do
			{
				_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
				_unit moveInGunner objArtiW;
			};
			for "_i" from 1 to (objArtiW emptyPositions "Commander") step 1 do
			{
				_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
				_unit moveInCommander objArtiW;
			};
			objArtiW allowCrewInImmobile true;
			[objArtiW, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew objArtiW);
			sleep 1;
			z1 addCuratorEditableObjects [[objArtiW],true];
			if(DBG)then{["Artillery west new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objArtiWr=false;
	};

	//ArtiE
	if(_par==10)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resBE!=""))exitWith{objArtiEr=false;};
	
		//respawn
		if(!alive objArtiE)then
		{						
			[objArtiE, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
			deleteVehicle objArtiE;
			if(count artiE!=0)then
			{
				_vSel = selectRandom artiE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objArtiE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objArtiE,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom artiW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objArtiE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objArtiE,[_tex,1]] call bis_fnc_initVehicle;
			};
			objArtiE lockDriver true;
			objArtiE allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objArtiE],true];
			[objArtiE] call wrm_fnc_parachute;	
			publicvariable "objArtiE";
			[20] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["Artillery east respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objArtiE)||(objArtiE getHitPointDamage "hitGun"==1)||(objArtiE getHitPointDamage "hitTurret"==1))then
		{
			objArtiE setDamage 0; 
			if(DBG)then{["Artillery east repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objArtiE)then
		{
			objArtiE setVehicleAmmoDef 1;
			_mag=getPylonMagazines objArtiE;
			if(count _mag>0)then
			{
				for "_i" from 1 to (count _mag) step 1 do
				{
					objArtiE setPylonLoadout [_i,(_mag select (_i-1))];
				};
			};
			if(DBG)then{["Artillery east rearmed"] remoteExec ["systemChat", 0, false];};
		};

		//new crew
		if((objArtiE emptyPositions "Gunner" > 0)||(objArtiE emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objArtiE))>0)then
			{
				[objArtiE, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
				{ objArtiE deleteVehicleCrew _x } forEach crew objArtiE;
			};
			
			_grpArtiE=createGroup [sideE, true];			
			for "_i" from 1 to (objArtiE emptyPositions "Gunner") step 1 do
			{
				_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
				_unit moveInGunner objArtiE;
			};
			for "_i" from 1 to (objArtiE emptyPositions "Commander") step 1 do
			{
				_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
				_unit moveInCommander objArtiE;
			};
			objArtiE allowCrewInImmobile true;
			[objArtiE, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew objArtiE);
			sleep 1;
			z1 addCuratorEditableObjects [[objArtiE],true];
			if(DBG)then{["Artillery east new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objArtiEr=false;
	};
	
	//MortarW
	if(_par==11)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resBW!=""))exitWith{objMortWr=false;};		

		//respawn
		if(!alive objMortW)then
		{						
			[objMortW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
			deleteVehicle objMortW;
			if(count mortW!=0)then
			{
				_vSel = selectRandom mortW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objMortW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objMortW,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom mortE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objMortW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objMortW,[_tex,1]] call bis_fnc_initVehicle;
			};
			objMortW lockDriver true;
			objMortW allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objMortW],true];
			[objMortW] call wrm_fnc_parachute;	
			publicvariable "objMortW";
			[23] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["Mortar west respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objMortW)||(objMortW getHitPointDamage "hitGun"==1)||(objMortW getHitPointDamage "hitTurret"==1))then
		{
			objMortW setDamage 0; 
			if(DBG)then{["Mortar west repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objMortW)then
		{
			objMortW setVehicleAmmoDef 1;
			_mag=getPylonMagazines objMortW;
			if(count _mag>0)then
			{
				for "_i" from 1 to (count _mag) step 1 do
				{
					objMortW setPylonLoadout [_i,(_mag select (_i-1))];
				};
			};
			if(DBG)then{["Mortar west rearmed"] remoteExec ["systemChat", 0, false];};			
		};

		//new crew
		if((objMortW emptyPositions "Gunner" > 0)||(objMortW emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objMortW))>0)then
			{
				[objMortW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
				{ objMortW deleteVehicleCrew _x } forEach crew objMortW;
			};
			
			_grpArtiW=createGroup [sideW, true];			
			for "_i" from 1 to (objMortW emptyPositions "Gunner") step 1 do
			{
				_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
				_unit moveInGunner objMortW;
			};
			for "_i" from 1 to (objMortW emptyPositions "Commander") step 1 do
			{
				_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
				_unit moveInCommander objMortW;
			};
			objMortW allowCrewInImmobile true;
			[objMortW, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
			} forEach (crew objMortW);
			sleep 1;
			z1 addCuratorEditableObjects [[objMortW],true];
			if(DBG)then{["Mortar west new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objMortWr=false;
	};

	//MortarE
	if(_par==12)exitWith
	{
		sleep arTime; //9 min default
		if(!(getMarkerColor resBE!=""))exitWith{objMortEr=false;};
	
		//respawn
		if(!alive objMortE)then
		{						
			[objMortE, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
			deleteVehicle objMortE;
			if(count mortE!=0)then
			{
				_vSel = selectRandom mortE;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objMortE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objMortE,[_tex,1]] call bis_fnc_initVehicle;
			}else
			{
				_vSel = selectRandom mortW;
				_typ="";_tex="";
				if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
				objMortE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
				[objMortE,[_tex,1]] call bis_fnc_initVehicle;
			};
			objMortE lockDriver true;
			objMortE allowCrewInImmobile true;
			z1 addCuratorEditableObjects [[objMortE],true];
			[objMortE] call wrm_fnc_parachute;	
			publicvariable "objMortE";
			[24] remoteExec ["wrm_fnc_V2hints", 0, false];
			if(DBG)then{["Mortar east respawned"] remoteExec ["systemChat", 0, false];};
		};
		
		//repair
		if((!canMove objMortE)||(objMortE getHitPointDamage "hitGun"==1)||(objMortE getHitPointDamage "hitTurret"==1))then
		{
			objMortE setDamage 0; 
			if(DBG)then{["Mortar east repaired"] remoteExec ["systemChat", 0, false];};
		};

		//rearm
		if(!someAmmo objMortE)then
		{
			objMortE setVehicleAmmoDef 1;
			_mag=getPylonMagazines objMortE;
			if(count _mag>0)then
			{
				for "_i" from 1 to (count _mag) step 1 do
				{
					objMortE setPylonLoadout [_i,(_mag select (_i-1))];
				};
			};
			if(DBG)then{["Mortar east rearmed"] remoteExec ["systemChat", 0, false];};
		};

		//new crew
		if((objMortE emptyPositions "Gunner" > 0)||(objMortE emptyPositions "Commander" > 0))then
		{			
			if(({alive _x} count (crew objMortE))>0)then
			{
				[objMortE, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
				{ objMortE deleteVehicleCrew _x } forEach crew objMortE;
			};
			
			_grpArtiE=createGroup [sideE, true];			
			for "_i" from 1 to (objMortE emptyPositions "Gunner") step 1 do
			{
				_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
				_unit moveInGunner objMortE;
			};
			for "_i" from 1 to (objMortE emptyPositions "Commander") step 1 do
			{
				_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
				_unit moveInCommander objMortE;
			};
			objMortE allowCrewInImmobile true;
			[objMortE, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];
			{ _x addMPEventHandler
				["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
			} forEach (crew objMortE);
			sleep 1;
			z1 addCuratorEditableObjects [[objMortE],true];
			if(DBG)then{["Mortar east new crew"] remoteExec ["systemChat", 0, false];};
		};
		
		objMortEr=false;
	};
};