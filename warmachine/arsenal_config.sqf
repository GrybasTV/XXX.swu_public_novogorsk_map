/*
    Arsenal Configuration
    
    This file handles the White/Black listing of items in the Virtual Arsenal.
    
    LOGIC:
    - Vanilla/DLC items: BLOCKED by default. Only items in 'wrm_vanillaWhitelist' are shown.
    - Mod items: ALLOWED by default. Items in 'wrm_modBlacklist' are hidden.
*/

// VANILLA / DLC WHITELIST
// Items listed here will be VISIBLE even if they are Vanilla/DLC.
// Use this for essential items like GPS, Binoculars, specific Vanilla weapons if needed.
wrm_vanillaWhitelist = [
    // Maps & GPS
    "ItemMap",
    "ItemGPS",
    "ItemCompass",
    "ItemWatch",
    "ItemRadio",
    
    // Binoculars / Rangefinders
    "Binocular",
    "Rangefinder",
    "Laserdesignator",
    "Laserdesignator_02",
    "Laserdesignator_03",
    
    // NVGs
    "NVGoggles",
    "NVGoggles_OPFOR",
    "NVGoggles_INDEP",
    "O_NVGoggles_hex_F",
    "O_NVGoggles_urb_F",
    "O_NVGoggles_ghex_F",
    "NVGoggles_tna_F",
    
    // Toolkits / Medkits (if vanilla)
    "ToolKit",
    "Medikit",
    "FirstAidKit",
    "MineDetector"
];

// MOD BLACKLIST
// Items listed here will be HIDDEN even if they belong to the loaded Mod.
// Use this to remove overpowered or broken items from mods.
wrm_modBlacklist = [
    // Example: "rhs_weap_m4a1_carryhandle"
];

// Broadcast variables to all clients so they can filter their local Arsenals
publicVariable "wrm_vanillaWhitelist";
publicVariable "wrm_modBlacklist";
