#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_readVehicle

Description:
    Load serialized vehicle storage data from storage backend.

Parameters:
    0: _uuid - Vehicle UUID_raw <STRING>

Optional:

Example:
    (begin example)
    private _data = _storage call["readVehicle", ["vehicle-uuid-1234"]];
    (end example)

Returns:
    <HASHMAP> Vehicle data if found, nil otherwise.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(readVehicle);

if !assert(params[
    ["_uuid", nil, [""]]
]) exitWith {};

private _dataKeys = _self call["read", [SECTION_VEHICLE, _uuid, [[]]]];
private _data = createHashMap;

_dataKeys apply {
    private _subKey = [_uuid, _x] joinString (_self get "_prefixSeparator");
    _data set[_x, _self call["read", [SECTION_VEHICLE, _subKey]]];
};

_data;
