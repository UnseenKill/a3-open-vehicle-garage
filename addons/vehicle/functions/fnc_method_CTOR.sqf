#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_CTOR

Description:
    Constructor method for vehicle OO class.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:

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
if !assert(!isNull _vehicle) exitWith {};

_self set["_vehicle", _vehicle];

nil;
