#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_writeVehicle

Description:
    Save serialized vehicle storage data to storage backend.

Parameters:
    0: _uuid - Vehicle UUID <STRING>
    1: _data - Vehicle data to write <HASHMAP>

Optional:

Example:

Returns:
    Nothing

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(writeVehicle);

if !assert(params[
    ["_uuid", nil, [""]],
    ["_data", nil, [createHashMap]]
]) exitWith {};

nil;
