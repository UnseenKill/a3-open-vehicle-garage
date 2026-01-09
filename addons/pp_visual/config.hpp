class A3OVG_CONFIG_CLASS_BASE {
    // Position provider base class
    class PositionProvider {
        class Base;
        // Visual position provider; float a model of the vehicle to determine position
        class Visual: Base {
            // Instantiatable
            scope = 1;
            // Class definition name as registered with util_fnc_registerClassDefinition
            className = QADDON;
            // Human-readable name; unused
            name = "Visual position provider";
        };
    };
};
