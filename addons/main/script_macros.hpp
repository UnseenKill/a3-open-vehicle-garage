#include "script_macros_common.hpp"

#define A3OVG_CONFIG_CLASS_BASE TRIPLES(PREFIX,Config,Base)
#define A3OVG_CONFIG_CLASS DOUBLES(PREFIX,Config)
#define A3OVG_FEATURE_ENABLED(config,feature) (getNumber(_config >> "Features" >> QUOTE(feature)) != 0)
#define A3OVG_FUNCTION_PREAMBLE(function) \
    TRACE_1(function,_this); \
    if isNull(localNamespace getVariable[QEGVAR(core,configVerified), configNull]) exitWith { \
        ERROR_3(QUOTE(ARR_2(Configuration not found. Abort call to QQUOTE(%1) from %2,line %3.)),function,__FILE__,__LINE__); \
        if (hasInterface) then { \
            [LELSTRING(API,ConfigVerificationFailed)] call BIS_fnc_error; \
        }; \
    };

#define A3OVG_GET_CONFIG(var) \
    private var = localNamespace getVariable[QEGVAR(core,configVerified), configNull]; \
    if !assert(!isNull(var)) exitWith {}

#define A3OVG_UI_PUSH_CONTEXT() \
    (EGVAR(ui,context) pushBack [])
#define A3OVG_UI_POP_CONTEXT() \
    (EGVAR(ui,context) deleteAt(count EGVAR(ui,context) - 1))

#define A3OVG_VEH_NAME(vehicle) getText((if (vehicle isEqualType objNull) then[{configOf(vehicle)}, {configFile >> QUOTE(CfgVehicles) >> (vehicle)}]) >> QUOTE(displayName))
