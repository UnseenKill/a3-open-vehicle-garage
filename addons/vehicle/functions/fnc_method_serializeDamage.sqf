#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeDamage

Description:
    Convert vehicle damage data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeDamage", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeDamage);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

private _vehicle = _self get "_vehicle";

_data set["damage", createHashMapFromArray[
    ["damage", damage _vehicle],
    ["hitPoints", getAllHitPointsDamage _vehicle]
]];

nil;
