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
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogSwitchToTab),_display);

if !assert(params[
    ["_idcTabHostCtrl", nil, [0]]
]) exitWith {};

private _tabHostCtrl = _display displayCtrl _idcTabHostCtrl;
if !assert(!isNull _tabHostCtrl) exitWith {};

private _onActivateCallback = _tabHostCtrl getVariable[QGVAR(onActivateCallback), {}];
private _canSwitch = [_tabHostCtrl] call _onActivateCallback;

if (!isNil "_canSwitch" && { _canSwitch isEqualTo false }) exitWith {
    INFO("Tab switch prevented by onActivateCallback.");
};

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

nil;
