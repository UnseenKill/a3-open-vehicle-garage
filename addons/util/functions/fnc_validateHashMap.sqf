#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_validateHashMap

Description:
    Validate keys and values of a hash map like `params` does for arrays.

    No nested validation is performed; only the top-level keys and values are checked.

    Will emit warnings to RPT if validation fails and returns false.

Parameters:
    0: _hashmap - hash map to validate <HASHMAP>
    1: _paramSpec - array of parameter specifications like for `params` <ARRAY>

Optional:

Example:
    (begin example)
    [_hashmap, [
        ["key1", nil, [0]],
        ["key2", "defaultValue", [""]]
    ]] call EFUNC(util,validateHashMap);
     => returns true if:
        - _hashmap contains "key1" with a value of type number
        - _hashmap contains "key2" with a value of type string, optionally
    (end example)

Returns:
    <BOOL> True if validation passed, false otherwise

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_types"]

if !assert(params[
    ["_hashmap", nil, [createHashMap]],
    ["_paramSpec", nil, [[]]]
]) exitWith { false };

try {
    _paramSpec apply {
        private["_key","_default","_types"];

        if (_x isEqualType "") then {
            _key = _x;
        } else {
            if !assert(_x isEqualType []) then {
                throw format["invalid param spec type: %1", typeName _x];
            };
            if !assert(_x params[
                ["_vkey", nil, [""]]
            ]) then { throw format["invalid param spec: %1", _x] };

            _key = _vkey;
            _default = _x param[1, nil];
            _types = _x param[2, nil, [[]]];
        };

        if (_key in _hashmap) then {
            if (!(isNil "_types") && { _types isEqualType [] }) then {
                if !([_hashmap get _key] params[
                    ["_v", nil, _types]
                ]) then { throw format["invalid type for key '%1' in hashmap: expected %2, got %3", _key, _types, typeName(_hashmap get _key)] };
            };
        } else {
            if (isNil "_default") then {
                throw format["missing required key '%1' in hashmap %2", _key, _hashmap];
            };

            _hashmap set[_key, _default];
        };
    };

    true;
} catch {
    WARNING_2("%1: %2",QFUNC(validateHashMap),_exception);
    TRACE_1(QFUNC(validateHashMap),_hashmap);
    false;
};
