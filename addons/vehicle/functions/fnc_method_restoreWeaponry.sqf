#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreWeaponry

Description:
    Restore vehicle weaponry from serialized data.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>
    1: _data - serialized data <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restoreWeaponry);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_data", nil, [createHashMap]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _weaponsPilot = getArray(configOf _vehicle >> "weapons");

getAllPylonsInfo _vehicle apply {
    _x params["_index", "_name", "_turret", "_magazine", "_count"];
    _vehicle weaponsTurret _turret 
        select { !(_x in _weaponsPilot) }
        apply { _vehicle removeWeaponTurret[_x, _turret] };
    _vehicle setPylonLoadout[_name, "", true, _turret];
};

private _turretsReset = [];
_data get "magazines" apply {
    _x params["_magazine", "_turret", "_count"];
    TRACE_3(QFUNC(method_restoreWeaponry),_magazine,_count,_turret);

    if !(_turret in _turretsReset) then {
        _vehicle removeAllMagazinesTurret _turret;
        _turretsReset pushBack _turret;
    };

    _vehicle addMagazineTurret[_magazine, _turret, _count];
};

_data get "pylons" apply {
    _x params["_index", "_name", "_turret", "_magazine", "_count"];
    TRACE_5(QFUNC(method_restoreWeaponry),_index,_name,_turret,_magazine,_count);

    if (_count >= 0) then {
        _vehicle setPylonLoadout[_index, _magazine, true, _turret];
        _vehicle setAmmoOnPylon[_index, _count];
    };
};

nil;
