#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_showHintSingle

Description:
    Shows a single hint message on the screen.

    Does not queue multiple hints, unlike A3OVG_ui_fnc_showHint.

Parameters:
    0: _formatText - String to use with `format` <STRING>

Optional:
    1..x: ... - Additional parameters for `format` <ANY>

Example:
    (begin example)
    ["Hello, %1", "world"] call A3OVG_ui_fnc_showHint;
    (end example)

Returns:
    Nothing

Environment:
    Client,Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(showHintSingle));

if !assert(params[
    ["_formatText", nil, [""]]
]) exitWith {};

["uiShowHint", [format _this]] call EFUNC(core,runCallback);

nil;
