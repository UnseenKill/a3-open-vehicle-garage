#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_storage_fnc_storageAdapterBase

Description:
    Return storage interface hashmap object description.

Parameters:

Optional:

Example:

Returns:
    <HASHMAP>

Environment:
    Both, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(storageAdapterBase),_this);

createHashMapFromArray[
    ["#type", [QADDON]],
    ["#flags", ["sealed", "unscheduled"]],

    // Properties
    ["_adapterConfig", nil],
    ["_autoCommit", nil],
    ["_prefixSeparator", nil],
    ["_storageDatabase", nil],
    ["_storagePrefix", nil],

    /**
     * commitChanges() -> Nothing
     *
     * Commit any pending changes to storage backend.
     */
    METHOD_ABSTRACT(commitChanges),

    /**
     * deleteKey(String section, String key) -> Bool
     *
     * Delete all entries associated with given key from storage backend.
     */
    METHOD_ABSTRACT(deleteKey),

    /**
     * readKey(String section, String key) -> Any
     *
     * Read value from storage backend. Should return `nil` if key does not exist.
     */
    METHOD_ABSTRACT(readKey),

    /**
     * writeKey(String section, String key, Any value) -> Bool
     *
     * Write value to storage backend.
     */
    METHOD_ABSTRACT(writeKey),

    /**
     * getPrefixSeparator() -> String
     *
     * Get the separator string used between prefix and UUID in storage keys.
     */
    METHOD_ABSTRACT(getPrefixSeparator),

    /**
     * #create(String databaseName[, String prefix])
     *
     * Constructor method for storage adapter instance.
     */
    METHOD_DEFINE_NAME(#create,CTOR),

    /**
     * #str() -> String
     *
     * String representation of storage adapter instance.
     */
    METHOD_DEFINE_NAME(#str,toString),

    /**
     * commit([Boolean force=false]) -> Nothing
     *
     * Commit any pending changes to storage backend.
     *
     * If `force` is false, don't commit if auto-commit is disabled.
     */
    METHOD_DEFINE(commit),

    /**
     * getKey(String uuid) -> String
     *
     * Create storage key including prefix etc. for given UUID.
     */
    METHOD_DEFINE(getKey),

    /**
     * initialize() -> Nothing
     *
     * Initialize storage adapter instance. Called after construction.
     */
    METHOD_DEFINE(initialize),

    /**
     * read(String section, String key[, Array expectedDataTypes]) -> Any
     *
     * Read serialized data from storage backend.
     */
    METHOD_DEFINE(read),

    /**
     * removeVehicle(String uuid) -> Bool
     *
     * Remove vehicle storage data from storage backend.
     */
    METHOD_DEFINE(removeVehicle),

    /**
     * toStringExtra() -> Array
     *
     * Extra information for string representation.
     */
    METHOD_DEFINE_BODY(toStringExtra,[]),

    /**
     * updateTOC(String uuid, HashMap data, Bool create) -> Bool
     *
     * Update the Table of Contents (TOC) for vehicle storage.
     */
    METHOD_DEFINE(updateTOC),

    /**
     * write(String section, String key, Any value) -> Bool
     *
     * Write value to storage backend.
     */
    METHOD_DEFINE(write),

    /**
     * writeVehicle(String uuid, HashMap data) -> Bool
     *
     * Save serialized vehicle storage data to storage backend.
     */
    METHOD_DEFINE(writeVehicle)
];
