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
TRACE_1(QFUNC(storageAdapter),_this);

createHashMapFromArray[
    ["#type", [QADDON]],
    ["#base", QUOTE(DOUBLES(PREFIX,storage))],
    ["#flags", ["sealed", "unscheduled"]],

    // Properties
    ["_dbi", nil],

    METHOD_DEFINE_NAME(#create,CTOR),
    METHOD_DEFINE_BODY(commitChanges,nil),
    METHOD_DEFINE(deleteKey),
    METHOD_DEFINE_BODY(getPrefixSeparator,QUOTE(_)),
    METHOD_DEFINE(readKey),
    METHOD_DEFINE(toStringExtra),
    METHOD_DEFINE(writeKey)
];
