#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_openGarage

Description:
    Open garage

Parameters:

Optional:

Example:
    (begin example)
    [] call A3OVG_fnc_openGarage;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(openGarage));

if !assert(hasInterface) exitWith {};

if !(["canGarageOpen", [player]] call EFUNC(core,runCallback)) then {
    ["showHint", [localize ELSTRING(UI,OpenGarageDenied)]] call EFUNC(core,runCallback);
} else {
    [CBA_EVENT_GARAGE_OPEN_BEFORE, [player]] call CBA_fnc_localEvent;
    createDialog QEGVAR(ui,dialog);
    [CBA_EVENT_GARAGE_OPEN_AFTER, [player]] call CBA_fnc_localEvent;
};

true;
