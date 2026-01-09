#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_simple_fnc_classDefinition

Description:
    Return class definition hash map for simple position provider class.

Parameters:

Optional:

Returns:
    <HASHMAP> Class definition

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(classDefinition),_this);

createHashMapFromArray[
    ["#base", QUOTE(DOUBLES(PREFIX,pp_base))],
    ["#type", QADDON],
    ["#flags", ["sealed"]],

    // Properties

    // Methods

    /**
     * getPositionAsync(Code callback) -> Nothing
     *
     * Call `callback` with vehicle position when available.
     * `callback` signature: `void callback(PositionProvider self, Position3D position, Vector vectorUp)`.
     */
    METHOD_DEFINE(getPositionAsync)
];
