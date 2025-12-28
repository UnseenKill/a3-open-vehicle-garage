#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_CTOR

Description:
    Storage adapter constructor method.

Parameters:
    0: _prefix - Storage prefix <STRING>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(CTOR);

if !assert(params[
    ["_prefix", nil, [""]]
]) exitWith {};

_self set["_storagePrefix", _prefix];

nil;
