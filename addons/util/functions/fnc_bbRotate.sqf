#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_bbRotate

Description:
    Rotate a bounding box around its center by a given direction (in degrees).

    Can use an object to get the bounding box, direction and center
    automatically. Will use the object's stored bounding box 
    (in GVAR(bbCached)), if available.

Parameters:
    0: _boxOrObject - object whose bounding box to rotate <OBJECT>
    0: _boxOrObject - non-rotated, relative bounding box to rotate <ARRAY>

Optional:
    1: _dir - direction to rotate by (in degrees) <NUMBER>

Example:
    (begin example)
    // Earlier (optional):
    _vehicle setVariable[QEGVAR(util,bbCached), 0 boundingBoxReal _vehicle];
    // Later: get object's bounding box rotated to its current direction
    _rotatedBB = [_vehicle] call A3OVG_util_fnc_bbRotate;
    (end example)

Returns:
    <ARRAY> Rotated bounding box [[xmin, ymin, zmin], [xmax, ymax, zmax], radius]

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(bbRotate),_this);

if !assert(params[
    ["_boxOrObject", nil, [objNull, []]]
]) exitWith {};

private _dir = param[1, if (_boxOrObject isEqualType objNull) then { getDir _boxOrObject } else { 0 }, [0]];
private _cos = cos -_dir;
private _sin = sin -_dir;
private _extract = if !(_boxOrObject isEqualType objNull) then {
    [+_boxOrObject, [0,0,0]];
} else {
    [if !(isNil {_boxOrObject getVariable QGVAR(bbCached)}) then [{_boxOrObject getVariable QGVAR(bbCached)},{0 boundingBoxReal _boxOrObject}], _boxOrObject modelToWorld[0,0,0]];
};

_extract params["_box","_center"];

private _pt_0 = _box select 0;
private _pt_1 = _box select 1;

#define PT(x,y,z) _center vectorAdd[ \
    ((DOUBLES(_pt,x) select 0) * _cos) - ((DOUBLES(_pt,x) select 1) * _sin), \
    ((DOUBLES(_pt,y) select 0) * _sin) + ((DOUBLES(_pt,y) select 1) * _cos), \
    DOUBLES(_pt,z) select 2 \
]

[PT(0,0,0), PT(1,1,1), _box select 2]
