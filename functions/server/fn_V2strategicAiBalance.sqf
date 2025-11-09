/*
	Author: IvosH (modifikuota)
	
	Description:
		Prestige Strategic AI Balance sistema - HYBRID SCALING
		Kariai: ONE-WAY (spawn, bet nenaikinami)
		Technika: PROPORCIONAL SCALING (pagal lygį keičiasi tikimybės)
		Dinaminis AI boost pagal strateginius sektorius
		Skaičiuoja sektorius atsižvelgiant į neutralius sektorius (kaip fn_V2aiMove.sqf)
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		fn_V2aiMove.sqf (sektorių skaičiavimo logika)
		
	Execution:
		[] spawn wrm_fnc_V2strategicAiBalance;
*/

if !(isServer) exitWith {}; //run on the dedicated server or server host

//Prestige Strategic AI Balance veikia tik jei AI įjungtas ir misijos parametras aktyvus
//Patikrinti ar AIon yra apibrėžtas (SQF best practices)
private _aiLevel = missionNamespace getVariable ["AIon", 1]; // Default 1 jei nėra apibrėžtas
if (_aiLevel == 0) exitWith {}; //Jei AI išjungtas (parametru), sistema nereikalinga

//Patikrinti ar DBG yra apibrėžtas (SQF best practices)
private _debugMode = missionNamespace getVariable ["DBG", false]; // Default false jei nėra apibrėžtas
private _prestigeEnabled = ("asp18" call BIS_fnc_getParamValue) == 1;

//Jei asp18=1 (Enabled), sistema įjungta. Kitu atveju išjungta.
if (!_prestigeEnabled) exitWith
{
	if(_debugMode)then
	{
		systemChat "[STRATEGIC AI] Sistema išjungta (asp18=0)";
	};
};

//Pradėti sistemą
if(_debugMode)then
{
	systemChat "[STRATEGIC AI] Sistema pradėta - dinaminis AI balansas įjungtas";
};

//Inicializuoti armor spawn ratio kintamuosius pagal pradinį AI lygį
private _initialRatio = call {
	if (_aiLevel == 1) exitWith {1.0};  // 100% Armor 1
	if (_aiLevel == 2) exitWith {0.7};  // 70% Armor 1
	if (_aiLevel == 3) exitWith {0.5};  // 50% Armor 1
	0.7; // fallback
};

armorSpawnRatioW = _initialRatio;
armorSpawnRatioE = _initialRatio;
publicVariable "armorSpawnRatioW";
publicVariable "armorSpawnRatioE";

if(_debugMode)then
{
	systemChat format ["[STRATEGIC AI] Inicializuoti armor ratio: W=%1, E=%2", armorSpawnRatioW, armorSpawnRatioE];
};

//Išsaugoti bazinį AI lygį (saugos riba 1-3) ir paskutinę pritaikytą reikšmę
private _baseAILevel = _aiLevel;
_baseAILevel = (_baseAILevel max 1) min 3;
private _lastAppliedLevel = _baseAILevel; //Inicijuoti su baziniu lygiu
private _lastDiff = 1000000; //skirtumas iš praeitos iteracijos (1e6 kaip pradinis sentinel)

