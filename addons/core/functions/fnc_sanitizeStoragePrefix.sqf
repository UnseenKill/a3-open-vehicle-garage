#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_core_fnc_sanitizeStoragePrefix

Description:
    Sanitize storage prefix by removing invalid characters.

    Does nothing but lower-casing the prefix for now. More complex sanitization
    may be added in the future if needed.

Parameters:
    0: _prefix - Storage prefix <STRING>

Optional:

Example:
    (begin example)
    ["invalid<>string+\\!foobar"] call A3OVG_core_fnc_sanitizeStoragePrefix;
    (end example)

Returns:
    <STRING> Sanitized storage prefix

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(sanitizeStoragePrefix),_this);

if !assert(params[
    ["_prefix", nil, [""]]
]) exitWith {};

toLowerANSI _prefix;
