#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_getGUID

Description:
    Create unique vehicle identifier.

Parameters:
    0: _vehicle - Vehicle to get GUID for <OBJECT>

Optional:

Example:
    (begin example)
    [_vehicle] call A3OVG_vehicle_fnc_getGUID;
    (end example)

Returns:
    <STRING>

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(getGUID));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {""};
if !assert(!isNull _vehicle) exitWith {""};

[] call CBA_fnc_createUUID;
