#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_vehiclePositionServer

Description:
    Spawn and position selected vehicle.

Parameters:
    0: _pp - Position provider object <HASHMAP>
    1: _vehicle - Vehicle object <HASHMAP>
    2: _position - Desired vehicle position <ARRAY>
    3: _vectorDirAndUp - Desired vehicle up and direction vector <ARRAY>
    4: _player - Player object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(vehiclePositionServer));
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_pp", nil, [createHashMap]],
    ["_vehicle", nil, [createHashMap]],
    ["_position", nil, [[]], [2,3]],
    ["_vectorDirAndUp", nil, [[]]],
    ["_player", nil, [objNull]]
]) exitWith {};

if !assert(VALIDATE_OBJECT(_pp,QUOTE(DOUBLES(PREFIX,pp_base)))) exitWith {};
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};
if !assert(!isNull _player) exitWith {};

INFO_2("Received vehicle position request; type=%1, position=%2",_vehicle get "_className",_position);

private _object = (_vehicle get "_className") createVehicle[0,0,1000];

try {
    if !assert(!isNull _object) then { throw "Vehicle creation returned null object." };

    _vehicle call["restore", [_object]];
    _object setPosATL _position;
    _object setVectorDirAndUp _vectorDirAndUp;
    _vehicle call["delete", []];
} catch {
    ERROR_2("Failed to create vehicle of type %1: %2",_vehicle get "_className",_exception);
};

[_vehicle call["getUUID", []], objNull] call FUNC(setMutex);

nil;
