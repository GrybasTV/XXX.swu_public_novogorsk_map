call
{
	if(resZeus==true)exitWith
	{
		resZeus=false; publicvariable "resZeus";
		hint parseText format ["Respawn of the units placed by Zeus<br/>DISABLED"];
	};
	if(resZeus==false)exitWith
	{
		resZeus=true; publicvariable "resZeus";
		hint parseText format ["Respawn of the units placed by Zeus<br/>ENABLED"];
	};
};