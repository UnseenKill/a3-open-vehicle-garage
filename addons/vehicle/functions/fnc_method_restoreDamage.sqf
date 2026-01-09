#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreDamage

Description:
    Restore vehicle damage state from serialized data.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>
    1: _data - serialized data <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restoreDamage);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_data", nil, [createHashMap]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _hitpointDamage = _data get "hitPoints";

_vehicle setDamage(_data get "damage");

((_hitpointDamage select 0) createHashMapFromArray (_hitPointDamage select 2)) apply {
    TRACE_2(QFUNC(method_restoreDamage),_x,_y);
    _vehicle setHitPointDamage[_x, _y];
};

nil;
