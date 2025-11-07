/*
	Author: IvosH
	
	Description:
		Kliento funkcija, kuri patikrina ir atnaujina support provider'ius prisijungiant (JIP).
		Ši funkcija užtikrina, kad JIP žaidėjai gautų teisingus CAS lėktuvus ir artilerijos prieigą.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		fn_V2syncSupportProviders.sqf
		fn_leaderActions.sqf
		
	Execution:
		[] call wrm_fnc_V2syncSupportProvidersClient;
*/

if (!hasInterface) exitWith {}; //Tik klientuose su interface

//Laukti, kol žaidėjas bus inicializuotas
waitUntil {!isNull player};
waitUntil {player == player};

//Laukti, kol bus apibrėžti support provider'iai
waitUntil {!isNil "SupCasHW" && !isNil "SupCasBW" && !isNil "SupCasHE" && !isNil "SupCasBE"};

//Laukti, kol misija bus pradėta (progress > 1)
waitUntil {progress > 1};

//Laukti, kol bus apibrėžti lėktuvų masyvai
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

//Atnaujinti CAS support provider'ius su teisingais lėktuvais
//Naudojame setVariable su true, kad būtų sinchronizuota su visais klientais
if (!isNull SupCasHW) then
{
	SupCasHW setVariable ["bis_supp_vehicles", _HeliArW, true];
};
if (!isNull SupCasBW) then
{
	SupCasBW setVariable ["bis_supp_vehicles", _PlaneW, true];
};
if (!isNull SupCasHE) then
{
	SupCasHE setVariable ["bis_supp_vehicles", _HeliArE, true];
};
if (!isNull SupCasBE) then
{
	SupCasBE setVariable ["bis_supp_vehicles", _PlaneE, true];
};

//Jei žaidėjas yra leaderis, atnaujinti support link'us
//Tai užtikrina, kad support meniu būtų teisingai sukonfigūruotas
if (isPlayer leader player && leader player == player) then
{
	//Patikrinti ar SupReq yra teisingai inicializuotas
	call
	{
		if (side player == sideW) exitWith 
		{
			if (!isNil "SupReqW" && !isNull SupReqW) then
			{
				SupReq = SupReqW;
				//Pašalinti ir vėl pridėti support link'us, kad atnaujintų nustatymus
				[player, SupReq] call BIS_fnc_removeSupportLink;
				[player, SupReq] call BIS_fnc_addSupportLink;
			};
		};
		if (side player == sideE) exitWith 
		{
			if (!isNil "SupReqE" && !isNull SupReqE) then
			{
				SupReq = SupReqE;
				//Pašalinti ir vėl pridėti support link'us, kad atnaujintų nustatymus
				[player, SupReq] call BIS_fnc_removeSupportLink;
				[player, SupReq] call BIS_fnc_addSupportLink;
			};
		};
	};
};

//Patikrinti artilerijos prieigą - tikrinti, ar artilerijos objektas egzistuoja
//Jei artilerijos objektas neegzistuoja, pašalinti support link'ą
call
{
	if (side player == sideW) exitWith 
	{
		//Tikrinti, ar artilerijos sektorius yra užimtas (resBW marker egzistuoja)
		if (getMarkerColor resBW != "") then
		{
			//Tikrinti, ar artilerijos objektas egzistuoja
			//Tikrinti ir objArtiW, ir objMortW (mortar)
			_hasArtillery = false;
			if (!isNil "objArtiW" && !isNull objArtiW && alive objArtiW) then
			{
				_hasArtillery = true;
			};
			if (!isNil "objMortW" && !isNull objMortW && alive objMortW) then
			{
				_hasArtillery = true;
			};
			
			//Jei nei artilerijos, nei mortar objektas neegzistuoja, pašalinti support link'ą
			if (!_hasArtillery) then
			{
				if (!isNil "SupReqW" && !isNull SupReqW && !isNil "SupArtiV2" && !isNull SupArtiV2) then
				{
					[SupReqW, SupArtiV2] call BIS_fnc_removeSupportLink;
					if(DBG)then{systemChat "Artillery support removed - artillery/mortar object does not exist";};
				};
			};
		};
	};
	if (side player == sideE) exitWith 
	{
		//Tikrinti, ar artilerijos sektorius yra užimtas (resBE marker egzistuoja)
		if (getMarkerColor resBE != "") then
		{
			//Tikrinti, ar artilerijos objektas egzistuoja
			//Tikrinti ir objArtiE, ir objMortE (mortar)
			_hasArtillery = false;
			if (!isNil "objArtiE" && !isNull objArtiE && alive objArtiE) then
			{
				_hasArtillery = true;
			};
			if (!isNil "objMortE" && !isNull objMortE && alive objMortE) then
			{
				_hasArtillery = true;
			};
			
			//Jei nei artilerijos, nei mortar objektas neegzistuoja, pašalinti support link'ą
			if (!_hasArtillery) then
			{
				if (!isNil "SupReqE" && !isNull SupReqE && !isNil "SupArtiV2" && !isNull SupArtiV2) then
				{
					[SupReqE, SupArtiV2] call BIS_fnc_removeSupportLink;
					if(DBG)then{systemChat "Artillery support removed - artillery/mortar object does not exist";};
				};
			};
		};
	};
};

if(DBG)then{systemChat "Support providers synchronized for JIP player";};

