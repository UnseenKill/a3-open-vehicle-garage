#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTreeOnSelChanged

Description:
    Event handler function called when the selection in the vehicle tree view
    changes. Updates the vehicle details display accordingly.

Parameters:
    0: _treeView - Tree view control <CONTROL>
    1: _selectionPath - Array of selected nodes <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogTreeOnSelChanged),_display);

if !assert(params[
    ["_treeView", nil, [controlNull]],
    ["_selectionPath", nil, [[]]]
]) exitWith {};

private _controls = _display getVariable QGVAR(controls);
private _uuid = _treeView tvData _selectionPath;
private _show = (count _selectionPath > 1) && { _uuid isNotEqualTo "" };

_controls get "previewVehiclePicture" ctrlShow _show;
_controls get "previewVehicleName" ctrlShow _show;
_controls get "previewVehicleCredit" ctrlShow _show;
_controls get "previewVehicleEditorPreview" ctrlShow _show;
_controls get "previewVehicleTextHost" ctrlShow _show;

if !(_show) exitWith {
    [A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, []] call CBA_fnc_localEvent;
    [false, false] call FUNC(dialogUpdateUI);
};

private _vehicle = _display getVariable QGVAR(vehicles) get _uuid;
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

[A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, [_vehicle]] call CBA_fnc_localEvent;
[true] call FUNC(dialogUpdateUI);

nil;