//Pagrindinis ciklas - tikrinti sektorių balansą kas 30 sekundžių (performance optimization)
private _checkInterval = 30; //sekundės tarp patikrinimų - padidinta pagal SQF best practices
for "_i" from 0 to 1 step 0 do 
{
	//Laukti, kol žaidimas prasidės
	if(progress < 2) then {
		sleep 5;
		continue;
	};
	
	//Skaičiuoti strateginius sektorius (AA, Artillery, CAS)
	private _secW = 0; //West kontroliuojami sektoriai
	private _secE = 0; //East kontroliuojami sektoriai
	private _secNeutral = 0; //Neutralūs sektoriai
	
	call
	{
		if((getMarkerColor resAW == "") && (getMarkerColor resAE == "")) exitWith {_secNeutral = _secNeutral + 1;};
		if(getMarkerColor resAW != "") exitWith {_secW = _secW + 1;};
		if(getMarkerColor resAE != "") exitWith {_secE = _secE + 1;};
	};
	
	call
	{
		if((getMarkerColor resBW == "") && (getMarkerColor resBE == "")) exitWith {_secNeutral = _secNeutral + 1;};
		if(getMarkerColor resBW != "") exitWith {_secW = _secW + 1;};
		if(getMarkerColor resBE != "") exitWith {_secE = _secE + 1;};
	};
	
	call
	{
		if((getMarkerColor resCW == "") && (getMarkerColor resCE == "")) exitWith {_secNeutral = _secNeutral + 1;};
		if(getMarkerColor resCW != "") exitWith {_secW = _secW + 1;};
		if(getMarkerColor resCE != "") exitWith {_secE = _secE + 1;};
	};
	
	//Apskaičiuoti sektorių balansą
	private _sectorDiff = _secW - _secE; //Teigiamas = West turi daugiau, neigiamas = East turi daugiau
	private _absDiff = abs _sectorDiff; //Absoliutus skirtumas
	private _diffChange = if (_lastDiff == 1e6) then {_sectorDiff} else {_sectorDiff - _lastDiff};
	
	//RUBBERBAND SISTEMA: COOP NUSTATYMAS PAGAL MŪŠIO DINAMIKĄ (sektorių balansą)
	//Svarbiausia yra progresas žemėlapyje (sektorių balansas), ne žaidėjų skaičius
	//Sistema balansuoja pagal faktišką mūšio dinamiką - kuri pusė pralaimi, gauna AI boost'ą
	call
	{
		if (_aiLevel == 1) exitWith {coop = 0;}; //AI lygis 1 = visada balanced
		
		//Balansuoti pagal sektorių balansą (mūšio dinamiką/progresą žemėlapyje)
		if (_sectorDiff > 0) exitWith {coop = 1;}; //West turi daugiau sektorių = East gauna boost (pralaimi)
		if (_sectorDiff < 0) exitWith {coop = 2;}; //East turi daugiau sektorių = West gauna boost (pralaimi)
		coop = 0; //Balansuota = abi pusės gauna AI
	};
	
	publicVariable "coop";
	
	if(_debugMode)then
	{
		if (coop != 0) then
		{
			systemChat format ["[RUBBERBAND] coop=%1 | MŪŠIO DINAMIKA (sektorių balansas) | Sektoriai: W:%2 E:%3 | Skirtumas:%4", coop, _secW, _secE, _sectorDiff];
		};
	};
	
	//Tikslinis AI lygis pagal dokumentaciją (bazinis + skirtumas, maks. 3)
	private _targetAILevel = _baseAILevel;
	if (_absDiff > 0) then
	{
		private _maxBoost = 3 - _baseAILevel;
		private _boost = _absDiff min _maxBoost;
		_targetAILevel = _baseAILevel + _boost;
	};
	
	//Pritaikyti naują lygį tik jei pasikeitė
		if (_targetAILevel != _lastAppliedLevel) then
		{
			//Nustatyti globalų AI lygį su validation (SQF best practices)
			missionNamespace setVariable ["AIon", _targetAILevel, true];

		//PROPORCINGAS SUNKUMO SKALINGAS PAGAL AI LYGĮ
		//Kiekvienas lygis turi aiškų progresyvų sunkumą
		//KARIAI: ONE-WAY (spawn, bet nenaikinami)
		//TECHNIKA: PROPORCIONAL SCALING (keičiasi tikimybės pagal lygį)
		//COOP: Nustatomas rubberband sistema (žr. aukščiau)
		call
		{
			//AI LYGIS 1: BAZINIS (Balanced - 100%)
			if (_targetAILevel == 1) exitWith
			{
				// Technikos proporcijos: 100% Armor 1, 0% Armor 2
				armorSpawnRatioW = 1.0;  // 100% tikimybė gauti Armor 1
				armorSpawnRatioE = 1.0;
				aiArmWr2 = false;  // Armor 2: IŠJUNGTI (respawn neleidžiamas)
				aiArmEr2 = false;
				// coop jau nustatytas rubberband sistema (žr. aukščiau)
				// Kariai: išlaikomi visi istoriniai spawn'ai (one-way scaling)
				if(_debugMode)then{systemChat "[STRATEGIC AI] Lygis 1: Bazinis (100% - tik lengva technika, kariai išlieka)";};
			};

			//AI LYGIS 2: VIDUTINIS BOOST (Challenging - 150%)
			if (_targetAILevel == 2) exitWith
			{
				// Technikos proporcijos: 70% Armor 1, 30% Armor 2
				armorSpawnRatioW = 0.7;  // 70% tikimybė gauti Armor 1, 30% Armor 2
				armorSpawnRatioE = 0.7;
				aiArmWr2 = true;   // Armor 2: ĮJUNGTI (respawn leidžiamas)
				aiArmEr2 = true;
				// coop jau nustatytas rubberband sistema (žr. aukščiau)
				// Kariai: +12 papildomų (jei dar nebuvo) + išlaikomi visi istoriniai
				if(_debugMode)then{systemChat "[STRATEGIC AI] Lygis 2: Vidutinis boost (150% - 70% lengva/30% sunki technika + 12 papildomų karių)";};
			};

			//AI LYGIS 3: MAKSIMALUS BOOST (Overwhelming - 200%+)
			if (_targetAILevel == 3) exitWith
			{
				// Technikos proporcijos: 50% Armor 1, 50% Armor 2
				armorSpawnRatioW = 0.5;  // 50% tikimybė gauti Armor 1, 50% Armor 2
				armorSpawnRatioE = 0.5;
				aiArmWr2 = true;   // Armor 2: ĮJUNGTI VISI (respawn leidžiamas)
				aiArmEr2 = true;
				// coop jau nustatytas rubberband sistema (žr. aukščiau)
				// Kariai: +24 papildomų (jei dar nebuvo) + išlaikomi visi istoriniai
				if(_debugMode)then{systemChat "[STRATEGIC AI] Lygis 3: Maksimalus boost (200%+ - 50% lengva/50% sunki technika + 24 papildomi kariai)";};
			};
		};

		//PublicVariable svarbiausius kintamuosius
		//coop jau nustatytas ir publicVariable'inamas kas kartą pagrindiniame cikle (žr. aukščiau)
		publicVariable "armorSpawnRatioW";
		publicVariable "armorSpawnRatioE";
		publicVariable "aiArmWr2";
		publicVariable "aiArmEr2";

		//DINAMIŠKAI VALDYTI SQUAD'US PAGAL AI LYGĮ
		[_targetAILevel] call wrm_fnc_V2prestigeSquadManager;

		_lastAppliedLevel = _targetAILevel;

		if(_debugMode)then
		{
			private _dbgMsg = if (_absDiff > 0) then
			{
				format ["[STRATEGIC AI] Boost aktyvuotas | W:%1 E:%2 N:%3 | Skirtumas:%4 (Δ%5) | Lygis:%6",
					_secW, _secE, _secNeutral, _sectorDiff, _diffChange, _targetAILevel]
			}
			else
			{
				format ["[STRATEGIC AI] Balansas atkurtas | W:%1 E:%2 N:%3 | Skirtumas:%4 (Δ%5) | Lygis:%6",
					_secW, _secE, _secNeutral, _sectorDiff, _diffChange, _targetAILevel]
			};
			systemChat _dbgMsg;
		};
	};
	
	_lastDiff = _sectorDiff;
	
	//Laukti prieš kitą tikrinimą
	sleep _checkInterval;
};

