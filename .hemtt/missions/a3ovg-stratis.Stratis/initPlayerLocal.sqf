#define OVERRIDE_UUID_GENERATION
#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Wait Until Mission Starts And Player Is Player
waitUntil { time > 0 };
if (!isDedicated && player != player) then { waitUntil { player == player && alive player } };

player addAction ["Run local 'script.sqf'", {
    [] call compile preprocessFileLineNumbers 'script.sqf';
}, nil, -200, false, true, '', 'true'];

[hashValue player] call A3OVG_fnc_setStoragePrefix;

#ifdef OVERRIDE_UUID_GENERATION
missionNamespace setVariable[QEFUNC(vehicle,getUUID), {
    TRACE_1(QEFUNC(vehicle,getUUID_Override),_this);
    "deadbeef-baad-f000-000d-aaaaaaaaaaaa";
}];
#endif // OVERRIDE_UUID_GENERATION
