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
    private _value = ["read", [_section, _key]] call _dbi;

    if (_value isEqualTo false) exitWith { MTRACE_2(QUOTE(readKey),_key,nil) };

    // Non-empty strings indicate non-chunked data
    private _decoded = if (_value isNotEqualTo "") then {
        ["decodeBase64", _value] call _dbi;
    } else {
        private _chunks = [];
        private _index = -1;

        while { true } do {
            INC(_index);

            private _chunkKey = format["%1:%2", _key, _index];
            private _chunk = ["read", [_section, _chunkKey]] call _dbi;
            if (_chunk isEqualTo false) then { break };
            _chunks pushBack(["decodeBase64", _chunk] call _dbi);
        };

        _chunks joinString "";
    };

    MTRACE_3(QUOTE(readKey),_key,_value,_decoded);

    [_decoded] call FUNC(unserialize);
} catch {
    ERROR_4("%1() failed to read key %2 in section %3: %4",QFUNC(method_readKey),_key,_section,str _exception);
    nil;
};
