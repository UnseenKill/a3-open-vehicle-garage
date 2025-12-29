#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_setVehicle

Description:
    Vehicle object setter method.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    _vehicle call["setVehicle", [_vehicleObject]];
    (end example)

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(setVehicle);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _vehicle) exitWith {};

_self set["_vehicle", _vehicle];
_self set["_displayName", getText(configOf _vehicle >> "displayName")];

nil;
