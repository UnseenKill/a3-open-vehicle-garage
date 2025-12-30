#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_triggerServerLoadUUIDs

Description:
    Function to request vehicle data from the server for a list of vehicle UUIDs.
    Sends a remoteExec to the server and waits for the response containing the
    vehicle data.

Parameters:
    0: _vehicleUUIDs - list of vehicle UUIDs <ARRAY>
    1: _treeView - Tree view control <CONTROL>
    2: _selectionPath - selected node path <ARRAY>
    3: _category - category name <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_UI_FUNCTION_PREAMBLE(QFUNC(triggerServerLoadUUIDs),_display);
A3OVG_MAKE_UNSCHEDULED(FUNC(triggerServerLoadUUIDs));

if !assert(params[
    ["_vehicleUUIDs", nil, [[]]],
    ["_treeView", nil, [controlNull]],
    ["_selectionPath", nil, [[]]],
    ["_category", nil, [""]]
]) exitWith {};

private _waitUUID = [] call CBA_fnc_createUUID;
[_waitUUID, owner player, _vehicleUUIDs] remoteExecCall[QEFUNC(core,loadVehicleUUIDs), 2];

INFO_1("Sent vehicle UUIDs request to server as request %1",_waitUUID);

private _stamp = diag_tickTime;

waitUntil {
    (isNil { uiNamespace getVariable QGVAR(dialog) }) ||
    { missionNamespace getVariable[_waitUUID, false] isEqualType createHashMap } ||
    { (diag_tickTime - _stamp) > 10 };
};

if (isNil { uiNamespace getVariable QGVAR(dialog) }) exitWith {
    INFO("Garage Dialog closed before vehicle UUIDs received from server.");
};

if (missionNamespace getVariable[_waitUUID, false] isEqualType false) exitWith {
    ERROR_1("Timed out waiting for vehicle UUIDs from server after %1 seconds.",diag_tickTime - _stamp);

    _treeView tvSetCurSel[-1];
    _treeView tvSetColor[_selectionPath, [1,0,0,1]];
    _treeView tvSetText[_selectionPath, _treeView getVariable QGVAR(loading) get _category];
    _treeView tvSetTooltip[_selectionPath, "Failed to load vehicle data from server: request timed out."];

    while { (_treeView tvCount _selectionPath) > 0 } do {
        _treeView tvDelete(_selectionPath + [0]);
    };
};

// TODO: Process

nil;
