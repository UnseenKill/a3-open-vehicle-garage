#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_base_fnc_method_CTOR

Description:
    Class constructor method.

Parameters:
    0: _vehicle - Vehicle hashmap object <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(CTOR);

if !assert(params[
    ["_vehicle", nil, [createHashMap]]
]) exitWith {};
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

_self set["_vehicle", _vehicle];

nil;
