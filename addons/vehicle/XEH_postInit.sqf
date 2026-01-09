#include "script_component.hpp"

INFO("Comiling vehicle categories filters...");
GVAR(categoryFilters) = compileFinal([] call FUNC(compileCategoryFilters));
