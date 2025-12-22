#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_userActionVehicleGarageRemove

Description:
    Remove user action to open garage from object

Parameters:
    0: _object - Object from which the user action will be removed <OBJECT>

Optional:

Example:
    (begin example)
    [building1] call A3OVG_fnc_userActionOpenGarageRemove;
    (end example)

Returns:
    <BOOLEAN> True if action was removed, false if no action was found

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(userActionVehicleGarageRemove),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _actionId = _vehicle getVariable QGVAR(userActionGarageVehicleId);

if isNil "_actionId" then {
    false;
} else {
    _vehicle removeAction _actionId;
    _vehicle setVariable[QGVAR(userActionGarageVehicleId), nil, true];
    true;
};
