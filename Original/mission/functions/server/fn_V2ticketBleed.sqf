/*
	Author: IvosH

	Description:
		Controls tickets bleed

	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		[] spawn wrm_fnc_V2ticketBleed;
*/
if !( isServer ) exitWith {}; //run on the dedicated server or server host
["Ticket bleed started"] remoteExec ["systemChat", 0, false];

for "_i" from 0 to 1 step 0 do 
{
	_secW=0; _secE=0;
	
	if(getMarkerColor resFobW!="")then{_secW=_secW+1;}; //baseW1 (transport) is under control of sideW
	if(getMarkerColor resFobWE!="")then{_secE=_secE+1;};	
	if(getMarkerColor resBaseW!="")then{_secW=_secW+1;};
	if(getMarkerColor resBaseWE!="")then{_secE=_secE+1;};	
	if(getMarkerColor resFobEW!="")then{_secW=_secW+1;};
	if(getMarkerColor resFobE!="")then{_secE=_secE+1;};	
	if(getMarkerColor resBaseEW!="")then{_secW=_secW+1;};
	if(getMarkerColor resBaseE!="")then{_secE=_secE+1;};	
	if(getMarkerColor resAW!="")then{_secW=_secW+1;};
	if(getMarkerColor resAE!="")then{_secE=_secE+1;};		
	if(getMarkerColor resBW!="")then{_secW=_secW+1;};
	if(getMarkerColor resBE!="")then{_secE=_secE+1;};	
	if(getMarkerColor resCW!="")then{_secW=_secW+1;};
	if(getMarkerColor resCE!="")then{_secE=_secE+1;};
	
	if(_secW!=_secE)then
	{
		if(_secW>_secE)
		then{[sideE,((_secW-_secE)*-1)] call BIS_fnc_respawnTickets;}
		else{[sideW,((_secE-_secW)*-1)] call BIS_fnc_respawnTickets;};
	};
	sleep 7;
};