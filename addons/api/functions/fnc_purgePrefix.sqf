#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_fnc_purgePrefix

Description:
    Delete saved data with a specific prefix from the garage storage.

Parameters:

Optional:
    0: _prefix - The prefix of the data to be deleted <STRING>

Example:
    (begin example)
    // Delete all data with no prefix
    [] call A3OVG_fnc_purgePrefix;

    // If prefixes are enabled (set), delete all data with the prefix "prefix"
    ["prefix"] call A3OVG_fnc_purgePrefix;
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNCMAIN(purgePrefix));
A3OVG_VERIFY_SERVER();

private _prefix = param[0, nil, [""]];

LOG_1("Purging garage data with prefix: %1.",RETDEF(_prefix,"N/A"));

private _storage = [] call EFUNC(core,getStorage);
_storage call["purge", [_prefix]];

nil;
