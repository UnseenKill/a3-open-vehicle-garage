#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogWaitUntilTrue

Description:
    Waits until a given condition is true, showing a message while waiting.

Parameters:
    0: _message - Status bar message to display <STRING>
    1: _condition - Condition to evaluate <CODE>
    2: _onTrue - Code to execute once condition is true <CODE>

Optional:
    3: _params - Parameters to pass to all callbacks <ARRAY>
    4: _timeout - Optional timeout in seconds <NUMBER>
    5: _onTimeout - Code to execute if timeout occurs <CODE>

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_MAKE_SCHEDULED(FUNC(dialogWaitUntilTrue));
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogWaitUntilTrue),_display);

if !assert(params[
    ["_message", nil, [""]],
    ["_condition", nil, [{}]],
    ["_onTrue", nil, [{}]]
]) exitWith {};

private _params = param[3, [], [[]]];
private _timeout = param[4, 10, [0]];
private _onTimeout = param[5, nil, [{}]];

[A3OVG_EVENT_UI_PUSHSTATUS, [_message, false, 0]] call CBA_fnc_localEvent;

private _startTime = diag_tickTime;
private _abort = false;

while { !(_abort || { _params call _condition }) } do {
    uiSleep 0.1;

    if (!dialog || { isNull _display }) then {
        WARNING("Dialog closed while waiting.");
        _abort = true;
        break;
    };

    if (_timeout > 0 && (diag_tickTime - _startTime) > _timeout) then {
        WARNING("Timeout reached while waiting in dialogWaitUntilTrue.");
        [A3OVG_EVENT_UI_PUSHSTATUS, [format[LLSTRING(GarageDialog_Status_OperationTimedOut), (diag_tickTime - _startTime) toFixed 1], true]] call CBA_fnc_localEvent;

        if !(isNil "_onTimeout") then {
            _params call _onTimeout;
        };

        _abort = true;
        break;
    };
};

if (_abort) exitWith {};

[A3OVG_EVENT_UI_PUSHSTATUS, [LLSTRING(GarageDialog_Status_Ready), false, 0]] call CBA_fnc_localEvent;

_params call _onTrue;
