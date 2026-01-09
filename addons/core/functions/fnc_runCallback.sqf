#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_api_fnc_runCallback

Description:
    Run callback code from config

Parameters:
    0: _name - Callback name <STRING>

Optional:
    1: _params - Optional parameters <ARRAY>

Example:
    (begin example)
    ["uiShowHint", ["Hello world (%1)!", 1337]] call A3OVG_api_fnc_runCallback;
    private _canOpen = ["canGarageOpen"] call A3OVG_api_fnc_runCallback;
    (end example)

Returns:
    Callback return value

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
// Avoid RPT spam and don't log "can*" callbacks
#ifdef DEBUG_MODE_FULL
if (_this isNotEqualTo [] && {_this select 0 isEqualType "" && {toLowerANSI(_this select 0) find "can" != 0}}) then {
    TRACE_1(QFUNC(runCallback),_this);
};
#endif

if !assert(params[
    ["_name", nil, [""]]
]) exitWith {};

if (isNil QGVAR(callbacks)) exitWith {
    ERROR_1("callbacks not yet compiled; cannot run callback %1",_name);
};

A3OVG_GET_CONFIG(_config);

private _params = param[1, [], [[]]];
private _key = toLowerANSI _name;
private _callbacks = GVAR(callbacks) get _key;

if !assert(!isNil "_callbacks") exitWith {
    ERROR_1("no such compiled callback: %1",_key);
};

_callbacks findIf {
    private _result = _params call _x;
    !(isNil "_result") && { _result isEqualTo false };
} == -1;
