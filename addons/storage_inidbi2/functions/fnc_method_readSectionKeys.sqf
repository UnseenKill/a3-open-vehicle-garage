#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_readSectionKeys

Description:
    Get all keys in given section from INIDBI2 storage backend.

Parameters:
    0: _section - The section name from which to retrieve keys <STRING>

Optional:

Returns:
    <ARRAY> - An array of keys in the specified section.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(readSectionKeys);

if !assert(params[
    ["_section", nil, [""]]
]) exitWith {[]};

private _dbi = _self get "_dbi";
private _keys = ["getKeys", _section] call _dbi;

_keys select { -1 == (_x find ":") };
