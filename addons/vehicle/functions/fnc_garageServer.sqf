#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garageServer

Description:
    Server-side handling of putting vehicle into garage.

Parameters:
    0: _vehicleObject - Vehicle to put into garage <OBJECT>
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
    ["_vehicleObject", nil, [objNull,""]],
    ["_player", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _player) exitWith {};
if !assert(!isNull _vehicleObject) exitWith {};
if !assert(!(_vehicleObject isEqualType "")) exitWith {};

INFO_2("Parking vehicle %1 for player %2",_vehicleObject,_player);

private _vehicle = [_vehicleObject] call FUNC(new);
private _message = if (_vehicle call["write", []]) then {
    LELSTRING(UI,VehicleGarageSuccess);
} else {
    LELSTRING(UI,VehicleGarageFailure);
};

[format[_message, _vehicle get "_displayName"]] remoteExecCall[QEFUNC(ui,showHint), owner _player];

nil;
