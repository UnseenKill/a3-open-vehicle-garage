#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_canLock

Description:
    Check if the vehicle can be locked by a player.

Parameters:
    0: _player - Player attempting to lock <OBJECT>

Optional:

Returns:
    <BOOL> - Whether the vehicle can be locked by the player

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(method_canLock);

if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith { false };
if !assert(!isNull _player) exitWith { false };

private _ownerLock = _self get "_ownerLock";

!(_self call["isLocked", []]) &&
{ (isNil "_ownerLock") || {_ownerLock isEqualTo getPlayerUID _player}};
