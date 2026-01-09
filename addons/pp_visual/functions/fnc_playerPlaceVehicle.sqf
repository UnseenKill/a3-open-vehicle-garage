#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_visual_fnc_playerPlaceVehicle

Description:
    Allow player to visually place a vehicle of specified class.

Parameters:
    0: _vehicleClass - Vehicle class name <STRING>
    0: _vehicleClass - Vehicle object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(playerPlaceVehicle));
A3OVG_MAKE_SCHEDULED(FUNC(playerPlaceVehicle));

if !assert(params[
    ["_vehicleClass", nil, ["", objNull]]
]) exitWith {};

if !assert(!(_vehicleClass isEqualType objNull) || { !isNull _vehicleClass }) exitWith {};
if !assert(!(_vehicleClass isEqualType "") || { _vehicleClass isNotEqualTo "" }) exitWith {};

private _extract = if (_vehicleClass isEqualType objNull) then {
    [_vehicleClass, typeOf _vehicleClass];
} else {
    [_vehicleClass createVehicleLocal[0,0,1000], _vehicleClass];
};

if !assert(_extract params[
    ["_vehicle", nil, [objNull]],
    ["_vehicleClass", nil, [""]]
]) exitWith {};

[_vehicle] call FUNCMAIN(userActionVehicleGarageRemove);
_vehicle enableSimulation false;
_vehicle allowDamage false;
_vehicle setPosATL [0,0,1000];
_vehicle setVectorUp [0,0,1];
_vehicle setDir 0;

uiSleep 0.1;

private _display = findDisplay 46;
private _events = [];

GVAR(rotateCW) = false;
GVAR(rotateCCW) = false;
GVAR(placeVehicle) = _vehicle;
GVAR(collisions) = [];
GVAR(paintBBs) = [_vehicle];
GVAR(ignoreKeys) = flatten[["Action", "leanLeft", "leanRight", "ingamePause"] apply {
    actionKeys _x;
}];

private _bb = 0 boundingBoxReal _vehicle;
_vehicle setVariable[QGVAR(bb), _bb];

_events pushBack["KeyDown", _display displayAddEventHandler["KeyDown", {
    params["_display", "_key", "_shift", "_ctrl", "_alt"];

    _key = [_key, _shift, _ctrl, _alt] call EFUNC(util,adjustDIK);

    // Escape doesn't get handed down to KeyUp event, so we handle it here
    switch true do {
        case(_key arrayIntersect actionKeys "ingamePause" isNotEqualTo []): {
            GVAR(placeVehicle) = nil;
            true;
        };

        case(_key arrayIntersect actionKeys "leanLeft" isNotEqualTo []): { GVAR(rotateCW) = true; true };
        case(_key arrayIntersect actionKeys "leanRight" isNotEqualTo []): { GVAR(rotateCCW) = true; true };

        default {
            _key arrayIntersect GVAR(ignoreKeys) isNotEqualTo [];
        };
    };
}]];

_events pushBack["KeyUp", _display displayAddEventHandler["KeyUp", {
    params["_display", "_key", "_shift", "_ctrl", "_alt"];

    _key = [_key, _shift, _ctrl, _alt] call EFUNC(util,adjustDIK);

    switch true do {
        case(_key arrayIntersect actionKeys "leanLeft" isNotEqualTo []): { GVAR(rotateCW) = false };
        case(_key arrayIntersect actionKeys "leanRight" isNotEqualTo []): { GVAR(rotateCCW) = false };

        case(_key arrayIntersect actionKeys "Action" isNotEqualTo []): {
            if GVAR(validPlacement) then {
                GVAR(placeVehicle) = nil;
            };
        };
    };

    nil;
}]];

