/*
	Author: IvosH
	
	Description:
		Admin menu dialog layout.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		admin scripts
		description.ext (#include "admin\adminMenu.hpp")
		defines.hpp
		
	Execution:
		Place trigger - repeatable
		Text: Administrator menu
		Activation: Radio Juliet
		On activation: aMenu = createDialog "adminMenu";
*/
class adminMenu
{
	idd = 2019;
	movingEnable = true;
	enableSimulation = 1;

	class controlsBackground // Background controls (placed behind Controls)
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2201;
			x = 13 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 14 * GUI_GRID_CENTER_W;
			h = 12 * GUI_GRID_CENTER_H;
			moving = true;
		};
	};
	
	class controls  // Main controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 501;
			text = "Administrator menu"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
		};
		class button1: RscButton
		{
			idc = 502;
			text = "Teleport"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Moves you to the selected location"; //--- ToDo: Localize;
			action = "[] execVM ""admin\teleport.sqf"";";
		};
		class button2: RscButton
		{
			idc = 503;
			text = "Enable ZEUS"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Zeus ON"; //--- ToDo: Localize;
			action = "[] execVM ""admin\enableZeus.sqf"";";
		};
		class button3: RscButton
		{
			idc = 504;
			text = "Disable ZEUS"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Zeus OFF"; //--- ToDo: Localize;
			action = "[] execVM ""admin\disableZeus.sqf"";";
		};
		class button4: RscButton
		{
			idc = 505;
			text = "Start 2nd phase"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Starts fight for the FOB"; //--- ToDo: Localize;
			action = "[] execVM ""admin\startFob.sqf"";";
		};
		class button5: RscButton
		{
			idc = 506;
			text = "Mission End"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 11 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 12 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Terminates the mission"; //--- ToDo: Localize;
			action = "[] execVM ""admin\endGame.sqf"";";
		};
		class buttonClose: RscButton
		{
			idc = 507;
			text = "X"; //--- ToDo: Localize;
			x = 26 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 0.999997 * GUI_GRID_CENTER_W;
			h = 0.999999 * GUI_GRID_CENTER_H;
			tooltip = "Close admin menu"; //--- ToDo: Localize;
			action = "closeDialog 0;";
		};
	};
};
