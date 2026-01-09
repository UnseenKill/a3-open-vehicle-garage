#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_removeVehicle

Description:
    Remove all storage entries associated with given vehicle UUID.

Parameters:
    0: _uuid - Vehicle UUID <STRING>

Optional:

Example:
    (begin example)
    _storage call["removeVehicle", ["vehicle-uuid-1234"]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(removeVehicle);

if !assert(params[
    ["_uuid", nil, [""]]
]) exitWith { false };

try {
    private _properties = _self call["read", [SECTION_VEHICLE, _uuid, [[]]]];
    private _separator = _self get "_prefixSeparator";

    MTRACE_2(QUOTE(removeVehicle),_uuid,RETDEF(_properties,"N/A"));

    if !(isNil "_properties") then {
        _properties apply {
            _self call["removeKey", [SECTION_VEHICLE, [_uuid, _x] joinString _separator]];
        };
    };

    _self call["removeKey", [SECTION_VEHICLE, _uuid]];
    _self call["removeKey", [SECTION_TOC, _uuid]];
    _self call["commit", []];

    true;
} catch {
    ERROR_MSG_3("%1() failed to remove vehicle data for UUID %2: %3",QFUNC(method_removeVehicle),_uuid,str _exception);
    false;
};
