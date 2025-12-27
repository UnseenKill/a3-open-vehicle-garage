#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garage

Description:
    Put vehicle into garage.

Parameters:
    0: _vehicle - Vehicle to put into garage <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle1] call A3OVG_vehicle_fnc_garage;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(garage));
A3OVG_GET_CONFIG(_config);

if !assert(params[
    ["_vehicle", nil, [objNull,""]]
]) exitWith {};

if !assert(!isNull _vehicle) exitWith {};
if !assert(!(_vehicle isEqualType "")) exitWith {};

private _data = [_vehicle] call FUNC(serialize);
private _storage = [] call EFUNC(core,getStorage);
private _guid = [_vehicle] call FUNC(getGUID);

_storage call["write", [_guid, _data]];

[format[LELSTRING(UI,VehicleGarageSuccess), A3OVG_VEH_NAME(_vehicle)]] call EFUNC(ui,showHint);

nil;
