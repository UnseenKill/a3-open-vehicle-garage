#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_getKey

Description:
    Retrieve storage key associated with given UUID.

Parameters:
    0: _uuid - Vehicle UUID storage key <STRING>

Optional:

Example:
    (begin example)
    private _key = [_uuid] call A3OVG_storage_inidbi2_fnc_method_getKey;
    (end example)

Returns:
    <STRING> Storage key

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getKey);

if !assert(params[
    ["_uuid", nil, [""]]
]) exitWith { "" };

_uuid;
