#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_toString

Description:
    Convert vehicle object to string representation.

Parameters:

Optional:

Returns:
    <STRING>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_self", nil, [createHashMap]]
]) exitWith {};

format["%1(%2)", _self get "_className", _self get "_uuid"];
