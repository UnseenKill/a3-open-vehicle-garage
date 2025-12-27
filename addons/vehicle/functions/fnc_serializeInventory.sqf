#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serializeInventory

Description:
    Convert vehicle inventory data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>
    1: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [_data, _vehicle] call A3OVG_vehicle_fnc_serializeInventory;
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(serializeInventory),_this#1);
A3OVG_GET_CONFIG(_config);

if !assert(params[
    ["_data", nil, [createHashMap]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

if A3OVG_FEATURE_ENABLED(_config,storeInventory) then {
    _data set["inventory", createHashMapFromArray[
        ["backpack", getBackpackCargo _vehicle],
        ["weapons", weaponsItemsCargo _vehicle],
        ["magazines", getMagazineCargo _vehicle],
        ["items", getItemCargo _vehicle]
    ]];
};

nil;
