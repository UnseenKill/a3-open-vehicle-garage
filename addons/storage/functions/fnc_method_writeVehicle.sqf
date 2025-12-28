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
    <BOOL> Success status

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(writeVehicle);

if !assert(params[
    ["_uuid", nil, [""]],
    ["_data", nil, [createHashMap]]
]) exitWith { false };

try {
    private _key = _self call["getKey", [_uuid]];

    _self call["deleteKey", [_key]];
    _data apply {
        _self call["write", [_key, _x, _y]];
    };

    true;
} catch {
    ERROR_MSG_3("%1() failed to write vehicle data for UUID %2: %3",QFUNC(method_writeVehicle),_uuid,str _exception);
    false;
};
