/*
	Author: IvosH
	
	Description:
		Add missiom briefing 
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		init.sqf
		
	Execution:
		call compile preProcessFileLineNumbers "diary.sqf";
*/

if (!hasInterface) exitWith {};
waitUntil {!isNull player};

/*
unitName createDiarySubject [subject, displayName, picture-optional];
unitName createDiaryRecord [subject, [title, text], task-optional, state-optional];

modifiers, links, and font options
<marker name='marker_name'>text with link</marker>
<img image='Image file name jpeg or paa' />
<font color='#FF0000' size='14' face='vbs2_digital'>Text you want in this font</font>
<br/> New Line

http://www.w3schools.com/colors/colors_picker.asp
https://community.bistudio.com/wikidata/images/archive/0/0e/20140217182059%21Arma3Fonts.png
*/

player createDiaryRecord 
["Diary",["Credits","
Author:<br/>
IvosH<br/><br/>
Thanks to:<br/>
Bohemia Interactive<br/>
for Arma 3 and community support<br/><br/>
Feuerex, Killzone Kid, Larrow<br/>
for their tutorials<br/><br/>
Ceb.Cin<br/>
for the trailer and showcase video<br/><br/>
Udie, Majkl, Flash-Ranger, kju, G_Redeye, GamerDad, Spanilo, Viper, Prapor, hmoody-TH, Serjant, Michal99, Libor, Miguel 83, Lucie<br/>
for their help. Thank you very much. I would never get this far without you.
"]];

player createDiaryRecord 
["Diary",["Admin options","
Zeus is available for admin, server host and if player is alone on the server<br/><br/>
LOBBY PARAMETERS<br/>
Factions selection<br/>
Virtual arsenal<br/>
Mission generator<br/> 
Automatic mission start<br/>
Enable DLC content.<br/><br/>
ADMIN MENU (accessible via radio)<br/>
To access Administrator menu - Press 0-0-0
"]];

player createDiaryRecord 
["Diary",["Actions menu","
MISSION GENERATOR - Create mission. Opens setup dialog window. Select area of operation, set up mission parameters, start mission.<br/><br/>
BECOME SQUAD LEADER - You can become leader of your squad.<br/><br/>
LEAVE LEADER POSITION - To leave the squad leader position.<br/><br/>
AIR DROP -  Squad leader can request an airdrop. Supplybox | Car | Truck.<br/><br/>
FORTIFICATION - As a squad leader, you can build fortifications.<br/><br/>
UAV | UGV request -  Squad leader can request UAV and UGV. Use UAV terminal to operate the vehicle. (Arma 3 default factions)<br/><br/>
REARM - You can rearm, repair and refuel vehicles at the bases.<br/><br/>
FLIP VEHICLE - Turn vehicle back on the wheels.<br/><br/>
PUSH BOAT - Player can push the boat into the water.
"]];

player createDiaryRecord 
["Diary",["Features","
MISSION GENERATOR - To create and start the mission, open Mission generator in the Actions menu.<br/><br/>
OBJECTIVES - Holding objectives gives your team advantage over enemy. Combat support, Anti Air | Artillery | CAS, access to vehicles, respawn positions. Capturing speed depends on the number of players and AI units present in the area. More players / AI units = faster capturing. If ticket bleed is enabled, holding majority of the objectives reduces opponents respawn tickets.<br/><br/> 
COMBAT SUPPORT - Anti Air | Artillery | CAS. Combat support is obtained as a reward after capturing a sector. Every squad leader can request combat support by pressing 0-8-(support type).<br/><br/>
BASES - Serve as starting position, vehicles respawn position and access to virtual arsenal. Bases of the opposing forces are not marked on the map, but they can be captured.<br/><br/>
MARKERS - Represent positions of the Bases, respawn positions of the vehicles and the supply drop.<br/><br/>
FLAGS - Serve as a teleports for fast travel between Bases.<br/><br/>
AUTONOMOUS AI - If autonomous AI is enabled, all AI units will join the battle and attack objectives. It's recommended to control squad leaders by players.<br/><br/>
REVIVE - Player can be revived by another player or by AI unit.<br/><br/>
SQUAD LEADER - As a squad leader you have acces to squad command | Artillery | CAS | Air drop | Fortifications.<br/><br/>
EQUIPMENT - Appropriate equipment is required for special actions. Medkit, First aid kit - revive teammates | Toolkit - repair vehicles and defuse explosives | UAV terminal – hack and operate UAV.<br/><br/>
CUSTOM LOADOUT - You can create custom loadout in the virtual arsenal, supply box at the base. Custom Loadout is available in the respawn menu: Default > Custom Loadout.<br/><br/>
ZEUS - Zeus is available for admin, server host and if player is alone on the server.
"]];

_p1="";_p2="";
call
{
	if(sideW==west&&sideE==east)exitWith{_p1='''plot3WE.paa''';};
	if(sideW==west&&sideE==independent)exitWith{_p1='''plot3WI.paa''';};
	if(sideW==independent&&sideE==east)exitWith{_p1='''plot3EI.paa''';};
};

_textCQ = ["
<img image=",_p1," width='368' height='184'/><br/><br/>
CONQUEST GAME MODE<br/>
Both teams fight for 7 objectives. Capture and hold ANTI AIR, ARTILLERY and CAS TOWER positions. Locate and capture two enemy BASES. Protect two friendly BASES. Your team wins if enemy respawn tickets are depleted or if your team captures all 7 objectives. If ticket bleed is enabled, holding majority of the objectives reduces opponents respawn tickets. 
"] joinString "";

player createDiaryRecord 
["Diary",["Conquest Gameplay",_textCQ]];

_textWM = [
"WARMACHINE ",island,"<br/><br/>
<img image='lobby.paa' width='368' height='184'/><br/><br/>
WARMACHINE <br/>
Conquest game mode for Arma 3, with replayable, dynamically generated missions. Inspired by the Battlefield games. Multiplayer scenario can be played as SP | Coop | PvP. Game mode is playable from 1 to 48 players. <br/><br/>
FOCUSED ON COMBAT <br/>
Epic battles and intense firefights. Your main task is to fight with your team for victory. Choose your favorite weapon or vehicle and fight. <br/><br/>
VARIABILITY <br/>
Every created mission is unique. In the mission generator, you can select any place on the map, set up mission parameters, or leave it randomized. You can easily create missions from small scale infantry combat to battlefield style scenario with all the vehicles, artillery and close air support. Mission layout is every time different. <br/><br/>
IN ACTION <br/>
Autonomous AI is designed to populate battlefield with low number of players. AI units will join the battle and attack objectives, call artillery and close air support. AI units respawn on the best position closest to the fight and ready to attack. Players can be revived by AI. <br/><br/>"
] joinString "";

player createDiaryRecord 
["Diary",["WarMachine",_textWM]];