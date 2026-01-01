#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTabCustomizeOnLoad

Description:
    Event handler function called when the Customize tab is loaded.

Parameters:
    0: _tabHostCtrl - Tab host control <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE_WAIT_FOR_DISPLAY(QFUNC(dialogTabCustomizeOnLoad),_display);

if !assert(params[
    ["_tabHostCtrl", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _tabHostCtrl) exitWith {};

[A3OVG_EVENT_UI_DIALOG_TABCHANGED_BEFORE, { call FUNC(dialogTabCustomizeOnActivate) }] call FUNC(subscribeToEvent);
[A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED, { [] call FUNC(dialogTabCustomizeUpdatePreview) }] call FUNC(subscribeToEvent);

nil;
