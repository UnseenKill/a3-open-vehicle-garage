#ifndef A3OVG_PREAMBLE_BAILOUT
    #define A3OVG_PREAMBLE_BAILOUT nil
#endif // A3OVG_PREAMBLE_BAILOUT

#define A3OVG_UI_FUNCTION_PREAMBLE(function,displayVariable) \
    TRACE_1(function,_this); \
    private displayVariable = uiNamespace getVariable QGVAR(dialog); \
    if !assert((!isNil QUOTE(displayVariable)) && {displayVariable isEqualType displayNull && {!isNull displayVariable}}) exitWith { \
        A3OVG_PREAMBLE_BAILOUT; \
        ERROR_3(QUOTE(ARR_2(UI namespace messed up. Abort call to QQUOTE(%1) from %2,line %3.)),function,__FILE__,__LINE__); \
    }

#define A3OVG_UI_FUNCTION_PREAMBLE_WAIT_FOR_DISPLAY(function,displayVariable) \
    if !(canSuspend) exitWith { \
        TRACE_1("deferred:" + function,_this); \
        _this spawn(missionNamespace getVariable function); \
    }; \
    waitUntil { !dialog || {!isNil { uiNamespace getVariable QGVAR(dialog) }} }; \
    A3OVG_UI_FUNCTION_PREAMBLE(function,displayVariable)
