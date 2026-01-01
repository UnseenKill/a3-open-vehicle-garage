#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogRegisterTabHostCtrl

Description:
    Registers a tab host control within the Garage Dialog for tab switching.

Parameters:
    0: _tabHostCtrl - Tab host control <CONTROL>
    1: _onLoadCallback - On activate callback <CODE>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE_WAIT_FOR_DISPLAY(QFUNC(dialogRegisterTabHostCtrl),_display);

if !assert(params[
    ["_tabHostCtrl", nil, [controlNull]],
    ["_onLoadCallback", nil, [{}]]
]) exitWith {};
if !assert(!isNull _tabHostCtrl) exitWith {};

_tabHostCtrl setVariable[QGVAR(isMainTabhost), true];
[_tabHostCtrl] call _onLoadCallback;

nil;
