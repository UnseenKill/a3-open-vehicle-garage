#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnTreeSelChanged

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
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogOnTreeSelChanged),_display);

if !assert(params[
    ["_treeView", nil, [controlNull]],
    ["_selectionPath", nil, [[]]]
]) exitWith {};

private _controls = uiNamespace getVariable QGVAR(dialogControls);
private _uuid = _treeView tvData _selectionPath;
private _show = (count _selectionPath > 1) && { _uuid isNotEqualTo "" };

_controls get "previewVehiclePicture" ctrlShow _show;
_controls get "previewVehicleName" ctrlShow _show;
_controls get "previewVehicleCredit" ctrlShow _show;
_controls get "previewVehicleEditorPreview" ctrlShow _show;
_controls get "previewVehicleTextHost" ctrlShow _show;

if !(_show) exitWith {
    TRACE_1("check",_uuid);
};

private _data = uiNamespace getVariable QGVAR(toc) get _uuid;

if !assert(!isNil "_data") exitWith {};

private _class = _data get "class";
private _config = configFile >> "CfgVehicles" >> _class;

if !assert(isClass _config) exitWith {};

private _info = [_config] call EFUNC(util,getClassModInfo);
private _credit = [];

_credit = [parseText "<t size='1.33'>By:&#160;</t>"];

if !(isNil { _info get "logo" }) then {
    _credit pushBack image(_info get "logo");
    _credit pushBack parseText "&#160;";
};

_credit pushBack parseText format["<t size='1.33'>%1</t>", _info get "author"];

_controls get "previewVehiclePicture" ctrlSetText getText(_config >> "picture");
_controls get "previewVehicleName" ctrlSetText getText(_config >> "displayName");
_controls get "previewVehicleCredit" ctrlSetStructuredText composeText _credit;
_controls get "previewVehicleEditorPreview" ctrlSetText getText(_config >> "editorPreview");

nil;
