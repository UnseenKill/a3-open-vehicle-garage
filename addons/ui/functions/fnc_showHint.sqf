#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_showHint

Description:
    Show a hint to the player via callback.

    Pops the UI context stack explicitly; no need to call A3OVG_UI_POP_CONTEXT
    afterwards.

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
A3OVG_GET_CONFIG(_config);

if !assert(params[
    ["_formatText", nil, [""]]
]) exitWith {};

private _stacked = if (GVAR(context) isNotEqualTo []) then {
    A3OVG_UI_POP_CONTEXT();
} else {
    WARNING("UI context stack underflow");
    [];
};

private _hints = if A3OVG_FEATURE_ENABLED(_config,uiHintsCollapse) then {
    [flatten[
        format _this,
        _stacked
    ] joinString "<br/>"]
} else {
    private _strings = [format _this] + _stacked;
    if A3OVG_FEATURE_ENABLED(_config,uiHintsUncollapsedLIFO) then {
        reverse _strings;
    };

    _strings;
};

_hints apply {
    ["uiShowHint", [_x]] call EFUNC(core,runCallback);
};

nil;
