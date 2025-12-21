#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(Component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_common"
        };
        author = "$STR_A3OVG_Author";
        authors[] = {};
        url = "$STR_A3OVG_URL";
        useThisStringtableEntrySoHemttShutsUp = CSTRING(Title);
        VERSION_CONFIG;
    };
};

#include "CfgSettings.hpp"
