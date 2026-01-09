#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_readSectionKeys

Description:
    Get all keys in given section from storage backend.

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

private _s = _self call["getStorage", []];
if !(_section in _s) exitWith {[]};
keys(_s get _section);
