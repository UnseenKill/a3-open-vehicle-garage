#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_uiStackHint

Description:
    Add a hint to the current UI hint context

Parameters:
    0: _formatString - format string <STRING>

Optional:
    1..x: _args - format arguments <ANY>

Example:
    (begin example)
    ["Hello, %1", "world"] call A3OVG_fnc_uiStackHint;
    (end example)

Returns:
    <BOOL> Always `false`

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(uiStackHint));

if !assert(params[
    ["_formatString", "", [""]]
]) exitWith { false };

if (EGVAR(ui,context) isEqualTo []) exitWith {
    ERROR_1("uiStackHint called with empty context stack for %1",_this);
    false;
};

(EGVAR(ui,context) select -1) pushBack (format _this);

false;
