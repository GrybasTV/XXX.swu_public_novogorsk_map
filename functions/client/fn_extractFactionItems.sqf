/*
	Author: Generated for Ukraine 2025 / Russia 2025
	
	Description:
		Automatiškai ištraukia aprangas, ginklus, itemus iš mūsų apibrėžtų karių (unitsW/unitsE)
		Vietoj hardcoded prefix'ų (RUS_, UA_, UKR_), naudoja tikrą, ką turi mūsų kariai
		
	Parameter(s):
		0: SIDE - west arba east
		
	Returns:
		ARRAY - [uniforms, helmets, vests, backpacks, weapons, items, magazines]
		
	Dependencies:
		init.sqf, unitsW, unitsE
		
	Execution:
		_result = [west] call wrm_fnc_extractFactionItems;
*/

params [["_side", west, [sideEmpty]]];

//Nustatyti, kuriuos karius naudoti
_unitsArray = [];
if (_side == west) then
{
	_unitsArray = unitsW;
} else
{
	if (_side == east) then
	{
		_unitsArray = unitsE;
	} else
	{
		//Independent - nenaudojame
		[[], [], [], [], [], [], []]; //grąžiname tuščius masyvus
	};
};

//Masyvai itemams
_uniforms = [];
_helmets = [];
_vests = [];
_backpacks = [];
_weapons = [];
_items = [];
_magazines = [];

//Sukurti temp grupę už horizon (nematoma žaidėjams)
_tempGrp = createGroup [_side, true];
_tempPos = [0, 0, 0]; //virtual position

