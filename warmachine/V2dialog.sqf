/*
	Author: IvosH
	
	Description:
		Content of the MISSIONS GENERATOR dialog.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		dialog.hpp
		
	Execution:
		[] execVM "warmachine\V2dialog.sqf";
*/

disableSerialization;
//CONTENT: variables for RscCombo: _menuXX = [["text","tooltip"],["",""]];

//AO selection method
_menu11 =
[
	["Random AO","Location is selected randomly. Mission is generated automatically"],
	["Select AO","Select area of operation on the map. Mission layout is generated automatically. Recommended"]
];
//AO size
_menu91 =
[
	["Random","Size is selected randomly"],
	["Small - Default","Default"],
	["Medium","1,5x larger"],
	["Large","2x larger"]
];
//Mission type
_menu21 = 
[
	["Random","Mission type is selected randomly"],
	["Infantry mission","Infantry, Transport vehicles"],
	["Combined ground forces","Infantry, light vehicles, armors, transport helicopter"],
	["Full spectrum warfare","Infantry, light vehicles, armors, transport helicopter, gunship, jet"]
];
//Time of day
_menu31 = 
[
	["Random","Time of day is selected randomly"],
	["Dawn",(dawn select 0)],
	["Morning","9:00h"],
	["Noon","12:00h"],
	["Afternoon","15:00h"],
	["Dusk",(dusk select 0)],
	["Night","23:00h"]
];
//Respawn tickets
_menu32 = 
[
	["Auto adjust","Based on the number of players and AI"], 
	["200",""], 
	["400",""], 
	["800",""], 
	["1200",""], 
	["1600",""],
	["2000",""],
	["2400",""],
	["2800",""],
	["3200",""],
	["3600",""],
	["4000",""]
];
//Weather
_menu41 = 
[
	["Random","Weather is selected randomly"],
	["Clear","Clear sky, no rain"],
	["Cloudy","Overcast, probability of rain"],
	["Rain","Overcast and rain"],
	["Storm","Overcast and storm"]
];
//Ticket bleed
_menu42 = 
[
	["Disabled","Relax, make a plan. It's recommended to set a time limit"],
	["Enabled","Hurry up, rush for the objectives"]
];
//Fog
_menu51 =
[
	["No","Good visibility"]
];
//Time limit
_menu52 = 
[
	["Disabled","It's recommended to enable ticket bleed"],
	["60 min","1h"],
	["90 min","1,5h"],
	["120 min","2h"]
];
//Autonomous AI
_menu61 = 
[
	["Disabled","Only AI units lead by the player join the battle"], //0
	["Balanced","All AI units join the battle. AI vehicles spawn continuously for both sides"], //1
	["Challenging","In SP/COOP - AI vehicles spawn on the enemy side"], //2
	["Overwhelming","In SP/COOP - More AI units and vehicles spawn on the enemy side"] //3
];
//Respawn type
_menu62 = 
[
	["Base, Sectors","Respawn is available on the BASE and captured SECTORS"],
	["Base, Sectors, Squad","Respawn is available on the BASE, captured SECTORS and SQUAD position"]
];
//Revive
_menu71 = 
[
	["Disabled","No revive"],
	["Arma 3","Player can revive Player"],
	["Warmachine","Player/AI can revive Player"]
];
if(isClass(configfile >> "CfgMods" >> "SPE"))then
{
	_menu71 = 
	[
		["Disabled","No revive"],
		["Arma 3","Player can revive Player"],
		["Warmachine","Player/AI can revive Player"],
		["Spearhead 1944","Player/AI can revive Player/AI"]
	];
};
//Player respawn time
_menu72 =
[
	["5 sec","Instant respawn"],
	["30 sec - Default","Default"],
	["60 sec","Normal"],
	["120 sec","Long respawn"],
	["180 sec","Go for a coffee"]
];
//3rd person view
_menu81 = [];
if(difficultyOption "thirdPersonView">0)then
{
	if(difficultyOption "thirdPersonView"==1)then
	{
		_menu81 =
		[
			["Disabled","Recommended for tough guys"],
			["Only in the vehicle","Battlefield style"],
			["Enabled","Third person view available"]
		];
	} else 
	{
		_menu81 =
		[
			["Disabled","Recommended for tough guys"],
			["Only in the vehicle","Battlefield style"]
		];
	};
}else
{
	_menu81 = [["Disabled by the server","Third person view is not allowed"]];
};
//Vehicles respawn time
_menu82 =
[
	["30/90 sec","Armor madness"],
	["1/3 min","Fast respawn"],
	["3/9 min - Default","Default"],
	["5/15 min","Long respawn"],
	["10/30 min","Once upon a time, there was a tank"]
];

_menu = [_menu11, _menu91, _menu21, _menu31, _menu32, _menu41, _menu42, _menu51, _menu52, _menu61, _menu62, _menu71, _menu72, _menu81, _menu82];

