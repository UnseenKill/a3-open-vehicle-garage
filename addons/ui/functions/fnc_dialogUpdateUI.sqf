#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogUpdateUI

Description:
    Updates the vehicle dialog UI elements based on the current state.

Parameters:
    0: _isUiAvailable - Whether to lock UI <BOOL>

Optional:
    1: _hardLock - Lock the tree control, too <BOOL> Default: false

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogUpdateUI),_display);

#define APPLY_LOCK() if true then { \
    allControls _hostCtrl select { ctrlType _x in[CT_ACTIVETEXT, CT_BUTTON] } apply { \
        _x ctrlEnable !(_isLocked); \
    }; \
}

if !assert(params[
    ["_isUiAvailable", nil, [false]]
]) exitWith {};

private _hardLock = param[1, false, [true]];
private _controls = _display getVariable QGVAR(controls);
private _vehicle = _display getVariable QGVAR(vehicle);
private _haveSelection = !(isNil "_vehicle");
private ["_hostCtrl","_isLocked"];

// Buttons below the vehicle tree
_hostCtrl = _controls get "hostGrpButtons";
_isLocked = !_isUiAvailable || { !_haveSelection };

APPLY_LOCK();

// Select button
if (!_isLocked && { _vehicle call["isLocked", []] }) then {
    _hostCtrl = _controls get "btnSelect";
    _hostCtrl ctrlEnable false;
};

// Mini buttons above the vehicle tree
_hostCtrl = _controls get "hostGrpMiniButtons";
_isLocked = !_isUiAvailable || { !_haveSelection };

APPLY_LOCK();

// Tab selection buttons
_hostCtrl = _controls get "hostGrpTabButtons";
_isLocked = !_isUiAvailable || { !_haveSelection };

APPLY_LOCK();

// Tree control
_hostCtrl = _controls get "treeView";
_isLocked = !_isUiAvailable && { _hardLock };

_hostCtrl ctrlEnable !(_isLocked);

// Update lock button and mini-button text according to vehicle selection
private _label = [LSTRING(GarageDialog_BtnLock_Label), LSTRING(GarageDialog_BtnUnlock_Label)] select(
    !(isNil "_vehicle") && { _vehicle call["isLocked", []] }
);

_display displayCtrl IDC_RSCGARAGEDIALOG_BTN_LOCK ctrlSetText localize _label;
_display displayCtrl IDC_RSCGARAGEDIALOG_BTN_MINI_LOCK ctrlSetTooltip localize _label;

nil;
