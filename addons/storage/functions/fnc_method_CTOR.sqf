#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_CTOR

Description:
    Storage adapter constructor method.

Parameters:
    0: _databaseName - Storage database name <STRING>

Optional:
    1: _prefix - Storage key prefix <STRING>

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
    ["_databaseName", nil, [""]]
]) exitWith {};

private _prefix = param[1, nil, [""]];

_self set["_storageDatabase", _databaseName];
_self set["_storagePrefix", _prefix];

nil;
