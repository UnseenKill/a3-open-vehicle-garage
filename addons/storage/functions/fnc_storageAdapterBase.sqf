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
A3OVG_FUNCTION_PREAMBLE(QFUNC(storageAdapterBase));

createHashMapFromArray[
    ["#flags", ["unscheduled"]],
    ["#type", [QADDON]],

    /**
     * read(String section, String key) -> Any
     *
     * Read value from storage backend.
     */
    METHOD_ABSTRACT(read),

    /**
     * write(String section, String key, Any value) -> Bool
     *
     * Write value to storage backend.
     */
    METHOD_ABSTRACT(write),

    /**
     * deleteKey(String key) -> Bool
     *
     * Delete all entries associated with given key from storage backend.
     */
    METHOD_ABSTRACT(deleteKey),

    /**
     * #create()
     *
     * Constructor method for storage adapter instance.
     */
    METHOD_DEFINE_NAME(#create,CTOR),

    /**
     * getKey(String uuid) -> String
     *
     * Create storage key including prefix etc. for given UUID.
     */
    METHOD_DEFINE(getKey),

    /**
     * writeVehicle(String uuid, HashMap data) -> Bool
     *
     * Save serialized vehicle storage data to storage backend.
     */
    METHOD_DEFINE(writeVehicle)
];
