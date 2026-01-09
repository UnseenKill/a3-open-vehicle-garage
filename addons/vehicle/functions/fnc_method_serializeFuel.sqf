#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeFuel

Description:
    Convert vehicle fuel data to serializable data.

Parameters:
    0: _data - Shared hashmap with serialized vehicle data <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeFuel", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeFuel);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

private _vehicle = _self get "_vehicle";

_data set["fuel", fuel _vehicle];

nil;
