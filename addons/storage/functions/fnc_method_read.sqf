#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_method_read

Description:
    Read serialized data from storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>

Optional:
    2: _expectedDataTypes - Expected data types <ARRAY>

Example:
    (begin example)
    _data = _storage call["read", ["section-name", "key-name", ["",false]]];
    (end example)

Returns:
    <ANY> Stored value or nil if key does not exist

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(read);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith {};

private _expectedDataTypes = param[2, nil, [[]]];
private _value = _self call["readKey", [_section, _key]];

if (isNil "_value" || { isNil "_expectedDataTypes" }) exitWith { RETNIL(_value) };

if !assert([_value] params[
    ["_validated", nil, _expectedDataTypes]
]) exitWith {};

_validated;
