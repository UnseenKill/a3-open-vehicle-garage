#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QUOTE(A3OVG_ADDON_CORE)};
        author = "$STR_A3OVG_Author";
        authors[] = {};
        url = "$STR_A3OVG_URL";
        VERSION_CONFIG;
    };
};

#include "config.hpp"
#include "dialog.hpp"
#include "CfgEventHandlers.hpp"
