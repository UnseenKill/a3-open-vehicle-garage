#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_commit

Description:
    Commit any pending changes to storage backend.

Parameters:

Optional:
    0: _force - force or auto-commit (default: false) <BOOL>

Example:
    (begin example)
    _storage call["commit", [true]];
    (end example)

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(commit);

private _force = param[0, false, [true]];

if (_force || { _self get "_autoCommit" }) then {
    _self call["commitChanges", []];
};

nil;
