#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogButtonLockClicked

Description:
    Function called when the Lock Button in the Garage Dialog is clicked. Toggles
    the lock state of the currently previewed vehicle.

Parameters:
    0: _control - Button Control <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogButtonLockClicked),_display);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _vehicle = _display getVariable QGVAR(vehicle);
if !assert(!isNil "_vehicle") exitWith {};

if (_vehicle call["isLocked", []]) then {
    _vehicle call["setLocked", [false]];
} else {
    _vehicle call["setLocked", [getPlayerUID player]];
};

_vehicle call["saveProperties", []];

[A3OVG_EVENT_UI_VEHICLE_DATACHANGED, [_vehicle], true] call EFUNC(util,broadcastEvent);
[A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, []] call CBA_fnc_localEvent;

nil;
