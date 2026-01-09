#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_getCategory

Description:
    Return vehicle category metadata.

Parameters:

Optional:

Example:
    (begin example)
    private _data = _vehicle call["getCategory", []];
    (end example)

Returns:
    <HASHMAP> - Vehicle category metadata

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(method_getCategory);

private _category = _self get "_category";

if (isNil "_category") exitWith {};

GVAR(categoryFilters) get "filters" get _category;
