#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_registerStorageAdapterClass

Description:
    Register a storage adapter class in the storage adapter class registry.

    Registry is used to look up storage adapter classes by name when calling 
    super methods.

Parameters:
    0: _definition - Class definition <HASHMAP>

Optional:

Example:
    (begin example)
    [createHashMapFromArray[
        ["#type", ["A3OVG_storage_foobar"]],
        // Additional class definition entries...
    ]] call A3OVG_storage_fnc_registerStorageAdapterClass;
    (end example)

Returns:
    <HASHMAP> The definition as passed and registered.

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_definition", nil, [createHashMap]]
]) exitWith {};

private _className = _definition get "#type";

if !assert(!isNil("_className")) exitWith {};

if (_className isEqualType []) then {
    _className = _className select 0;
};

if !assert(_className isEqualType "") exitWith {};

GVAR(classRegistry) set[_className, _definition];

_definition;
