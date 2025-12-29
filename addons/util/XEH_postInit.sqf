#include "script_component.hpp"

INFO("sealing class registry");

GVAR(classRegistry) = compileFinal GVAR(classRegistry);

nil;
