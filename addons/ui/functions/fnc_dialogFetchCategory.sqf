#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogFetchCategory

Description:
    Function to fetch vehicle data for all vehicles in a given category from
    the server when a category node is expanded in the vehicle tree view.

Parameters:
    0: _treeView - Tree view control <CONTROL>
    1: _selectionPath - selected node path <ARRAY>
    2: _category - category name <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogFetchCategory),_display);

if !assert(params[
    ["_treeView", nil, [controlNull]],
    ["_selectionPath", nil, [[]]],
    ["_category", nil, [""]]
]) exitWith {};

private _count = _treeView tvCount _selectionPath;

if (_count == 0) exitWith {};

_treeView tvSetText[_selectionPath, format[LLSTRING(GarageDialog_Status_CategoryLoading), _treeView getVariable QGVAR(loading) get _category]];

private _vehicleUUIDs = [];
for "_n" from 0 to (_count - 1) do {
    private _childPath = _selectionPath + [_n];
    private _uuid = _treeView tvData _childPath;
    if (_uuid isNotEqualTo "") then {
        _vehicleUUIDs pushBack _uuid;
    };
};

[_vehicleUUIDs, _treeView, _selectionPath, _category] spawn FUNC(triggerServerLoadUUIDs);

nil;
