#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serializeFuel

Description:
    Convert vehicle fuel data to serializable data.

Parameters:
    0: _data - Shared hashmap with serialized vehicle data <HASHMAP>
    1: _vehicle - Vehicle to convert <OBJECT>

Optional:

Example:
    (begin example)
    [_data, _vehicle] call A3OVG_vehicle_fnc_serializeFuel;
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(serializeFuel));

if !assert(params[
    ["_data", nil, [createHashMap]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

_data set["fuel", fuel _vehicle];

nil;
