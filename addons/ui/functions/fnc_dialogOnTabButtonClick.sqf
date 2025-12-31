#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnTabButtonClick

Description:
    Function called when a tab button in the Garage Dialog is clicked. Handles
    switching between different tabs.

Parameters:
    0: _button - The button clicked <CONTROL>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogOnTabButtonClick),_display);

if !assert(params[
    ["_button", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _button) exitWith {};

private _idcTabHostCtrl = _button getVariable QGVAR(idcTabHostCtrl);

if !assert(!isNil "_idcTabHostCtrl") exitWith {};

[_idcTabHostCtrl] call FUNC(dialogSwitchToTab);

nil;
