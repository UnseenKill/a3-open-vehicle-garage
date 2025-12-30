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

nil;
