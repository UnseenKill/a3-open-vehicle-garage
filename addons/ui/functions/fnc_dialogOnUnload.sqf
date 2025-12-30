#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnUnload

Description:
    Handler function called when the Garage Dialog is unloaded/closed.

Parameters:
    0: _display - Dialog unloaded <DISPLAY>
    1: _exitCode - Closing code <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(dialogOnUnload),_this);

INFO("Garage Dialog unloading. Cleaning UI namespace.");

uiNamespace setVariable [QGVAR(dialog), nil];
uiNamespace setVariable [QGVAR(dialogControls), nil];
uiNamespace setVariable [QGVAR(toc), nil];

nil;
