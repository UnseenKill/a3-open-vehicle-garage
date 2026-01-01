#define A3OVG_EVENT_GARAGE_OPEN_AFTER QUOTE(TRIPLES(PREFIX,garage,openAfter))
#define A3OVG_EVENT_GARAGE_OPEN_BEFORE QUOTE(TRIPLES(PREFIX,garage,openBefore))

// Params: [Control _button, Display _display]
#define A3OVG_EVENT_UI_BUTTON_MINILOCK_CLICKED QUOTE(TRIPLES(PREFIX,event,uiButtonMiniLockClicked))
// Params: [Control _button, Display _display]
#define A3OVG_EVENT_UI_BUTTON_MINIRENAME_CLICKED QUOTE(TRIPLES(PREFIX,event,uiButtonMiniRenameClicked))
// Params: [Control _button, Display _display]
#define A3OVG_EVENT_UI_BUTTON_MINIREARM_CLICKED QUOTE(TRIPLES(PREFIX,event,uiButtonMiniRearmClicked))
// Params: [Control _button, Display _display]
#define A3OVG_EVENT_UI_BUTTON_MINIREPAIR_CLICKED QUOTE(TRIPLES(PREFIX,event,uiButtonMiniRepairClicked))
// Params: [Control _button, Display _display]
#define A3OVG_EVENT_UI_BUTTON_MINIREFUEL_CLICKED QUOTE(TRIPLES(PREFIX,event,uiButtonMiniRefuelClicked))

// Params: [Control _tabHostCtrl]
#define A3OVG_EVENT_UI_DIALOG_TABCHANGED_AFTER QUOTE(TRIPLES(PREFIX,event,uiDialogTabChangedAfter))
// Params: [Control _tabHostCtrl]
#define A3OVG_EVENT_UI_DIALOG_TABCHANGED_BEFORE QUOTE(TRIPLES(PREFIX,event,uiDialogTabChangedBefore))
// Params: [Vehicle _vehicle]
#define A3OVG_EVENT_UI_VEHICLE_DATACHANGED QUOTE(TRIPLES(PREFIX,event,uiVehicleChanged))
// Params: []
#define A3OVG_EVENT_UI_VEHICLE_SELECTIONCHANGED QUOTE(TRIPLES(PREFIX,event,uiVehicleSelectionChanged))
