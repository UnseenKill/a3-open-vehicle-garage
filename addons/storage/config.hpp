class A3OVG_CONFIG_CLASS_BASE {
    // Data persistence configurations
    class Storage {
        // Adapter to use for data persistence; needs to be overridden in extension configs
        defaultAdapter = "";

        // Base adapter class
        class Adapter {
            scope = 0;
            method = QFUNC(storageAdapterBase);
            name = "Storage interface adapter";
        };
    };
};
