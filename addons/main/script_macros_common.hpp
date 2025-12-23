#define MAINPREFIX z
#include "\x\cba\addons\main\script_macros_common.hpp"

// HEMTT complains about padded arguments; the original macro has a newline in it
#undef PFORMAT_2
#undef PFORMAT_3
#undef PFORMAT_4
#undef PFORMAT_5
#undef PFORMAT_6
#undef PFORMAT_7
#undef PFORMAT_8
#undef PFORMAT_9
#define PFORMAT_2(MESSAGE,A,B) format ['%1: A=%2, B=%3', MESSAGE, RETNIL(A), RETNIL(B)]
#define PFORMAT_3(MESSAGE,A,B,C) format ['%1: A=%2, B=%3, C=%4', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C)]
#define PFORMAT_4(MESSAGE,A,B,C,D) format ['%1: A=%2, B=%3, C=%4, D=%5', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D)]
#define PFORMAT_5(MESSAGE,A,B,C,D,E) format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E)]
#define PFORMAT_6(MESSAGE,A,B,C,D,E,F) format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F)]
#define PFORMAT_7(MESSAGE,A,B,C,D,E,F,G) format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G)]
#define PFORMAT_8(MESSAGE,A,B,C,D,E,F,G,H) format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H)]
#define PFORMAT_9(MESSAGE,A,B,C,D,E,F,G,H,I) format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9, I=%10', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H), RETNIL(I)]

#undef PREP
#undef PREPMAIN
#ifdef DISABLE_COMPILE_CACHE
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preprocessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,functions\DOUBLES(fnc,var1))'
    #define PREPMAIN(var1) TRIPLES(PREFIX,fnc,var1) = compile preprocessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,functions\DOUBLES(fnc,var1))'
#else
    #define PREP(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,functions\DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPMAIN(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,functions\DOUBLES(fnc,var1))', 'TRIPLES(PREFIX,fnc,var1)'] call SLX_XEH_COMPILE_NEW
#endif

#undef PATHTO_FNC
#define PATHTO_FNC(func) class func {\
    file = QPATHTOF(functions\DOUBLES(fnc,func).sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}

#ifndef QPREFIX
    #define QPREFIX QUOTE(PREFIX)
#endif
#ifndef QQPREFIX
    #define QQPREFIX QUOTE(QUOTE(PREFIX))
#endif

#ifndef QQUOTE
    #define QQUOTE(x) QUOTE(QUOTE(x))
#endif

#ifndef QELSTRING
    #define QELSTRING(section,string) QUOTE(ELSTRING(section,string))
#endif

#ifndef LQELSTRING
    #define LQELSTRING(section,string) localize QELSTRING(section,string)
#endif
