#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_verifyConfig

Description:
    Check if open garage is properly set up

Parameters:

Optional:

Example:
    (begin example)
    [] call A3OVG_core_fnc_verifyConfig;
    (end example)

Returns:
    <BOOL> success indicator

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(verifyConfig),_this);

if !(isNull(localNamespace getVariable[QGVAR(configVerified), configNull])) exitWith {
    LOG("config already verified, skipping check.");
    true;
};

private _accessor = QUOTE(A3OVG_CONFIG_CLASS);
private _config = ([configFile, missionConfigFile] select(is3DEN || {is3DENPreview})) >> _accessor;

LOG_2("%1: verifying configuration from %2",QFUNC(verifyConfig),_config);

try {
    if !assert(isClass _config) then {
        throw format["Something is seriously wrong. No %1 config found.", _accessor];
    };

    if (getNumber(_config >> "scope") == 0) then {
        throw format["Nothing overrides %1 config; have to assume nothing is set up.", _accessor];
    };

    if (isServer || { isDedicated }) then {
        [_config] call FUNC(verifyConfigStorage);
    };

    localNamespace setVariable[QGVAR(configVerified), _config];

    true;
} catch {
    ERROR_1("Config verification failed: %1",_exception);
    false;
};
