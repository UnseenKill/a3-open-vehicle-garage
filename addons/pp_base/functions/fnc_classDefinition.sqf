#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_pp_base_fnc_classDefinition

Description:
    Return class definition hash map for position provider base class.

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
    ["#type", QADDON],
    ["#flags", ["sealed"]],

    // Properties

    // Vehicle hashmap object
    ["_vehicle", nil],

    // Methods

    /**
     * getPositionAsync(Code callback) -> Nothing
     *
     * Call `callback` with vehicle position when available.
     * `callback` signature: `void callback(PositionProvider self, Vehicle vehicle, Position3D position, Vector vectorDirAndUp)`.
     */
    METHOD_ABSTRACT(getPositionAsync),

    /**
     * #create(Vehicle vehicle) -> PositionProvider
     */
    METHOD_DEFINE_NAME(#create,CTOR)
];
