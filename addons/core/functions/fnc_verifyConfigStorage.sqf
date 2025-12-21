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
    <BOOLEAN>

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(verifyConfigStorage),_this);

if !assert(params[
    ["_config", nil, [configNull]]
]) exitWith { throw(QFUNC(verifyConfigStorage) + ": invalid parameters.") };

private _storageConfig = _config >> "Storage";

if !assert(isClass _storageConfig) then {
    throw "No Storage class found in configuration.";
};

private _storageClass = getText(_storageConfig >> QUOTE(defaultAdapter));
private _defaultAdapter = _storageConfig >> _storageClass;

if !(isClass _defaultAdapter) then {
    throw format ["Storage adapter class %1 not found in configuration.", str _storageClass];
};

true;
