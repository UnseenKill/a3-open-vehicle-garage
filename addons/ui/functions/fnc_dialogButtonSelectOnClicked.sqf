#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogButtonSelectOnClicked

Description:
    Handler for when the "Select" button is clicked in the dialog.

Parameters:
    0: _control - Button control <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogButtonSelectOnClicked),_display);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _vehicle = _display getVariable QGVAR(vehicle);
if !assert(!isNil "_vehicle") exitWith {};

private _uuid = _vehicle call["getUUID", []];

if (_uuid in GVAR(uuidMutex)) exitWith {
    [A3OVG_EVENT_UI_PUSHSTATUS, [format[LLSTRING(VehicleSelectDeniedMutex), _vehicle get "displayName"], true]] call CBA_fnc_localEvent;
};

[_uuid, player] remoteExecCall[QFUNC(setMutex), 2];

[
    LLSTRING(VehicleSelectAwaitMutex),
    {
        params["_uuid"];
        [_uuid] call FUNC(isMutexLocked);
    },
    {
        TRACE_1(QFUNC(dialogButtonSelectOnClicked),_this);
        params["_uuid"];
        [_uuid] call FUNC(vehicleSelect);
    },
    [_uuid]
] call FUNC(dialogWaitUntilTrue);

nil;
