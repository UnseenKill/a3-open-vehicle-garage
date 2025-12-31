#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_loadVehicleUUIDs

Description:
    Function to load vehicle data from the server for a list of vehicle UUIDs.

Parameters:
    0: _uuid - unique request identifier <STRING>
    1: _requestor - player ID requesting data <NUMBER>
    2: _vehicleUUIDs - list of vehicle UUIDs <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(loadVehicleUUIDs));
A3OVG_VERIFY_SERVER();
A3OVG_MAKE_SCHEDULED(EFUNC(core,loadVehicleUUIDs));

if !assert(params[
    ["_uuid", nil, [""]],
    ["_requestor", nil, [0]],
    ["_vehicleUUIDs", nil, [[]]]
]) exitWith {};

private _payload = _vehicleUUIDs apply { [_x] call EFUNC(vehicle,load) };

INFO_2("sending vehicle data payload response for %1 to player ID %2",_uuid,_requestor);

missionNamespace setVariable[_uuid, _payload, _requestor];

nil;
