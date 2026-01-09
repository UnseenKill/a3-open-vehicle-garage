class A3OVG_CONFIG_CLASS_BASE {
    // Vehicle categories configuration
    class Categories {
        class Base {
            // Not to be instantiated directly
            scope = 0;
            // The higher, the earlier probed
            priority = 0;
            // Sort order; alphabetical if equal order
            sortOrder = 25;
            // Category display name
            displayName = "";
            // Icon for the category
            icon = "";
            // filter function: Bool [Object vehicle]
            filter[] = {QUOTE(true)};
        };

        #define V (_this select 0)
        class Default: Base {
            scope = 1;
            priority = 0;
            sortOrder = 0;
            displayName = ECSTRING(UI,VehicleCategoryDefault);
            icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa";
        };

        class Car: Base {
            scope = 1;
            priority = 50;
            sortOrder = 50;
            displayName = ECSTRING(UI,VehicleCategoryCar);
            icon = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\car_ca.paa";
            filter[] = {QUOTE(V isKindOf QQUOTE(Car))};
        };

        class Helicopter: Base {
            scope = 1;
            priority = 100;
            sortOrder = 20;
            displayName = ECSTRING(UI,VehicleCategoryHelicopter);
            icon = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\helicopter_ca.paa";
            filter[] = {QUOTE(V isKindOf QQUOTE(Helicopter))};
        };

        class Plane: Helicopter {
            priority = 99;
            displayName = ECSTRING(UI,VehicleCategoryPlane);
            icon = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\plane_ca.paa";
            filter[] = {QUOTE(V isKindOf QQUOTE(Air))};
        };

        class Ship: Base {
            scope = 1;
            priority = 100;
            sortOrder = 10;
            displayName = ECSTRING(UI,VehicleCategoryShip);
            icon = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\naval_ca.paa";
            filter[] = {QUOTE(V isKindOf QQUOTE(Ship))};
        };

        class Tank: Base {
            scope = 1;
            priority = 100;
            sortOrder = 10;
            displayName = ECSTRING(UI,VehicleCategoryTank);
            icon = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\tank_ca.paa";
            filter[] = {QUOTE(V isKindOf QQUOTE(Tank))};
        };
        #undef V
    };
};
