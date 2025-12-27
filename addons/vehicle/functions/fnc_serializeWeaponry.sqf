#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serializeWeaponry

Description:
    Convert vehicle weaponry data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>
    1: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [_data, _vehicle] call A3OVG_vehicle_fnc_serializeWeaponry;
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(serializeWeaponry),_this#1);

if !assert(params[
    ["_data", nil, [createHashMap]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

_data set["weaponry", createHashMapFromArray[
    ["magazines", magazinesAllTurrets _vehicle],
    ["pylons", getAllPylonsInfo _vehicle]
]];

nil;
