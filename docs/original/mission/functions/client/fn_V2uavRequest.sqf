/*
Author: IvosH

Description:
	Add actions for UAV request
	obj = uavW, uavE, ugvW, ugvE
	[] = uavsW, ugvsW, uavsE, ugvsE
	
Parameter(s):
	0: NUMBER type of the UAV/UGV
	1: SIDE	player side

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf

Execution:
	[] spawn wrm_fnc_V2uavRequest
*/

_typ = _this select 0;
_sde = _this select 1;

call
{
	//UAV
	if(_typ==0)exitWith
	{
		call
		{
			if(_sde==sideW)exitWith
			{
				if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBW1];};
				if(alive uavW)exitWith{hint "UAV is already deployed";};
				if(uavWr>0)exitWith
				{ 
					_t=uavWr; _s="sec"; if(uavWr>60)then{_t=floor (uavWr/60); _s="min";};
					hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
				};
					
				uavW = createVehicle [(selectRandom uavsW), plhW, [], 0, "FLY"];
				createVehicleCrew uavW;
				publicvariable "uavW";
				(group driver uavW) move posCenter;
				
				uavW addMPEventHandler ["MPKilled",{[5] spawn wrm_fnc_V2coolDown;}];
				[5] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[uavW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
			
			if(_sde==sideE)exitWith
			{
				if(getMarkerColor resFobE=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBE1];};
				if(alive uavE)exitWith{hint "UAV is already deployed";};
				if(uavEr>0)exitWith
				{ 
					_t=uavEr; _s="sec"; if(uavEr>60)then{_t=floor (uavEr/60); _s="min";};
					hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
				};
				
				uavE = createVehicle [(selectRandom uavsE), plhE, [], 0, "FLY"];
				createVehicleCrew uavE;
				publicvariable "uavE";
				(group driver uavE) move posCenter;
				
				uavE addMPEventHandler ["MPKilled",{[6] spawn wrm_fnc_V2coolDown;}];
				[6] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[uavE],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
		};

	};
	
	//UGV
	if(_typ==1)exitWith
	{
		call
		{
			if(_sde==sideW)exitWith
			{
				if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UGV service is unavailable<br/>You lost %1 base",nameBW1];};
				if(alive ugvW)exitWith{hint "UGV is already deployed";};
				if(ugvWr>0)exitWith
				{ 
					_t=ugvWr; _s="sec"; if(ugvWr>60)then{_t=floor (ugvWr/60); _s="min";};
					hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
				};
				
				_s = (selectRandom ugvsW); 
				_pr =  objBaseW1 getRelPos [75, random 360];
				_p =  _pr findEmptyPosition [0, 50, _s];
				if(count _p==0)then{_p=_pr;};
				
				ugvW = createVehicle [_s, [_p select 0, _p select 1, 50], [], 0, "NONE"];
				createVehicleCrew ugvW;
				[ugvW] call wrm_fnc_parachute;
				publicvariable "ugvW";
				
				ugvW addMPEventHandler ["MPKilled",{[7] spawn wrm_fnc_V2coolDown;}];
				[7] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[ugvW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
			
			if(_sde==sideE)exitWith
			{
				if(getMarkerColor resFobE=="")exitWith{hint parseText format ["UGV service is unavailable<br/>You lost %1 base",nameBE1];};
				if(alive ugvE)exitWith{hint "UGV is already deployed";};
				if(ugvEr>0)exitWith
				{ 
					_t=ugvEr; _s="sec"; if(ugvEr>60)then{_t=floor (ugvEr/60); _s="min";};
					hint parseText format ["UGV service is unavailable<br/>UGV will be ready in %1 %2",_t,_s];
				};
				
				_s = (selectRandom ugvsE); 
				_pr =  objBaseE1 getRelPos [75, random 360];
				_p =  _pr findEmptyPosition [0, 50, _s];
				if(count _p==0)then{_p=_pr;};
				
				ugvE = createVehicle [_s, [_p select 0, _p select 1, 50], [], 0, "NONE"];
				createVehicleCrew ugvE;
				[ugvE] call wrm_fnc_parachute;
				publicvariable "ugvE";
				
				ugvE addMPEventHandler ["MPKilled",{[8] spawn wrm_fnc_V2coolDown;}];
				[8] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[ugvE],true]] remoteExec ["addCuratorEditableObjects", 2, false];
			};
		};
	};
};
