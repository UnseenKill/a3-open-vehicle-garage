#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_write

Description:
    Save serialized data to storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>
    2: _value - Value to write <ANY>

Optional:

Example:
    (begin example)
    _storage call["write", ["section-name", "key-name", _value]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(write);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]],
    ["_value", nil]
]) exitWith { false };

try {
    _self call["writeKey", [_section, _key, _value]];
} catch {
    ERROR_4("%1() failed to write data for section %2, key %3: %4",QFUNC(method_write),_section,_key,str _exception);
    false;
};
