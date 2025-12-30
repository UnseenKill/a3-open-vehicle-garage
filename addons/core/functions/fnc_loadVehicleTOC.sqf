#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_loadVehicleTOC

Description:
    Loads the Table of Contents (TOC) for vehicles from the storage.

Parameters:
    0: _uuid - Unique identifier for the TOC request <STRING>
    1: _ownerId - Owner player ID to answer <NUMBER>

Optional:

Example:
    (begin example)
    private _vehicleTOC = [] call EFUNC(core,loadVehicleTOC);
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(loadVehicleTOC));
A3OVG_VERIFY_SERVER();
A3OVG_MAKE_UNSCHEDULED(FUNC(loadVehicleTOC));

if !assert(params[
    ["_uuid", nil, [""]],
    ["_ownerId", nil, [0]]
]) exitWith {};

if is3DENPreview then { uiSleep 2.5 };

private _storage = [] call EFUNC(core,getStorage);
private _toc = _storage call["getVehicleTOC", []];

INFO_2("sending vehicle TOC response for %1 to player ID %2",_uuid,_ownerId);
missionNamespace setVariable[_uuid, _toc, _ownerId];

nil;
