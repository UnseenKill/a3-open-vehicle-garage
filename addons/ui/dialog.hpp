#include "\z\a3ovg\addons\ui\ui_define.hpp"

// Forward declarations
#ifndef __A3OVG_IS_3DEN__
    #define FORWARD(x) class x
#else
    #define FORWARD(x) import x
#endif // __A3OVG_IS_3DEN__

FORWARD(RscActiveText);
FORWARD(RscButton);
FORWARD(RscControlsGroup);
FORWARD(RscLine);
FORWARD(RscPicture);
FORWARD(RscPictureKeepAspect);
FORWARD(RscStructuredText);
FORWARD(RscText);
FORWARD(RscTree);
#undef FORWARD

class GVAR(RscButton): RscButton {
    sizeEx = QUOTE(safeZoneH * 0.025);
};

class GVAR(RscButtonDefault): GVAR(RscButton) {
    colorBackground[] = PRGBA(GUI_BCG_RGB);
    colorBackgroundActive[] = PRGBA(GUI_BCG_RGB);
    colorBackgroundDisabled[] = PRGB(GUI_BCG_RGB,0.5);
};

class GVAR(RscMiniButton): RscActiveText {
    style = ST_PICTURE;

    color[] = {0.6,0.6,0.6,1};
    colorActive[] = {1,1,1,1};
    colorBackground[] = {0,0,1,0.75};

    x = QUOTE(pixelW * 4);
    y = QUOTE(pixelH * 4);
    w = QUOTE(pixelW * 48);
    h = QUOTE(pixelH * 48);
};

class GVAR(RscTabButton): GVAR(RscButton) {
    y = 0;
    w = QUOTE(safeZoneW * 0.1);
    h = QUOTE(lineHeight);
};

class GVAR(RscText) : RscText {
    x = 0;
    y = 0;
    h = QUOTE(lineHeight);
    w = 0;
    sizeEx = QUOTE(safeZoneH * 0.02);
};

class GVAR(RscTextBackground) : GVAR(RscText) {
    colorBackground[] = {0,0,0,0.25};
};

class GVAR(RscTextTitle) : GVAR(RscText) {
    colorBackground[] = PRGBA(GUI_BCG_RGB);
};

class GVAR(RscTitleBar) : RscText {
    y = QUOTE(safeZoneY + 0.1 * safeZoneH);
    h = QUOTE(safeZoneH * 0.03);
    w = QUOTE(safeZoneW * 0.4);
    sizeEx = QUOTE(safeZoneH * 0.025);
    colorBackground[] = PRGBA(GUI_BCG_RGB);
};

class GVAR(Dialog) {
    idd = IDD_GARAGE_DIALOG;
    movingEnable = 0;
    onLoad = QUOTE(call FUNC(dialogOnLoad));
    onUnload = QUOTE(call FUNC(dialogOnUnload));

    class Controls {
        class Title: GVAR(RscTitleBar) {
            text = CSTRING(GarageDialog_TitleMain_Label);
            x = QUOTE(safeZoneX + safeZoneW * 0.1);
        };

        class Branding: GVAR(RscTitleBar) {
            text = CSTRING(GarageDialog_TitlePoweredBy_Label);
            x = QUOTE(safeZoneX + safeZoneW * 0.5);
            style = QUOTE(ST_RIGHT);
        };

        class Main: RscControlsGroup {
            idc = IDC_RSCGARAGEDIALOG_GROUP_MAIN;
            x = QUOTE(safeZoneX + safeZoneW * 0.1);
            y = QUOTE(safeZoneY + safeZoneH * 0.13 + pixelH * 8);
            w = QUOTE(safeZoneW * 0.8);
            h = QUOTE(safeZoneH * 0.75);

            class Controls {
                class Background: GVAR(RscTextBackground) {
                    w = QUOTE(safeZoneW * 0.8);
                    h = QUOTE(safeZoneH * 0.75);
                };

                class PanelLeft: RscControlsGroup {
                    x = QUOTE(pixelW * 8);
                    y = QUOTE(pixelH * 8);
                    w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                    h = QUOTE(safeZoneH * 0.75 - pixelH * 16);

                    class Controls {
                        class PanelTitle: GVAR(RscTextTitle) {
                            text = CSTRING(GarageDialog_PanelLeftTitle_Label);
                            x = 0;
                            y = 0;
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                        };

                        class MiniButtons: RscControlsGroup {
                            x = 0;
                            y = QUOTE(pixelH * 8 + lineHeight);
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                            h = QUOTE(lineHeight - pixelH * 8);

                            class Controls {
                                class BG: RscText {
                                    w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                                    h = QUOTE(lineHeight - pixelH * 8);
                                    colorBackground[] = {0,0,0,0.4};
                                };

