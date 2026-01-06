#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_loadFrom

Description:
    Load vehicle data from serialized data.

Parameters:
    0: _data - Data as produced by `serialize()` method <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(loadFrom);

#define ADOPT_PROPERTY_NIL(property,validation,allowNil) if true then { \
    private _value = _data get QUOTE(_properties) get QUOTE(property); \
    if ((allowNil) && { isNil "_value" }) exitWith { \
        TRACE_1(QUOTE(DOUBLES(loadFrom,property)),"<nil>"); \
        _self set[QUOTE(property), nil]; \
    }; \
    if assert([_value] params[["_validated", nil, validation]]) then { \
        TRACE_1(QUOTE(DOUBLES(loadFrom,property)),_validated); \
        _self set[QUOTE(property), _validated]; \
    } else { \
        throw format["failed to load property '%1' from serialized data.", QUOTE(property)]; \
    }; \
}
#define ADOPT_PROPERTY(property,validation) ADOPT_PROPERTY_NIL(property,validation,false)

if !assert(params[
    ["_data", nil, [createHashMap]]
]) exitWith {};

_self set["_serialized", _data];
_self set["_vehicle", objNull];

ADOPT_PROPERTY(_category,[""]);
ADOPT_PROPERTY(_className,[""]);
ADOPT_PROPERTY(_displayName,[""]);
ADOPT_PROPERTY(_owner,[""]);
ADOPT_PROPERTY_NIL(_ownerLock,[""],true);
ADOPT_PROPERTY(_uuid,[""]);

nil;
