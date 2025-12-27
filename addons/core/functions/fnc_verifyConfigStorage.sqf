#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_verifyConfigStorage

Description:
    Verify storage adapter configuration

Parameters:
    0: _config - Configuration class <CONFIG>

Optional:

Example:
    (begin example)
    [_config] call A3OVG_core_fnc_verifyConfigStorage;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(verifyConfigStorage),_this);
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_config", nil, [configNull]]
]) exitWith { throw(QFUNC(verifyConfigStorage) + ": invalid parameters.") };
if !assert(!isNull _config) exitWith { throw "null-configuration given." };

private _storageConfig = _config >> "Storage";

if !assert(isClass _storageConfig) then {
    throw "No Storage class found in configuration.";
};

if !assert(isText(_storageConfig >> "defaultAdapter")) then {
    throw "No defaultAdapter defined in Storage configuration.";
};

private _storageClass = getText(_storageConfig >> "defaultAdapter");
private _defaultAdapter = _storageConfig >> _storageClass;

if !(isClass _defaultAdapter) then {
    throw format["Storage adapter class %1 not found in configuration.", str _storageClass];
};

if (getNumber(_defaultAdapter >> "scope") == 0) then {
    throw format["Storage adapter class %1 is not public (scope == 0).", str configName _defaultAdapter];
};

if !(isText(_defaultAdapter >> "method")) then {
    throw format["Storage adapter class %1 does not define a definition method.", str configName _defaultAdapter];
};

private _method = getText(_defaultAdapter >> "method");

if !assert(missionNamespace getVariable[_method, false] isEqualType {}) then {
    throw format["Storage adapter definition method %1() not found.", _method];
};

INFO_1("using storage adapter: %1",str configName _defaultAdapter);
localNamespace setVariable[QGVAR(configVerifiedStorage), _defaultAdapter];

nil;
