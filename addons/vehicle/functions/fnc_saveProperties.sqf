#include "..\script_component.hpp"
#include "\z\a3ovg\addons\storage\script_macros.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_saveProperties

Description:
    Saves the vehicle properties to persistent storage.

Parameters:
    0: _uuid - Vehicle UUID <STRING>
    1: _properties - Vehicle properties data <HASHMAP>

Optional:

Example:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(saveProperties));
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_uuid", nil, [""]],
    ["_properties", nil, [createHashMap]]
]) exitWith {};

private _storage = [] call EFUNC(core,getStorage);
private _key = _storage call["getKey", [[_uuid, "_properties"] joinString(_storage get "_prefixSeparator")]];

INFO_2("Writing vehicle properties %1: %2",_key,_properties);
_storage call["write", [SECTION_VEHICLE, _key, _properties]];

nil;
