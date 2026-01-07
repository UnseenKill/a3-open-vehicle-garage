#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreFuel

Description:
    Restore vehicle fuel from serialized data.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>
    1: _data - serialized data <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restoreFuel);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_data", nil, [0]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

_vehicle setFuel _data;

nil;
