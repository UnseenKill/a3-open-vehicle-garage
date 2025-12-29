class A3OVG_CONFIG_CLASS_BASE {
    // Data persistence configurations
    class Storage {
        // Adapter to use for data persistence; needs to be overridden in extension configs
        defaultAdapter = "";

        // Base adapter class
        class Adapter {
            // Not to be instantiated directly
            scope = 0;
            // Automatically save changes
            autoCommit = 1; 
            // Class definition name as registered with util_fnc_registerClassDefinition
            className = QADDON;
            // Human-readable name; unused
            name = "Storage interface adapter";
        };
    };
};
