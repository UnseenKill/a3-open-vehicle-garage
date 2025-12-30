#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnLoad

Description:
    Function called when the Garage Dialog is loaded. Sets up necessary data
    and UI elements.

Parameters:
    0: _display - Dialog <DISPLAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(dialogOnLoad));

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};
if !assert(!isNull _display) exitWith {};

INFO("Garage Dialog loading.");

allControls(_display displayCtrl IDC_RSCGARAGEDIALOG_GROUP_MAIN) apply {
    _x ctrlEnable false;
};

nil;
