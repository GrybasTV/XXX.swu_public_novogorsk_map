/*
	Author: IvosH
	
	Description:
		Script executed when Start button is pressed. Start creating the mission (run start.sqf).
		
	Parameter(s):
		dialog selections
		
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		dialog.hpp
		
	Execution:
		[] execVM "warmachine\startButton.sqf";
*/

//LOCAL VARIABLES: saves dialog selections-------------------------------------------LOCAL//
aoType = lbCurSel 311; //AO selection method
aoSize = lbCurSel 391; //AO selection method
missType = lbCurSel 321; //Mission type	
day = lbCurSel 331; //Time of day	
resTickets = lbCurSel 332; //Respawn tickets	
weather = lbCurSel 341; //Weather	
ticBleed = lbCurSel 342; //Ticket bleed	
fogLevel = lbCurSel 351; //Fog	
timeLim = lbCurSel 352; //Time limit	
AIon = lbCurSel 361; //Autonomous AI
resType = lbCurSel 362; //Respawn type
revOn = lbCurSel 371; //Revive
resTime = lbCurSel 372; //Player respawn time
viewType = lbCurSel 381; //3rd person view
vehTime = lbCurSel 382; //Vehicles respawn time

//enable loading of dialog selections
dSel = 1;

//control of DIALOG selections
if (progress >= 1) exitWith {};
if (aoType!=0 && AOcreated==0) exitWith {hint parseText format ["SELECT AREA OF OPERATION<br/><br/>Press button SELECT AREA OF OPERATION and select a position on the map"];};

progress = 1;  publicVariable "progress";
//close dialog window
[0] remoteExec ["closeDialog", 0, false]; //closeDialog 0;

if ("param2" call BIS_fnc_getParamValue > 0) then 
{ 
	_t=10; if(DBG)then{_t=3;};
	for "_i" from _t to 0 step -1 do //loop 10
	{
		[parseText format ["Mission started by %1<br/>START IN %2<br/><br/>(Close virtual arsenal to save your loadout)",profileName, _i]] remoteExec ["hint", 0, false];
		sleep 1;
	};
} else
{
	for "_i" from 10 to 0 step -1 do //loop
	{
		[parseText format ["Mission started by %1<br/>START IN %2",profileName, _i]] remoteExec ["hint", 0, false];
		sleep 1;
	};
};

[""] remoteExec ["hint", 0, false];
if(!DBG)then{[["CREATING MISSION", "BLACK", 3]] remoteExec ["titleText", 0, false];}; //black screen
sleep 3;

[[
	//mission parameters
	aoType, missType, day, resTickets, weather, ticBleed, fogLevel, timeLim, AIon, resType, revOn, resTime, viewType, vehTime, 
	//objectives position
	posArti, posCas, posAA, posBaseW1,posBaseW2, posBaseE1, posBaseE2, 
	//infantry respawn 
	resArtiW, resArtiE, resCasW, resCasE, resAAW, resAAE, resBaseW1W, resBaseW1E, resBaseW2W, resBaseW2E, resBaseE1W, resBaseE1E, resBaseE2W, resBaseE2E,  
	//vehicle respawn
	rBikeW, rTruckW, rHeliTrW, rCarArW, rCarW, rArmorW1, rHeliArW, rArmorW2, rBikeE, rTruckE, rHeliTrE, rCarArE, rCarE, rArmorE1, rHeliArE, rArmorE2,
	//directions
	dirBW, dirBE,
	aoSize
], "warmachine\V2startServer.sqf"] remoteExec ["execVM", 0, false];