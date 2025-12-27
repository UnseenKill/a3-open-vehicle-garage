#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_verifyConfigServer

Description:
    Verify server-specific configuration.

Parameters:
    0: _config - Configuration class <CONFIG>

Optional:

Example:
    (begin example)
    [_config] call FUNC(verifyConfigServer);
    (end example)

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(verifyConfigServer),_this);
A3OVG_VERIFY_SERVER();

if !assert(params[
    ["_config", nil, [configNull]]
]) exitWith { throw(QFUNC(verifyConfigServer) + ": invalid parameters.") };
if !assert(!isNull _config) exitWith { throw "null-configuration given." };

if !isText(missionConfigFile >> "missionGroup") then {
    WARNING("This mission does not define a missionGroup; storage backends may not function properly across missions.");
} else {
    INFO_1("Mission group recognized as %1.",str getText(missionConfigFile >> "missionGroup"));
};

nil;
