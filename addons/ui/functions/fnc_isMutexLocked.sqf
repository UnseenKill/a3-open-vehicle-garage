#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_isMutexLocked

Description:
    Checks if a mutex is currently locked for a given vehicle UUID.

Parameters:
    0: _uuid - UUID of the vehicle <STRING>

Optional:

Returns:
    <BOOL> True if the mutex is locked, false otherwise.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(isMutexLocked));

if !assert(params[
    ["_uuid", nil, [""]]
]) exitWith { false };

if !(_uuid in GVAR(uuidMutex)) exitWith { false };

A3OVG_GET_CONFIG(_config);

private _mutexTTL = getNumber(_config >> "Features" >> "mutexTTL");
private _data = GVAR(uuidMutex) get _uuid;

if !assert(_data params[
    ["_lockedSince", 0, [0]],
    ["_lockingPlayer", objNull, [objNull]]
]) exitWith { false };

if ((diag_tickTime - _lockedSince) <= _mutexTTL) exitWith { true };

// Mutex expired
[_uuid, objNull] remoteExecCall[QFUNC(setMutex), 2];
false;
