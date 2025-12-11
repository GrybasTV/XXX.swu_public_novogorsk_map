/*
	Author: IvosH
	
	Description:
		Script executed when CANCEL button is pressed. save current selection
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		dialog.hpp
		
	Execution:
		[] execVM "warmachine\cancel.sqf";
*/

//LOCAL VARIABLES: saves dialog selections
aoType = lbCurSel 311; //AO selection method
aoSize = lbCurSel 391; //AO size
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

private _startTime = time;
waitUntil {
    sleep 0.1;
    (dSel == 1) || (time - _startTime > 60)
};

if (time - _startTime > 60 && dSel != 1) exitWith {
    // Timeout - uždarome dialogą bet kokiu atveju
    closeDialog 0;
};

//close dialog window
closeDialog 0;