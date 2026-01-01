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

    // <STRING> - key of vehicle category, lowercase classname
    ["_category", nil],
    // <STRING> - vehicle classname
    ["_className", nil],
    // <STRING> - vehicle display name
    ["_displayName", nil],
    // <STRING> - vehicle owner's playerUID
    ["_owner", nil],
    // <STRING> - vehicle locked to owner only (UID)
    ["_ownerLock", nil],
    // <HASHMAP> - serialized vehicle data; populated on load
    ["_serialized", nil],
    // <STRING> - vehicle unique identifier
    ["_uuid", nil],
    // <OBJECT> - vehicle object
    ["_vehicle", nil],

    // Methods

    /**
     * CTOR(Object vehicle[, String uuid]) -> Nothing
     *
     * Constructor method for vehicle object.
     */
    METHOD_DEFINE_NAME(#create,CTOR),

    /**
     * createUUID() -> String
     *
     * Generate a new UUID for the vehicle.
     */
    METHOD_DEFINE(createUUID),

    /**
     * getCategory() -> Hashmap
     *
     * Get vehicle category metadata.
     */
    METHOD_DEFINE(getCategory),

    /**
     * getUUID() -> String
     *
     * Get the UUID of the vehicle.
     */
    METHOD_DEFINE(getUUID),

    /**
     * isLocked() -> Boolean
     *
     * Check if the vehicle is locked to its owner.
     */
    METHOD_DEFINE(isLocked),

    /**
     * loadFrom(HashMap data) -> Nothing
     *
     * Load vehicle data from serialized data.
     */
    METHOD_DEFINE(loadFrom),

    /**
     * serialize() -> HashMap
     *
     * Convert vehicle to serializable data.
     */
    METHOD_DEFINE(serialize),

    /**
     * serializeDamage(HashMap data) -> Nothing
     *
     * Serialize vehicle damage state into data.
     */
    METHOD_DEFINE(serializeDamage),

    /**
     * serializeFuel(HashMap data) -> Nothing
     *
     * Serialize vehicle fuel state into data.
     */
    METHOD_DEFINE(serializeFuel),

    /**
     * serializeInventory(HashMap data) -> Nothing
     *
     * Serialize vehicle inventory into data.
     */
    METHOD_DEFINE(serializeInventory),

    /**
     * serializeResupply(HashMap data) -> Nothing
     *
     * Serialize vehicle resupply state into data.
     */
    METHOD_DEFINE(serializeResupply),

    /**
     * serializeWeaponry(HashMap data) -> Nothing
     *
     * Serialize vehicle weaponry state into data.
     */
    METHOD_DEFINE(serializeWeaponry),

    /**
     * setOwner(Number playerUID) -> Nothing
     *
     * Set the vehicle owner.
     */
    METHOD_DEFINE(setOwner),

    /**
     * setVehicle(Object vehicle) -> Nothing
     *
     * Set the vehicle object.
     */
    METHOD_DEFINE(setVehicle),

    /**
     * write() -> HashMap
     *
     * Write vehicle data to a storage backend.
     */
    METHOD_DEFINE(write)
];
