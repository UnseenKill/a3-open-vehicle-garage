#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_userActionOpenGarageAdd

Description:
    Add user action to open garage to any object

Parameters:
    0: _object - Object to which the user action will be added <OBJECT>

Optional:
    1: _priority - Priority of the action <SCALAR> (default: 6)
    2: _range - Range of the action <SCALAR> (default: 15)

Example:
    (begin example)
    [building1] call A3OVG_fnc_userActionOpenGarageAdd;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(userActionOpenGarageAdd),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

_this deleteAt 0;
params[
    ["_priority", 6, [0]],
    ["_range", 15, [0]]
];

[_object] call FUNCMAIN(userActionOpenGarageRemove);

private _actionId = _object addAction[
    "",
    QUOTE(call FUNCMAIN(openGarage)),
    nil,
    _priority,
    true,
    true,
    "",
    QUOTE(isNull objectParent _this && {[ARR_2(QQUOTE(canGarageOpen),[ARR_2(_this,_target)])] call EFUNC(core,runCallback)}),
    _range
];

_object setUserActionText[
    _actionId,
    LELSTRING(UI,OpenGarageUA),
    "<img size='2' image='\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa' /> " + LELSTRING(UI,OpenGarageUA)
];

_object setVariable[QGVAR(userActionOpenGarageId), _actionId, true];
EGVAR(core,garageObjects) pushBackUnique _object;

nil;
