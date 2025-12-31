#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnUpdateTOC

Description:
    Populate vehicle list after TOC update

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogOnUpdateTOC),_display);

private _controls = _display getVariable QGVAR(controls);
private _toc = _display getVariable QGVAR(toc);
private _treeView = _controls get "treeView";

// Populate tree view with TOC data
tvClear _treeView;
private _sorted = [_toc] call EFUNC(vehicle,sortTOC);

if !assert(_sorted params[
    ["_uniqueCategories", nil, [[]]],
    ["_entries", nil, [[]]]
]) exitWith {};

private _categoryToNodeMap = createHashMap;
_uniqueCategories apply {
    private _node = _treeView tvAdd[[], _x get "displayName"];
    _treeView tvSetPicture[[_node], _x get "icon"];
    _treeView tvSetData[[_node], _x get "name"];
    _categoryToNodeMap set[_x get "name", _node];
};

_entries apply {
    if !assert(_x params[
        ["_uuid", nil, [""]],
        ["_data", nil, [createHashMap]]
    ]) exitWith {};

    private _parentNode = _categoryToNodeMap get(_data get "category");
    private _index = _treeView tvAdd[[_parentNode], _data get "displayName"];

    if isClass(configFile >> "CfgVehicles" >> (_data get "class")) then {
        _treeView tvSetData[[_parentNode, _index], _uuid];
    } else {
        _treeView tvSetColor[[_parentNode, _index], [0.5, 0.5, 0.5, 1]];
    };

    TRACE_3("TOC",_uuid,_index,_data get "displayName");
};

[_treeView, []] call FUNC(dialogTreeOnSelChanged);

nil;
