/*
	Author: IvosH
	
	Description:
		MISSIONS GENERATOR dialog layout V2.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		description.ext
		defines.hpp
		
	Execution:
		#include "warmachine\V2dialog.hpp"
		dialogOpen = createDialog "V2missionsGenerator"; publicVariable "dialogOpen";
*/
class V2missionsGenerator
{
	idd = 2020;
	movingEnable = true;
	enableSimulation = 1;
	onLoad = "execVM ""warmachine\V2dialog.sqf"";";
	
	//BACKGROUND
	class controlsBackground // Background controls (placed behind Controls)
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 6.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 27 * GUI_GRID_CENTER_W;
			h = 8.5 * GUI_GRID_CENTER_H;
			moving = true;
		};
		class IGUIBack_2201: IGUIBack
		{
			idc = 2201;
			x = 6.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 27 * GUI_GRID_CENTER_W;
			h = 16.0082 * GUI_GRID_CENTER_H;
		};
	};
	
	class controls  // Main controls
	{
/*
		//HEADER
		class header: RscStructuredText
		{
			idc = 101;
			text = "WARMACHINE - Mission generator"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0.99 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12.5 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			//size = 2 * GUI_GRID_CENTER_H;
		};
*/
		//BUTTONS
		class buttonMap: RscButton
		{
			idc = 401;
			text = "SELECT AREA OF OPERATION"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1.49 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 2.00102 * GUI_GRID_CENTER_H;
			tooltip = "Opens map to select area of operation"; //--- ToDo: Localize;
			action = "[] execVM ""warmachine\V2aoButton.sqf"";";
		};
		class buttonStart: RscButton
		{
			idc = 402;
			text = "START MISSION"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 5.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 2.00102 * GUI_GRID_CENTER_H;
			tooltip = "Close dialog window and start the mission"; //--- ToDo: Localize;
			action = "[] execVM ""warmachine\V2startButton.sqf"";";
		};
		class buttonCancel: RscButton
		{
			idc = 403;
			text = "X"; //--- ToDo: Localize;
			x = 32 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = -0.01 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 1.5 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Close dialog window, keeps current parameters"; //--- ToDo: Localize;
			action = "[] execVM ""warmachine\V2cancelButton.sqf"";";
		};
		class buttonV1: RscButton
		{
			idc = 404;
			text = "WARMACHINE - Mission generator"; //--- ToDo: Localize;
			x = 6.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = -1.01 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			tooltip = "By IvosH"; //--- ToDo: Localize;
			//action = "[] execVM ""warmachine\V2version1Button.sqf"";";
		};
/*		class buttonV2: RscButton
		{
			idc = 405;
			text = "VERSION 2"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = -0.01 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Switch to version 2"; //--- ToDo: Localize;
			action = "[] execVM ""warmachine\V2version1Button.sqf"";";
		};
*/
		//TEXT
		class text11: RscText
		{
			idc = 211;
			text = "AO selection method"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Random / By one click"; //--- ToDo: Localize;
		};
		class text91: RscText
		{
			idc = 291;
			text = "AO size"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Size of the AO"; //--- ToDo: Localize;
		};
		class text21: RscText
		{
			idc = 221;
			text = "Mission type"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 5.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "What types of the vehicles will be available"; //--- ToDo: Localize;
		};
		class text31: RscText
		{
			idc = 231;
			text = "Time of day"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 9.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};

		class text32: RscText
		{
			idc = 232;
			text = "Respawn tickets"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 9.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Amount of the available respawns fo each side"; //--- ToDo: Localize;
		};
		class text41: RscText
		{
			idc = 241;
			text = "Weather"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 12 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class text42: RscText
		{
			idc = 242;
			text = "Ticket bleed"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 12 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Reduces enemy tickets by holding majority of the objectives"; //--- ToDo: Localize;
		};
		class text51: RscText
		{
			idc = 251;
			text = "Fog"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 14.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class text52: RscText
		{
			idc = 252;
			text = "Time limit"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 14.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Maximal duration of the game"; //--- ToDo: Localize;
		};
		class text61: RscText
		{
			idc = 261;
			text = "Autonomous AI"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "All AI units will join the battle and attack objectives"; //--- ToDo: Localize;
		};
		class text62: RscText
		{
			idc = 262;
			text = "Respawn type"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Where player can respawn"; //--- ToDo: Localize;
		};
		class text71: RscText
		{
			idc = 271;
			text = "Revive"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 19.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Revive system"; //--- ToDo: Localize;
		};
		class text72: RscText
		{
			idc = 272;
			text = "Player respawn time"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 19.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class text81: RscText
		{
			idc = 281;
			text = "3rd person view"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 22 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Third person view for player"; //--- ToDo: Localize;
		};
		class text82: RscText
		{
			idc = 282;
			text = "Vehicles respawn time"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 22 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
			tooltip = "Unarmed tansport vehicles / Armed vehicles"; //--- ToDo: Localize;
		};
		
		//COMBO
		class combo11: RscCombo
		{
			idc = 311;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo91: RscCombo
		{
			idc = 391;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo21: RscCombo
		{
			idc = 321;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 6.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo31: RscCombo
		{
			idc = 331;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo32: RscCombo
		{
			idc = 332;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo41: RscCombo
		{
			idc = 341;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 13 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo42: RscCombo
		{
			idc = 342;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 13 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo51: RscCombo
		{
			idc = 351;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 15.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo52: RscCombo
		{
			idc = 352;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 15.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo61: RscCombo
		{
			idc = 361;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 18 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo62: RscCombo
		{
			idc = 362;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 18 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo71: RscCombo
		{
			idc = 371;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 20.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo72: RscCombo
		{
			idc = 372;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 20.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo81: RscCombo
		{
			idc = 381;
			x = 7.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 23 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
		class combo82: RscCombo
		{
			idc = 382;
			x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 23 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 1.00051 * GUI_GRID_CENTER_H;
		};
	};
};
