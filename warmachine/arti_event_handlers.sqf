// Artillery Event Handlers - atskiras failas siekiant išvengti kabučių problemų
// Šis failas iškviečiamas iš ModuleSector OnOwnerChange callback

// Tikrinti ar objArtiW egzistuoja ir turi crew
if (!isNull objArtiW && {alive objArtiW} && {count crew objArtiW > 0}) then {
    {
        // Pridėti event handler tik jei dar neturi
        if !(_x getVariable ["wrm_artiEH_added", false]) then {
            _x setVariable ["wrm_artiEH_added", true];
            _x addMPEventHandler ["MPKilled", {
                params ["_corpse", "_killer", "_instigator", "_useEffects"];
                [_corpse, sideW] spawn wrm_fnc_killedEH;
            }];
        };
    } forEach (crew objArtiW);
};

// Tikrinti ar objArtiE egzistuoja ir turi crew
if (!isNull objArtiE && {alive objArtiE} && {count crew objArtiE > 0}) then {
    {
        // Pridėti event handler tik jei dar neturi
        if !(_x getVariable ["wrm_artiEH_added", false]) then {
            _x setVariable ["wrm_artiEH_added", true];
            _x addMPEventHandler ["MPKilled", {
                params ["_corpse", "_killer", "_instigator", "_useEffects"];
                [_corpse, sideE] spawn wrm_fnc_killedEH;
            }];
        };
    } forEach (crew objArtiE);
};

// Tikrinti ar objAAW egzistuoja ir turi crew
if (!isNull objAAW && {alive objAAW} && {count crew objAAW > 0}) then {
    {
        // Pridėti event handler tik jei dar neturi
        if !(_x getVariable ["wrm_artiEH_added", false]) then {
            _x setVariable ["wrm_artiEH_added", true];
            _x addMPEventHandler ["MPKilled", {
                params ["_corpse", "_killer", "_instigator", "_useEffects"];
                [_corpse, sideW] spawn wrm_fnc_killedEH;
            }];
        };
    } forEach (crew objAAW);
};

// Tikrinti ar objAAE egzistuoja ir turi crew
if (!isNull objAAE && {alive objAAE} && {count crew objAAE > 0}) then {
    {
        // Pridėti event handler tik jei dar neturi
        if !(_x getVariable ["wrm_artiEH_added", false]) then {
            _x setVariable ["wrm_artiEH_added", true];
            _x addMPEventHandler ["MPKilled", {
                params ["_corpse", "_killer", "_instigator", "_useEffects"];
                [_corpse, sideE] spawn wrm_fnc_killedEH;
            }];
        };
    } forEach (crew objAAE);
};
