#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreResupply

Description:
    Restore vehicle resupply data from serialized data.

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
METHOD_PREAMBLE(restoreResupply);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_data", nil, [createHashMap]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

#define RESTORE_CARGO(type,function) if true then { \
    if (_data get (type) get "cargo" isNotEqualTo -1) then { \
        _vehicle function(_data get (type) get "cargo"); \
    }; \
}

RESTORE_CARGO(QUOTE(rearm),setAmmoCargo);
RESTORE_CARGO(QUOTE(refuel),setFuelCargo);
RESTORE_CARGO(QUOTE(repair),setRepairCargo);
#undef RESTORE_CARGO

if (A3OVG_HAVE_ACE()) then {
    if (_data get "rearm" get "aceCurrent" isNotEqualTo -1) then {
        [_vehicle, _data get "rearm" get "aceCurrent"] call ace_rearm_fnc_setSupplyCount;
    };
    if (_data get "refuel" get "aceCurrent" isNotEqualTo -1) then {
        _vehicle setVariable["ace_refuel_currentFuelCargo", _data get "refuel" get "aceCurrent", true];
    };
};

nil;
