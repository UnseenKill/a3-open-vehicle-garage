#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_new

Description:
    Create instance of registered class.

Parameters:
    0: _className - Class name <STRING>

Optional:
    1: _ctorArguments - Constructor arguments <ARRAY> (default: [])

Example:
    (begin example)
    ["A3OVG_myClass", [123, false, "Hello world."]] call A3OVG_util_fnc_new;
    (end example)

Returns:
    <HASHMAP-OBJECT> New instance of class.

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(new),_this);

if !assert(params[
    ["_className", nil, [""]]
]) exitWith {};

private _ctorArguments = param[1, [], [[]]];

if !assert(_className in GVAR(classRegistry)) exitWith {};

private _classDef = GVAR(classRegistry) get _className;

createHashMapObject[_classDef, _ctorArguments];
