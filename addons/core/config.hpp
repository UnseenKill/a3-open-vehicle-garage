// Open vehicle garage config class
class A3OVG_CONFIG_CLASS_BASE {
    scope = 0;

    class Callbacks {
        // (Bool [Object player[, Object garage]]) Whether players can open the garage
        canGarageOpen = QUOTE(true);
        // (Bool [Object player[, Object vehicle]]) Whether players can store a vehicle in the garage
        canVehicleGarage[] = {QUOTE(true)};
        // (Void [String hintText[, ...]]) Show UI hint texts to the player
        showHint = QUOTE(hint parseText format _this);
    };

    // Feature configurations
    class Features {
        // Save vehicle inventory on garage store
        storeInventory = 1;
        // Add "garage vehicle" user actions to any vehicle
        vehicleUserActionGlobal = 1;
        // Radius around a garage in which vehicles can be garaged
        vehicleUserActionRadius = 250;
        // Maximum distance a player can be from their vehicle to garage it
        vehicleUserActionRange = 10;
    };
};
