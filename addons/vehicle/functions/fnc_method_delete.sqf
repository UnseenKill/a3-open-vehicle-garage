#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_delete

Description:
    Delete the vehicle from storage.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(delete);

if (hasInterface) then {
    [_self call["getUUID", []]] remoteExecCall[QFUNC(delete), 2];
} else {
    [_self call["getUUID", []]] call FUNC(delete);
};

nil;
