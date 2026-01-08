#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_removeKey

Description:
    Remove a specific key from storage.

Parameters:
    0: _section - Section name <STRING>
    1: _key - UUID_raw <STRING>

Optional:

Returns:
    <BOOL> Success status

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(removeKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith { false };

_self call["deleteKey", [_section, _self call["getKey", [_key]]]];
