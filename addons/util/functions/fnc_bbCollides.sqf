#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3U_util_fnc_bbCollides

Description:
    Check if two bounding boxes collide.

    We're doing this in 2D (X,Y) with a quick Z check first to bail out early;
    will maybe give us some false positives when two objects are on slanted
    surfaces...

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

#define x 0
#define y 1
#define z 2

// No Z overlap, bail out early
if ((_boxA select 1 select z) < (_boxB select 0 select z)) exitWith { false };
if ((_boxB select 1 select z) < (_boxA select 0 select z)) exitWith { false };

private _dot = {
    params["_A", "_B"];
    ((_A select x) * (_B select x)) + ((_A select y) * (_B select y));
};

private _substract = {
    params["_A","_B"];
    [(_A select x) - (_B select x), (_A select y) - (_B select y)];
};

private _normalize = {
    params["_v"];
    private _length = sqrt((_v select x) ^ 2 + (_v select y) ^ 2);
    if (_length == 0) exitWith { [0,0] };
    [(_v select x) / _length, (_v select y) / _length];
};

private _project = {
    params["_rect","_axis"];
    private _min = [_rect select 0, _axis] call _dot;
    private _max = _min;

    _rect select[1] apply {
        private _d = [_x, _axis] call _dot;
        if (_d < _min) then { _min = _d };
        if (_d > _max) then { _max = _d };
    };

    [_min, _max];
};

private _overlaps = {
    params["_projA","_projB"];
    
    !(
        ((_projA select 1) < (_projB select 0)) ||
        {(_projB select 1) < (_projA select 0)}
    );
};

private _rectanglesIntersect = {
    params["_rectA","_rectB"];

    private _axes = [];

    // Axes from rectangle A
    _axes pushBack([[_rectA select 1, _rectA select 0] call _substract] call _normalize);
    _axes pushBack([[_rectA select 3, _rectA select 0] call _substract] call _normalize);

    // Axes from rectangle A
    _axes pushBack([[_rectB select 1, _rectB select 0] call _substract] call _normalize);
    _axes pushBack([[_rectB select 3, _rectB select 0] call _substract] call _normalize);

    _axes findIf {
        private _axis = _x;

        private _projA = [_rectA, _axis] call _project;
        private _projB = [_rectB, _axis] call _project;

        !([_projA, _projB] call _overlaps)
    } == -1
};

// [Main code]
// Convert into list of vertices ordered clock-wise from minX,minY
private _A = [
    [_boxA select 0 select x, _boxA select 0 select y], // Min X,Y
    [_boxA select 0 select x, _boxA select 1 select y], // Min X, Max Y
    [_boxA select 1 select x, _boxA select 1 select y], // Max X,Y
    [_boxA select 1 select x, _boxA select 0 select y]  // Max X, Min Y
];

private _B = [
    [_boxB select 0 select x, _boxB select 0 select y], // Min X,Y
    [_boxB select 0 select x, _boxB select 1 select y], // Min X, Max Y
    [_boxB select 1 select x, _boxB select 1 select y], // Max X,Y
    [_boxB select 1 select x, _boxB select 0 select y]  // Max X, Min Y
];

[_A, _B] call _rectanglesIntersect;
