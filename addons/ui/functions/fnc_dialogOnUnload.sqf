#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnUnload

Description:
    Handler function called when the Garage Dialog is unloaded/closed.

Parameters:
    0: _display - Dialog unloaded <DISPLAY>
    1: _exitCode - Closing code <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(dialogOnUnload),_this);

INFO("Garage Dialog unloading. Cleaning UI namespace.");

uiNamespace setVariable [QGVAR(dialog), nil];

private _camera = uiNamespace getVariable QGVAR(cameraPiP);
if !(isNil "_camera") then {
    TRACE_1(QFUNC(dialogOnUnload),_camera);
    _camera cameraEffect["terminate", "back"];
    camDestroy _camera;
    uiNamespace setVariable[QGVAR(cameraPiP), nil];
};

private _vehicle = uiNamespace getVariable[QGVAR(previewVehicle), objNull];
if !isNull _vehicle then {
    TRACE_1(QFUNC(dialogOnUnload),_vehicle);
    deleteVehicle _vehicle;
    uiNamespace setVariable[QGVAR(previewVehicle), nil];
};

nil;
