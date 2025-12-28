#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_getParentMethod

Description:
    Retrieve parent method from storage adapter instance.

Parameters:
    0: _self - Storage adapter instance <HASHMAP-OBJECT>
    1: _methodName - Method name <STRING>

Optional:

Example:
    (begin example)
    [_self, "thisMethod"] call A3OVG_storage_fnc_getParentMethod;
    (end example)

Returns:
    <CODE>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getParentMethod),_this);

if !assert(params[
    ["_self", nil],
    ["_methodName", nil, [""]]
]) exitWith {};

private _base = _self get "#base";

if (isNil "_base") exitWith {
    throw format["Class %1 has no parent class. Cannot call super %2 on this instance.", THIS_CLASS, str _methodName];
};

private _method = _base get _methodName;

if ((isNil "_method") || { !(_method isEqualType {}) }) exitWith {
    throw format["Parent method %1 (of %2) is not defined or not a code block", str _methodName, THIS_CLASS];
};

_method;
