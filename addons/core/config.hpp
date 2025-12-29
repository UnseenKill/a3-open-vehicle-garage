// Open vehicle garage config class
class A3OVG_CONFIG_CLASS_BASE {
    scope = 0;

    #define QCOND(condition,string) QUOTE((condition) || {[LQELSTRING(UI,string)] call FUNCMAIN(uiStackHint)})
    #define V (_this select 0)
    class Callbacks {
        // (Bool [Object player[, Object garage]]) Whether players can open the garage
        canGarageOpen = QUOTE(true);
        // (Bool [Object attached]) Whether things attached to a vehicle can be ignored when garaging
        canIgnoreAttached = QUOTE([ARR_3(QQUOTE(Chemlight_base),QQUOTE(IRStrobeBase),QQUOTE(ACE_IR_Strobe_Effect))] findIf {(_this select 0) isKindOf _x} != -1);
        // (Bool [Object vehicle, Object player]) Whether players can store a vehicle in the garage
        canVehicleGarage[] = {
            QCOND([ARR_3(QQUOTE(LandVehicle),QQUOTE(Ship),QQUOTE(Air))] findIf {V isKindOf _x} != -1,VehicleGarageDeniedNotAVehicle),
            QCOND(alive V,VehicleGarageDeniedDead),
            QCOND(locked V <= 1,VehicleGarageDeniedLocked),
            QCOND(crew V isEqualTo [],VehicleGarageDeniedCrewed),
            QCOND(isNull attachedTo V,VehicleGarageDeniedAttachedToSomething),
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

    // Dummy strings so HEMTT picks them up as "used"; it doesn't within quotes in .hpp files
    class Strings {
        class UI {
            stringsUsed[] = {
                ECSTRING(UI,VehicleGarageDeniedAttachedToSomething),
                ECSTRING(UI,VehicleGarageDeniedCrewed),
                ECSTRING(UI,VehicleGarageDeniedDead),
                ECSTRING(UI,VehicleGarageDeniedLocked),
                ECSTRING(UI,VehicleGarageDeniedNotAVehicle),
                ECSTRING(UI,VehicleGarageDeniedTooFarFromGarage)
            };
        };
    };
};
