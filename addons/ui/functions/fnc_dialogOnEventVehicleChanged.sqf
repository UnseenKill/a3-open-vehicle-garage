#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnEventVehicleChanged

Description:
    CBA event handler function called when a vehicle properties changed.

Parameters:
    0: _vehicle - Vehicle object instance <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogOnEventVehicleChanged),_display);

if !assert(params[
    ["_vehicle", nil, [createHashMap]]
]) exitWith {};
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

private _vehicles = _display getVariable QGVAR(vehicles);

if !((_vehicle call["getUUID", []]) in _vehicles) then {
    INFO_2("change event for previously unknown vehicle %1 (%2); adding to vehicles hashmap",_vehicle get "_displayName",_vehicle call[ARR_2("getUUID",[])]);
    _vehicles set[_vehicle call["getUUID", []], _vehicle];
};

[_vehicle] call FUNC(dialogTreeUpdateVehicleEntry);

nil;
