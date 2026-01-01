#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTabOverviewOnLoad

Description:
    Event handler function called when the Overview tab is loaded.

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
A3OVG_UI_FUNCTION_PREAMBLE_WAIT_FOR_DISPLAY(QFUNC(dialogTabOverviewOnLoad),_display);

if !assert(params[
    ["_tabHostCtrl", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _tabHostCtrl) exitWith {};

[A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, {
    A3OVG_UI_FUNCTION_PREAMBLE(A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED,_display);

    private _vehicle = _display getVariable QGVAR(vehicle);
    if (isNil "_vehicle") exitWith {};

    private _uuid = _vehicle call["getUUID", []];
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
}] call FUNC(subscribeToEvent);

nil;
