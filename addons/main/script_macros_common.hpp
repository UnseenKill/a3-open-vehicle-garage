#define MAINPREFIX z
#include "\x\cba\addons\main\script_macros_common.hpp"

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
