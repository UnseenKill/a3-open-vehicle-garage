#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeResupply

Description:
    Convert vehicle Arma3 cargo data (fuel, repair, ...) to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeResupply", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeResupply);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

private _vehicle = _self get "_vehicle";

_data set["cargo", createHashMapFromArray[
    ["rearm", createHashMapFromArray[
        ["cargo", getAmmoCargo _vehicle],
        ["aceCurrent", if (A3OVG_HAVE_ACE()) then[{[_vehicle] call ace_rearm_fnc_getSupplyCount}, {-1}]],
        ["aceMax", getNumber(configOf _vehicle >> "ace_rearm_defaultSupply")]
    ]],
    ["refuel", createHashMapFromArray[
        ["cargo", getFuelCargo _vehicle],
        ["aceCurrent", if (A3OVG_HAVE_ACE()) then[{_vehicle getVariable["ace_refuel_currentFuelCargo", -1]}, {-1}]],
        ["aceMax", getNumber(configOf _vehicle >> "ace_refuel_fuelCargo")]
    ]],
    ["repair", createHashMapFromArray[
        ["cargo", getRepairCargo _vehicle]
    ]]
]];

nil;
