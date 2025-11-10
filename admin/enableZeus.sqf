//close dialog window
//closeDialog 0;

//condition: if player is admin (server host) or if command is available for everybody
if (!((serverCommandAvailable "#kick")||(count(allPlayers - entities "HeadlessClient_F")==1))) 
exitWith {hint "Command is available only for admin";};

if (isNull getAssignedCuratorUnit z1) then
{
	//player become Zeus
	[player, z1] remoteExec ["assignCurator", 2, false];
	//all players and playable units will be editable by Zeus
	z1 addCuratorEditableObjects [allplayers+playableUnits];
	hint "ZEUS Enabled";

} else
{
	//unassign zeus owner
	z1 remoteExec ["unassignCurator", 2, false];
	hint "ZEUS Disabled";
};