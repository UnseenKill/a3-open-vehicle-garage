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
    ["_vehicleClass", nil, ["", objNull]],
    ["_parameters", nil, [createHashMap]]
]) exitWith {};

if !assert(!(_vehicleClass isEqualType objNull) || { !isNull _vehicleClass }) exitWith {};
if !assert(!(_vehicleClass isEqualType "") || { _vehicleClass isNotEqualTo "" }) exitWith {};
if !assert([_parameters, [
    ["callbackAbort", {}, [{}, []]],
    ["callbackStart", {}, [{}, []]],
    ["callbackPlaced", nil, [{}, []]]
]] call EFUNC(util,validateHashMap)) exitWith {};

// Normalize callbacks to [{}, []] format
_parameters apply {
    if (_x find "callback" isEqualTo 0) then {
        if (_y isEqualType {}) then {
            _parameters set[_x, [_y, []]];
        };
    };
};

private _canDelete = (_vehicleClass isEqualType "");
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
_vehicle lockInventory true;
_vehicle lock true;
_vehicle setPosATL [0,0,1000];
_vehicle setVectorUp [0,0,1];
_vehicle setDir 0;
_vehicle setVariable[QGVAR(bbRelative), 0 boundingBoxReal _vehicle];

if assert(_parameters get "callbackStart" params[["_callbackCode", nil, [{}]], ["_callbackParams", nil, [[]]]]) then {
    [_vehicle, _callbackParams] call _callbackCode;
};

uiSleep 0.1;

private _display = findDisplay 46;
private _events = [];

GVAR(rotateCW) = false;
GVAR(rotateCCW) = false;
GVAR(placementAbort) = false;
GVAR(placeVehicle) = _vehicle;
GVAR(collisions) = [];
GVAR(paintBBs) = [_vehicle];
GVAR(ignoreKeys) = flatten[["Action", "leanLeft", "leanRight", "ingamePause"] apply {
    actionKeys _x;
}];

