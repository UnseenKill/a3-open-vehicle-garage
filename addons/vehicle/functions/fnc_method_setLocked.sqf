#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_setLocked

Description:
    Sets the lock state of the vehicle.

Parameters:
    0: _locked - Lock state <BOOL> / Owner UID <STRING>

Optional:

Example:
    (begin example)
    _vehicle call["setLocked", [false]];
    _vehicle call["setLocked", [getPlayerUID player]];
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(setLocked);

if !assert(params[
    ["_locked", nil, ["", false]]
]) exitWith {};

if (_locked isEqualType true && { _locked isEqualTo true }) exitWith {
    ERROR("Cannot set vehicle to locked=true; need an owner UID string instead.");
};

if (_locked isEqualType false) then {
    _self set["_ownerLock", nil];
} else {
    _self set["_ownerLock", _locked];
};

nil;
