#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogCustomizeUpdatePreview

Description:
    Update customization preview with currently selected vehicle and customization.

Parameters:
    0: _vehicle - Vehicle object to update preview for <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogCustomizeUpdatePreview),_display);

if !assert(params[
    ["_vehicle", nil, [createHashMap]]
]) exitWith {};

if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};
if (isNil { uiNamespace getVariable QGVAR(cameraPiP) }) exitWith {};

private _camera = uiNamespace getVariable QGVAR(cameraPiP);
private _controls = _display getVariable QGVAR(controls);
private _previewVehicle = uiNamespace getVariable[QGVAR(previewVehicle), objNull];

if !isNull(_previewVehicle) then {
    deleteVehicle _previewVehicle;
    uiNamespace setVariable[QGVAR(previewVehicle), nil];
};

private _data = _vehicle get "_serialized";

if !assert((!isNil "_data") && { _data isEqualType createHashMap}) exitWith {};

_previewVehicle = (_data get "class") createVehicleLocal[0,0,0];
_previewVehicle enableSimulation false;
_previewVehicle allowDamage false;
_previewVehicle setPosASL[0, 0, 100000];
_previewVehicle setVectorUp[0, 0, 1];
([_previewVehicle] + (_data get "custom")) call BIS_fnc_initVehicle;

uiNamespace setVariable[QGVAR(previewVehicle), _previewVehicle];

_controls get "customizePicPip" getVariable QGVAR(camera) params[
    ["_viewX", nil, [0]],
    ["_viewY", nil, [0]],
    ["_viewDist", nil, [0]]
];

private _bb = 0 boundingBoxReal _previewVehicle;
private _pos = [[(_bb select 2) * _viewDist, 0, 0], _viewY, 1] call BIS_fnc_rotateVector3D;
_pos = [_pos, _viewX] call BIS_fnc_rotateVector2D;
_pos = _previewVehicle modelToWorldWorld _pos;

_camera setPosWorld _pos;
_camera camSetTarget getPos _previewVehicle;
_camera camCommit 0;

nil;
