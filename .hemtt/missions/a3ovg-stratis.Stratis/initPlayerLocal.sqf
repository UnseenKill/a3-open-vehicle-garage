// Wait Until Mission Starts And Player Is Player
waitUntil { time > 0 };
if (!isDedicated && player != player) then { waitUntil { player == player && alive player } };

player addAction ["Run local 'script.sqf'", {
    [] call compile preprocessFileLineNumbers 'script.sqf';
}, nil, -200, false, true, '', 'true'];

[hashValue player] call A3OVG_fnc_setStoragePrefix;
