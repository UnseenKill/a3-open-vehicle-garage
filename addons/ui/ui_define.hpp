#ifndef __HAS_A3OVG_UI_DEFINE_HPP__
#define __HAS_A3OVG_UI_DEFINE_HPP__

// Dialog and control IDs
#define IDD_GARAGE_DIALOG 821601
#define IDC_RSCGARAGEDIALOG_BTN_CLOSE 821610
#define IDC_RSCGARAGEDIALOG_BTN_SPAWN 821611
#define IDC_RSCGARAGEDIALOG_BTN_LOCK 821612
#define IDC_RSCGARAGEDIALOG_BTN_TAB_OVERVIEW 821613
#define IDC_RSCGARAGEDIALOG_BTN_TAB_CUSTOMIZE 821614
#define IDC_RSCGARAGEDIALOG_BTN_MINI_LOCK 821615
#define IDC_RSCGARAGEDIALOG_GROUP_MAIN 821620
#define IDC_RSCGARAGEDIALOG_GROUP_TABHOST 821621
#define IDC_RSCGARAGEDIALOG_GROUP_MINIBTNHOST 821622
#define IDC_RSCGARAGEDIALOG_GROUP_BUTTONSHOST 821623
#define IDC_RSCGARAGEDIALOG_GROUP_TAB_BUTTONSHOST 821624
#define IDC_RSCGARAGEDIALOG_GROUP_TAB_WAIT 821625
#define IDC_RSCGARAGEDIALOG_GROUP_TAB_OVERVIEW 821626
#define IDC_RSCGARAGEDIALOG_GROUP_TAB_OVERVIEW_VEHICLEDYNAMICTEXTHOST 821627
#define IDC_RSCGARAGEDIALOG_GROUP_TAB_CUSTOMIZE 821628
#define IDC_RSCGARAGEDIALOG_LIST_VEHICLES 821630
#define IDC_RSCGARAGEDIALOG_TEXT_STATUSBAR 821640
#define IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLENAME 821641
#define IDC_RSCGARAGEDIALOG_TEXT_TAB_OVERVIEW_VEHICLEAUTHOR 821642
#define IDC_RSCGARAGEDIALOG_TEXT_TAB_PREVIEW_PIPDISABLED 821643
#define IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLEEDITORPREVIEW 821650
#define IDC_RSCGARAGEDIALOG_PIC_TAB_OVERVIEW_VEHICLE 821651
#define IDC_RSCGARAGEDIALOG_PIC_TAB_PREVIEW_PIP 821652

// Color macros to get colors from profileNamespace
#define PRGB(name,alpha) {\
    QUOTE(profileNamespace getVariable QQUOTE(DOUBLES(name,R))), \
    QUOTE(profileNamespace getVariable QQUOTE(DOUBLES(name,G))), \
    QUOTE(profileNamespace getVariable QQUOTE(DOUBLES(name,B))), \
    alpha \
}
#define PRGBA(name) PRGB(name,QUOTE(profileNamespace getVariable QQUOTE(DOUBLES(name,A))))

// Commonly used dimensions
#define lineHeight (safeZoneH * 0.03)

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_ANIMATED_USER    99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS              0x0F
#define ST_HPOS             0x03
#define ST_VPOS             0x0C
#define ST_LEFT             0x00
#define ST_RIGHT            0x01
#define ST_CENTER           0x02
#define ST_DOWN             0x04
#define ST_UP               0x08
#define ST_VCENTER          0x0C

#define ST_TYPE             0xF0
#define ST_SINGLE           0
#define ST_MULTI            16
#define ST_TITLE_BAR        32
#define ST_PICTURE          48
#define ST_FRAME            64
#define ST_BACKGROUND       80
#define ST_GROUP_BOX        96
#define ST_GROUP_BOX2       112
#define ST_HUD_BACKGROUND   128
#define ST_TILE_PICTURE     144
#define ST_WITH_RECT        160
#define ST_LINE             176

#define ST_SHADOW               0x100
#define ST_NO_RECT              0x200 // this style works for CT_STATIC in conjunction with ST_MULTI
#define ST_KEEP_ASPECT_RATIO    0x800

#define ST_TITLE            ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR              0x400
#define SL_VERT             0
#define SL_HORZ             0x400

#define SL_TEXTURES         0x10

#endif // __HAS_A3OVG_UI_DEFINE_HPP__