//VARIABLES: defines display and controls
_display = findDisplay 2020;
//controls
_cmb11 = _display displayCtrl 311;
_cmb91 = _display displayCtrl 391;
_cmb21 = _display displayCtrl 321;
_cmb31 = _display displayCtrl 331;
_cmb32 = _display displayCtrl 332;
_cmb41 = _display displayCtrl 341;
_cmb42 = _display displayCtrl 342;
_cmb51 = _display displayCtrl 351;
_cmb52 = _display displayCtrl 352;
_cmb61 = _display displayCtrl 361;
_cmb62 = _display displayCtrl 362;
_cmb71 = _display displayCtrl 371;
_cmb72 = _display displayCtrl 372;
_cmb81 = _display displayCtrl 381;
_cmb82 = _display displayCtrl 382;

_cmb = [_cmb11, _cmb91,_cmb21, _cmb31, _cmb32, _cmb41, _cmb42, _cmb51, _cmb52, _cmb61, _cmb62, _cmb71, _cmb72, _cmb81, _cmb82];

//ADD CONTENT TO THE DIALOG
{
	_cmbx = _x;
	_index = _forEachIndex;
	{
		_menux = _x;
		_cmbx lbAdd (_menux select 0);
		_cmbx lbSetTooltip [_forEachIndex, (_menux select 1)];
	} forEach (_menu select _index);
} forEach _cmb;

//SET DEFAULT VALUES at first opening of the dialog
if (dSel == 0) then
{
	_vi="";
	_groups = [];
	{_groups pushBackUnique group _x} forEach allPlayers;
	_grpNoW = sideW countSide _groups;
	_grpNoE = sideE countSide _groups;
	_plrNoW = sideW countSide allPlayers;
	_plrNoE = sideE countSide allPlayers;

	//3rd person view
	if(difficultyOption "thirdPersonView">0)then
	{
		if(_plrNoW==0 || _plrNoE==0)
		then
		{
			if(difficultyOption "thirdPersonView"==1)then 
			{
				_cmb81 lbSetCurSel 2;_vi="<br/>3rd person view enabled"; //1
			}else
			{
				_cmb81 lbSetCurSel 1;_vi="<br/>3rd person view available only in the vehicle"; //2
			};	
		}
		else
		{
			_cmb81 lbSetCurSel 1;_vi="<br/>3rd person view available only in the vehicle"; //2
		};
	}else{_cmb81 lbSetCurSel 0;}; //0

	_cmb11 lbSetCurSel 1; //1 AO selection method
	_cmb91 lbSetCurSel 1; //0 AO size
	_cmb21 lbSetCurSel 3; //3 Mission type
	_cmb31 lbSetCurSel 0; //0 Time of day
	_cmb32 lbSetCurSel 0; //0 Respawn tickets
	_cmb41 lbSetCurSel 0; //0 Weather
	_cmb42 lbSetCurSel 1; //1 Ticket bleed
	_cmb51 lbSetCurSel 0; //0 Fog
	_cmb52 lbSetCurSel 3; //3 Time limit
	_cmb61 lbSetCurSel 1; //1 Autonomous AI 
	_cmb62 lbSetCurSel 1; //1 Respawn type
	_cmb71 lbSetCurSel 2; //2 Revive
	//if(isClass(configfile >> "CfgMods" >> "SPE"))then{_cmb71 lbSetCurSel 3;};
	if((isClass(configfile >> "CfgMods" >> "SPE"))&&(modA == "SPE"))then{_cmb71 lbSetCurSel 3;};
	_cmb72 lbSetCurSel 1; //1 Player respawn time
	_cmb82 lbSetCurSel 2; //2 Vehicles respawn time

	//Hint
	_text = ["Players: ",_plrNoW," vs. ",_plrNoE,"<br/>Squads: ",_grpNoW," vs. ",_grpNoE,"<br/><br/>RECOMMENDED PARAMETERS<br/>Mission type: Full spectrum warfare<br/>Autonomous AI enabled",_vi,"<br/><br/>Zeus is available for administrator<br/>and server host"] joinString "";
	hint parseText format ["%1", _text];
};

//LOAD SELECTED VALUES when dialog is reopened
if (dSel != 0) then
{
	_cmb11 lbSetCurSel aoType; //AO selection method	
	_cmb91 lbSetCurSel aoSize; //AO size
	_cmb21 lbSetCurSel missType; //Mission type	
	_cmb31 lbSetCurSel day; //Time of day	
	_cmb32 lbSetCurSel resTickets; //Respawn tickets	
	_cmb41 lbSetCurSel weather; //Weather	
	_cmb42 lbSetCurSel ticBleed; //Ticket bleed	
	_cmb51 lbSetCurSel fogLevel; //Fog	
	_cmb52 lbSetCurSel timeLim; //Time limit	
	_cmb61 lbSetCurSel AIon; //Autonomous AI
	_cmb62 lbSetCurSel resType; //Respawn type
	_cmb71 lbSetCurSel revOn; //Revive
	_cmb72 lbSetCurSel resTime; //Player respawn time
	_cmb81 lbSetCurSel viewType; //3rd person view
	_cmb82 lbSetCurSel vehTime; //Vehicles respawn time
};