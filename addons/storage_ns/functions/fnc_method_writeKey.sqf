#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_writeKey

Description:
    Write value to namespace storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>
    2: _value - Value to write <ANY>

Optional:

Example:
    (begin example)
    _storage call["writeKey", ["vehicles", "vehicle_1234", _vehicleData]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(writeKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]],
    ["_value", nil]
]) exitWith { false };

private _s = _self call["getStorage", []];

if !(_section in _s) then {
    _s set[_section, createHashMap];
};

_s get _section set[_key, _value];

true;
