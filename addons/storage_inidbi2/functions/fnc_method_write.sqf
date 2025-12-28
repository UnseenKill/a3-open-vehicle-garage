#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_write

Description:
    Write value to INIDBI2 storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>
    2: _value - Value to write <ANY>

Optional:

Example:
    (begin example)
    _storage call["write", ["vehicles", "vehicle_1234", _vehicleData]];
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
    private _dbi = _self get "_dbi";
    private _serialized = [_value] call FUNC(serialize);
    private _chunked = [_dbi, _serialized] call FUNC(chunk);

    if (count _chunked <= 1) then {
        ["write", [_section, _key, _chunked select 0]] call _dbi;
    } else {
        {
            if !(["write", [_section, format["%1:%2", _key, _forEachIndex], _x]] call _dbi) exitWith { false };
            true;
        } forEach _chunked;
    };
} catch {
    ERROR_4("%1() failed to write key %2 in section %3: %4",QFUNC(method_write),_key,_section,str _exception);
    false;
};
