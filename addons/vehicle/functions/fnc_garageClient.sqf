#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_garageClient

Description:
    Put vehicle into garage.

Parameters:
    0: _vehicle - Vehicle to put into garage <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle1] call A3OVG_vehicle_fnc_garageClient;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(garageClient));
A3OVG_VERIFY_CLIENT();

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _vehicle) exitWith {};

A3OVG_UI_PUSH_CONTEXT();

private _attached = attachedObjects _vehicle select {
    !(["canIgnoreAttached", [_x]] call EFUNC(core,runCallback));
};

private _index = _attached findIf {
    !(["canVehicleGarage", [_x, player]] call EFUNC(core,runCallback));
};

if (_index != -1) exitWith {
    INFO_3("vehicle garaging of %1 denied by attached object %2 for %3",_vehicle,_attached select _index,player);
    [format[LELSTRING(UI,VehicleGarageDeniedAttached), A3OVG_VEH_NAME(_attached select _index)]] call EFUNC(ui,showHint);
};

A3OVG_UI_POP_CONTEXT();

[_attached + [_vehicle], player] remoteExecCall[QFUNC(garageServer), 2];

nil;
