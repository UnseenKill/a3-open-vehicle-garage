#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_util_fnc_getClassModInfo

Description:
    Retrieve mod information from class config

Parameters:
    0: _config - class config <CONFIG>

Optional:

Example:
    (begin example)
    [configOf _vehicle] call A3OVG_util_fnc_getClassModInfo;
    (end example)

Returns:
    <HASHMAP>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(getClassModInfo));

if !assert(params[
    ["_config", nil, [configNull]]
]) exitWith { createHashMap };

configSourceAddonList _config params[
    ["_addon", nil, [""]]
];

private _modInfo = createHashMap;
private _patch = configFile >> "CfgPatches" >> _addon;

while { isText(_patch >> "addonRootClass") } do {
    _patch = configFile >> "CfgPatches" >> getText(_patch >> "addonRootClass");
    if !assert(isClass _patch) then { break };
};

_modInfo set["logo", nil];

if (configSourceModList _patch params[["_path",nil,[""]]]) then {
    private _info = modParams[_path, ["logo"]];

    if (_info select 0 isNotEqualTo "") then {
        _modInfo set["logo", _info select 0];
    };
};

_modInfo set["author", getText(_patch >> "author")];
_modInfo set["url", getText(_patch >> "url")];

_modInfo;
