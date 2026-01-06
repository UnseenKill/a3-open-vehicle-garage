#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogPushStatus

Description:
    Set status bar message, revert after a delay

Parameters:
    0: _message - Status message to display <STRING>

Optional:
    1: _isError - Whether the message is an error <BOOL>; default: false
    2: _displayTime - Duration to display the message <NUMBER>; default: 5 seconds

Example:
    (begin example)
    [_message, _isError, _displayTime] call A3OVG_ui_fnc_dialogPushStatus;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogPushStatus),_display);

if !assert(params[
    ["_message", "", [""]]
]) exitWith {};

private _isError = param[1, false, [true]];
private _displayTime = param[2, 5, [0]];

_display getVariable QGVAR(messageStack) pushBack [_message, _isError, _displayTime];

if (isNil { _display getVariable QGVAR(messagePopping) }) then {
    [] call FUNC(dialogPopStatusMessage);
};

nil;
