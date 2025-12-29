#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_vehicle_fnc_classDefinition

Description:
    Return vehicle OO class definition.

Parameters:

Optional:

Example:

Returns:
    <HASHMAP> - Vehicle class definition

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
createHashMapFromArray[
    ["#type", QADDON],
    ["#flags", ["sealead", "unscheduled"]],

    // Properties
    ["_vehicle", nil],

    // Methods
    METHOD_DEFINE_NAME(#create,CTOR)
];
