class A3OVG_CONFIG_CLASS_BASE {
    class Callbacks {
        // (Void [String hintTextStructured]) Show UI hint texts to the player
        uiShowHint = QUOTE(hint parseText(_this select 0));
    };

    class Features {
        // Whether to collapse multiple hints into one or execute callback on
        // all hints in current context
        uiHintsCollapse = 0;
        // When collapsing hints, whether to use LIFO when executing subsequent
        // callbacks for non-collapsed hints
        uiHintsUncollapsedLIFO = 1;
    };
};
