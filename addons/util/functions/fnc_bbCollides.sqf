#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3U_util_fnc_bbCollides

Description:
    Check if two bounding boxes collide.

Parameters:
    0: _boxA - Box A <ARRAY> [[[xmin, ymin, zmin], [xmax, ymax, zmax]]]
    1: _boxB - Box B <ARRAY> [[[xmin, ymin, zmin], [xmax, ymax, zmax]]]

Optional:

Returns:
    <BOOL> true if boxes collide, false otherwise

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
// No fancy function prolog or in-depth type checking; this function gets called
// a lot and needs to be as fast as possible.
params["_boxA","_boxB"];

if (_boxA isEqualType objNull) then { _boxA = [_boxA] call EFUNC(util,bbRotate) };
if (_boxB isEqualType objNull) then { _boxB = [_boxB] call EFUNC(util,bbRotate) };

private _a_min = _boxA select 0;   // [xmin, ymin, zmin]
private _a_max = _boxA select 1;   // [xmax, ymax, zmax]

private _b_min = _boxB select 0;
private _b_max = _boxB select 1;

// Check overlap on x-axis
if (((_a_max select 0) < (_b_min select 0)) || {(_b_max select 0) < (_a_min select 0)}) exitWith { false };
// Check overlap on y-axis
if (((_a_max select 1) < (_b_min select 1)) || {(_b_max select 1) < (_a_min select 1)}) exitWith { false };
// Check overlap on z-axis
if (((_a_max select 2) < (_b_min select 2)) || {(_b_max select 2) < (_a_min select 2)}) exitWith { false };
// Overlaps on all axes

true;
