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

if !(_show) exitWith {};

private _data = _display getVariable QGVAR(toc) get _uuid;

if !assert(!isNil "_data") exitWith {};

private _class = _data get "class";
private _config = configFile >> "CfgVehicles" >> _class;

if !assert(isClass _config) exitWith {};

// Vehicle display name
private _displayName = [];

if (isText(_config >> "picture") && { getText(_config >> "picture") isNotEqualTo "" }) then {
    _displayName pushBack image getText(_config >> "picture");
    _displayName pushBack parseText "&#160;";
};

_displayName pushBack parseText format["<t size='1.75'>%1</t>", getText(_config >> "displayName")];

// Vehicle attribution
private _info = [_config] call EFUNC(util,getClassModInfo);
private _credit = [];

_credit = [parseText format["<t size='1.33'>%1&#160;</t>", LLSTRING(GarageDialog_PreviewCredit_Label)]];

if (isNil { _info get "logo" }) then {
    _controls get "previewVehiclePicture" ctrlShow false;
} else {
    _controls get "previewVehiclePicture" ctrlShow true;
    _controls get "previewVehiclePicture" ctrlSetText(_info get "logo");
};

_credit pushBack parseText format["<t size='1.33'>%1</t>", _info get "author"];

// Vehicle dynamic info
[_controls get "previewVehicleTextHost", _uuid] call FUNC(dialogCreateVehicleDynamicInfo);

// Update UI
_controls get "previewVehicleName" ctrlSetStructuredText composeText _displayName;
_controls get "previewVehicleCredit" ctrlSetStructuredText composeText _credit;
_controls get "previewVehicleEditorPreview" ctrlSetText getText(_config >> "editorPreview");

nil;
