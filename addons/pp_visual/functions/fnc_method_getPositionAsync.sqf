#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_visual_fnc_method_getPositionAsync

Description:
    Asynchronously gets the position of the vehicle being placed and passes it
    to the provided callback.

Parameters:
    0: _callback - Callback code receiving calculated position <CODE>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getPositionAsync);

if !assert(params[
    ["_callback", nil, [{}]]
]) exitWith {};

nil;
