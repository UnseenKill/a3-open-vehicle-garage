#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_getVehicleTOC

Description:
    Retrieves the Table of Contents (TOC) for vehicles.

Parameters:

Optional:

Example:
    (begin example)
    private _toc = _storage call["getVehicleTOC", []];
    (end example)

Returns:
    <HASHMAP> - A hashmap representing the vehicle TOC (UUID -> <HASHMAP>).

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getVehicleTOC);
A3OVG_VERIFY_SERVER();

private _keys = _self call["getSectionKeys", [SECTION_TOC, _self get "_storagePrefix"]];

createHashMapFromArray(_keys apply {
    [_x, _self call["read", [SECTION_TOC, _self call["getKey", [_x]]]]];
});
