#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_compileCategoryFilters

Description:
    Compiles vehicle category filters from configuration.

Parameters:

Optional:

Returns:
    <HASHMAP>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(compileCategoryFilters));
A3OVG_GET_CONFIG(_config);

private _filters = createHashMapFromArray[
    ["filters", createHashMap]
];

(QUOTE(getNumber(_x >> QQUOTE(scope)) > 0) configClasses(_config >> "Categories")) apply {
    private _categoryName = toLowerANSI configName _x;
    private _filterStatements = getArray(_x >> "filter");
    private _compiledFilter = [_filterStatements] call EFUNC(core,compileStatements);

    TRACE_2("compiled category filter",_categoryName,_compiledFilter);

    _filters get "filters" set[_categoryName, createHashMapFromArray[
        ["filter", _compiledFilter],
        ["displayName", getText(_x >> "displayName")],
        ["icon", getText(_x >> "icon")],
        ["priority", getNumber(_x >> "priority")],
        ["name", _categoryName],
        ["sortOrder", getNumber(_x >> "sortOrder")]
    ]];
};

private["_temp"];

// Create priority sorted list of category keys
_temp = _filters get "filters" apply { [_y get "priority", _y get "displayName", _x] };
_temp sort false;
_filters set["priority", _temp apply { _x select 2 } ];

// Create sortOrder sorted list of category keys
_temp = _filters get "filters" apply { [_y get "sortOrder", _y get "displayName", _x] };
_temp sort false;
_filters set["sortOrder", _temp apply { _x select 2 } ];

_filters;
