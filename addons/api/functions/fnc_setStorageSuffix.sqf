#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_setStorageSuffix

Description:
    Set runtime storage suffix for storage adapter.

    This function can only be run _once_ before any storage interactions have
    taken place. It is primarily intended for use in scenarios where multiple
    independent garage systems are running on the same storage backend and need
    to avoid key collisions.

    For some storage adapters, there's a config derived prefix; this suffix is
    appended to that prefix to form the final storage key prefix.

Parameters:
    0: _suffix - Storage suffix to set <STRING>

Optional:

Example:
    (begin example)
    ["myStorageSuffix"] call A3OVG_fnc_setStorageSuffix;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setStorageSuffix),_this);
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_suffix", nil, [""]]
]) exitWith {};

if !assert(isNil QEGVAR(core,storageSingleton)) exitWith {
    ERROR_1("%1() called after storage singleton was initialized; suffix cannot be changed at this point.",QFUNC(setStorageSuffix));
};

localNamespace setVariable[QGVAR(storageSuffix), _suffix];

nil;
