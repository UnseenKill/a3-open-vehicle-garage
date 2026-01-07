#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_compileCallbacks

Description:
    Compile all callbacks from config into memory

Parameters:

Optional:

Example:
    (begin example)
    [] call A3OVG_core_fnc_compileCallbacks;
    (end example)

Returns:
    <HASHMAP> Compiled callbacks

Environment:
    Client+Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(compileCallbacks));
A3OVG_GET_CONFIG(_config);

private _callbacks = createHashMap;

configProperties[_config >> "Callbacks", "true", true] apply {
    private _key = toLowerANSI configName _x;
    private _statements = switch true do {
        case isText(_x): { [getText _x] };
        case isArray(_x): { getArray _x };
        default { nil };
    };

    if !assert(!isNil "_statements") exitWith { ERROR_2("Callback %1 not found or not array/text: %2",_key,_x) };

    private _compiled = [_statements] call FUNC(compileStatements);

    TRACE_2("compiled",_key,_compiled);

    _callbacks set[_key, _compiled];
};

_callbacks;
