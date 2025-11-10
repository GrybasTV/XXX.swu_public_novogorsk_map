params ["_veh","_player","_dir"];
if(!local _veh)exitWith{};
_veh allowDammage false;
//_dir = _veh getRelDir _player;
_axs=[];
call
{
	 if(_dir>22.5 && _dir<67.5)exitWith{_axs=[-5,-5,0];};
	 if(_dir>67.5 && _dir<112.5)exitWith{_axs=[-7,0,0];};
	 if(_dir>112.5 && _dir<157.5)exitWith{_axs=[-5,5,0];};
	 if(_dir>157.5 && _dir<202.5)exitWith{_axs=[0,7,0];};
	 if(_dir>202.5 && _dir<247.5)exitWith{_axs=[5,5,0];};
	 if(_dir>247.5 && _dir<292.5)exitWith{_axs=[7,0,0];};
	 if(_dir>292.5 && _dir<337.5)exitWith{_axs=[5,-5,0];};
	 if(_dir>337.5 || _dir<22.5)exitWith{_axs=[0,-7,0];};
};
_veh setVelocityModelSpace _axs;
sleep 1;
if(!isTouchingGround _veh)then{_veh setVelocityModelSpace [0,0,0];};
_veh allowDammage true;
sleep 1;
if(!isTouchingGround _veh)then{_veh setVelocityModelSpace [0,0,0];};
