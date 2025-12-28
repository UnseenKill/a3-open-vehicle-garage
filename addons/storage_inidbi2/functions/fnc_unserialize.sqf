#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_unserialize

Description:
    Unserialize data previously serialized with A3OVG_storage_fnc_serialize.

Parameters:
    0: _serialized - Serialized data <STRING>

Optional:

Example:
    (begin example)
    _data = _storage call["unserialize", [_serializedData]];
    (end example)

Returns:
    Unserialized data <ANY>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(unserialize),_this);

if !assert(params[
    ["_serialized", nil, [""]]
]) exitWith {};

if !assert(count _serialized >= 2) exitWith {};

private _type = [_serialized, 0, 2] call CBA_fnc_substr;
private _data = [_serialized, 2] call CBA_fnc_substr;

switch _type do {
    case "S:": { _data };
    case "N:": { parseNumber _data };
    case "B:": { (_data == "1") };
    case "A:";
    case "H:": { fromJSON _data };
    default { throw format["cannot unserialize data of type %1", _type] };
};
