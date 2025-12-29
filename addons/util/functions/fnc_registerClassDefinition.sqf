#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_registerClassDefinition

Description:
    Register a class definition in the class definition registry.

    Registry is used to look up class definitions by name when calling super
    methods.

Parameters:
    0: _definition - Class definition <HASHMAP>

Optional:

Example:
    (begin example)
    [createHashMapFromArray[
        ["#type", ["A3OVG_class_foobar"]],
        // Additional class definition entries...
    ]] call A3OVG_util_fnc_registerClassDefinition;
    (end example)

Returns:
    <HASHMAP> The definition as passed and registered.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_definition", nil, [createHashMap]]
]) exitWith {};

if !assert([_definition get "#type"] params[
    ["_className", nil, ["", []]]
]) exitWith {};

if (_className isEqualType []) then {
    _className = _className select 0;
} else {
    // Fix "Bad conversion array" RPT spam
    _definition set["#type", [_className]];
};

if !assert(_className isEqualType "") exitWith {};

if (_className in GVAR(classRegistry)) exitWith {
    ERROR_2("%1(): class definition already registered: %2",QFUNC(registerClassDefinition),str _className);
};

INFO_2("%1(): registering class definition for class %2",QFUNC(registerClassDefinition),str _className);

private _base = _definition get "#base";

// Resolve base class name if it points to a class
if (!isNil "_base" && {_base isEqualType ""}) then {
    private _baseDef = GVAR(classRegistry) get _base;
    if (isNil "_baseDef") exitWith {
        ERROR_3("%1(): base class definition for %2 not found: %3",QFUNC(registerClassDefinition),str _className,str _base);
    };
    INFO_3("%1(): resolved base class %2 for class %3",QFUNC(registerClassDefinition),str _base,str _className);
    _definition set["#base", _baseDef];
};

GVAR(classRegistry) set[_className, _definition];

_definition;
