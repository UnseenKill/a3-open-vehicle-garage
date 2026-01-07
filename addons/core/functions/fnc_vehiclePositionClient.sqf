#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_vehiclePositionClient

Description:
    Spawn and position selected vehicle.

Parameters:
    0: _pp - Position provider object <HASHMAP>
    1: _vehicle - Vehicle object <HASHMAP>
    2: _position - Desired vehicle position <ARRAY>
    3: _vectorDirAndUp - Desired vehicle up and direction vector <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(vehiclePositionClient));
A3OVG_VERIFY_CLIENT();

if !assert(params[
    ["_pp", nil, [createHashMap]],
    ["_vehicle", nil, [createHashMap]],
    ["_position", nil, [[]], [2,3]],
    ["_vectorDirAndUp", nil, [[]]]
]) exitWith {};

if !assert(VALIDATE_OBJECT(_pp,QUOTE(DOUBLES(PREFIX,pp_base)))) exitWith {};
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

INFO_2("Sending vehicle position request to server; type=%1, position=%2",_vehicle get "_className",_position);

[_pp, _vehicle, _position, _vectorDirAndUp, player] remoteExecCall[QFUNC(vehiclePositionServer), 2];

nil;
