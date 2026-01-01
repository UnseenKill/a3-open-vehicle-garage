#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_isLocked

Description:
    Check if vehicle is locked.

Parameters:

Optional:

Example:
    (begin example)
    _vehicle call["isLocked", []];
    (end example)

Returns:
    <BOOL> - true if locked, false otherwise

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(isLocked);

!isNil { _self get "_ownerLock" };
