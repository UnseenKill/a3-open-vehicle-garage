#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_write

Description:
    Commit serialized vehicle data to storage backend.

Parameters:

Optional:

Example:
    (begin example)
    _vehicle call["write", []];
    (end example)

Returns:
    <BOOL> - Success status

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(write);
A3OVG_VERIFY_SERVER();

private _storage = [] call EFUNC(core,getStorage);
private _data = _self call["serialize", []];

(_storage call["updateTOC", [_self get "_uuid", _data, true]]) &&
{ _storage call["writeVehicle", [_self get "_uuid", _data]] };
