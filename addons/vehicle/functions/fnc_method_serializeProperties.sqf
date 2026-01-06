#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeProperties

Description:
    Convert internal properties to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeProperties", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeProperties);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

_data set["_properties", createHashMapFromArray[
    ["_category", _self get "_category"],
    ["_className", _self get "_className"],
    ["_displayName", _self get "_displayName"],
    ["_owner", _self get "_owner"],
    ["_ownerLock", _self get "_ownerLock"],
    ["_serialized", nil],
    ["_uuid", _self get "_uuid"],
    ["_vehicle", nil]
]];

nil;
