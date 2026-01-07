#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_vehicleSelect

Description:
    Ungarage vehicle.

    Mutex on vehicle must exist before calling this function. See A3OVG_core_fnc_setMutex.

Parameters:
    0: _request - vehicle selection request <HASHMAP>
        - "_uuid" : vehicle UUID <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(vehicleSelect));

if !assert(params[
    ["_request", nil, [createHashMap]]
]) exitWith {};

if !assert([_request, [
    ["_uuid", nil, [""]]
]] call EFUNC(util,validateHashMap)) exitWith {};

TRACE_1(QFUNC(vehicleSelect),_request);

nil;
