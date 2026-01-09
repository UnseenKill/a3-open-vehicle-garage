#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_setMutex

Description:
    Sets or clears a mutex for a vehicle UUID to prevent concurrent selections.

Parameters:
    0: _uuid - UUID to (un)lock <STRING>
    1: _player - Player who is locking or unlocking <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(setMutex));
A3OVG_VERIFY_SERVER();
A3OVG_GET_CONFIG(_config);

if !assert(params[
    ["_uuid", nil, [""]],
    ["_player", nil, [objNull]]
]) exitWith {};

if !(isNull _player) then {
    GVAR(uuidMutex) set[_uuid, [diag_tickTime, _player]];
} else {
    GVAR(uuidMutex) deleteAt _uuid;
};

publicVariable QGVAR(uuidMutex);

nil;
