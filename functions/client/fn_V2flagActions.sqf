/*
	Author: IvosH
	
	Description:
		Add actions to the flags. Teleports between flags
	
	Parameter(s):
		0: OBJECT, flgBW1
		1: OBJECT, flgBW2
		2: OBJECT, flgJetW
		3: OBJECT, flgBE1
		4: OBJECT, flgBE2
		5: OBJECT, flgJetE
		5: VARIABLE, missType
	
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		
	Execution:
		[flgBW1,flgBW2,flgJetW,flgBE1,flgBE2,flgJetE,missType] remoteExec ["wrm_fnc_flagActions", 0, true];
		[flgBW1,flgBW2,flgJetW,flgBE1,flgBE2,flgJetE,missType] call wrm_fnc_flagActions;
*/

if (!hasInterface) exitWith {}; //run on the players only
waitUntil {((side player == sideW)||(side player == sideE))};
flgBW1 = _this select 0;
flgBW2 = _this select 1;
flgJetW = _this select 2;
flgBE1 = _this select 3;
flgBE2 = _this select 4;
flgJetE = _this select 5;
missType = _this select 6;
_flgs = [];
_act = [];

_nme1=format ["Teleport to the Transport base"];
_nme2="Teleport to the Armors base";
if(missType<2)then
{
	_nme2="Teleport to the Helicopter base";
	if(((side player == sideW)&&(count HeliTrW==0)) || ((side player == sideE)&&(count HeliTrE==0)))then{_nme2="Teleport to the Infantry base";};
};

call
{
	if (side player == sideW) exitWith 
	{
		_flgs = [flgBW2,flgBW1];
		_act = //[title, script, priority, condition],
		[
			[_nme2,
			{
				if(player==leader player)then
				{
					_grp=[player];
					{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};}forEach units group player;
					{_x setPos (flgBW2 getRelPos [random [3,6,9],random [135,180,225]]);}forEach _grp;
				}
				else{player setPos (flgBW2 getRelPos [3,180]);};
			},6,""],
			[_nme1,
			{
				if(player==leader player)then
				{
					_grp=[player];
					{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};}forEach units group player;
					{_x setPos (flgBW1 getRelPos [random [3,6,9],random [135,180,225]]);}forEach _grp;
				}
				else{player setPos (flgBW1 getRelPos [3,180]);};
			},5.5,"(flgDel==0||sideA == sideW)"]
		];

	if (missType == 3) then 
	{
		// Patikriname, ar kintamieji yra apibrėžti prieš juos naudojant
		// Naudojame lokalius kintamuosius, kad išvengtume kelių isNil patikrinimų
		_plHWDefined = !isNil "plHW";
		_plHEDefined = !isNil "plHE";
		_plH1Defined = !isNil "plH1";
		_plH2Defined = !isNil "plH2";
		_planesCheck = false;
		
		// Tikriname planes==2 sąlygą tik jei visi kintamieji yra apibrėžti
		if((planes==2) && _plHWDefined && _plHEDefined && _plH1Defined && _plH2Defined) then {
			_planesCheck = ((plHW==plH1)||(plHW==plH2))&&((plHE==plH1)||(plHE==plH2));
		};
		
		if(
			(count HeliArW!=0) ||
			((count PlaneW!=0)&&(planes==1)) ||
			((count PlaneW!=0)&&_planesCheck)
		)then
		{
			// Patikriname, ar flag objektas buvo sukurtas prieš jį pridedant
			if (flgJetW isNotEqualTo "" && {!isNull flgJetW}) then {
				_flgs pushBack flgJetW;
				_act pushBack ["Teleport to the Air base",{player setPos (flgJetW getRelPos [3,180]);},5,""];
			};
		};
	};
	};
	
	if (side player == sideE) exitWith 
	{
		_flgs = [flgBE2,flgBE1];
		_act = //[title, script, priority, condition],
		[
			[_nme2,
			{
				if(player==leader player)then
				{
					_grp=[player];
					{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};}forEach units group player;
					{_x setPos (flgBE2 getRelPos [random [3,6,9],random [135,180,225]]);}forEach _grp;
				}
				else{player setPos (flgBE2 getRelPos [3,180]);};
			},6,""],
			[_nme1,
			{
				if(player==leader player)then
				{
					_grp=[player];
					{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};}forEach units group player;
					{_x setPos (flgBE1 getRelPos [random [3,6,9],random [135,180,225]]);}forEach _grp;
				}
				else{player setPos (flgBE1 getRelPos [3,180]);};
			},5.5,"(flgDel==0||sideA == sideE)"]
		];

		if (missType == 3) then 
		{
			// Patikriname, ar kintamieji yra apibrėžti prieš juos naudojant
			// Naudojame lokalius kintamuosius, kad išvengtume kelių isNil patikrinimų
			_plHWDefined = !isNil "plHW";
			_plHEDefined = !isNil "plHE";
			_plH1Defined = !isNil "plH1";
			_plH2Defined = !isNil "plH2";
			_planesCheck = false;
			
			// Tikriname planes==2 sąlygą tik jei visi kintamieji yra apibrėžti
			if((planes==2) && _plHWDefined && _plHEDefined && _plH1Defined && _plH2Defined) then {
				_planesCheck = ((plHW==plH1)||(plHW==plH2))&&((plHE==plH1)||(plHE==plH2));
			};
			
			if(
				(count HeliArE!=0) ||
				((count PlaneE!=0)&&(planes==1)) ||
				((count PlaneE!=0)&&_planesCheck)
			)then
			{
				// Patikriname, ar flag objektas buvo sukurtas prieš jį pridedant
				if (flgJetE isNotEqualTo "" && {!isNull flgJetE}) then {
					_flgs pushBack flgJetE;
					_act pushBack ["Teleport to the Air base",{player setPos (flgJetE getRelPos [3,180]);},5,""];
				};
			};
		};
	};
};

{
	_flg = _x;
	_indx = _forEachIndex; 
	{
		_flg addAction [
		_x select 0, //title
		_x select 1, //script
		nil, //arguments (Optional)
		_x select 2, //priority (Optional)
		true, //showWindow (Optional)
		true, //hideOnUse (Optional)
		"", //shortcut, (Optional) 
		_x select 3, //condition,  (Optional)
		5, //radius, (Optional)
		false, //unconscious, (Optional)
		""]; //selection]; (Optional)
	} forEach _act - [_act select _indx];
} forEach _flgs;