#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_simple_fnc_method_getPositionAsync

Description:
    Simple position provider implementation of getPositionAsync.

Parameters:
    0: _callback - Callback code receiving calculated position <CODE>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getPositionAsync);

if !assert(params[
    ["_callback", nil, [{}]]
]) exitWith {};

private _vehicle = _self get "_vehicle";
private _vector = player weaponDirection currentWeapon player;
private _beg = ASLToAGL eyePos player;
private _inFront = _beg vectorAdd (_vector vectorMultiply 15);
private _position = _inFront findEmptyPosition[10, 5, _vehicle get "_className"];

if !assert(_position isNotEqualTo []) then { throw "Could not find empty position in front of player." };

[_callback, [_self, _vehicle, _position, [vectorDir player vectorMultiply -1, surfaceNormal _position]]] call CBA_fnc_execNextFrame;

nil;
