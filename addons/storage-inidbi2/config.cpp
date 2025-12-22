#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3OVG_storage","inidbi2"};
        skipWhenMissingDependencies = 1;
        author = "$STR_A3OVG_Author";
        authors[] = {};
        url = "$STR_A3OVG_URL";
        VERSION_CONFIG;
    };
};

#include "config.hpp"
