#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogSetLoading

Description:
    Sets the loading state of the Garage Dialog, enabling or disabling UI elements
    as necessary.

Parameters:
    0: _isLoading - Whether the dialog is in a loading state <BOOL>

Optional:
    1: _idcTabActivate - IDC of the tab to activate after loading <SCALAR>
        Default: -1 (no tab change)

Example:
    (begin example)
    [true] call A3OVG_ui_fnc_dialogSetLoading;
    [false, IDC_RSCGARAGEDIALOG_TAB_TO_CHANGE] call A3OVG_ui_fnc_dialogSetLoading;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogSetLoading),_display);

if !assert(params[
    ["_isLoading", nil, [false]]
]) exitWith {};

private _idcTabActivate = param[1, -1, [0]];

private _controls = _display getVariable QGVAR(controls);
private _mainGroup = _controls get "mainGroup";
private _tabHost = _controls get "tabHost";

[!_isLoading, true] call FUNC(dialogUpdateUI);

private _tabs = allControls _tabHost select { ctrlType _x isEqualTo CT_CONTROLS_GROUP };
private _active = _tabs findIf { 
    if (_isLoading) then {
        _x getVariable[QGVAR(isActiveTab), false] isEqualTo true;
    } else {
        [ctrlIDC _x isNotEqualTo IDC_RSCGARAGEDIALOG_GROUP_TAB_WAIT, ctrlIDC _x isEqualTo _idcTabActivate] select(_idcTabActivate != -1);
    };
};

if (_isLoading) then {
    [A3OVG_EVENT_UI_PUSHSTATUS, [LLSTRING(GarageDialog_Status_Loading), false, 0]] call CBA_fnc_localEvent;
} else {
    [A3OVG_EVENT_UI_PUSHSTATUS, [LLSTRING(GarageDialog_Status_Ready), false, 0]] call CBA_fnc_localEvent;
};

(_tabs select 0) ctrlSetFade([1, 0] select _isLoading);
(_tabs select 0) ctrlCommit 0.25;

if (_active != -1) then {
    (_tabs select _active) ctrlSetFade([0, 1] select _isLoading);
    (_tabs select _active) ctrlCommit 0.25;
    (_tabs select _active) setVariable[QGVAR(isActiveTab), !_isLoading];
};

nil;
