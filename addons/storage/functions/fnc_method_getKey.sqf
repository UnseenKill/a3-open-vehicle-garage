#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_getKey

Description:
    Retrieve storage key for given UUID.

Parameters:
    0: _uuid - Vehicle UUID <STRING>

Optional:

Example:
    (begin example)
    private _key = _self call["getKey", ["vehicle-uuid-1234"]];
    // _key now contains the storage key associated with the given UUID
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

[_self get "storagePrefix", _uuid] joinString PREFIX_SEPARATOR;
