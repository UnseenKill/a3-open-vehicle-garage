#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_commitChanges

Description:
    Write changes to profile namespace.

Parameters:

Optional:

Example:
    (begin example)
    _storage call["commitChanges", []];
    (end example)

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(commitChanges);

if !(_self get "_autoCommit") then {
    private _nsKey = _self get "_nsKey";
    private _nsKeyTemp = _self get "_nsKeyTemp";

    private _tempStorage = profileNamespace getVariable _nsKeyTemp;
    profileNamespace setVariable[_nsKey, +_tempStorage];

    LOG_2("committed changes from temporary storage %1 to main storage %2",str _nsKeyTemp,str _nsKey);
};

saveProfileNamespace;

nil;
