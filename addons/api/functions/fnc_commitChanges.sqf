#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_commitChanges

Description:
    Commits any pending changes to the garage storage.

    Calls storage adapater save function irregardless of whether delayed saves
    are supported by the adapter.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3OVG_fnc_commitChanges;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(commitChanges));
A3OVG_VERIFY_SERVER();

LOG("Committing storage changes.");

private _storage = [] call EFUNC(core,getStorage);
_storage call["commit", []];

nil;
