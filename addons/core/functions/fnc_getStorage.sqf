#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_getStorage

Description:
    Get storage interface singleton object.

Parameters:

Optional:

Example:
    (begin example)
    private _storage = [] call A3OVG_core_fnc_getStorage;
    _storage call["write", [_key, _data]];
    (end example)

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

    if (!assert((_storageAdapter isEqualType configNull) && { !isNull _storageAdapter })) exitWith {
        ERROR_MSG_2("%1() could not retrieve valid storage adapter from localNamespace variable %2.",QFUNC(getStorage),QGVAR(configVerifiedStorage));
    };

    LOG_1("Initializing storage singleton using adapter %1.",str configName _storageAdapter);

    private _className = [_storageAdapter >> "className", "STRING", configName _storageAdapter] call CBA_fnc_getConfigEntry;

    // Set by fnc_verifyConfigServer
    private _database = localNamespace getVariable QGVAR(storageDatabase);
    // Set by A3OVG_fnc_setStoragePrefix
    private _prefix = localNamespace getVariable QGVAR(storagePrefix);

    LOG_1("Storage database: %1",_database);
    LOG_1("Storage prefix: %1",RETDEF(_prefix,"<none>"));

    private _object = [_className, [_storageAdapter, _database, RETNIL(_prefix)]] call EFUNC(util,new);

    if !assert(!isNil "_object") exitWith {
        throw format["%1() could not create storage object of class %2.", QFUNC(getStorage), str _className];
    };

    _object call["initialize", []];

    GVAR(storageSingleton) = compileFinal createHashMapFromArray[
        ["_", _object]
    ];
};

GVAR(storageSingleton) get "_";
