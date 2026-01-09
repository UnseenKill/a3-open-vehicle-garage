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
    if !(_self call["removeVehicle", [_uuid, true]]) then {
        throw format["failed to delete vehicle UUID %1", _uuid];
    };

    private _keys = keys _data;
    private _separator = _self get "_prefixSeparator";

    _keys sort true;

    if !(_self call["write", [SECTION_VEHICLE, _uuid, _keys]]) exitWith { false };

    _keys apply {
        _self call["write", [SECTION_VEHICLE, [_uuid, _x] joinString _separator, _data get _x]];
    };

    _self call["commit", []];

    true;
} catch {
    ERROR_MSG_3("%1() failed to write vehicle data for UUID %2: %3",QFUNC(method_writeVehicle),_uuid,str _exception);
    false;
};