                                class ButtonShortLock: GVAR(RscMiniButton) {
                                    tooltip = CSTRING(GarageDialog_BtnLock_Label);
                                    text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayDynamicGroups\Lock.paa";
                                    x = QUOTE(safeZoneW * 0.2 - pixelW * 80);
                                };

                                class ButtonShortRename: GVAR(RscMiniButton) {
                                    tooltip = CSTRING(GarageDialog_BtnMiniRename_Label);
                                    text = "\z\a3ovg\addons\ui\icons\action-edit.paa";
                                    x = QUOTE(safeZoneW * 0.2 - pixelW * 128);
                                };

                                class ButtonShortRearm: GVAR(RscMiniButton) {
                                    tooltip = CSTRING(GarageDialog_BtnMiniRearm_Label);
                                    text = "\A3\Ui_F\data\IGUI\Cfg\Actions\reammo_ca.paa";
                                    x = QUOTE(safeZoneW * 0.2 - pixelW * 172);
                                };

                                class ButtonShortRepair: GVAR(RscMiniButton) {
                                    tooltip = CSTRING(GarageDialog_BtnMiniRepair_Label);
                                    text = "\A3\Ui_F\data\IGUI\Cfg\Actions\repair_ca.paa";
                                    x = QUOTE(safeZoneW * 0.2 - pixelW * 220);
                                };

                                class ButtonShortRefuel: GVAR(RscMiniButton) {
                                    tooltip = CSTRING(GarageDialog_BtnMiniRefuel_Label);
                                    text = "\A3\Ui_F\data\IGUI\Cfg\Actions\refuel_ca.paa";
                                    x = QUOTE(safeZoneW * 0.2 - pixelW * 268);
                                };
                            };
                        };

                        class VehicleList: RscTree {
                            idc = IDC_RSCGARAGEDIALOG_LIST_VEHICLES;
                            x = 0;
                            y = QUOTE(pixelH * 8 + 2 * lineHeight);
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                            h = QUOTE(safeZoneH * 0.75 - pixelH * 32 - lineHeight * 3);
                            colorBackground[] = {0,0,0,0.4};
                            onLoad = QUOTE(call FUNC(dialogTreeOnLoad));
                        };

                        class Buttons: RscControlsGroup {
                            x = 0;
                            y = QUOTE(safeZoneH * 0.75 - pixelH * 24 - lineHeight);
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                            h = QUOTE(pixelH * 8 + lineHeight);

                            class Controls {
                                class ButtonSpawn: RscButton {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_SPAWN;
                                    text = CSTRING(GarageDialog_BtnSpawn_Label);
                                    x = 0;
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 - pixelW * 4);
                                    h = QUOTE(lineHeight);
                                };

                                class ButtonLock: RscButton {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_LOCK;
                                    text = CSTRING(GarageDialog_BtnLock_Label);
                                    tooltip = CSTRING(GarageDialog_BtnLock_Tooltip);
                                    x = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 + pixelW * 4);
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 - pixelW * 4);
                                    h = QUOTE(lineHeight);
                                };
                            };
                        };
                    };
                };

                class PanelMain: RscControlsGroup {
                    x = QUOTE(safeZoneW * 0.2);
                    y = QUOTE(pixelH * 8);
                    w = QUOTE(safeZoneW * 0.6 - pixelW * 8);
                    h = QUOTE(safeZoneH * 0.75 - pixelH * 16);

                    class Controls {
                        class TabButtonBar: RscControlsGroup {
                            x = 0;
                            y = 0;
                            w = QUOTE(safeZoneW * 0.6 - pixelW * 8);
                            h = QUOTE(lineHeight);

                            class Controls {
                                class ButtonOverview: GVAR(RscTabButton) {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_TAB_OVERVIEW;
                                    text = CSTRING(GarageDialog_BtnTabOverview_Label);
                                    x = 0;
                                };

                                class ButtonCustomize: GVAR(RscTabButton) {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_TAB_CUSTOMIZE;
                                    text = CSTRING(GarageDialog_BtnTabCustomize_Label);
                                    x = QUOTE(safeZoneW * 0.1 + pixelW * 8);
                                };
                            };
                        };

                        class TabHost: RscControlsGroup {
                            idc = IDC_RSCGARAGEDIALOG_GROUP_TABHOST;
                            x = 0;
                            y = QUOTE(lineHeight + pixelH * 8);
                            w = QUOTE(safeZoneW * 0.6 - pixelW * 8);
                            h = QUOTE(safeZoneH * 0.75 - pixelH * 24 - lineHeight);

                            class Controls {
                                class Background: GVAR(RscTextBackground) {
                                    w = QUOTE(safeZoneW * 0.6 - pixelW * 8);
                                    h = QUOTE(safeZoneH * 0.75 - pixelH * 24 - lineHeight);
                                };