GVAR(eachFrameEH_Preview) = addMissionEventHandler["EachFrame", {
    if isNil(QGVAR(placeVehicle)) exitWith {
        GVAR(collisions) apply { [_x, []] call EFUNC(util,setObjectColor) };
    };

    private _vehicle = GVAR(placeVehicle);
    private _pos = screenToWorld[0.5, 0.75];
    private _wantUpdate = GVAR(rotateCW) || { GVAR(rotateCCW) };

    if (!_wantUpdate && { _pos distance getPosATL _vehicle < 0.25 }) exitWith {};

    _vehicle setPosATL [_pos#0, _pos#1, 0.05];
    _vehicle setVectorUp surfaceNormal getPosASL _vehicle;

    if (GVAR(rotateCW)) then {
        _vehicle setDir ((getDir _vehicle - diag_deltaTime * 120) mod 360);
    } else {
        if (GVAR(rotateCCW)) then {
            _vehicle setDir ((getDir _vehicle + diag_deltaTime * 120) mod 360);
        };
    };

    _vehicle setVariable[QGVAR(dir), getDir _vehicle];
    _vehicle setVariable[QGVAR(pos), getPosATL _vehicle];
    _vehicle setVariable[QGVAR(vdup), [vectorDir _vehicle, vectorUp _vehicle]];

    diag_log "------------------ Checking placement validity -----------------";

    GVAR(collisions) apply { [_x, []] call EFUNC(util,setObjectColor) };
    GVAR(paintBBs) = GVAR(paintBBs) - GVAR(collisions);
    GVAR(collisions) = [];

    GVAR(validPlacement) = true;
    GVAR(validPlacement) = GVAR(validPlacement) && { player distance _vehicle < 50 };

    if GVAR(validPlacement) then {
        private _bb = _vehicle getVariable QGVAR(bb);
        private _radius = _bb select 2;
        private _vicinity = nearestObjects[_vehicle, ["LandVehicle","House"], _radius * 2] - [_vehicle];
        private _index = _vicinity findIf { [_bb, _x] call EFUNC(util,bbCollides) };

        if (_index > -1) then {
            private _collider = _vicinity select _index;

            GVAR(validPlacement) = false;

            if !(_collider in GVAR(collisions)) then {
                diag_log format["Collision with %1", _collider];

                _collider setVariable[QGVAR(bb), 0 boundingBoxReal _collider];

                GVAR(collisions) pushBack _collider;
                GVAR(paintBBs) pushBackUnique _collider;
                [_collider, [1,0.3,0.1,0.5]] call EFUNC(util,setObjectColor);
            };
        };
    };

    if (GVAR(validPlacement) isNotEqualTo(GVAR(placeVehicle) getVariable[QGVAR(isValidPosition), true])) then {
        GVAR(placeVehicle) setVariable[QGVAR(isValidPosition), GVAR(validPlacement)];

        if !GVAR(validPlacement) then {
            [GVAR(placeVehicle), [1,0.3,0.1,0.5]] call EFUNC(util,setObjectColor);
        } else {
            [GVAR(placeVehicle), []] call EFUNC(util,setObjectColor);
        };
    };
}];

GVAR(eachFrameEH_Debug) = addMissionEventHandler["EachFrame", {
    if isNil(QGVAR(placeVehicle)) exitWith {};

    GVAR(paintBBs) apply {
        private _vehicle = _x;
        private _dir = (getDir _vehicle % 360);
        private _cos_0 = cos -_dir;
        private _sin_0 = sin -_dir;
        private _cos_1 = cos _dir;
        private _sin_1 = sin _dir;
        private _bb = _vehicle getVariable QGVAR(bb);
        private _center = _vehicle modelToWorld[0,0,0];
        private _lines = [];


        //       (00,11,12)       +------------------+    (10,11,12)
        //                      / |H                /|G
        //                     /  |                / |
        //                    /   |               /  |
        //       (00,01,12)   +------------------+   |    (10,01,12)
        //                    |E  |            F |   |
        //                    |   |              |   |
        //       (00,11,02)1  |   +--------------|---+    (10,11,02)0
        //                    |  /D              |  /C
        //                    | /                | /
        //                    |/                 |/
        //                    +------------------+    
        //       (00,01,02)0  A                  B        (10,01,02)1


        private _pt_0 = _bb select 0;
        private _pt_1 = _bb select 1;

        #define P(x,y,z) [DOUBLES(_pt,x) select 0, DOUBLES(_pt,y) select 1, DOUBLES(_pt,z) select 2]
        #define R(a,x,y,z) [\
            ((DOUBLES(_pt,x) select 0) * DOUBLES(_cos,a)) - ((DOUBLES(_pt,x) select 1) * DOUBLES(_sin,a)), \
            ((DOUBLES(_pt,y) select 0) * DOUBLES(_sin,a)) + ((DOUBLES(_pt,y) select 1) * DOUBLES(_cos,a)), \
            DOUBLES(_pt,z) select 2 \
        ] vectorAdd _center

        // Bottom square
        _lines pushBack [R(0,0,0,0), R(1,1,0,0), [1,0,0,1]]; // A-B
        _lines pushBack [R(1,0,1,0), R(0,1,1,0), [1,0,0,1]]; // D-C
        _lines pushBack [R(0,0,0,0), R(1,0,1,0), [1,0,0,1]]; // A-D
        _lines pushBack [R(1,1,0,0), R(0,1,1,0), [1,0,0,1]]; // B-C

        // Top square
        _lines pushBack [R(0,0,0,1), R(1,1,0,1), [0,0.5,0,1]]; // E-F
        _lines pushBack [R(1,0,1,1), R(0,1,1,1), [0,0.5,0,1]]; // H-G
        _lines pushBack [R(0,0,0,1), R(1,0,1,1), [0,0.5,0,1]]; // E-H
        _lines pushBack [R(1,1,0,1), R(0,1,1,1), [0,0.5,0,1]]; // F-G

        // Vertical lines
        _lines pushBack [R(0,0,0,0), R(0,0,0,1), [1,1,0,1]]; // A-E
        _lines pushBack [R(1,1,0,0), R(1,1,0,1), [1,1,0,1]]; // B-F
        _lines pushBack [R(1,0,1,0), R(1,0,1,1), [1,1,0,1]]; // C-G
        _lines pushBack [R(0,1,1,0), R(0,1,1,1), [1,1,0,1]]; // D-H

        _lines apply {
            drawLine3D[_x select 0, _x select 1, _x select 2, 40];
        };
    };
}];

while { true } do {
    uiSleep 0.1;
    if ((isNil QGVAR(placeVehicle)) || { isNull GVAR(placeVehicle) }) then { break };
};

diag_log "DONE";

removeMissionEventHandler["EachFrame", GVAR(eachFrameEH_Preview)];
removeMissionEventHandler["EachFrame", GVAR(eachFrameEH_Debug)];
_events apply { _display displayRemoveEventHandler _x };

attachedObjects _vehicle apply { deleteVehicle _x };
deleteVehicle _vehicle;

nil;
