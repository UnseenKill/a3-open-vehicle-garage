class A3OVG_CONFIG_CLASS_BASE {
    // Position provider base class
    class PositionProvider {
        class Base;
        // Simple position provider; use findEmptyPosition and place the vehicle
        class Simple: Base {
            // Instantiatable
            scope = 1;
            // Class definition name as registered with util_fnc_registerClassDefinition
            className = QADDON;
            // Human-readable name; unused
            name = "Simple position provider";
        };
    };
};
