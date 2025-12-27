// Open vehicle garage config class
class A3OVG_CONFIG_CLASS_BASE {
    scope = 0;

    #define QCOND(condition,string) QUOTE((condition) || {[LQELSTRING(UI,string)] call FUNCMAIN(uiStackHint)})
    #define V (_this select 0)
    class Callbacks {
        // (Bool [Object player[, Object garage]]) Whether players can open the garage
        canGarageOpen = QUOTE(true);
        // (Bool [Object vehicle, Object player]) Whether players can store a vehicle in the garage
        canVehicleGarage[] = {
            QUOTE(true),
            QCOND(alive V,VehicleGarageDeniedDead),
            QCOND(locked V <= 1,VehicleGarageDeniedLocked),
            QCOND(crew V isEqualTo [],VehicleGarageDeniedCrewed),
            QCOND(attachedTo V isEqualTo [],VehicleGarageDeniedAttachedToSomething),
            QCOND(V distance(_this select 1) <= 25,VehicleGarageDeniedTooFarFromGarage)
        };
    };
    #undef V
    #undef QCOND

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