                                class TabWait: RscControlsGroup {
                                    idc = IDC_RSCGARAGEDIALOG_GROUP_TAB_WAIT;
                                    fade = 1;
                                    x = QUOTE(pixelW * 8);
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                    h = QUOTE(safeZoneH * 0.75 - pixelH * 40 - lineHeight);

                                    onLoad = QUOTE((_this select 0) setVariable[ARR_2(QQGVAR(isMainTabhost),true)]);

                                    class Controls {
                                        class Hourglass: RscPictureKeepAspect {
                                            text = "\z\a3ovg\addons\ui\icons\wait-large-hourglass.paa";
                                            x = QUOTE(safeZoneW * 0.2);
                                            y = QUOTE(safeZoneH * 0.2);
                                            w = QUOTE(safeZoneW * 0.2);
                                            h = QUOTE(safeZoneH * 0.2);
                                        };
                                    };
                                };

                                class TabOverview: RscControlsGroup {
                                    idc = IDC_RSCGARAGEDIALOG_GROUP_TAB_OVERVIEW;
                                    fade = 1;
                                    x = QUOTE(pixelW * 8);
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                    h = QUOTE(safeZoneH * 0.75 - pixelH * 40 - lineHeight);

                                    onLoad = QUOTE((_this select 0) setVariable[ARR_2(QQGVAR(isMainTabhost),true)]);

                                    class Controls {
                                        class VehiclePicture: RscPictureKeepAspect {
                                            idc = IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLE;
                                            text = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_hmg_F_ca.paa";
                                            x = QUOTE(safeZoneW * 0.6 - pixelW * 24 - lineHeight * 3);
                                            y = 0;
                                            w = QUOTE(lineHeight * 3);
                                            h = QUOTE(lineHeight * 3);
                                        };

                                        class VehicleName: RscStructuredText {
                                            idc = IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLENAME;
                                            text = "Hunter HMG";
                                            x = 0;
                                            y = 0;
                                            w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                            h = QUOTE(lineHeight * 1.5);
                                            sizeEx = QUOTE(safeZoneH * 0.04);
                                        };

                                        class VehicleAuthor: RscStructuredText {
                                            idc = IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLEAUTHOR;
                                            text = "By: Red Hammer Studios";
                                            x = 0;
                                            y = QUOTE(lineHeight * 1.5);
                                            w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                            h = QUOTE(lineHeight * 1.5);
                                            sizeEx = QUOTE(safeZoneH * 0.03);
                                        };

                                        class S0: RscLine {
                                            x = 0;
                                            y = QUOTE(lineHeight * 3);
                                            w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                            h = 0;
                                        };

                                        class VehicleEditorPreview: RscPicture {
                                            idc = IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLEEDITORPREVIEW;
                                            text = "\A3\EditorPreviews_F\Data\CfgVehicles\B_MRAP_01_hmg_F.jpg";
                                            x = QUOTE(safeZoneW * 0.42 - pixelW * 24);
                                            y = QUOTE(3 * lineHeight + pixelH * 8);
                                            w = QUOTE(safeZoneW * 0.18);
                                            h = QUOTE(safeZoneH * 0.18);
                                        };

                                        class VehicleDynamicText: RscControlsGroup {
                                            idc = IDC_RSCGARAGEDIALOG_GROUP_TAB_OVERVIEW_VEHICLEDYNAMICTEXTHOST;
                                            x = 0;
                                            y = QUOTE(6 * lineHeight);
                                            w = QUOTE(safeZoneW * 0.6 - pixelW * 24);
                                            h = QUOTE(safeZoneH * 0.75 - pixelH * 40 - 7 * lineHeight);
                                            sizeEx = QUOTE(safeZoneH * 0.02);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };

        class StatusBar: GVAR(RscTextTitle) {
            idc = IDC_RSCGARAGEDIALOG_TEXT_STATUSBAR;
            text = "";
            x = QUOTE(safeZoneX + safeZoneW * 0.1);
            y = QUOTE(safeZoneY + safeZoneH * 0.88 + pixelH * 16);
            w = QUOTE(safeZoneW * 0.725);
            h = QUOTE(lineHeight);
        };

        class BtnClose: GVAR(RscButtonDefault) {
            idc = IDC_RSCGARAGEDIALOG_BTN_CLOSE;
            text = CSTRING(GarageDialog_BtnClose_Label);
            x = QUOTE(safeZoneX + safeZoneW * 0.825 + pixelW * 8);
            y = QUOTE(safeZoneY + safeZoneH * 0.88 + pixelH * 16);
            w = QUOTE(safeZoneW * 0.075 - pixelW * 8);
            h = QUOTE(lineHeight);
            action = "closeDialog 0";
        };
    };
};
