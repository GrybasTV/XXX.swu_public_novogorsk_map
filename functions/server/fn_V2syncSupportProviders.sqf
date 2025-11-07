/*
	Author: IvosH
	
	Description:
		Sinhronizuoja CAS support provider'ius su teisingais lėktuvais visiems klientams.
		Ši funkcija reikalinga, kad JIP žaidėjai gautų teisingus lėktuvus, o ne vanilla.
		Taip pat patikrina ir atnaujina artilerijos support provider'ius.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		fn_V2syncSupportProvidersClient.sqf
		
	Execution:
		[] call wrm_fnc_V2syncSupportProviders;
*/

if (!isServer) exitWith {}; //Tik serveryje

//Laukti, kol bus apibrėžti support provider'iai ir lėktuvų masyvai
waitUntil {!isNil "SupCasHW" && !isNil "SupCasBW" && !isNil "SupCasHE" && !isNil "SupCasBE"};
waitUntil {!isNil "HeliArW" && !isNil "PlaneW" && !isNil "HeliArE" && !isNil "PlaneE"};

//Paruošti lėktuvų masyvus (konvertuoti į string masyvus, jei reikia)
_HeliArW=[];
if ((HeliArW select 0) isEqualType [])
then{{_HeliArW pushBackUnique (_x select 0);} forEach HeliArW;}
else{_HeliArW=HeliArW;};

_PlaneW=[];
if ((PlaneW select 0) isEqualType [])
then{{_PlaneW pushBackUnique (_x select 0);} forEach PlaneW;}
else{_PlaneW=PlaneW;};

_HeliArE=[];
if ((HeliArE select 0) isEqualType [])
then{{_HeliArE pushBackUnique (_x select 0);} forEach HeliArE;}
else{_HeliArE=HeliArE;};

_PlaneE=[];
if ((PlaneE select 0) isEqualType [])
then{{_PlaneE pushBackUnique (_x select 0);} forEach PlaneE;}
else{_PlaneE=PlaneE;};

//Atnaujinti CAS support provider'ius su teisingais lėktuvais visiems klientams
//Naudojame remoteExec su 0 (visi klientai) ir true (persistent), kad JIP žaidėjai taip pat gautų teisingus nustatymus
[SupCasHW,["bis_supp_vehicles", _HeliArW]] remoteExec ["setVariable",0,true];
[SupCasBW,["bis_supp_vehicles", _PlaneW]] remoteExec ["setVariable",0,true];
[SupCasHE,["bis_supp_vehicles", _HeliArE]] remoteExec ["setVariable",0,true];
[SupCasBE,["bis_supp_vehicles", _PlaneE]] remoteExec ["setVariable",0,true];

//Atnaujinti cooldown laiką (jei reikia)
if (!isNil "arTime") then
{
	{[_x,["bis_supp_cooldown", arTime]] remoteExec ["setVariable",0,true];} forEach [SupCasHW,SupCasBW,SupCasHE,SupCasBE];
};

//IFA3 modifikacijai - specialus vehicle init
if(modA=="IFA3")then
{
	{[_x,["bis_supp_vehicleinit",{_this setVelocityModelSpace [0, 100, 100];}]] remoteExec ["setVariable",0,true];} forEach [SupCasBW,SupCasBE];
};

//Kvieskime kliento funkciją visiems klientams, kad patikrintų support provider'ius prisijungiant
//Tai užtikrina, kad JIP žaidėjai gautų teisingus nustatymus
[] remoteExec ["wrm_fnc_V2syncSupportProvidersClient", 0, false];

if(DBG)then{["Support providers synchronized for all clients"] remoteExec ["systemChat", 0, false];};

