//Enable/disable admin options (radio, loop)
//(initPlayerLocal.sqf) null = [] execVM "admin\radio.sqf";
for "_i" from 0 to 1 step 0 do
{
	sleep 7;
	_rd=0;
	call
	{
		//if("wmgenerator" call BIS_fnc_getParamValue == 2)exitWith{_rd=1;}; //2
		if(serverCommandAvailable "#kick")exitWith{_rd=1;}; //0
		if(("wmgenerator" call BIS_fnc_getParamValue > 0)&&(count(allPlayers - entities "HeadlessClient_F")==1))exitWith{_rd=1;}; //1
	};
	if (_rd==1)
	then {10 setRadioMsg "Admin Menu";} 
	else {10 setRadioMsg "null";};
	sleep 59;
};