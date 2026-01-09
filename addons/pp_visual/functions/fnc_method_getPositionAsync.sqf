#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_visual_fnc_method_getPositionAsync

Description:
    Asynchronously gets the position of the vehicle being placed and passes it
    to the provided callback.

Parameters:
    0: _callback - Callback code receiving calculated position <CODE>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(getPositionAsync);

if !assert(params[
    ["_callback", nil, [{}]]
]) exitWith {};

private _vehicleClass = _self get "_vehicle" get "_className";

[_vehicleClass, createHashMapFromArray[
    ["callbackAbort", [{
        TRACE_1(QFUNC(pp_visual_getPositionAsync_abort),_this);
        params["_vehicleClass","_params"];
        _params params["_uuid"];

        INFO_2("Placement of vehicle class %1 aborted; resetting mutex for UUID %2.",_vehicleClass,_uuid);
        [_uuid, objNull] remoteExec[QEFUNC(core,setMutex), 2];
    }, [_self get "_vehicle" call["getUUID", []]]]],
    ["callbackStart", [{
        TRACE_1(QFUNC(pp_visual_getPositionAsync_start),_this);
        params["_vehicle","_params"];
        _params params["_self"];

        private _serialized = _self get "_vehicle" get "_serialized";
        _self get "_vehicle" call["restoreCustomization", [_vehicle, _serialized get "custom"]];
    }, [_self]]],
    ["callbackPlaced", [{
        TRACE_1(QFUNC(pp_visual_getPositionAsync_placed),_this);
        params["","_position","_vectorDirAndUp","_params"];
        _params params["_self","_callback"];

        [_callback, [_self, _self get "_vehicle", _position, _vectorDirAndUp]] call CBA_fnc_execNextFrame;
    }, [_self, _callback]]]
]] call FUNC(playerPlaceVehicle);

nil;
