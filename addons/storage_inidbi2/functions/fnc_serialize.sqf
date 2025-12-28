#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_serialize

Description:
    Serialize value for storage in INIDBI2 backend.

Parameters:
    0: _value - value to serialize <ANY>

Optional:

Example:
    (begin example)
    [_value] call A3OVG_storage_inidbi2_fnc_serialize;
    (end example)

Returns:
    <STRING> Serialized value

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(serialize),_this);

if !assert(params[
    ["_value", nil]
]) exitWith { "" };

switch true do {
    case(_value isEqualType ""): { format["S:%1", _value] };
    case(_value isEqualType 0): { format["N:%1", _value] };
    case(_value isEqualType true): { format["B:%1", [0,1] select _value] };
    case(_value isEqualType []): { format["A:%1", toJSON _value] };
    case(_value isEqualType createHashMap): { format["H:%1", toJSON _value] };
    default { throw format["cannot serialize value of type %1", typeName _value] };
};
