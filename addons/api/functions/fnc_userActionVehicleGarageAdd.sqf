#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_userActionOpenGarageAdd

Description:
    Adds the "Garage vehicle" user action to a vehicle

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:
    1: _priority - Priority of the action <SCALAR> (default: 6)
    2: _range - Range of the action <SCALAR> (default: 15)

Example:
    (begin example)
    [vehicle1] call A3OVG_fnc_userActionVehicleGarageAdd;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled, PostInit phase

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(userActionVehicleGarageAdd));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

A3OVG_GET_CONFIG(_config);

_this deleteAt 0;
params[
    ["_priority", 6, [0]],
    ["_range", getNumber(_config >> "Features" >> "vehicleUserActionRadius"), [0]]
];

[_vehicle] call FUNCMAIN(userActionVehicleGarageRemove);

private _actionId = _vehicle addAction[
    "",
    QUOTE(call FUNCMAIN(garageVehicle)),
    nil,
    _priority,
    false,
    true,
    "",
    QUOTE(isNull objectParent _this),
    _range
];
_vehicle setUserActionText[
    _actionId,
    "<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa' /> " + format[LELSTRING(UI,vehicleGarageUALong), getText(configOf _vehicle >> "displayName")],
    "<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa' /> " + LELSTRING(UI,vehicleGarageUA)
];
_vehicle setVariable[QGVAR(userActionGarageVehicleId), _actionId, true];

nil;
