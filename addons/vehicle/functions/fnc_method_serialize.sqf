#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_serialize

Description:
    Convert vehicle to serializable data.

Parameters:
    0: _vehicle - Vehicle to convert <OBJECT>

Optional:

Example:
    (begin example)
    private _data = _vehicle call["serialize", []];
    (end example)

Returns:
    <HASHMAP> - Serialized vehicle data

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(serialize);

private _vehicle = _self get "_vehicle";

if isNull(_vehicle) then { throw "Can't serialize. Vehicle object is null." };

private _data = createHashMap;

_data set["class", typeOf _vehicle];
_data set["custom", [_vehicle] call BIS_fnc_getVehicleCustomization];
_data set["displayName", getText(configOf _vehicle >> "displayName")];

_self call["serializeFuel", [_data]];
_self call["serializeDamage", [_data]];
_self call["serializeResupply", [_data]];
_self call["serializeWeaponry", [_data]];
_self call["serializeInventory", [_data]];

_data;
