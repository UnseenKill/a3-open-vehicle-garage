#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_ns_fnc_storageAdapter

Description:
    Storage adapter implementation for namespace storage backend.

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
TRACE_1(QFUNC(storageAdapter),_this);

createHashMapFromArray[
    ["#type", [QADDON]],
    ["#base", QUOTE(DOUBLES(PREFIX,storage))],
    ["#flags", ["sealed", "unscheduled"]],

    // Properties
    ["_nsKey", QUOTE(ADDON)],
    ["_nsKeyTemp", nil],

    // Methods
    METHOD_DEFINE_NAME(#delete,DTOR),
    METHOD_DEFINE(commitChanges),
    METHOD_DEFINE(deleteKey),
    METHOD_DEFINE(getStorage),
    METHOD_DEFINE_BODY(getPrefixSeparator,QUOTE(_)),
    METHOD_DEFINE(initialize),
    METHOD_DEFINE(readKey),
    METHOD_DEFINE(writeKey)
];
