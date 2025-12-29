#define METHOD_ABSTRACT(methodName) \
    [#methodName, { throw format["abstract method %1::%2() called on base class", QADDON, #methodName] }]
#define METHOD_DEFINE_BODY(methodName,functionBody) [#methodName, { functionBody }]
#define METHOD_DEFINE_NAME(methodName,functionName) METHOD_DEFINE_BODY(methodName,METHOD_INVOKE(functionName))
#define METHOD_DEFINE(methodName) METHOD_DEFINE_NAME(methodName,methodName)
#define METHOD_INVOKE(name) [_self, _this] call FUNC(DOUBLES(method,name))

#define METHOD_PREAMBLE_RET(methodName,return) \
    PREAMBLE_TRACE(methodName); \
    if !assert(params[ \
        ["_self", nil, [createHashMap]], \
        ["_"+"this", nil, [[]]] \
    ]) exitWith { return }
#define METHOD_PREAMBLE(methodName) METHOD_PREAMBLE_RET(methodName,nil)

#ifdef DEBUG_MODE_FULL
#define MTRACE_MSG(MESSAGE) format[ARR_3(QUOTE(%1::%2),THIS_CLASS,MESSAGE)]
#define MTRACE_1(MESSAGE,A) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_1(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A))
#define MTRACE_2(MESSAGE,A,B) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_2(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B))
#define MTRACE_3(MESSAGE,A,B,C) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_3(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C))
#define MTRACE_4(MESSAGE,A,B,C,D) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_4(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D))
#define MTRACE_5(MESSAGE,A,B,C,D,E) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_5(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D,E))
#define MTRACE_6(MESSAGE,A,B,C,D,E,F) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_6(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D,E,F))
#define MTRACE_7(MESSAGE,A,B,C,D,E,F,G) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_7(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D,E,F,G))
#define MTRACE_8(MESSAGE,A,B,C,D,E,F,G,H) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_8(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D,E,F,G,H))
#define MTRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_9(str diag_frameNo + ' ' + MTRACE_MSG(MESSAGE),A,B,C,D,E,F,G,H,I))
#ifndef PREAMBLE_TRACE_NO_ARGS
    #define PREAMBLE_TRACE(methodName) LOG_SYS_FILELINENUMBERS('TRACE',format[ARR_4("%1::%2(%3)",((_this#0) get "#type" select 0),QUOTE(methodName),_this#1)])
#else
    #define PREAMBLE_TRACE(methodName) LOG_SYS_FILELINENUMBERS('TRACE',format[ARR_4("%1::%2(%3)",((_this#0) get "#type" select 0),QUOTE(methodName),"...")])
#endif // PREAMBLE_TRACE_NO_ARGS
#else
#define MTRACE_1(MESSAGE,A) /* disabled */
#define MTRACE_2(MESSAGE,A,B) /* disabled */
#define MTRACE_3(MESSAGE,A,B,C) /* disabled */
#define MTRACE_4(MESSAGE,A,B,C,D) /* disabled */
#define MTRACE_5(MESSAGE,A,B,C,D,E) /* disabled */
#define MTRACE_6(MESSAGE,A,B,C,D,E,F) /* disabled */
#define MTRACE_7(MESSAGE,A,B,C,D,E,F,G) /* disabled */
#define MTRACE_8(MESSAGE,A,B,C,D,E,F,G,H) /* disabled */
#define MTRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) /* disabled */
#define PREAMBLE_TRACE(methodName) /* disabled */
#endif

#define REGISTER_CLASSDEF(generator) ([[] call(generator)] call EFUNC(util,registerClassDefinition))

#define VALIDATE_OBJECT(variable,class) (!isNil QUOTE(variable) && {(variable) isEqualType createHashMap} && {!isNil{(variable) get "#type"}} && {class in((variable) get "#type")})

#define SUPER(methodName) ([_self, #methodName] call EFUNC(util,getParentMethod))
#define THIS_CLASS (_self get "#type" select 0)
