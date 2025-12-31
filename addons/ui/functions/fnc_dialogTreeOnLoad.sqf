#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTreeOnLoad

Description:
    Function called when the vehicle tree control in the Garage Dialog is loaded.
    Sets up necessary data and event handlers.

Parameters:
    0: _treeView - Tree control <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(dialogTreeOnLoad),_this);
A3OVG_MAKE_SCHEDULED(FUNC(dialogTreeOnLoad));

waitUntil { !dialog || { !isNull(uiNamespace getVariable[QGVAR(dialog), displayNull]) } };

A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogTreeOnLoad),_display);

if !assert(params[
    ["_treeView", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _treeView) exitWith {};

// Keeps track of categories being loaded
_treeView setVariable[QGVAR(loading), createHashMap];
// Keeps track of categories already loaded
_treeView setVariable[QGVAR(loaded), createHashMap];

_treeView ctrlAddEventHandler["TreeExpanded", { call FUNC(dialogTreeOnExpanded) }];
_treeView ctrlAddEventHandler["TreeSelChanged", { call FUNC(dialogTreeOnSelChanged) }];

nil;
