#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_deleteKey

Description:
    Delete all entries associated with given key from namespace storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>

Optional:

Example:
    (begin example)
    _storage call["deleteKey", ["vehicles","vehicle_1234"]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(deleteKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith { false };

private _s = _self call["getStorage", []];

if (_section in _s) then {
    _s get _section deleteAt _key;
};

true;
