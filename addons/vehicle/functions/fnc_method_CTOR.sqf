#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_CTOR

Description:
    Constructor method for vehicle OO class.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:
    1: _uuid - Vehicle UUID <STRING>

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(CTOR);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

if (!isNull _vehicle) then {
    _self call["setVehicle", [_vehicle]];
};

private _uuid = param[1, nil, [""]];

if !(isNil "_uuid") then {
    _self set["_uuid", _uuid];
} else {
    _self set["_uuid", _self call["createUUID", []]];
};

nil;
