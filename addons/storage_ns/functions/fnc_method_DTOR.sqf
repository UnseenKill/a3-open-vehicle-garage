#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_DTOR

Description:
    Destructor for namespace storage backend.

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(DTOR);

if !(_self get "_autoCommit") then {
    private _nsKeyTemp = _self get "_nsKeyTemp";
    LOG_1("cleaning up temporary storage key %1",str _nsKeyTemp);
    profileNamespace setVariable[_nsKeyTemp, nil];
};

nil;
