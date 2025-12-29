#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeWeaponry

Description:
    Convert vehicle weaponry data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeWeaponry", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeWeaponry);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

private _vehicle = _self get "_vehicle";

_data set["weaponry", createHashMapFromArray[
    ["magazines", magazinesAllTurrets _vehicle],
    ["pylons", getAllPylonsInfo _vehicle]
]];

nil;
