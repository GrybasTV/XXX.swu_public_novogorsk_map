/*
Author: IvosH

Description:
	Add actions to build fortification
	
Parameter(s):
	none
	
Returns:
	nothing
	
Dependencies:
	fn_leaderActions.sqf
	
Execution:
	[] call wrm_fnc_fortification
*/

if(progress<2)exitWith{};

f1=[
	player, //target
	"+ Sandbags barricade tall", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort1==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["Land_SandbagBarricade_01_hole_F", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,1.3]];
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		steep=(surfaceNormal getPos bar select 2)<0.95;
		if((!ground)||(ground&&steep))then{bar setVectorUp [0,0,1];};		
		[1] spawn wrm_fnc_V2coolDown;
		fort1 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.3, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

f2=[
	player, //target
	"+ Sandbags barricade low", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort2==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["Land_SandbagBarricade_01_half_F", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,0.7]];
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		if(!ground)then{bar setVectorUp [0,0,1];};
		[2] spawn wrm_fnc_V2coolDown;
		fort2 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.2, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

f3=[
	player, //target
	"+ Sandbags barricade low", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort3==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["Land_SandbagBarricade_01_half_F", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,0.7]];
		bar setDir 180;
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		if(!ground)then{bar setVectorUp [0,0,1];};
		[3] spawn wrm_fnc_V2coolDown;
		fort3 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.1, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

