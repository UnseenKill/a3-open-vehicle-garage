#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_readKey

Description:
    Read value from namespace storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>

Optional:

Example:
    (begin example)
    private _value = _storage call["read", ["vehicles", "vehicle_1234"]];
    (end example)

Returns:
    <HASHMAP> Read value, or default value if key does not exist

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(readKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith {};

private _s = _self call["getStorage", []];

if (!(_section in _s) || { !(_key in (_s get _section)) }) exitWith {};
_s get _section get _key;
