#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restore

Description:
    Restore the vehicle object from serialized data.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restore);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _serialized = _self get "_serialized";

_self call["restoreCustomization", [_vehicle, _serialized get "custom"]];
_self call["restoreDamage", [_vehicle, _serialized get "damage"]];
_self call["restoreFuel", [_vehicle, _serialized get "fuel"]];
_self call["restoreInventory", [_vehicle, _serialized get "inventory"]];
_self call["restoreResupply", [_vehicle, _serialized get "cargo"]];
_self call["restoreWeaponry", [_vehicle, _serialized get "weaponry"]];

nil;
