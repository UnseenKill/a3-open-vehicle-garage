// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX A3OVG

#include "script_production.hpp"
#include "script_version.hpp"
#include "cba_events.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.20

// Define DEBUG_MODE_FULL for full debug mode when not in production
#ifndef __A3OVG_PRODUCTION__
    #define DEBUG_MODE_FULL
#endif

/*
// Defined DEBUG_MODE_NORMAL in a few CBA_fncs to prevent looped logging :)
#ifndef DEBUG_MODE_NORMAL
    #define DEBUG_MODE_FULL
#endif
*/

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).
/*
    #define DEBUG_ENABLED_COMMON
    #define DEBUG_ENABLED_DIAGNOSTIC
    #define DEBUG_ENABLED_EVENTS
    #define DEBUG_ENABLED_HASHES
    #define DEBUG_ENABLED_MAIN
    #define DEBUG_ENABLED_NETWORK
    #define DEBUG_ENABLED_STRINGS
    #define DEBUG_ENABLED_VERSIONING
*/

#ifdef __A3OVG_PRODUCTION__
    // Remove CfgFunction adding headers and disable SCRIPT macro (comment out to enable for debugging)
    #define SKIP_FUNCTION_HEADER // [Enable for release]
    #define SKIP_SCRIPT_NAME // [Enable for release]
#else
    #define RECOMPILE // [Disable for release]
    #define DISABLE_COMPILE_CACHE
#endif
