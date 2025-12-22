#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_garageVehicle

Description:
    Put a vehicle into the garage

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle1] call A3OVG_fnc_garageVehicle;
    (end example)

Returns:
    <BOOL> True on success, false on failure

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(garageVehicle));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith { false };

if !assert(hasInterface) exitWith { false };

A3OVG_UI_PUSH_CONTEXT();
if !(["canVehicleGarage", [_vehicle, player]] call EFUNC(core,runCallback)) exitWith {
    INFO_2("vehicle garaging of %1 denied by callback for %2",_vehicle,player);
    [localize ELSTRING(UI,VehicleGarageDenied)] call EFUNC(ui,showHint);
    false;
};
A3OVG_UI_POP_CONTEXT();

[_vehicle, player] call EFUNC(vehicle,garage);

true;
