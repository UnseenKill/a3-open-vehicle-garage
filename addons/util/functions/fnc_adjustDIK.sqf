#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_adjustDIK

Description:
    Adjust DIK key code based on additional modifier keys.

    To effectively compare keycodes returned by e.g. `actionKeys`, the raw key
    code 1 for Escape for example needs to be adjusted to include modifier
    keys such as Shift, Ctrl, Alt.

Parameters:
    0: _key - DIK key code <NUMBER>
    1: _shift - Shift key pressed <BOOL>
    2: _ctrl - Ctrl key pressed <BOOL>
    3: _alt - Alt key pressed <BOOL>

Optional:

Example:
    (begin example)
    [DIK_ESCAPE, true, false, false] call A3OVG_util_fnc_adjustDIK
    // returns [1, 939524097];
    (end example)

Returns:
    <ARRAY> Adjusted DIK key codes [<NUMBER>, <NUMBER>, ...]

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params [
    ["_key", nil, [0]],
    ["_shift", nil, [true]],
    ["_ctrl", nil, [true]],
    ["_alt", nil, [true]]
]) exitWith {};

if (!_shift && { !_ctrl } && { !_alt }) exitWith { [_key] };

flatten[[[
    [_shift, 939524096],  /* L-Shift */
    [_shift, 905969664 ], /* R-Shift  */
    [_ctrl, 486539264],   /* L-Ctrl */
    [_ctrl, -1660944384], /* R-Ctrl */
    [_alt, 939524096],    /* L-Alt */
    [_alt, -1207959552 ]  /* R-Alt */
], [_key], {
    if (_x select 0) then {
        _accumulator pushBack((_accumulator select 0) + (_x select 1));
    };
    _accumulator;
}] call CBA_fnc_inject];
