/*
Author: IvosH

Description:
	Add actions (action menu) after time delay

Parameter(s):
	0: number

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf
	fn_airDrop
	fn_fortification
	fn_V2uavRequest
	
Execution:
	[1] spawn wrm_fnc_V2coolDown;
*/

_tpe=_this select 0;

call
{
	//fortification
	if(_tpe<4)exitWith
	{
		sleep arTime;

		call
		{
			if(_tpe==1)exitWith{fort1 = 0; systemChat"Trench barricade is available";};
			if(_tpe==2)exitWith{fort2 = 0; systemChat"Trench barricade is available";};
			if(_tpe==3)exitWith{fort3 = 0; systemChat"Trench barricade is available";};
		};
		
		if(fort==1 && player==leader player)then
		{				
			fort=0;
			fortAction = player addAction 
			[
				"Fortification", //title
				{
					player removeAction fortAction;
					fort=1;
				}, //script
				nil, //arguments (Optional)
				0.3, //priority (Optional)
				false, //showWindow (Optional)
				false, //hideOnUse (Optional)
				"", //shortcut, (Optional) 
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection]; (Optional)
			];
		};
	};
	
	//UAV
	if(_tpe==5)exitWith
	{
		uavWr=arTime; 
		publicvariable "uavWr";
		while {uavWr>0} do 
		{
			sleep 10;
			uavWr=uavWr-10;
			publicvariable "uavWr";
		};
		uavWr=0;
		publicvariable "uavWr";	
	};
	if(_tpe==6)exitWith
	{
		uavEr=arTime; 
		publicvariable "uavEr";
		while {uavEr>0} do 
		{
			sleep 10;
			uavEr=uavEr-10;
			publicvariable "uavEr";
		};
		uavEr=0;
		publicvariable "uavEr";	
	};
	//UGV
	if(_tpe==7)exitWith
	{
		ugvWr=arTime; 
		publicvariable "ugvWr";
		while {ugvWr>0} do 
		{
			sleep 10;
			ugvWr=ugvWr-10;
			publicvariable "ugvWr";
		};
		ugvWr=0;
		publicvariable "ugvWr";	
	};
	if(_tpe==8)exitWith
	{
		ugvEr=arTime; 
		publicvariable "ugvEr";
		while {ugvEr>0} do 
		{
			sleep 10;
			ugvEr=ugvEr-10;
			publicvariable "ugvEr";
		};
		ugvEr=0;
		publicvariable "ugvEr";	
	};

	//AirDrop
	//Supplyes air drop
	if(_tpe==9)exitWith
	{
		sleep arTime;
		suppUsed = 0;
		if(player==leader player)then
		{
			systemChat "Supply airdrop is available";
			if(airDrop==1)then
			{
				supplyAction = player addAction 
				[
					"- Supply drop", //title
					{		
						openMap [true, false];
						["SupplyDrop"] spawn wrm_fnc_removeDrop;
						hint "Select SUPPLY drop location";
						["SupplyDrop", "onMapSingleClick", 
							{
								if(!surfaceIsWater _pos)then
								{
									// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
									_box = createVehicle [selectRandom supply, [_pos param [0, 0], _pos param [1, 0], 60], [], 0, "NONE"];
									[_box] call wrm_fnc_parachute;
									[z1,[[_box],true]] remoteExec ["addCuratorEditableObjects", 2, false];
									[_box,(str profileName),(side player)] remoteExec ["wrm_fnc_V2suppMrk", 0, true];
									suppUsed = 1;
									player removeAction supplyAction;
									if (modA=="GM") then {[_box,(side player)] call wrm_fnc_supplyBox};
									["SupplyDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
									[9] spawn wrm_fnc_V2coolDown;
									hint "Supplies delivered";
								}else{hint "Select position above ground";};
							}
						] call BIS_fnc_addStackedEventHandler;
					}, 
					nil, 0.8, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
				];
			};
		};
	};

	//Car air drop
	if(_tpe==10)exitWith
	{	
		sleep arTime;
		carUsed = 0;
		if(player==leader player)then
		{
			systemChat "Car airdrop is available";
			if(airDrop==1)then
			{	
				carAction = player addAction 
				[
					"- Car airdrop", //title
					{
						openMap [true, false];
						["CarDrop"] spawn wrm_fnc_removeDrop;
						hint "Select CAR airdrop location";
						["CarDrop", "onMapSingleClick", 
							{
								if(!surfaceIsWater _pos)then
								{
									// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
									_car = createVehicle [selectRandom car, [_pos param [0, 0], _pos param [1, 0], 60], [], 0, "NONE"];
									[_car] call wrm_fnc_parachute;
									_car setDir (getPos player getDir _pos);
									[z1,[[_car],true]] remoteExec ["addCuratorEditableObjects", 2, false];
									carUsed = 1;
									player removeAction carAction;
									["CarDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
									[10] spawn wrm_fnc_V2coolDown;
									hint "Car deployed";
								}else{hint "Select position above ground";};
							}
						] call BIS_fnc_addStackedEventHandler;
					}, 
					nil, 0.7, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
				];
			};
		};
	};

	//Boat air drop
	if(_tpe==11)exitWith
	{	
		sleep arTime;
		boatTrUsed = 0;
		if(player==leader player)then
		{
			systemChat "Boat airdrop is available";
			if(airDrop==1)then
			{
				BoatTrAction = player addAction 
				[
					"- Boat airdrop", //title
					{
						openMap [true, false];
						["BoatTrDrop"] spawn wrm_fnc_removeDrop;
						hint "Select BOAT airdrop location";
						["BoatTrDrop", "onMapSingleClick", 
							{
								if(surfaceIsWater _pos)then
								{
									// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
									_boat = createVehicle [selectRandom boatTr, [_pos param [0, 0], _pos param [1, 0], 60], [], 0, "NONE"]; //create boat
									[_boat] call wrm_fnc_parachute;
									_boat setDir (getPos player getDir _pos);
									[z1,[[_boat],true]] remoteExec ["addCuratorEditableObjects", 2, false]; //add unit to zeus
									if((count divEw!=0)&&(count divEe!=0))then
									{
										{_boat addItemCargoGlobal [_x, 1];} forEach divE; //add diving gear to cargo
										_boat addWeaponCargoGlobal [divW, 1];
										_boat addMagazineCargoGlobal [divM, 3];
									};
									boatTrUsed = 1;
									player removeAction BoatTrAction;
									["BoatTrDrop", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
									[11] spawn wrm_fnc_V2coolDown;
									hint "Boat deployed";
								}else{hint "Select position above water";};
							}
						] call BIS_fnc_addStackedEventHandler;
					}, //script
					nil, //arguments (Optional)
					0.4, //priority (Optional)
					false, //showWindow (Optional)
					true, //hideOnUse (Optional)
					"", //shortcut, (Optional) 
					"", //condition,  (Optional)
					0, //radius, (Optional) -1disable, 15max
					false, //unconscious, (Optional)
					"" //selection]; (Optional)
				];
			};
		};
	};	
	
};
