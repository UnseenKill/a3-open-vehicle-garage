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

saveProfileNamespace;

nil;
