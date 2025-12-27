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

[
    ["#base", [] call A3OVG_storage_fnc_storageAdapterBase], 
    ["#type", QADDON]
];
