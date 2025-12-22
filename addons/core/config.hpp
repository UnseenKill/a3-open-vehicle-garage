// Open vehicle garage config class
class A3OVG_CONFIG_CLASS_BASE {
    scope = 0;

    class Callbacks {
        // (Bool [Object player[, Object garage]]) Whether players can open the garage
        canGarageOpen = QUOTE(true);
        // (Void [String hintText[, ...]]) Show UI hint texts to the player
        showHint = QUOTE(hint parseText format _this);
    };

    // Feature configurations
    class Features {
        // Save vehicle inventory on garage store
        storeInventory = 1;
    };
};
