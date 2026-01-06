#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_saveProperties

Description:
    Saves the current properties of the vehicle to the vehicle's data store.

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(saveProperties);

private _data = createHashMap;

_self call["serializeProperties", [_data]];

[_self call["getUUID", []], _data] remoteExecCall[QFUNC(saveProperties), 2];

nil;
