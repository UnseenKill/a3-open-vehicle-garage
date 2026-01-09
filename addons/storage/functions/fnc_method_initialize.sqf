#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_initialize

Description:
    Initialize storage adapter object after construction.

Parameters:

Optional:

Example:
    (begin example)
    _storage call["initialize", []];
    (end example)

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(initialize);

_self set["_autoCommit", getNumber((_self get "_adapterConfig") >> "autoCommit") != 0];
_self set["_prefixSeparator", _self call["getPrefixSeparator", []]];

nil;
