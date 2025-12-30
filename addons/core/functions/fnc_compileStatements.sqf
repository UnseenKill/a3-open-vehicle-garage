#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_compileStatements

Description:
    Compile a list of code statements into an array of compiled code blocks

Parameters:
    0: _statements - Array of code statements to compile <ARRAY,STRING>

Optional:

Example:
    (begin example)
    [["a=b+c"]] call A3OVG_core_fnc_compileStatements;
    (end example)

Returns:
    <ARRAY> Array of compiled code blocks

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(compileStatements),[]);

if !assert(params[
    ["_statements", nil, [[], ""]]
]) exitWith {[]};

if !(_statements isEqualType []) then {
    _statements = [_statements];
};

private _compiled = [];

_statements apply {
    private _code = switch true do {
        case(_x isEqualTo "1");
        case(toLowerANSI _x isEqualTo "true"): { {true} };
        case(_x isEqualTo "0");
        case(toLowerANSI _x isEqualTo "false"): { {false} };
        default { compile _x };
    };

    if (!assert(!isNil "_code") || {!assert(_code isEqualType {})}) exitWith {
        ERROR_1("Callback statement could not be compiled: %1",_x);
    };

    _compiled pushBack compileFinal _code;
};

_compiled;
