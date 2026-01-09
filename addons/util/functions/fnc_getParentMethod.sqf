#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_getParentMethod

Description:
    Retrieve parent method for hashmap object instance from class registry.

Parameters:
    0: _self - Instance <HASHMAP-OBJECT>
    1: _methodName - Method name <STRING>

Optional:

Example:
    (begin example)
    [_self, "thisMethod"] call A3OVG_util_fnc_getParentMethod;
    (end example)

Returns:
    <CODE>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
#ifdef WANT_ARMA_TO_CRASH
TRACE_1(QFUNC(getParentMethod),_this);
#endif /* WANT_ARMA_TO_CRASH */

if !assert(params[
    ["_self", nil],
    ["_methodName", nil, [""]]
]) exitWith {};

private _types = _self get "#type";

if (count _types <= 1) exitWith {
    throw format["Class %1 has no parent class. Cannot call super %2 on this instance.", THIS_CLASS, str _methodName];
};

private _parent = _types select 1;

if !assert(_parent in GVAR(classRegistry)) exitWith {
    throw format["Parent class %1 of %2 is not registered in class registry. Cannot call super %3 on this instance.", _parent, THIS_CLASS, str _methodName];
};

private _definition = GVAR(classRegistry) get _parent;

if !(_methodName in _definition) exitWith {
    throw format["Parent method %1 (of %2) is not defined in class definition. Cannot call super %3 on this instance.", str _methodName, THIS_CLASS, str _methodName];
};

private _method = _definition get _methodName;

if ((isNil "_method") || { !(_method isEqualType {}) }) exitWith {
    throw format["Parent method %1 (of %2) is not defined or not a code block", str _methodName, THIS_CLASS];
};

_method;
