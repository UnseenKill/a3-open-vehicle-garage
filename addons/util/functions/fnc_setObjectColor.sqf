#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_setObjectColor

Description:
    Changes all hidden selection textures of an object to a specified color.

    Works best on vehicles; houses seem to be immune.

Parameters:
    0: _object - The object whose hidden selection textures will be changed <OBJECT>
    1: _color - The color to apply to the object's hidden selection textures <ARRAY>
        Pass an empty array to reset to default colors.
        Format: [R,G,B,A] where R,G,B,A are values between 0 and 1

Optional:
    2: _param3 - description <TYPE>

Example:
    (begin example)
    ["param1", "param2"] call PREFIX_fnc_name;
    (end example)

Returns:
    Nothing

Environment:
    Client/Server/Both, Unscheduled/Scheduled, ...

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setObjectColor),_this);

if !assert(params[
    ["_object", nil, [objNull]],
    ["_color", nil, [true, []]]
]) exitWith {};

if (_color isEqualTo []) then {
    _color = "#reset";
};

if (_color isEqualType [] && {count _color == 4}) then {
    _color = format(["#(argb,8,8,3)color(%1,%2,%3,%4)"] + _color);
};

getArray(configOf _object >> "hiddenselections") apply {
    _object setObjectTexture [_x, _color];
};

nil;
