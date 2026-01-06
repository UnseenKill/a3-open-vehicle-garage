#include "..\script_component.hpp"
#include "..\ui_define.hpp"
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

_tabHostCtrl controlsGroupCtrl IDC_RSCGARAGEDIALOG_TEXT_TAB_PREVIEW_PIPDISABLED ctrlShow !isPiPEnabled;
_tabHostCtrl controlsGroupCtrl IDC_RSCGARAGEDIALOG_PIC_TAB_PREVIEW_PIP ctrlShow isPiPEnabled;
_tabHostCtrl controlsGroupCtrl IDC_RSCGARAGEDIALOG_PIC_TAB_PREVIEW_PIP setVariable[QGVAR(camera), [30, 20, 1.15]];

nil;
