#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_getUUID

Description:
    Return UUID

Parameters:

Optional:

Example:
    (begin example)
    private _uuid = _vehicle call["getUUID", []];
    (end example)

Returns:
    <STRING> - Vehicle UUID

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(method_getUUID);

_self get "_uuid";
