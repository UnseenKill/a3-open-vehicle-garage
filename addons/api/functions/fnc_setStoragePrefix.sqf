#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_setStoragePrefix

Description:
    Set runtime storage prefix for storage adapter.

    This function can only be run _once_ before any storage interactions have
    taken place. It is primarily intended for use in scenarios where multiple
    independent garage systems are running on the same storage backend and need
    to avoid key collisions.

    For some storage adapters, there's a config derived prefix; this prefix is
    appended to that prefix to form the final storage key prefix.

Parameters:
    0: _prefix - Storage prefix to set <STRING>

Optional:

Example:
    (begin example)
    ["myStoragePrefix"] call A3OVG_fnc_setStoragePrefix;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setStoragePrefix),_this);
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_prefix", nil, [""]]
]) exitWith {};

if !assert(isNil QEGVAR(core,storageSingleton)) exitWith {
    ERROR_1("%1() called after storage singleton was initialized; prefix cannot be changed at this point.",QFUNC(setStoragePrefix));
};

localNamespace setVariable[QEGVAR(core,storagePrefix), [_prefix] call EFUNC(core,sanitizeStoragePrefix)];
LOG_1("Runtime storage prefix set to %1.",str(localNamespace getVariable QEGVAR(core,storagePrefix)));

nil;
