#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_method_initialize

Description:
    Initialize namespace storage backend.

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
METHOD_PREAMBLE(initialize);

call SUPER(initialize);

private _nsKey = _self get "_nsKey";
private _storage = profileNamespace getVariable _nsKey;

if (!(isNil "_storage") && { !(_storage isEqualType createHashMap) }) then {
    WARNING_2("profile namespace key %1 is occupied by non-hashmap data, overwriting %2",str _nsKey,RETNIL(_storage));
    _storage = nil;
};

if (isNil "_storage") then {
    INFO_1("profile namespace is uninitialized for storage_ns, creating new hashmap at %1",str _nsKey);
    profileNamespace setVariable[_nsKey, createHashMap];
};

LOG_1("using namespace key %1",str _nsKey);

nil;
