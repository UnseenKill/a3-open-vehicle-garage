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
    _storage = createHashMap;
    profileNamespace setVariable[_nsKey, _storage];
};

LOG_1("using namespace key %1",str _nsKey);

if !(_self get "_autoCommit") then {
    private _tempStorageKey = _nsKey + "_temp";
    profileNamespace setVariable[_tempStorageKey, +_storage];
    _self set["_nsKeyTemp", _tempStorageKey];
    LOG_1("autoCommit disabled, using temporary storage key %1",str _tempStorageKey);
};

nil;