_events pushBack["KeyDown", _display displayAddEventHandler["KeyDown", {
    params["_display", "_key", "_shift", "_ctrl", "_alt"];

    _key = [_key, _shift, _ctrl, _alt] call EFUNC(util,adjustDIK);

    // Escape doesn't get handed down to KeyUp event, so we handle it here
    switch true do {
        case(_key arrayIntersect actionKeys "ingamePause" isNotEqualTo []): {
            GVAR(placeVehicle) = nil;
            GVAR(placementAbort) = true;
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

    GVAR(collisions) apply { [_x, []] call EFUNC(util,setObjectColor) };
    GVAR(paintBBs) = GVAR(paintBBs) - GVAR(collisions);
    GVAR(collisions) = [];

    GVAR(validPlacement) = !surfaceIsWater getPosATL _vehicle;
    GVAR(validPlacement) = GVAR(validPlacement) && { player distance _vehicle < 50 };

    if GVAR(validPlacement) then {
        private _bbRelative = _vehicle getVariable QGVAR(bbRelative);
        private _radius = _bbRelative select 2;
        private _vicinity = nearestObjects[_vehicle, ["LandVehicle","Air","CAManBase","House"], _radius * 2] - [_vehicle];
        private _marker = GVAR(marker);

        _marker setMarkerColorLocal "ColorBrown";
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerBrushLocal "FDiagonal";

        private _index = _vicinity findIf {
            private _bb = 0 boundingBoxReal _x;
            _bb set[0, _x modelToWorld(_bb select 0)];
            _bb set[1, _x modelToWorld(_bb select 1)];

            private _markerCenter = ((_bb select 0) vectorAdd (_bb select 1)) vectorMultiply 0.5;
            private _markerDimensions = (_bb select 1) vectorAdd ((_bb select 0) vectorMultiply -1) vectorMultiply 0.5;

            _marker setMarkerDirLocal getDir _x;
            _marker setMarkerPosLocal _markerCenter;
            _marker setMarkerSizeLocal(_markerDimensions vectorMultiply 1.5 select[0,2]);
            _x inArea _marker;
        };

        // Only shoot rays if we found a potential collision
        if (_index > -1) then {
            private _collider = _vicinity select _index;
            private _boxMin = AGLToASL(_vehicle modelToWorld (_bbRelative select 0));
            private _boxMax = AGLToASL(_vehicle modelToWorld (_bbRelative select 1));
            private _rays = [];

            // Cross (minX,minY,minZ) -> (maxX,maxY,minZ)
            _rays pushBack[[_boxMin select 0, _boxMin select 1, _boxMin select 2], [_boxMax select 0, _boxMin select 1, _boxMin select 2]];
            // Diagonal left side face bottom to top (minX,minY,minZ) -> (minX,maxY,maxZ)
            _rays pushBack[[_boxMin select 0, _boxMin select 1, _boxMin select 2], [_boxMin select 0, _boxMax select 1, _boxMax select 2]];
            // Diagonal left side face top to bottom (minX,minY,maxZ) -> (minX,maxY,minZ)
            _rays pushBack[[_boxMin select 0, _boxMin select 1, _boxMax select 2], [_boxMin select 0, _boxMax select 1, _boxMin select 2]];
            // Diagonal right side face bottom to top (maxX,minY,minZ) -> (maxX,maxY,maxZ)
            _rays pushBack[[_boxMax select 0, _boxMin select 1, _boxMin select 2], [_boxMax select 0, _boxMax select 1, _boxMax select 2]];
            // Diagonal right side face top to bottom (maxX,minY,maxZ) -> (maxX,maxY,minZ)
            _rays pushBack[[_boxMax select 0, _boxMin select 1, _boxMax select 2], [_boxMax select 0, _boxMax select 1, _boxMin select 2]];
            // Diagonal front face bottom to top (minX,minY,minZ) -> (maxX,minY,maxZ)
            _rays pushBack[[_boxMin select 0, _boxMin select 1, _boxMin select 2], [_boxMax select 0, _boxMin select 1, _boxMax select 2]];
            // Diagonal front face top to bottom (minX,minY,maxZ) -> (maxX,minY,minZ)
            _rays pushBack[[_boxMin select 0, _boxMin select 1, _boxMax select 2], [_boxMax select 0, _boxMin select 1, _boxMin select 2]];
            // Diagonal back face bottom to top (minX,maxY,minZ) -> (maxX,maxY,maxZ)
            _rays pushBack[[_boxMin select 0, _boxMax select 1, _boxMin select 2], [_boxMax select 0, _boxMax select 1, _boxMax select 2]];
            // Diagonal back face top to bottom (minX,maxY,maxZ) -> (maxX,maxY,minZ)
            _rays pushBack[[_boxMin select 0, _boxMax select 1, _boxMax select 2], [_boxMax select 0, _boxMax select 1, _boxMin select 2]];

            GVAR(validPlacement) = _rays findIf {
                lineIntersects[_x # 0, _x # 1, _vehicle];
            } == -1;

            if (!GVAR(validPlacement) && { !(_collider in GVAR(collisions)) }) then {
                INFO_1("Collision with %1",_collider);

                _collider setVariable[QGVAR(bbRelative), 0 boundingBoxReal _collider];

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

#ifndef __A3OVG_PRODUCTION__
GVAR(eachFrameEH_Debug) = addMissionEventHandler["EachFrame", {
    if isNil(QGVAR(placeVehicle)) exitWith {};

    GVAR(paintBBs) apply {
        //       7(0,0;1,1;1,2)      +------------------+    6(1,0;1,1;1,2)
        //                          /|H                /|G
        //                         / |                / |
        //                        /  |               /  |
        //       4(0,0;0,1;1,2)  +------------------+   |    5(1,0;0,1;1,2)
        //                       |E  |            F |   |
        //                       |   |              |   |
        //       3(0,0;1,1;02)   |   +--------------|---+    2(1,0;1,1;0,2)
        //                       |  /D              |  /C
        //                       | /                | /
        //                       |/                 |/
        //                       +------------------+    
        //       0(0,0;0,1;0,2)  A                  B        1(1,0;0,1;0,2)

        private _vehicle = _x;
        private _direction = getDir _vehicle;
        private _bb = _vehicle getVariable QGVAR(bbRelative);
        private _lines = [];
        private _bounds = [];

        _bounds pushBack[_bb select 0 select 0, _bb select 0 select 1, _bb select 0 select 2]; // Min X,Y
        _bounds pushBack[_bb select 1 select 0, _bb select 0 select 1, _bb select 0 select 2]; // Max X, Min Y
        _bounds pushBack[_bb select 1 select 0, _bb select 1 select 1, _bb select 0 select 2]; // Max X,Y
        _bounds pushBack[_bb select 0 select 0, _bb select 1 select 1, _bb select 0 select 2]; // Min X, Max Y

        _bounds pushBack[_bb select 0 select 0, _bb select 0 select 1, _bb select 1 select 2]; // Min X,Y
        _bounds pushBack[_bb select 1 select 0, _bb select 0 select 1, _bb select 1 select 2]; // Max X, Min Y
        _bounds pushBack[_bb select 1 select 0, _bb select 1 select 1, _bb select 1 select 2]; // Max X,Y
        _bounds pushBack[_bb select 0 select 0, _bb select 1 select 1, _bb select 1 select 2]; // Min X, Max Y

        _bounds = _bounds apply { _vehicle modelToWorld _x };

        // Bottom square
        _lines pushBack[_bounds select 0, _bounds select 1, [1,0,0,1]]; // A-B
        _lines pushBack[_bounds select 1, _bounds select 2, [1,0,0,1]]; // B-C
        _lines pushBack[_bounds select 2, _bounds select 3, [1,0,0,1]]; // C-D
        _lines pushBack[_bounds select 3, _bounds select 0, [1,0,0,1]]; // D-A

        // Top square
        _lines pushBack[_bounds select 4, _bounds select 5, [1,1,0,1]]; // A-B
        _lines pushBack[_bounds select 5, _bounds select 6, [1,1,0,1]]; // B-C
        _lines pushBack[_bounds select 6, _bounds select 7, [1,1,0,1]]; // C-D
        _lines pushBack[_bounds select 7, _bounds select 4, [1,1,0,1]]; // D-A

        // Vertical lines
        _lines pushBack[_bounds select 0, _bounds select 4, [0,0,1,1]]; // A-E
        _lines pushBack[_bounds select 1, _bounds select 5, [0,0,1,1]]; // B-F
        _lines pushBack[_bounds select 2, _bounds select 6, [0,0,1,1]]; // C-G
        _lines pushBack[_bounds select 3, _bounds select 7, [0,0,1,1]]; // D-H

        _lines apply {
            drawLine3D[_x select 0, _x select 1, _x select 2, 40];
        };
    };
}];
#endif

GVAR(marker) = createMarkerLocal[hashValue _vehicle, [0,0,0]];
#ifndef __A3OVG_PRODUCTION__
GVAR(marker) setMarkerAlphaLocal 0;
#endif

INFO_1("%1: placement loop starting",QFUNC(playerPlaceVehicle));
waitUntil { (isNil QGVAR(placeVehicle)) || { isNull GVAR(placeVehicle) } };
INFO_1("%1: placement loop ended",QFUNC(playerPlaceVehicle));

deleteMarker GVAR(marker);

GVAR(validPlacement) = GVAR(validPlacement) && { !GVAR(placementAbort) };

removeMissionEventHandler["EachFrame", GVAR(eachFrameEH_Preview)];
removeMissionEventHandler["EachFrame", GVAR(eachFrameEH_Debug)];
_events apply { _display displayRemoveEventHandler _x };

private _position = getPosATL _vehicle;
private _vectorDirAndUp = [vectorDir _vehicle, vectorUp _vehicle];

if (_canDelete || { !GVAR(validPlacement) }) then {
    attachedObjects _vehicle apply { deleteVehicle _x };
    deleteVehicle _vehicle;
};

if !GVAR(validPlacement) then {
    INFO_1("%1: placement aborted",QFUNC(playerPlaceVehicle));

    if assert(_parameters get "callbackAbort" params[["_callbackCode", nil, [{}]], ["_callbackParams", nil, [[]]]]) then {
        [_vehicleClass, _callbackParams] call _callbackCode;
    };
} else {
    INFO_1("%1: placement confirmed",QFUNC(playerPlaceVehicle));

    if assert(_parameters get "callbackPlaced" params[["_callbackCode", nil, [{}]], ["_callbackParams", nil, [[]]]]) then {
        [_vehicle, _position, _vectorDirAndUp, _callbackParams] call _callbackCode;
    };
};

nil;
