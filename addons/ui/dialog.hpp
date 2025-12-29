#include "ui_define.hpp"

class GVAR(RscTitleBar) : RscText {
    y = QUOTE(safeZoneY + 0.1 * safeZoneH);
    h = QUOTE(safeZoneH * 0.03);
    w = QUOTE(safeZoneW * 0.4);
    sizeEx = QUOTE(safeZoneH * 0.025);
    colorBackground[] = PRGBA(GUI_BCG_RGB);
};

class GVAR(RscText) : RscText {
    h = QUOTE(lineHeight);
    sizeEx = QUOTE(safeZoneH * 0.02);
};

class GVAR(RscTextTitle) : GVAR(RscText) {
    colorBackground[] = PRGBA(GUI_BCG_RGB);
};

class GVAR(Dialog) {
    idd = IDD_GARAGE_DIALOG;
    movingEnable = 0;

    class Controls {
        class Title: GVAR(RscTitleBar) {
            text = CSTRING(GarageDialog_TitleMain);
            x = QUOTE(safeZoneX + 0.1 * safeZoneW);
        };
        class Branding: GVAR(RscTitleBar) {
            text = CSTRING(GarageDialog_TitlePoweredBy);
            x = QUOTE(safeZoneX + 0.5 * safeZoneW);
            style = QUOTE(ST_RIGHT);
        };

        class Background: RscControlsGroup {
            x = QUOTE(safeZoneX + 0.1 * safeZoneW);
            y = QUOTE(safeZoneY + 0.13 * safeZoneH + pixelH * 8);
            w = QUOTE(safeZoneW * 0.8);
            h = QUOTE(safeZoneH * 0.75);

            class Controls {
                class Background: GVAR(RscText) {
                    x = 0;
                    y = 0;
                    w = QUOTE(safeZoneW * 0.8);
                    h = QUOTE(safeZoneH * 0.75);
                    colorBackground[] = {0,0,0,0.25};
                };

                class PanelLeft: RscControlsGroup {
                    x = QUOTE(pixelW * 8);
                    y = QUOTE(pixelH * 8);
                    w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                    h = QUOTE(safeZoneH * 0.75 - pixelH * 16 - lineHeight);

                    class Controls {
                        class PanelTitle: GVAR(RscTextTitle) {
                            text = CSTRING(GarageDialog_PanelLeftTitle);
                            x = 0;
                            y = 0;
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                        };

                        class VehicleList: RscTree {
                            idc = IDC_RSCGARAGEDIALOG_LIST_VEHICLES;
                            x = 0;
                            y = QUOTE(pixelH * 8 + lineHeight);
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                            h = QUOTE(safeZoneH * 0.75 - pixelH * 32 - lineHeight * 3);
                            colorBackground[] = {0,0,0,0.4};
                        };

                        class Buttons: RscControlsGroup {
                            x = 0;
                            y = QUOTE(safeZoneH * 0.75 - pixelH * 24 - lineHeight * 2);
                            w = QUOTE(safeZoneW * 0.2 - pixelW * 16);
                            h = QUOTE(pixelH * 8 + lineHeight);

                            class Controls {
                                class SpawnButton: RscButton {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_SPAWN;
                                    text = CSTRING(GarageDialog_BtnSpawn);
                                    x = 0;
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 - pixelW * 4);
                                    h = QUOTE(lineHeight);
                                };

                                class CloseButton: RscButton {
                                    idc = IDC_RSCGARAGEDIALOG_BTN_CLOSE;
                                    text = CSTRING(GarageDialog_BtnClose);
                                    x = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 + pixelW * 4);
                                    y = QUOTE(pixelH * 8);
                                    w = QUOTE((safeZoneW * 0.2 - pixelW * 16) / 2 - pixelW * 4);
                                    h = QUOTE(lineHeight);
                                    action = "closeDialog 0";
                                };
                            };
                        };
                    };
                };

                class StatusBar: GVAR(RscTextTitle) {
                    idc = IDC_RSCGARAGEDIALOG_TEXT_STATUSBAR;
                    text = "";
                    x = 0;
                    y = QUOTE(safeZoneH * 0.75 - lineHeight);
                    w = QUOTE(safeZoneW * 0.8);
                    h = QUOTE(lineHeight);
                };
            };
        };
    };
};
