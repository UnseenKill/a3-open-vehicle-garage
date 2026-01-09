#include "..\script_component.hpp"
#include "\z\a3ovg\addons\storage\script_macros.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_delete

Description:
    Delete the vehicle from storage.

Parameters:
    0: _uuid - Vehicle UUID <STRING>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(delete));
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_uuid", "", [""]]
]) exitWith {};

INFO_1("Deleting vehicle with UUID %1",_uuid);

private _storage = [] call EFUNC(core,getStorage);

_storage call["removeVehicle", [_uuid]];

nil;
