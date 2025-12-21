#define COMPONENT api
#include "\z\a3ovg\addons\main\script_mod.hpp"
#include "\z\a3ovg\addons\main\script_macros.hpp"

#define A3OVG_VERIFY_CONFIG() if !([] call EFUNC(core,verifyConfig)) exitWith {\
    ERROR_2("Configuration verification failed. Called from %1, line %2",__FILE__,__LINE__);\
    [localize LSTRING(ConfigVerificationFailed)] call BIS_fnc_error;\
}
