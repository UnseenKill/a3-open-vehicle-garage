#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_method_restoreInventory

Description:
    Restore vehicle inventory from serialized data.

Parameters:
    0: _vehicle - Vehicle object <OBJECT>

Optional:
    1: _data - serialized data <HASHMAP>

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(restoreInventory);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

clearBackpackCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

private _data = param[1, nil, [createHashMap]];
if (isNil "_data") exitWith {}; // feature might not be used

#define RESTORE_INVENTORY(type,function) if true then {\
    private _keyValues = _data get(type); \
    TRACE_1(type,_keyValues); \
    ((_keyValues select 0) createHashMapFromArray (_keyValues select 1)) apply { \
        TRACE_2(QFUNC(method_restoreInventory_)+type,_x,_y); \
        _vehicle function[_x, _y]; \
    }; \
}

RESTORE_INVENTORY(QUOTE(backpack),addBackpackCargoGlobal);
RESTORE_INVENTORY(QUOTE(items),addItemCargoGlobal);
RESTORE_INVENTORY(QUOTE(magazines),addMagazineCargoGlobal);
#undef RESTORE_INVENTORY

_data get "weapons" apply {
    TRACE_1(QFUNC(method_restoreInventory_weapons),_x);
    _vehicle addWeaponWithAttachmentsCargoGlobal[_x, 1];
};

nil;
