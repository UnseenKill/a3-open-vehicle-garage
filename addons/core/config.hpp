// Open vehicle garage config class
class A3OVG_CONFIG_CLASS_BASE {
    scope = 0;

    class Callbacks {
        // Whether players can open the garage
        canOpenGarage = QUOTE(true);
        // How are hint texts shown to the player
        showHint = QUOTE(hint parseText format _this);
    };

    // Feature configurations
    class Features {
        // Save vehicle inventory on garage store
        storeInventory = 1;
    };

    // Data persistence configurations
    class Storage {
        // Adapter to use for data persistence; needs to be overridden in extension configs
        defaultAdapter = "";

        // Base adapter class
        class Adapter {
            scope = 0;
            name = "Storage interface adapter";
        };
    };
};
