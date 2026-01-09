#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_new

Description:
    Creates a new vehicle object from a given vehicle object.

Parameters:
    0: _vehicle - Vehicle object to create a new instance from <OBJECT>

Optional:

Example:
    (begin example)
    private _oo = [_vehicle] call A3OVG_vehicle_fnc_new;
    (end example)

Returns:
    <HASHMAP-OBJECT> - New vehicle object

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(new));

if !assert(params[
    ["_vehicle", nil, [objNull,""]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

[QADDON, [_vehicle]] call EFUNC(util,new);
