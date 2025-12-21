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
    Boolean

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(verifyConfig),_this);

private _config = configFile >> QPREFIX;

try {
    if !assert(isClass _config) then {
        throw format["Something is seriously wrong. No %1 config found.", QPREFIX];
    };

    if (getNumber(_config >> "scope") == 0) then {
        throw format["Nothing overrides %1 config; have to assume nothing is set up.",QPREFIX];
    };

    true;
} catch {
    ERROR_1("Config verification failed: %1",_exception);
    false;
};
