#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serializeDamage

Description:
    Convert vehicle damage data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>
    1: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [_data, _vehicle] call A3OVG_vehicle_fnc_serializeDamage;
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(serializeDamage));

if !assert(params[
    ["_data", nil, [createHashMap]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

_data set["damage", createHashMapFromArray[
    ["damage", damage _vehicle],
    ["hitPoints", getAllHitPointsDamage _vehicle]
]];

nil;
