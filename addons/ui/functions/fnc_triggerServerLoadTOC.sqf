#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_triggerServerLoadTOC

Description:
    Triggers the server to load the vehicle Table of Contents (TOC) for the
    player.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(triggerServerLoadTOC));

private _waitUUID = [] call CBA_fnc_createUUID;
[_waitUUID, owner player] remoteExecCall[QEFUNC(core,loadVehicleTOC), 2];

INFO_1("Sent vehicle TOC request to server as request %1",_waitUUID);

private _stamp = diag_tickTime;
private _loadSuccess = false;
private _display = uiNamespace getVariable QGVAR(dialog);
private _ctrl = _display getVariable QGVAR(controls) get "waitTab";
private _n = 1;
private _longWait = false;

_ctrl ctrlSetFade 0.5;
_ctrl ctrlCommit 0.75;

while { !(_loadSuccess) } do {
    if (ctrlCommitted _ctrl) then {
        _n = [1, 0] select _n;
        _ctrl ctrlSetFade([0, 0.5] select _n);
        _ctrl ctrlCommit 0.75;
    };

    uiSleep 0.5;

    if (isNil { uiNamespace getVariable QGVAR(dialog) }) then {
        INFO("Garage Dialog closed before vehicle TOC received from server.");
        break;
    };

    if (missionNamespace getVariable[_waitUUID, false] isEqualType createHashMap) then {
        INFO_1("Received vehicle TOC from server after %1 seconds.",diag_tickTime - _stamp);
        _loadSuccess = true;
        continue;
    };

    if ((diag_tickTime - _stamp) > 5) then {
        WARNING_1("Waiting a long time for vehicle TOC from server: %1 seconds.",diag_tickTime - _stamp);
        
        if !(_longWait) then {
            [A3OVG_EVENT_UI_PUSHSTATUS, [LLSTRING(GarageDialog_Status_WaitingForServerTOC), true, 0]] call CBA_fnc_localEvent;
            _longWait = true;
        };
    };

    if ((diag_tickTime - _stamp) > 15) then {
        ERROR_1("Timed out waiting for vehicle TOC from server after %1 seconds.",diag_tickTime - _stamp);
        [LLSTRING(GarageDialog_Status_ServerTOCTimeout)] call FUNC(showHintSingle);
        while { dialog } do { closeDialog 1 };
    };
};

if !(_loadSuccess) exitWith {};

private _toc = missionNamespace getVariable _waitUUID;
missionNamespace setVariable[_waitUUID, nil];
_display setVariable[QGVAR(toc), _toc];

TRACE_1(QFUNC(triggerServerLoadTOC),_toc);

if (keys _toc isEqualTo []) exitWith {
    [LLSTRING(GarageDialog_Status_NoVehiclesInGarage)] call FUNC(showHintSingle);
    while { dialog } do { closeDialog 1 };
};

[] call FUNC(dialogOnUpdateTOC);
[false] call FUNC(dialogSetLoading);

nil;
