/*
Disable default A3 revive, enable SPE advanced revive (create module)
[] execVM "SPErevive.sqf";
player setdamage 0.6;
*/

//[player] call bis_fnc_disableRevive;
//[player] remoteExec ["bis_fnc_disableRevive", 0, true];
{[player] call bis_fnc_disableRevive;} remoteExec ["call", 0, true];

if (isServer)then{
	"SPE_Module_Advanced_Revive" createUnit [(position player),createGroup sideLogic,format
	["
		mdlRev=this;
		this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
		this setVariable ['name','modRev'];
		
		this setVariable ['SPE_ReviveEnabled',0,true];
		this setVariable ['SPE_ReviveMode',0,true];
		this setVariable ['SPE_ReviveRequiredTrait',0,true];
		this setVariable ['SPE_ReviveMedicSpeedMultiplier',1,true];
		this setVariable ['SPE_ReviveDelay',6,true];
		this setVariable ['SPE_ReviveForceRespawnDelay',6,true];
		this setVariable ['SPE_ReviveBleedOutDelay',180,true];
		this setVariable ['SPE_ReviveFakAmount',1,true];
		this setVariable ['SPE_ReviveIcons',0,true];
		this setVariable ['SPE_ReviveAutoCall',2,true];
		this setVariable ['SPE_ReviveAutoWithstand',2,true];
		this setVariable ['SPE_WithstandExtraFAK',0,true];
		this setVariable ['SPE_WithstandEnabled',0,true];
		this setVariable ['SPE_WithstandEnabledAI',0,true];
		this setVariable ['SPE_ReviveUnits',0,true];
	"]];
	publicVariable "mdlRev";
};

//[mdlRev] remoteExec ["SPE_MissionUtilityFunctions_fnc_ReviveToksaModuleInit", -2, true];
//[mdlRev,[],true] call SPE_MissionUtilityFunctions_fnc_ReviveToksaModuleInit;

["SPE Revive enabled"] remoteExec ["systemChat", 0, true];
//systemChat "SPE Revive enabled";