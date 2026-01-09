#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_xehVehicleInitPost

Description:
    Vehicle extended event handler - on vehicle init

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:

Example:

Returns:
    Return description <TYPE>

Environment:
    Client+Server, Unscheduled, InitPost phase

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(xehVehicleInitPost));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

// Client side only
if (hasInterface) exitWith {
    A3OVG_GET_CONFIG(_config);

    if (getNumber(_config >> "Features" >> "vehicleUserActionGlobal") == 0) exitWith {};

    if (_vehicle getVariable[QGVARMAIN(vehicleUserAction), true]) then {
        [_vehicle] call FUNCMAIN(userActionVehicleGarageAdd);
    };
};

nil;
