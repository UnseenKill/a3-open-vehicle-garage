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

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(openGarage),_this);

if ([] call EFUNC(core,verifyConfig)) then {
    createDialog QEGVAR(ui,dialog);
};

nil;
