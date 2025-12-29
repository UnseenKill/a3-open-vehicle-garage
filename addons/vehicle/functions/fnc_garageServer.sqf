#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garageServer

Description:
    Server-side handling of putting vehicle into garage.

Parameters:
    0: _vehicle - Vehicle to put into garage <OBJECT>
    1: _player - Player parking the vehicle <OBJECT>

Optional:

Example:
    (begin example)
    [_vehicle, _player] call A3OVG_vehicle_fnc_garageServer;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(garageServer));
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_vehicle", nil, [objNull,""]],
    ["_player", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _player) exitWith {};
if !assert(!isNull _vehicle) exitWith {};
if !assert(!(_vehicle isEqualType "")) exitWith {};

INFO_2("Parking vehicle %1 for player %2",_vehicle,_player);

private _data = [_vehicle] call FUNC(serialize);
private _storage = [] call EFUNC(core,getStorage);
private _uuid = [_vehicle] call FUNC(getUUID);

private _success = 
    (_storage call["updateTOC", [_uuid, _data, true]]) &&
    { _storage call["writeVehicle", [_uuid, _data]] };

private _message = if (_success) then {
    LELSTRING(UI,VehicleGarageSuccess);
} else {
    LELSTRING(UI,VehicleGarageFailure);
};

[format[_message, A3OVG_VEH_NAME(_vehicle)]] remoteExecCall[QEFUNC(ui,showHint), owner _player];

nil;
