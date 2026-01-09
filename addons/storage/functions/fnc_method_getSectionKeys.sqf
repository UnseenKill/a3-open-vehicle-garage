#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_getSectionKeys

Description:
    Get all keys in given section from storage backend.

Parameters:
    0: _section - The section name from which to retrieve keys <STRING>

Optional:
    1: _prefix - The prefix used in storage keys <STRING>

Example:
    (begin example)
    // All keys from "mySection"
    private _keys = _storage call["getSectionKeys", ["mySection"]];
    // All keys from "mySection" with "myPrefix"
    private _keys = _storage call["getSectionKeys", ["mySection", "myPrefix"]];
    (end example)

Returns:
    <ARRAY> - An array of UUID_raw in the specified section.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getSectionKeys);

if !assert(params[
    ["_section", nil, [""]]
]) exitWith {[]};

private _prefix = param[1, nil, [""]];
private _keys = _self call["readSectionKeys", [_section]];

if (isNil "_prefix") exitWith { _keys };

_prefix = _prefix + (_self get "_prefixSeparator");
private _length = count _prefix;

_keys select { 0 == (_x find _prefix) } apply {
    [_x, _length] call CBA_fnc_substr;
};
