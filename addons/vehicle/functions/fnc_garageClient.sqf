#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garageClient

Description:
    Put vehicle into garage.

Parameters:
    0: _vehicle - Vehicle to put into garage <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle1] call A3OVG_vehicle_fnc_garageClient;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(garageClient));
A3OVG_VERIFY_CLIENT();

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _vehicle) exitWith {};

[_vehicle, player] remoteExecCall[QFUNC(garageServer), 2];

nil;
