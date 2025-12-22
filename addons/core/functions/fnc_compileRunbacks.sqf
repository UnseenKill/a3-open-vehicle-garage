#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_compileRunbacks

Description:
    Compile all runback callbacks from config into memory

Parameters:

Optional:

Example:
    (begin example)
    [] call A3OVG_core_fnc_compileRunbacks;
    (end example)

Returns:
    <HASHMAP> Compiled callbacks

Environment:
    Client+Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(compileRunbacks));
A3OVG_GET_CONFIG(_config);

private _callbacks = createHashMap;

configProperties[_config >> "Callbacks", "true", true] apply {
    private _key = toLowerANSI configName _x;
    private _statements = if isText(_x) then {
        [getText _x]
    } else {
        if isArray(_x) then {
            getArray _x
        };
    };

    if !assert(!isNil "_statements") exitWith { ERROR_2("Callback %1 not found or not array/text: %2",_key,_x) };
    private _compiled = [];

    _statements apply {
        private _code = switch true do {
            case(_x isEqualTo "1");
            case(toLowerANSI _x isEqualTo "true"): { {true} };
            case(_x isEqualTo "0");
            case(toLowerANSI _x isEqualTo "false"): { {false} };
            default { compileFinal _x };
        };

        if (!assert(!isNil "_code") || {!assert(_code isEqualType {})}) exitWith {
            ERROR_2("Callback %1 statement could not be compiled: %2",_key,_x);
        };

        _compiled pushBack _code;
    };

    TRACE_2("compiled",_key,_compiled);

    _callbacks set[_key, _compiled];
};

_callbacks;
