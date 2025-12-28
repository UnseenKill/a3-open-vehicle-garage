#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_readKey

Description:
    Read value from INIDBI2 storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>

Optional:

Example:
    (begin example)
    private _value = _storage call["read", ["vehicles", "vehicle_1234"]];
    (end example)

Returns:
    <HASHMAP> Read value, or default value if key does not exist

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(readKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith {};

try {
    private _dbi = _self get "_dbi";

    throw "Implement me.";
} catch {
    ERROR_4("%1() failed to read key %2 in section %3: %4",QFUNC(method_readKey),_key,_section,str _exception);
    nil;
};
