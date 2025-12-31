#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTreeOnExpanded

Description:
    Event handler function called when a node in the vehicle tree view is
    expanded. Initiates loading of vehicle data for the expanded category.

Parameters:
    0: _treeView - Tree view <CONTROL>
    1: _selectionPath - selected node path <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogTreeOnExpanded),_display);

if !assert(params[
    ["_treeView", nil, [controlNull]],
    ["_selectionPath", nil, [[]]]
]) exitWith {};

private _category = _treeView tvData _selectionPath;

if !(_category in(_treeView getVariable QGVAR(loading))) then {
    _treeView getVariable QGVAR(loading) set[_category, _treeView tvText _selectionPath];
    [_treeView, _selectionPath, _category] call FUNC(dialogFetchCategory);
    TRACE_1("loading",_treeView getVariable QGVAR(loading));
};

nil;
