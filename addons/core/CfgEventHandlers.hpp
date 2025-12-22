#define A3OVG_VEHICLE_INIT_POST() \
    class DOUBLES(ADDON,VehiclePost) { \
        init = QUOTE(call FUNC(xehVehicleInitPost)); \
    }

class Extended_InitPost_EventHandlers {
    class Air {
        A3OVG_VEHICLE_INIT_POST();
    };

    class LandVehicle {
        A3OVG_VEHICLE_INIT_POST();
    };

    class Ship {
        A3OVG_VEHICLE_INIT_POST();
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};
