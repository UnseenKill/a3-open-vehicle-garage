#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_inidbi2_fnc_method_CTOR

Description:
    Constructor method for INIDBI2 storage adapter.

Parameters:
    0: _prefix - Storage prefix <STRING>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
METHOD_PREAMBLE(CTOR);

call SUPER(CTOR);

private _dbi = ["new", _self get "storagePrefix"] call OO_INIDBI;
LOG_1("using INIDBI2 storage adddon v%1","getVersion" call _dbi);

_self set["dbi", _dbi];

nil;
