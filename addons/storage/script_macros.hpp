#define PREFIX_SEPARATOR ":"

#define METHOD_ABSTRACT(method) \
    [#method, { throw format["abstract method %1::%2() called on base class", QADDON, #method] }]
#define METHOD_DEFINE_NAME(method,function) [#method, { METHOD_INVOKE(function) }]
#define METHOD_DEFINE(method) METHOD_DEFINE_NAME(method,method)
#define METHOD_INVOKE(name) [_self, _this] call FUNC(DOUBLES(method,name))

#define METHOD_PREAMBLE_RET(method,return) \
    TRACE_1(format[ARR_3("%1::%2",((_this#0) get "#type" select 0),QUOTE(method))],_this#1); \
    if !assert(params[ \
        ["_self", nil], \
        ["_"+"this", nil, []] \
    ]) exitWith { return }
#define METHOD_PREAMBLE(method) METHOD_PREAMBLE_RET(method,nil)

#define SUPER(method) ([_self, #method] call EFUNC(storage,getParentMethod))
#define THIS_CLASS (_self get "#type" select 0)
