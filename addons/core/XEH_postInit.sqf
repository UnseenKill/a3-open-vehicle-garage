#include "script_component.hpp"

INFO_1("Running A3OVG version %1",QUOTE(VERSION_STR));

if !([] call FUNC(verifyConfig)) then {
    ERROR("Configuration verification failed. Check RPT above this message for details.");
} else {
    INFO("Configuration verified successfully.");
    GVAR(callbacks) = compileFinal([] call FUNC(compileRunbacks));
};
