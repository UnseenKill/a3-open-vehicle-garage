#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_chunk

Description:
    Chunk serialized string into smaller parts for storage in INIDBI2 backend.

Parameters:
    0: _dbi - INIDBI2 database object <OBJECT>
    1: _serialized - Serialized string to chunk <STRING>

Optional:

Example:
    (begin example)
    ["longstringhere"] call A3OVG_storage_inidbi2_fnc_chunk;
    (end example)

Returns:
    <ARRAY> Array of chunked strings

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_dbi", nil],
    ["_serialized", nil, [""]]
]) exitWith { [] };

private _chunks = [];
private _chunkSize = 64;

while { count _serialized > 0 } do {
    private _chunk = [_serialized, 0, _chunkSize] call CBA_fnc_substr;
    _serialized = [_serialized, _chunkSize] call CBA_fnc_substr;
    _chunks pushBack(["encodeBase64", _chunk] call _dbi);
};

_chunks;
