#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_getStorage

Description:
    Get storage interface singleton object.

Parameters:

Optional:

Example:

Returns:
    <HASHMAP-OBJECT>

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(getStorage));
A3OVG_VERIFY_SERVER();
A3OVG_GET_CONFIG(_config);

if (isNil QGVAR(storageSingleton)) then {
    private _storageAdapter = localNamespace getVariable QGVAR(configVerifiedStorage);

    if !assert(!isNil "_storageAdapter") exitWith {
        ERROR_MSG_1("%1() called before config verification.",QFUNC(getStorage));
    };

    private _method = missionNamespace getVariable getText(_storageAdapter >> "method");

    if (!assert(!isNil "_method") || {!assert(_method isEqualType {})}) exitWith {
        ERROR_MSG_3("%1() could not retrieve valid storage definition method %2 from adapter %3.",QFUNC(getStorage),RETDEF(_method,"any"),configName _storageAdapter);
    };

    private _definition = [] call _method;

    if !assert(_definition isEqualType []) exitWith {
        ERROR_MSG_3("%1() storage definition method %2 from adapter %3 did not return an array.",QFUNC(getStorage),_method,configName _storageAdapter);
    };

    private _object = createHashMapObject[_definition];

    GVAR(storageSingleton) = compileFinal createHashMapFromArray[
        ["_", _object]
    ];
};

GVAR(storageSingleton) get "_";
