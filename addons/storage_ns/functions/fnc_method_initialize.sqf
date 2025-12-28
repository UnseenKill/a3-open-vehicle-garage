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

private _storage = profileNamespace getVariable(_self get "_nsKey");

if (!(isNil "_storage") && { !(_storage isEqualType createHashMap) }) then {
    WARNING_2("profile namespace key %1 is occupied by non-hashmap data, overwriting %2",str(_self get "_nsKey"),RETNIL(_storage));
    _storage = nil;
};

if (isNil "_storage") then {
    INFO_1("profile namespace is uninitialized for storage_ns, creating new hashmap at %1",str(_self get "_nsKey"));
    _storage = createHashMap;
    profileNamespace setVariable[_self get "_nsKey", _storage];
};

nil;
