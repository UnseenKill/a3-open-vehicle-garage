/**
 * Full forward declaration of config base class for use with third party mods
 * that need to extend A3OVG_Config without having to infer how this class
 * looks like.
 */
class A3OVG_Config_Base {
    class Callbacks;

    class Categories {
        class Base;
        class Car;
        class Default;
        class Helicopter;
        class Plane;
        class Ship;
        class Tank;
    };

    class Features;

    class Storage {
        class Adapter;
        class Adapter_INIDBI2;
        class Adapter_NS;
    };
};
