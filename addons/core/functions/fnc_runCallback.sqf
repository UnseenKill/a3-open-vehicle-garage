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
    ["showHint", ["Hello world (%1)!", 1337]] call A3OVG_api_fnc_runCallback;
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

A3OVG_GET_CONFIG(_config);

private _params = param[1, [], [[]]];
private _key = toLowerANSI _name;
private _code = if (_key in GVAR(callbacks)) then {
    GVAR(callbacks) get _key;
} else {
    private _cfgCode = _config >> "Callbacks" >> _key;

    if !assert(isText(_cfgCode)) exitWith { ERROR_2("Callback %1 not found or not text: %2",_key,_cfgCode) };
    _cfgCode = getText(_cfgCode);

    private _result = switch true do {
        case(_cfgCode isEqualTo "0");
        case(toLowerANSI _cfgCode isEqualTo "false"): {
            false;
        };
        case(_cfgCode isEqualTo "1");
        case(toLowerANSI _cfgCode isEqualTo "true"): {
            true;
        };
        default {
            private _compiled = compileFinal _cfgCode;
            if (!assert(!isNil("_compiled")) || {!assert(_compiled isEqualType {})}) exitWith { ERROR_1("Callback %1 code could not be compiled",_key) };
            _compiled
        };
    };

    TRACE_2("compiled",_key,_result);

    if !(isNil "_result") then {
        GVAR(callbacks) set[_key, _result];
    };

    _result;
};

if (isNil "_code") exitWith {};
if !(_code isEqualType {}) exitWith { _code };

_params call _code;
