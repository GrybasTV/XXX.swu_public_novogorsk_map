//null = [] execVM "admin\openMenu.sqf";
if ((serverCommandAvailable "#kick")||(count(allPlayers - entities "HeadlessClient_F")==1)) then 
{
	call
	{
		if(version==1)exitWith{createDialog "adminMenu";};
		if(version==2)exitWith{createDialog "V2adminMenu";};
	};
};
