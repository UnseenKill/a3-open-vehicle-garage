#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogSwitchToTab

Description:
    Switches the active tab within a dialog's tab host control.

Parameters:
    0: _idcTabHostCtrl - IDC of the tab host control <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogSwitchToTab),_display);
A3OVG_MAKE_SCHEDULED(FUNC(dialogSwitchToTab));

if !assert(params[
    ["_idcTabHostCtrl", nil, [0]]
]) exitWith {};

private _tabHostCtrl = _display displayCtrl _idcTabHostCtrl;
if !assert(!isNull _tabHostCtrl) exitWith {};

private _canSwitch = try {
    [A3OVG_EVENT_UI_DIALOG_TABCHANGED_BEFORE, [_tabHostCtrl]] call CBA_fnc_localEvent;
    true;
} catch {
    INFO("Tab switch prevented by onActivateCallback.");
    false;
};

if !(_canSwitch) exitWith {};

private _controls = _display getVariable QGVAR(controls);

allControls (_controls get "tabHost") 
    select {
        (ctrlType _x isEqualTo CT_CONTROLS_GROUP) &&
        { _x getVariable[QGVAR(isMainTabhost), false] }
    } apply {
        _x setVariable[QGVAR(isActiveTab), (_x isEqualTo _tabHostCtrl)];
        _x ctrlSetFade(parseNumber(_x isNotEqualTo _tabHostCtrl));
        _x ctrlCommit 0.25;
    };

waitUntil { ctrlCommitted _tabHostCtrl };
[A3OVG_EVENT_UI_DIALOG_TABCHANGED_AFTER, [_tabHostCtrl]] call CBA_fnc_localEvent;

nil;
