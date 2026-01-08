#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_purge

Description:
    Purges items from storage based on defined criteria.

Parameters:

Optional:
    0: _prefix - Optional prefix <STRING>

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(purge);
A3OVG_VERIFY_SERVER();

private _prefix = param[0, nil, [""]];
private _keys = _self call["getSectionKeys", [SECTION_TOC, _self get "_storagePrefix"]];

_keys apply {
    TRACE_1(QFUNC(method_purge),_x);

    _self call["removeKey", [SECTION_TOC, _x]];
    _self call["removeVehicle", [_x]];
};

_self call["commit", []];

nil;
