#define PREAMBLE_TRACE_NO_ARGS
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogTreeUpdateVehicleEntry

Description:
    Update the vehicle entry in the tree view.

Parameters:
    0: _vehicle - Vehicle object instance <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(dialogTreeUpdateVehicleEntry),_display);

if !assert(params[
    ["_vehicle", nil, [createHashMap]]
]) exitWith {};
if !assert(VALIDATE_OBJECT(_vehicle,QUOTE(DOUBLES(PREFIX,vehicle)))) exitWith {};

private _controls = _display getVariable QGVAR(controls);
private _treeView = _controls get "treeView";
private _uuid = _vehicle call["getUUID", []];
private _category = _vehicle call["getCategory", []];
private _nodePath = [];

private["_count"];

// Find category node
_count = _treeView tvCount [];
for "_n" from 0 to (_count - 1) do {
    private _cat = _treeView tvData[_n];

    if (_cat isEqualTo (_category get "name")) then {
        _nodePath pushBack _n;
        break;
    };
};

// Find vehicle node
if (_nodePath isNotEqualTo []) then {
    _count = _treeView tvCount _nodePath;
    for "_n" from 0 to (_count - 1) do {
        private _thisUUID = _treeView tvData(_nodePath + [_n]);

        if (_thisUUID isEqualTo _uuid) then {
            _nodePath pushBack _n;
            break;
        };
    };
};

TRACE_2(QFUNC(dialogTreeUpdateVehicleEntry),_uuid,_nodePath);

// Create category if not existing
if (_nodePath isEqualTo []) then {
    INFO_1("creating new category node for %1",_category get "name");

    private _index = _treeView tvAdd[[], _category get "displayName"];
    _treeView tvSetPicture[[_index], _category get "icon"];
    _treeView tvSetData[[_index], _category get "name"];

    _nodePath pushBack _index;
};

// Create vehicle node if not existing
if (count _nodePath isEqualTo 1) then {
    INFO_2("creating new vehicle node for %1 (%2)",_uuid,_vehicle get "_displayName");

    private _index = _treeView tvAdd[[_nodePath], _vehicle get "_displayName"];
    _nodePath pushBack _index;
};

if !isClass(configFile >> "CfgVehicles" >> (_vehicle get "_className")) then {
    _treeView tvSetData[_nodePath, ""];
    _treeView tvSetColor[_nodePath, [0.5, 0.5, 0.5, 1]];
    _treeView tvSetTooltip[_nodePath, format[LLSTRING(GarageDialog_Status_VehicleClassUnknown), _vehicle get "_className"]];
} else {
    _treeView tvSetData[_nodePath, _uuid];
    _treeView tvSetText[_nodePath, _vehicle get "_displayName"];

    if !(_vehicle call["isLocked", []]) then {
        _treeView tvSetPictureRight[_nodePath, ""];
    } else {
        _treeView tvSetPictureRight[_nodePath, "\A3\Ui_f\data\GUI\Rsc\RscDisplayDynamicGroups\Lock.paa"];
    };
};

nil;
