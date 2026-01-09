#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_sortTOC

Description:
    Sorts the vehicle Table of Contents (TOC) into a specific order for display
    in the Garage Dialog.

Parameters:
    0: _toc - Table of contents <HASHMAP> (UUID -> <HASHMAP>)

Optional:

Returns:
    <ARRAY> Sorted TOC entries as [<ARRAY-OF-UNIQUE-CATEGORIES>, [[<UUID>, <CATEGORY-HASHMAP>], ...]].

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(sortTOC));

if !assert(params[
    ["_toc", nil, [createHashMap]]
]) exitWith {};

private _filters = GVAR(categoryFilters) get "filters";
private _defaultCategory = _filters get "default";
private _categoryUnique = [];
private _temp = _toc apply {
    private _cat = _filters getOrDefault[_y get "category", _defaultCategory];
    _categoryUnique pushBackUnique [_cat get "sortOrder", _cat];
    [-(_cat get "sortOrder"), _cat get "displayName", _y get "displayName", [_x, _y]];
};

_categoryUnique sort false;
_temp sort true;
[_categoryUnique apply { _x select -1 }, _temp apply { _x select -1 }];
