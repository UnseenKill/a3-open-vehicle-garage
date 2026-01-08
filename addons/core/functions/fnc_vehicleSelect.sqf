#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_vehicleSelect

Description:
    Ungarage vehicle.

    Mutex on vehicle must exist before calling this function. See A3OVG_core_fnc_setMutex.

Parameters:
    0: _request - vehicle selection request <HASHMAP>
        - "_pp" : position provider addon name <STRING> (default: "A3OVG_pp_simple")
        - "_vehicle" : vehicle object <HASHMAP>

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
    ["_pp", QUOTE(DOUBLES(PREFIX,pp_simple)), [""]],
    ["_vehicle", nil, [createHashMap]]
]] call EFUNC(util,validateHashMap)) exitWith {};

private _vehicle = _request get "_vehicle";
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

private _uuid = _vehicle call["getUUID", []];
private _pp = _request get "_pp";

TRACE_1(QFUNC(vehicleSelect),_request);
TRACE_2(QFUNC(vehicleSelect),_uuid,_pp);

private _provider = [_pp, [_request, _vehicle]] call EFUNC(util,new);

if !assert(VALIDATE_OBJECT(_provider,QUOTE(DOUBLES(PREFIX,pp_base)))) exitWith {};

try {
    _provider call["getPositionAsync", [{ call FUNC(vehiclePositionClient) }]];
} catch {
    ERROR_1("Error trying to get vehicle position from provider: %1",_exception);
    [_uuid, objNull] remoteExecCall[QFUNC(setMutex), 2];
};

nil;
