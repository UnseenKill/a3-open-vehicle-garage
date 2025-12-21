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

Scope:
    Client

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(openGarage));

if !assert(hasInterface) exitWith {};

if (["canOpenGarage", [player]] call EFUNC(core,runCallback)) then {
    createDialog QEGVAR(ui,dialog);
} else {
    ["showHint", [localize LSTRING(OpenGarageDenied)]] call EFUNC(core,runCallback);
};

true;
