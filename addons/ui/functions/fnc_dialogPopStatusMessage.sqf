#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogPopStatusMessage

Description:
    Pop status bar message from stack and set it.

    Not really pop, but unshift. Method not called that for readability. Or something.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogPopStatusMessage),_display);

_display setVariable[QGVAR(messagePopping), true];

private _controls = _display getVariable QGVAR(controls);
private _index = _display getVariable QGVAR(messageIndex);
private _statusBar = _controls get "statusBar";

_display setVariable[QGVAR(messageIndex), [1, 0] select _index];

private _item = if (_display getVariable QGVAR(messageStack) isEqualTo []) then {
    [LLSTRING(GarageDialog_Status_Ready), false, 0];
} else {
    _display getVariable QGVAR(messageStack) deleteAt 0;
};

if !assert(_item params[
    ["_message", nil, [""]],
    ["_isError", nil, [true]],
    ["_displayTime", nil, [0]]
]) exitWith {};

_statusBar select _index ctrlSetText _message;

if (_isError) then {
    _statusBar select _index ctrlSetTextColor[1, 0.3, 0.15, 1];
} else {
    _statusBar select _index ctrlSetTextColor[1, 1, 1, 1];
};

_statusBar select _index ctrlSetFade 0;
_statusBar select _index ctrlCommit 0.15;
_statusBar select (_display getVariable QGVAR(messageIndex)) ctrlSetFade 1;
_statusBar select (_display getVariable QGVAR(messageIndex)) ctrlCommit 0.15;

if (_displayTime > 0) exitWith {
    // Unshift next message or revert to default status after delay
    [_displayTime, _statusBar select _index] spawn {
        params["_displayTime","_control"];

        waitUntil { !(isNull _control) && { ctrlCommitted _control } };

        [{
            [] call FUNC(dialogPopStatusMessage);
        }, [], _displayTime] call CBA_fnc_waitAndExecute;
    };
};

_display setVariable[QGVAR(messagePopping), nil];

if (_display getVariable QGVAR(messageStack) isNotEqualTo []) then {
    WARNING_2("%1: %2 messages still in stack, discarding.",QFUNC(dialogPopStatusMessage),count(_display getVariable QGVAR(messageStack)));

    while { _display getVariable QGVAR(messageStack) isNotEqualTo [] } do {
        private _msg = _display getVariable QGVAR(messageStack) deleteAt 0;
        WARNING_2("%1: discard %2",QFUNC(dialogPopStatusMessage),_msg);
    };

    _display setVariable[QGVAR(messageStack), []];
};

nil;
