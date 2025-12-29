#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(classRegistry) = createHashMap;

INFO("class registry is open");
