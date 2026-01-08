#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreCustomization

Description:
    Restore vehicle customization from serialized data.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>
    1: _data - serialized data <ARRAY>

Optional:

Returns:
        

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restoreCustomization);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_data", nil, [[]]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

([_vehicle] + _data) call BIS_fnc_initVehicle;

nil;
