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
    <BOOL>

Scope:
    Client

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(openGarage),_this);

A3OVG_VERIFY_CONFIG();

if (!(["canOpenGarage", [player]] call EFUNC(core,runCallback))) exitWith {
    ["showHint", [localize LSTRING(OpenGarageDenied)]] call EFUNC(core,runCallback);
    false;
};

createDialog QEGVAR(ui,dialog);

true;
