#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_getStorage

Description:
    Get namespace storage backend hashmap.

Parameters:

Optional:

Example:
    (begin example)
    _storage call["getStorage", []];
    (end example)

Returns:
    <HASHMAP> Namespace storage backend

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getStorage);

private _key = ["_nsKeyTemp","_nsKey"] select(_self get "_autoCommit");

profileNamespace getVariable(_self get _key);
