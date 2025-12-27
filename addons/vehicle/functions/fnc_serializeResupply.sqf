#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serializeResupply

Description:
    Convert vehicle Arma3 cargo data (fuel, repair, ...) to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>
    1: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [_data, _vehicle] call A3OVG_vehicle_fnc_serializeResupply;
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(serializeResupply));

if !assert(params[
    ["_data", nil, [createHashMap]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

_data set["cargo", createHashMapFromArray[
    ["rearm", createHashMapFromArray[
        ["cargo", getAmmoCargo _vehicle],
        ["ace", if (A3OVG_HAVE_ACE()) then[{[_vehicle] call ace_rearm_fnc_getSupplyCount}, {0}]]
    ]],
    ["refuel", createHashMapFromArray[
        ["cargo", getFuelCargo _vehicle],
        ["ace", if (A3OVG_HAVE_ACE()) then[{_vehicle getVariable["ace_refuel_currentFuelCargo", getNumber(configOf _vehicle >> "ace_refuel_fuelCargo")]}, {0}]]
    ]],
    ["repair", createHashMapFromArray[
        ["cargo", getRepairCargo _vehicle]
    ]]
]];

nil;
