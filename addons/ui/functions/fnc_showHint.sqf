#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_showHint

Description:
    Show a hint to the player via callback

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
A3OVG_FUNCTION_PREAMBLE(QFUNC(showHint));

if !assert(params[
    ["_formatText", nil, [""]]
]) exitWith {};

["showHint", _this] call EFUNC(core,runCallback);

nil;
