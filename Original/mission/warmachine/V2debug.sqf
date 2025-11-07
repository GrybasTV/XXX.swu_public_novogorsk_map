if(count dbgVehs!=0)then
{
	{
		_veh=_x;
		{_veh deleteVehicleCrew _x} forEach crew _veh;
		deleteVehicle _veh;
	} forEach dbgVehs;
	dbgVehs = [];
};