#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_setOwner

Description:
    Set the owner of the vehicle.

Parameters:
    0: _player - Player object <OBJECT>
    0: _playerUID - Player UID <STRING>

Optional:

Example:
    (begin example)
    _vehicle call["setOwner", [_player]];
    (end example)

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(setOwner);

if !assert(params[
    ["_player", nil, [objNull,""]]
]) exitWith {};

private _uid = if (_player isEqualType "") then {
    _player
} else {
    if assert(!isNull _player) then {
        getPlayerUID _player;
    };
};

if !assert(!isNil "_uid") exitWith {};

_self set["_owner", _uid];

nil;
