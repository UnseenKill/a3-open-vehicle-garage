#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_broadcastEvent

Description:
    Broadcasts an event to all clients (except maybe caller) and the server.

Parameters:
    0: _eventName - Event name <STRING>
    1: _eventParams - Event parameters <ARRAY>

Optional:
    2: _excludeCaller - Exclude the caller from receiving the event <BOOL>
        Default: false

Example:
    (begin example)
    ["MyEvent", ["Hello", "world"]] call A3OVG_util_fnc_broadcastEvent;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(broadcastEvent),_this);
A3OVG_VERIFY_CLIENT();

if !assert(params[
    ["_eventName", nil, [""]],
    ["_eventParams", nil, [[]]]
]) exitWith {};

private _excludeCaller = param[2, false, [true]];

if !(_excludeCaller) then {
    [_eventName, _eventParams] call CBA_fnc_globalEvent;
} else {
    [_eventName, _eventParams] remoteExecCall[QFUNC(CBA_fnc_localEvent), -CBA_clientID];
};

nil;
