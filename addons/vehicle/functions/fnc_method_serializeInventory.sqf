#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serializeInventory

Description:
    Convert vehicle inventory data to serializable data.

Parameters:
    0: _data - Serialized data hashmap <HASHMAP>

Optional:

Example:
    (begin example)
    _vehicle call["serializeInventory", [_data]];
    (end example)

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serializeInventory);
A3OVG_GET_CONFIG(_config);

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

private _vehicle = _self get "_vehicle";

if A3OVG_FEATURE_ENABLED(_config,storeInventory) then {
    _data set["inventory", createHashMapFromArray[
        ["backpack", getBackpackCargo _vehicle],
        ["weapons", weaponsItemsCargo _vehicle],
        ["magazines", getMagazineCargo _vehicle],
        ["items", getItemCargo _vehicle]
    ]];
};

nil;
