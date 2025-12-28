#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_deleteKey

Description:
    Delete all entries associated with given key from INIDBI2 storage backend.

Parameters:
    0: _section - Section name <STRING>
    1: _key - Key name <STRING>

Optional:

Example:
    (begin example)
    _storage call["deleteKey", ["vehicles","vehicle_1234"]];
    (end example)

Returns:
    <BOOL> Success status

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(deleteKey);

if !assert(params[
    ["_section", nil, [""]],
    ["_key", nil, [""]]
]) exitWith { false };

try {
    private _dbi = _self get "_dbi";
    private _keys = ["getKeys", _section] call _dbi;

    MTRACE_2(QUOTE(deleteKey),_key,_keys);

    if (_key in _keys) then {
        MTRACE_1(QUOTE(deleteKeySingle),_key);
        ["deleteKey", [_section, _key]] call _dbi;
    } else {
        private _n = -1;

        while { true } do {
            INC(_n);

            private _subKey = format["%1:%2", _key, _n];
            if !(_subKey in _keys) then { break };
            ["deleteKey", [_section, _subKey]] call _dbi;
            MTRACE_1(QUOTE(deleteKeyMulti),_subKey);
        };
    };
} catch {
    ERROR_4("%1() failed to delete key %2 in section %3: %4",QFUNC(method_deleteKey),_key,_section,str _exception);
    false;
};
