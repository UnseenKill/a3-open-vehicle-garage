#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTabCustomizeOnActivate

Description:
    Function called when the Customize Tab is activated. Sets up necessary data
    and UI elements.

Parameters:
    0: _tabHostCtrl - Tab host control <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogTabCustomizeOnActivate),_display);

if !assert(params[
    ["_tabHostCtrl", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _tabHostCtrl) exitWith {};

// This event is not for us.
if (IDC_RSCGARAGEDIALOG_GROUP_TAB_CUSTOMIZE isNotEqualTo ctrlIDC _tabHostCtrl) exitWith {};

private _controls = _display getVariable QGVAR(controls);
private _camera = if !(isNil { uiNamespace getVariable QGVAR(cameraPiP) }) then {
    uiNamespace getVariable QGVAR(cameraPiP);
} else {
    private _cam = "camera" camCreate[0,0,0];
    private _light = "#lightpoint" createVehicleLocal[0,0,0];

    _light setLightColor[1,1,1];
    _light setLightBrightness 1.5;
    _light setLightAmbient[1,1,1];
    _light setLightDayLight true;
    _light lightAttachObject[_cam, [0,0,0]];

    _cam cameraEffect ["internal", "back", "rtt"];
    "rtt" setPiPEffect [0];

    _controls get "customizePicPip" ctrlSetText "#(argb,512,512,1)r2t(rtt,1.0)";

    _cam;
};

uiNamespace setVariable[QGVAR(cameraPiP), _camera];

[] call FUNC(dialogTabCustomizeUpdatePreview);

nil;
