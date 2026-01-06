#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_subscribeToEvent

Description:
    Subscribe to CBA; store event handler ID in internal array for cleanup.

Parameters:
    0: _event - Event name <STRING>
    1: _handler - Event handler code <CODE>

Optional:
    2: _args - Optional event handler arguments <ARRAY>
        Those will be available as `_thisArgs` (see: https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandlerArgs-sqf.html)

Example:
    (begin example)
    ["MyEvent", { hint "Hello, world. Event triggered." }] call A3OVG_ui_fnc_subscribeToEvent;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(subscribeToEvent),_this#0);

if !assert(params[
    ["_event", nil, [""]],
    ["_handler", nil, [{}]]
]) exitWith {};

private _args = param[2, nil, [[]]];

if !(isNil "_args") then {
    uiNamespace getVariable QGVAR(events) pushBack[_event, [_event, _handler, _args] call CBA_fnc_addEventHandlerArgs];
} else {
    uiNamespace getVariable QGVAR(events) pushBack[_event, [_event, _handler] call CBA_fnc_addEventHandler];
};

nil;
