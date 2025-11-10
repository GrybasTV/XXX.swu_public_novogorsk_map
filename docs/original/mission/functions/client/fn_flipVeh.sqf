_veh=cursortarget;
_veh allowDammage false;
_veh setPos [(getPos _veh select 0),(getPos _veh select 1),0.2];
_veh setVectorUp surfaceNormal getPos _veh select 2;
sleep 1;
_veh allowDammage true;
