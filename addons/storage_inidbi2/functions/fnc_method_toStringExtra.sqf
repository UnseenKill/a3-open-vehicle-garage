#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_toStringExtra

Description:
    Provide extra details for stringification.

Parameters:

Optional:

Example:
    (begin example)
    private _extras = _storage call["toStringExtra", []];
    (end example)

Returns:
    <ARRAY> Extra information for string representation.

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(toStringExtra);

[["dbi", !isNil {_self get "dbi"}]];
