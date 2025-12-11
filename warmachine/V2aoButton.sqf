/*
	Author: IvosH
	
	Description:
		Script executed when SELECT AREA OF OPERATION button is pressed
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		dialog.hpp
		
	Execution:
		[] execVM "warmachine\V2aoButton.sqf";
*/

//LOCAL VARIABLES: saves dialog selections
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

if (aoType == 0) exitWith 
{
	hint parseText format ["if you want to select AO position<br/>change AO selection method to<br/>Select AO"];
};

//close dialog window
closeDialog 0;
//open map
openMap [true, false];
// TIMEOUT #1
private _startTime1 = time;
waitUntil {
    sleep 0.1;
    (dSel == 1) || (time - _startTime1 > 60)
};

hint parseText format ["SELECT AREA OF OPERATION<br/><br/>By left mouse button click<br/>LMB<br/><br/>To select any sector and change its location<br/>Press Shift+LMB"];

["AOselect", "onMapSingleClick", {[_pos,_shift,_alt] execVM "warmachine\V2aoSelect.sqf";}] call BIS_fnc_addStackedEventHandler;

//remove eventhandler
// TIMEOUT #2
private _startTime2 = time;
waitUntil {
    sleep 0.1;
    (!visibleMap) || (time - _startTime2 > 300) // 5 minučių timeout žemėlapio uždarymui
};
["AOselect", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
if (AOcreated == 1) then {hint "AO CREATED SUCCESFULY";} else {hint "AO WAS NOT CREATED";};
dialogOpen = createDialog "V2missionsGenerator";
