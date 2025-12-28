#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_serialize

Description:
    Convert vehicle to serializable data.

Parameters:
    0: _vehicle - Vehicle to convert <OBJECT>

Optional:

Example:
    (begin example)
    private _data = [vehicle1] call A3OVG_vehicle_fnc_serialize;
    (end example)

Returns:
    <HASHMAP> - Serialized vehicle data

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(serialize));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _data = createHashMap;

_data set["class", typeOf _vehicle];
_data set["custom", [_vehicle] call BIS_fnc_getVehicleCustomization];
_data set["displayName", getText(configOf _vehicle >> "displayName")];

[_data, _vehicle] call FUNC(serializeFuel);
[_data, _vehicle] call FUNC(serializeDamage);
[_data, _vehicle] call FUNC(serializeResupply);
[_data, _vehicle] call FUNC(serializeWeaponry);
[_data, _vehicle] call FUNC(serializeInventory);

_data;
