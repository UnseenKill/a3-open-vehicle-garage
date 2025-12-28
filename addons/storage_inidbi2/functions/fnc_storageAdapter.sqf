#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_storageAdapter

Description:
    Storage adapter implementation for INIDBI2 storage backend.

Parameters:

Optional:

Example:

Returns:
    <HASHMAP>

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(storageAdapter));

createHashMapFromArray[
    ["#type", [QADDON]],
    ["#base", [] call EFUNC(storage,storageAdapterBase)], 
    ["#flags", ["sealed", "unscheduled"]],

    // Properties
    ["_dbi", nil],

    METHOD_DEFINE_NAME(#create,CTOR),
    METHOD_DEFINE(deleteKey),
    METHOD_DEFINE_BODY(getPrefixSeparator,QUOTE(_)),
    METHOD_DEFINE(read),
    METHOD_DEFINE(toStringExtra),
    METHOD_DEFINE(write)
];
