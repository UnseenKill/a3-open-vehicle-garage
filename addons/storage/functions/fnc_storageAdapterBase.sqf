#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_storageAdapterBase

Description:
    Return storage interface hashmap object description.

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
A3OVG_FUNCTION_PREAMBLE(QFUNC(storageAdapterBase));

#define ABSTRACT(method) \
    [#method, { throw format["abstract method %1::%2() called on base class", QADDON, #method] }]

createHashMapFromArray[
    ["#flags", ["unscheduled"]],
    ["#type", [QADDON]],
    ABSTRACT(read),
    ABSTRACT(write)
];
