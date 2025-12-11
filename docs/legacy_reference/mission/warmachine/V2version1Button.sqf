//switch version 2 to version 1
closeDialog 0;
dSel = 0;
version = 1;
sleep 0.1;
dialogOpen = createDialog "missionsGenerator";

_p1="";_p2="";
call
{
	if(sideW==west&&sideE==east)exitWith{_p1='''plot1WE.paa''';_p2='''plot2WE.paa''';};
	if(sideW==west&&sideE==independent)exitWith{_p1='''plot1WI.paa''';_p2='''plot2WI.paa''';};
	if(sideW==independent&&sideE==east)exitWith{_p1='''plot1IE.paa''';_p2='''plot2IE.paa''';};
};

_textGP = [
"Advance And Secure game mode consists of two phases. First phase of the scenario is a sector control game, second phase is an attack/defend game.<br/><br/>
<img image=",_p1," width='368' height='184'/><br/><br/>
SECTOR CONTROL<br/>
Both teams fight for 1-3 sectors. If your team holds more sectors than enemy, then opponent’s tickets start bleeding. You win first phase, if enemy runs out of tickets.<br/><br/>
<img image=",_p2," width='368' height='92'/><br/><br/>
ATTACK/DEFEND<br/>
Team, that won the first phase, attacks the enemy FOB (forward operating base). Enemy team has to defend. If attackers  capture enemy FOB, then defender’s tickets start bleeding. You win, if enemy tickets are depleted."
] joinString "";

diaryAAS = player createDiaryRecord 
["Diary",["AAS Gameplay",_textGP]];