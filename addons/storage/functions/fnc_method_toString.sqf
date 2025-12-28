#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_toString

Description:
    Convert storage adapter to string representation.

Parameters:

Optional:

Example:
    (begin example)
    private _string = _storage call["toString", []];
    (end example)

Returns:
    <STRING> String representation of storage adapter.

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(#str);

private _extra = _self call["toStringExtra", []];

format["%1<%2>", THIS_CLASS, _extra];