//Iteruoti per visus karius
{
	_unitClass = _x;
	
	//Patikrinti, ar kario klasė egzistuoja
	if (_unitClass != "" && {isClass (configFile >> "CfgVehicles" >> _unitClass)}) then
	{
		//Sukurti temp unit'ą
		_tempUnit = _tempGrp createUnit [_unitClass, _tempPos, [], 0, "NONE"];
		
		//Pritaikyti loadout'ą (jei reikia - bet kariai jau turėtų turėti loadout'ą config'e)
		//Naudojame getUnitLoadout, kad gautume tikrą, ką turi karių klasė
		_loadout = getUnitLoadout _tempUnit;
		
		//Ištraukti itemus iš loadout'o
		//Loadout formatas: [primaryWeapon, secondaryWeapon, handgun, uniform, vest, backpack, headgear, facewear, binocular, linkedItems, items]
		//Uniform - getUnitLoadout grąžina masyvą [uniformClass, uniformItems] arba ["", []] jei tuščias
		_uniformData = _loadout select 3;
		if (typeName _uniformData == "ARRAY" && count _uniformData > 0) then
		{
			_uniformClass = _uniformData select 0;
			if (_uniformClass != "" && typeName _uniformClass == "STRING") then
			{
				_uniforms pushBackUnique _uniformClass;
			};
		};
		
		//Vest - getUnitLoadout grąžina masyvą [vestClass, vestItems] arba ["", []] jei tuščias
		_vestData = _loadout select 4;
		if (typeName _vestData == "ARRAY" && count _vestData > 0) then
		{
			_vestClass = _vestData select 0;
			if (_vestClass != "" && typeName _vestClass == "STRING") then
			{
				_vests pushBackUnique _vestClass;
			};
		};
		
		//Backpack - getUnitLoadout grąžina masyvą [backpackClass, backpackItems] arba ["", []] jei tuščias
		_backpackData = _loadout select 5;
		if (typeName _backpackData == "ARRAY" && count _backpackData > 0) then
		{
			_backpackClass = _backpackData select 0;
			if (_backpackClass != "" && typeName _backpackClass == "STRING") then
			{
				_backpacks pushBackUnique _backpackClass;
			};
		};
		
		//Headgear (helmet) - getUnitLoadout grąžina string'ą arba "" jei tuščias
		_headgear = _loadout select 6;
		if (_headgear != "" && typeName _headgear == "STRING") then
		{
			_helmets pushBackUnique _headgear;
		};
		
		//Primary weapon - getUnitLoadout grąžina masyvą [weaponClass, muzzle, pointer, optic, [magazines], [magazinesInWeapon], bipod] arba ["", "", "", "", [], [], ""] jei tuščias
		_primaryWeaponData = _loadout select 0;
		if (typeName _primaryWeaponData == "ARRAY" && count _primaryWeaponData > 0) then
		{
			_weaponClass = _primaryWeaponData select 0;
			if (_weaponClass != "" && typeName _weaponClass == "STRING") then
			{
				_weapons pushBackUnique _weaponClass;
			};
			//Magazines iš primary weapon (indeksas 4)
			if (count _primaryWeaponData > 4) then
			{
				_magazinesArray = _primaryWeaponData select 4;
				if (typeName _magazinesArray == "ARRAY") then
				{
					{
						if (typeName _x == "ARRAY") then
						{
							if (count _x > 0) then
							{
								_magazineClass = _x select 0;
								if (_magazineClass != "" && typeName _magazineClass == "STRING") then
								{
									_magazines pushBackUnique _magazineClass;
								};
							};
						};
					} forEach _magazinesArray;
				};
			};
		};
		
		//Secondary weapon - getUnitLoadout grąžina masyvą [weaponClass, muzzle, pointer, optic, [magazines], [magazinesInWeapon], bipod] arba ["", "", "", "", [], [], ""] jei tuščias
		_secondaryWeaponData = _loadout select 1;
		if (typeName _secondaryWeaponData == "ARRAY" && count _secondaryWeaponData > 0) then
		{
			_weaponClass = _secondaryWeaponData select 0;
			if (_weaponClass != "" && typeName _weaponClass == "STRING") then
			{
				_weapons pushBackUnique _weaponClass;
			};
			//Magazines iš secondary weapon (indeksas 4)
			if (count _secondaryWeaponData > 4) then
			{
				_magazinesArray = _secondaryWeaponData select 4;
				if (typeName _magazinesArray == "ARRAY") then
				{
					{
						if (typeName _x == "ARRAY") then
						{
							if (count _x > 0) then
							{
								_magazineClass = _x select 0;
								if (_magazineClass != "" && typeName _magazineClass == "STRING") then
								{
									_magazines pushBackUnique _magazineClass;
								};
							};
						};
					} forEach _magazinesArray;
				};
			};
		};
		
		//Handgun - getUnitLoadout grąžina masyvą [weaponClass, muzzle, pointer, optic, [magazines], [magazinesInWeapon], bipod] arba ["", "", "", "", [], [], ""] jei tuščias
		_handgunData = _loadout select 2;
		if (typeName _handgunData == "ARRAY" && count _handgunData > 0) then
		{
			_weaponClass = _handgunData select 0;
			if (_weaponClass != "" && typeName _weaponClass == "STRING") then
			{
				_weapons pushBackUnique _weaponClass;
			};
			//Magazines iš handgun (indeksas 4)
			if (count _handgunData > 4) then
			{
				_magazinesArray = _handgunData select 4;
				if (typeName _magazinesArray == "ARRAY") then
				{
					{
						if (typeName _x == "ARRAY") then
						{
							if (count _x > 0) then
							{
								_magazineClass = _x select 0;
								if (_magazineClass != "" && typeName _magazineClass == "STRING") then
								{
									_magazines pushBackUnique _magazineClass;
								};
							};
						};
					} forEach _magazinesArray;
				};
			};
		};
		
		//Linked items (items, kurie prijungti prie ginklo - pvz., optic, acc, muzzle)
		_linkedItems = _loadout select 9;
		if (typeName _linkedItems == "ARRAY" && count _linkedItems > 0) then
		{
			{
				if (_x != "" && typeName _x == "STRING") then
				{
					_items pushBackUnique _x;
				};
			} forEach _linkedItems;
		};
		
		//Items (items, kurie yra inventory - pvz., FirstAidKit, Medikit)
		//Patikrinti, ar _loadout turi pakankamai elementų (indeksas 10)
		if (count _loadout > 10) then
		{
			_itemsArray = _loadout select 10;
			if (typeName _itemsArray == "ARRAY" && count _itemsArray > 0) then
			{
				{
					if (_x != "" && typeName _x == "STRING") then
					{
						_items pushBackUnique _x;
					};
				} forEach _itemsArray;
			};
		};
		
		//Facewear (goggles) - getUnitLoadout grąžina string'ą arba "" jei tuščias
		_facewear = _loadout select 7;
		if (_facewear != "" && typeName _facewear == "STRING") then
		{
			_items pushBackUnique _facewear;
		};
		
		//Binocular - getUnitLoadout gali grąžinti string'ą arba masyvą [binocularClass, binocularItems] arba "" jei tuščias
		if (count _loadout > 8) then
		{
			_binocular = _loadout select 8;
			if (typeName _binocular == "STRING") then
			{
				if (_binocular != "") then
				{
					_items pushBackUnique _binocular;
				};
			} else
			{
				if (typeName _binocular == "ARRAY" && count _binocular > 0) then
				{
					_binocularClass = _binocular select 0;
					if (_binocularClass != "" && typeName _binocularClass == "STRING") then
					{
						_items pushBackUnique _binocularClass;
					};
				};
			};
		};
		
		//Pašalinti temp unit'ą
		deleteVehicle _tempUnit;
	};
} forEach _unitsArray;

//Pašalinti temp grupę
deleteGroup _tempGrp;

//Grąžinti rezultatus
[_uniforms, _helmets, _vests, _backpacks, _weapons, _items, _magazines];

