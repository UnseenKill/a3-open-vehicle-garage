#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogCreateVehicleDynamicInfo

Description:
    Create dynamic vehicle information controls in the vehicle info dialog.

Parameters:
    0: _hostControl - Host control to create dynamic info controls in <CONTROL>
    1: _uuid - Vehicle UUID <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogCreateVehicleDynamicInfo),_display);

if !assert(params[
    ["_hostControl", nil, [controlNull]],
    ["_uuid", nil, [""]]
]) exitWith {};

if !assert(!isNull _hostControl) exitWith {};
if !assert(_uuid isNotEqualTo "") exitWith {};

private ["_ctrl"];
private _vehicle = _display getVariable QGVAR(vehicles) get _uuid;

allControls _hostControl apply { ctrlDelete _x };
ctrlPosition _hostControl params[
    "","",
    ["_hostWidth", nil, [0]],
    ["_hostHeight", nil, [0]]
];

if (isNil "_vehicle") exitWith {
    _ctrl = _display ctrlCreate[QGVAR(RscText), -1, _hostControl];
    _ctrl ctrlSetTextColor[0.8,0,0,1];
    _ctrl ctrlSetPosition[0, 0, _hostWidth, lineHeight];
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetText format["Vehicle UUID %1 is still being loaded...", _uuid];
};

private _data = _vehicle get "_serialized";

if !assert((!isNil "_data") && { _data isEqualType createHashMap}) exitWith {};

private _items = [];
private _line = 0;

#define PERCENT(VALUE) (((100 * (VALUE)) toFixed 0) + "%")
#ifndef __A3OVG_PRODUCTION__
_items pushBack ["UUID", _uuid, true];
_items pushBack ["Class name", _data get "class"];
#endif

_items pushBack [LLSTRING(GarageDialog_PreviewDynamic_Fuel_Label), PERCENT(_data get "fuel")];
_items pushBack [LLSTRING(GarageDialog_PreviewDynamic_Damage_Label), PERCENT(_data get "damage" get "damage")];
_items pushBack [LLSTRING(GarageDialog_PreviewDynamic_Inventory_Label), localize([LSTRING(GarageDialog_PreviewDynamic_InventorySaved_Text), LSTRING(GarageDialog_PreviewDynamic_InventoryEmpty_Text)] select([] isEqualTo(flatten(values(_data get "inventory")))))];

if (_data get "cargo" get "repair" get "cargo" > 0) then {
    _items pushBack[LLSTRING(GarageDialog_PreviewDynamic_RepairCapacity_Label), PERCENT(_data get "cargo" get "repair" get "cargo")];
};

if (_data get "cargo" get "rearm" get "aceMax" > 0) then {
    _items pushBack[LLSTRING(GarageDialog_PreviewDynamic_RearmCapacity_Label), format["%1 of %2 (%3)",
        _data get "cargo" get "rearm" get "aceCurrent",
        _data get "cargo" get "rearm" get "aceMax",
        PERCENT((_data get "cargo" get "rearm" get "aceCurrent") / (_data get "cargo" get "rearm" get "aceMax"))]];
} else {
    if (_data get "cargo" get "rearm" get "cargo" > 0) then {
        _items pushBack[LLSTRING(GarageDialog_PreviewDynamic_RearmCapacity_Label), PERCENT(_data get "cargo" get "rearm" get "cargo")];
    };
};

if (_data get "cargo" get "refuel" get "aceMax" > 0) then {
    _items pushBack[LLSTRING(GarageDialog_PreviewDynamic_RefuelCapacity_Label), format["%1l of %2l (%3)",
        _data get "cargo" get "refuel" get "aceCurrent",
        _data get "cargo" get "refuel" get "aceMax",
        PERCENT((_data get "cargo" get "refuel" get "aceCurrent") / (_data get "cargo" get "refuel" get "aceMax"))]];
} else {
    if (_data get "cargo" get "refuel" get "cargo" > 0) then {
        _items pushBack[LLSTRING(GarageDialog_PreviewDynamic_RefuelCapacity_Label), PERCENT(_data get "cargo" get "refuel" get "cargo")];
    };
};

private _keys = keys _data;
_keys sort true;
_keys apply { _items pushBack[format["<%1>", _x], str(_data get _x)] };

_items apply {
    _x params[
        ["_label", nil, [""]],
        ["_text", nil, [""]],
        ["_edit", false, [true]]
    ];

    _ctrl = _display ctrlCreate[QGVAR(RscText), -1, _hostControl];
    _ctrl ctrlSetPosition[0, _line * lineHeight, _hostWidth / 5, lineHeight];
    _ctrl ctrlSetFontHeight lineHeight;
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetText(_label + ":");

    _ctrl = _display ctrlCreate[[QGVAR(RscText),"RscEdit"] select _edit, -1, _hostControl];
    _ctrl ctrlSetPosition[_hostWidth / 5, _line * lineHeight, _hostWidth / 5 * 4, lineHeight];
    _ctrl ctrlSetFontHeight lineHeight;
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetText _text;

    INC(_line);
};

nil;
