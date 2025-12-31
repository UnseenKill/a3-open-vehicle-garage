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
    ["_category", nil],
    ["_displayName", nil],
    ["_owner", nil],
    ["_serialized", nil],
    ["_uuid", nil],
    ["_vehicle", nil],

    // Methods
    METHOD_DEFINE_NAME(#create,CTOR),
    METHOD_DEFINE(createUUID),
    METHOD_DEFINE(serialize),
    METHOD_DEFINE(serializeDamage),
    METHOD_DEFINE(serializeFuel),
    METHOD_DEFINE(serializeInventory),
    METHOD_DEFINE(serializeResupply),
    METHOD_DEFINE(serializeWeaponry),
    METHOD_DEFINE(setOwner),
    METHOD_DEFINE(setVehicle),
    METHOD_DEFINE(write)
];
