#define A3OVG_UI_FUNCTION_PREAMBLE(function,displayVariable) \
    TRACE_1(function,_this); \
    private displayVariable = uiNamespace getVariable QGVAR(dialog); \
    if !assert((!isNil QUOTE(displayVariable)) && {displayVariable isEqualType displayNull && {!isNull displayVariable}}) exitWith { \
        ERROR_3(QUOTE(ARR_2(UI namespace messed up. Abort call to QQUOTE(%1) from %2,line %3.)),function,__FILE__,__LINE__); \
    }
