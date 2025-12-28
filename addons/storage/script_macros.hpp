#define SECTION_TOC QUOTE(toc)
#define SECTION_VEHICLE QUOTE(vehicle)

#define METHOD_ABSTRACT(methodName) \
    [#methodName, { throw format["abstract method %1::%2() called on base class", QADDON, #methodName] }]
#define METHOD_DEFINE_BODY(methodName,functionBody) [#methodName, { functionBody }]
#define METHOD_DEFINE_NAME(methodName,functionName) METHOD_DEFINE_BODY(methodName,METHOD_INVOKE(functionName))
#define METHOD_DEFINE(methodName) METHOD_DEFINE_NAME(methodName,methodName)
#define METHOD_INVOKE(name) [_self, _this] call FUNC(DOUBLES(method,name))

#define METHOD_PREAMBLE_RET(methodName,return) \
    TRACE_1(format[ARR_3("%1::%2",((_this#0) get "#type" select 0),QUOTE(methodName))],_this#1); \
    if !assert(params[ \
        ["_self", nil], \
        ["_"+"this", nil, []] \
    ]) exitWith { return }
#define METHOD_PREAMBLE(methodName) METHOD_PREAMBLE_RET(methodName,nil)

#define SUPER(methodName) ([_self, #methodName] call EFUNC(storage,getParentMethod))
#define THIS_CLASS (_self get "#type" select 0)
