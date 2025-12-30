#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garageServer

Description:
    Server-side handling of putting vehicle into garage.

Parameters:
    0: _vehicles - Vehicles to put into garage <ARRAY>
    1: _player - Player parking the vehicle <OBJECT>

Optional:

Example:
    (begin example)
    [[_vehicle1, _vehicle2], _player] call A3OVG_vehicle_fnc_garageServer;
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
    ["_vehicles", nil, [[]]],
    ["_player", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _player) exitWith {};

_vehicles apply {
    private _vehicleObject = _x;

    if !assert(!isNull _vehicleObject) exitWith {};
    if !(isNull attachedTo _vehicleObject) then {
        detach _vehicleObject;
    };

    INFO_2("Parking vehicle %1 for player %2",_vehicleObject,_player);

    private _vehicle = [_vehicleObject] call FUNC(new);
    _vehicle call["setOwner", [_player]];

    private _message = if !(_vehicle call["write", []]) then {
        LELSTRING(UI,VehicleGarageFailure);
    } else {
        deleteVehicle _vehicleObject;
        LELSTRING(UI,VehicleGarageSuccess);
    };

    [format[_message, _vehicle get "_displayName"]] remoteExecCall[QEFUNC(ui,showHintSingle), owner _player];
};

nil;
