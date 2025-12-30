#include "..\script_component.hpp"
#include "..\ui_define.hpp"
/* ----------------------------------------------------------------------------
Function: A3OVG_ui_fnc_dialogOnLoad

Description:
    Function called when the Garage Dialog is loaded. Sets up necessary data
    and UI elements.

Parameters:
    0: _display - Dialog <DISPLAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
A3OVG_FUNCTION_PREAMBLE(QFUNC(dialogOnLoad));

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};
if !assert(!isNull _display) exitWith {};

INFO("Garage Dialog loading.");

uiNamespace setVariable[QGVAR(dialog), _display];
uiNamespace setVariable[QGVAR(dialogControls), createHashMapFromArray[
    ["mainGroup", _display displayCtrl IDC_RSCGARAGEDIALOG_GROUP_MAIN],
    ["previewVehiclePicture", _display displayCtrl IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLE],
    ["previewVehicleName", _display displayCtrl IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLENAME],
    ["previewVehicleCredit", _display displayCtrl IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLEAUTHOR],
    ["previewVehicleEditorPreview", _display displayCtrl IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLEEDITORPREVIEW],
    ["previewVehicleTextHost", _display displayCtrl IDC_RSCGARAGEDIALOG_GROUP_TAB_OVERVIEW_VEHICLEDYNAMICTEXTHOST],
    ["statusBar", _display displayCtrl IDC_RSCGARAGEDIALOG_TEXT_STATUSBAR],
    ["tabHost", _display displayCtrl IDC_RSCGARAGEDIALOG_GROUP_TABHOST],
    ["treeView", _display displayCtrl IDC_RSCGARAGEDIALOG_LIST_VEHICLES],
    ["waitTab", _display displayCtrl IDC_RSCGARAGEDIALOG_GROUP_TAB_WAIT]
]];

with uiNamespace do {
    allControls (GVAR(dialogControls) get "tabHost") 
        select { ctrlType _x isEqualTo CT_CONTROLS_GROUP }
        apply {
            _x ctrlSetFade 1;
            _x ctrlCommit 0;
        };

    private _treeView = GVAR(dialogControls) get "treeView";
    _treeView setVariable[QGVAR(loading), createHashMap];
    _treeView ctrlAddEventHandler["TreeExpanded", { call FUNC(dialogOnTreeExpanded) }];
    _treeView ctrlAddEventHandler["TreeSelChanged", { call FUNC(dialogOnTreeSelChanged) }];
};

[true] call FUNC(dialogSetLoading);
[] spawn FUNC(triggerServerLoadTOC);

nil;
