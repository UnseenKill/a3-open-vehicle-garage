#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_load

Description:
    Instantiate vehicle object from saved data.

Parameters:
    0: _uuid - unique identifier for the vehicle <STRING>

Optional:

Example:
    (begin example)
    private _vehicle = ["vehicle-uuid-1234"] call A3OVG_vehicle_fnc_load;
    (end example)

Returns:
    <HASHMAP-OBJECT> Vehicle object if successful, nil otherwise.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(load));
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_uuid", nil, [""]]
]) exitWith {};

private _storage = [] call EFUNC(core,getStorage);
private _data = _storage call["readVehicle", [_uuid]];

if (isNil "_data") exitWith {};

private _vehicle = [QADDON, [objNull, _uuid]] call EFUNC(util,new);
_vehicle set["_serialized", _data];

_vehicle;
