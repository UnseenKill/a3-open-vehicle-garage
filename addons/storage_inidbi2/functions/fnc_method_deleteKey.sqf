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
    ["deleteKey", [_section, _key]] call _dbi;
} catch {
    ERROR_4("%1() failed to delete key %2 in section %3: %4",QFUNC(method_deleteKey),_key,_section,str _exception);
    false;
};
