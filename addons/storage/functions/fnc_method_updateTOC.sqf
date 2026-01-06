#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_updateTOC

Description:
    Update the Table of Contents (TOC) for vehicle storage.

Parameters:
    0: _uuid - Vehicle UUID <STRING>
    1: _data - Vehicle data <HASHMAP>
    2: _create - Whether to create or delete entry <BOOL>

Optional:

Example:
    (begin example)
    _storage call["updateTOC", [_uuid, _data, true]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(updateTOC);

if !assert(params[
    ["_uuid", nil, [""]],
    ["_data", nil, [createHashMap]],
    ["_create", nil, [false]]
]) exitWith { false };

private _key = _self call["getKey", [_uuid]];
private _result = if !(_create) then {
    _self call["deleteKey", [SECTION_TOC, _key]];
} else {
    _self call["write", [SECTION_TOC, _key, createHashMapFromArray[
        ["class", _data get "class"],
        ["category", _data get "category"],
        ["displayName", _data get "displayName"]
    ]]];
};

if (_result) then {
    _self call["commit", []];
};

_result;
