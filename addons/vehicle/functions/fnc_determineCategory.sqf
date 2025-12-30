#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_determineCategory

Description:
    Determines the category of a vehicle based on configured filters.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:

Example:
    (begin example)
    [_vehicle] call A3OVG_vehicle_fnc_determineCategory;
    (end example)

Returns:
    <STRING> Category name

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(determineCategory));

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private _keys = GVAR(categoryFilters) get "priority";
private _index = _keys findIf {
    private _categoryData = GVAR(categoryFilters) get "filters" get _x;
    private _filters = _categoryData get "filter";

    _filters findIf { [_vehicle] call _x } != -1;
};

// There's a category to which any vehicle can default to; hence the assertion
if !assert(_index != -1) exitWith {};

_keys select _index;
