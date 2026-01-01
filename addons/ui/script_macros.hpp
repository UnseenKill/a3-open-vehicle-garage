#ifndef A3OVG_PREAMBLE_BAILOUT
    #define A3OVG_PREAMBLE_BAILOUT nil
#endif // A3OVG_PREAMBLE_BAILOUT

#ifdef DEBUG_MODE_FULL
    #ifndef PREAMBLE_TRACE_NO_ARGS
        #define UI_PREAMBLE_TRACE(function) TRACE_1(function,_this)
    #else
        #define UI_PREAMBLE_TRACE(function) TRACE_1(function + "(...)",[])
    #endif // PREAMBLE_TRACE_NO_ARGS
#else
    #define UI_PREAMBLE_TRACE(function) /* disabled */
#endif

#define A3OVG_UI_FUNCTION_PREAMBLE(function,displayVariable) \
    UI_PREAMBLE_TRACE(function); \
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
