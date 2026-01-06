#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_scourConfig

Description:
    Recursively searches through a config structure for classes that meet a
    specified condition.

Parameters:
    0: _config - The config class to scour <CONFIG>
    1: _condition - A code block that takes a config class and returns true if
        it meets the condition <CODE>. Config is in `_this` or variable `_config`.

Optional:
    2: _findFirst - If true, the function will return the first config class
        that meets the condition instead of an array of all matching classes
        <BOOL> Default: false

Example:
    (begin example)
    [configFile >> "CfgVehicles", {
        getNumber(_config >> "scope") > 0
    }] call A3OVG_util_fnc_scourConfig;
    (end example)

Returns:
    <ARRAY> An array of config classes that meet the condition (_findFirst=false).
    <CONFIG> First config class to meet the condition (_findFirst=true).

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_config", nil, [configNull]],
    ["_condition", nil, [{}]]
]) exitWith {};
if !assert(!isNull _config) exitWith {};

private _findFirst = param[2, false, [true]];
private _recursiveScour = {
    if !assert(params[
        ["_input", nil, [[]]],
        ["_findFirst", nil, [true]],
        ["_recursiveScour", nil, [{}]],
        ["_config", nil, [configNull]],
        ["_condition", nil, [{}]]
    ]) exitWith {};

    "true" configClasses _config apply {
        if isClass(_x) then {
            private _config = _x;
            if ([_config] call _condition) then {
                if (_findFirst) exitWith { throw _config };
                _input pushBack _config;
            };
            [_input, _findFirst, _recursiveScour, _config, _condition] call _recursiveScour;
        };
    };
};

try {
    private _result = [];
    [_result, _findFirst, _recursiveScour, _config, _condition] call _recursiveScour;
    [_result, nil] select(_findFirst && { _result isEqualTo [] });
} catch {
    _exception;
};
