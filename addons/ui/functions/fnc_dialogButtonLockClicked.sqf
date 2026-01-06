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

private _uuid = _vehicle call["getUUID", []];
private _locked = _vehicle call["isLocked", []];
private _newLockState = [getPlayerUID player, false] select _locked;
private _callback = ["canVehicleLock", "canVehicleUnlock"] select _locked;

TRACE_3(QFUNC(dialogButtonLockClicked),_uuid,_locked,_newLockState);

A3OVG_UI_PUSH_CONTEXT();
private _canDo = [_callback, [_vehicle, player]] call EFUNC(core,runCallback);
private _stacked = A3OVG_UI_POP_CONTEXT();

if !(_canDo) then {
    [A3OVG_EVENT_UI_PUSHSTATUS, [LLSTRING(VehicleToggleLockDenied), true]] call CBA_fnc_localEvent;
    _stacked apply { [A3OVG_EVENT_UI_PUSHSTATUS, [_x, true]] call CBA_fnc_localEvent };
} else {
    _vehicle call["setLocked", [_newLockState]];
    _vehicle call["saveProperties", []];

    private _message = [LSTRING(VehicleLockSuccess), LSTRING(VehicleUnlockSuccess)] select _locked;
    [A3OVG_EVENT_UI_PUSHSTATUS, [format[localize _message, _vehicle get "_displayName"]]] call CBA_fnc_localEvent;
    [A3OVG_EVENT_UI_VEHICLE_DATACHANGED, [_vehicle]] call EFUNC(util,broadcastEvent);
    [A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, []] call CBA_fnc_localEvent;
};

nil;
