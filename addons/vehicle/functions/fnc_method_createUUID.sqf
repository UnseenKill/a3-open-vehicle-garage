#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_createUUID

Description:
    Create unique vehicle identifier.

Parameters:

Optional:

Example:
    (begin example)
    _vehicle call["createUUID", []];
    (end example)

Returns:
    <STRING>

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(createUUID);

[] call CBA_fnc_createUUID;
