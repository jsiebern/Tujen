#include Gui\GetRange.ahk
#include Gui\Tujen_Gui_Helpers.ahk
#include Gui\Tujen_Gui_Functions.ahk
#include Gui\Tujen_Gui_Stats.ahk

IniRead, STR_TUJEN_CHARACTER, % INI_FILE, FindTextStrings, STR_TUJEN_CHARACTER, % " "
IniRead, STR_HAGGLE_FOR_ITEMS, % INI_FILE, FindTextStrings, STR_HAGGLE_FOR_ITEMS, % " "
IniRead, STR_STASH, % INI_FILE, FindTextStrings, STR_STASH, % " "
IniRead, STR_REROLL_CURRENCY, % INI_FILE, FindTextStrings, STR_REROLL_CURRENCY, % " "
IniRead, STR_CONFIRM_BUTTON, % INI_FILE, FindTextStrings, STR_CONFIRM_BUTTON, % " "
IniRead, STR_TUJEN_WINDOW_OPEN, % INI_FILE, FindTextStrings, STR_TUJEN_WINDOW_OPEN, % " "
IniRead, STR_HAGGLE_WINDOW_OPEN, % INI_FILE, FindTextStrings, STR_HAGGLE_WINDOW_OPEN, % " "
IniRead, STR_LESSER_ARTIFACT, % INI_FILE, FindTextStrings, STR_LESSER_ARTIFACT, % " "
IniRead, STR_GREATER_ARTIFACT, % INI_FILE, FindTextStrings, STR_GREATER_ARTIFACT, % " "
IniRead, STR_GRAND_ARTIFACT, % INI_FILE, FindTextStrings, STR_GRAND_ARTIFACT, % " "
IniRead, STR_EXCEPTIONAL_ARTIFACT, % INI_FILE, FindTextStrings, STR_EXCEPTIONAL_ARTIFACT, % " "
IniRead, STR_NUMBERS, % INI_FILE, FindTextStrings, STR_NUMBERS, % "|<0>*45$8.kM6Mb1kQ79mNkyS|<1>*45$5.k1bCQtnb8|<2>*45$7.1YTDbXnnnk82|<3>*45$7.1YTD77VwyDD46DU|<4>*45$8.wSDXkxCHgk01wz7nU|<5>*44$6.U1D71swwws17U|<6>*44$8.ww3Dbty161mQb8b1ts|<7>*44$8.083tyTDnwyTbnwzTU|<8>*45$7.lkH9oH3UY31kk1nk|<9>*45$8.ktaM61WMUCXtyMD7U"
IniRead, STR_NUMBERS_CURSIVE, % INI_FILE, FindTextStrings, STR_NUMBERS_CURSIVE, % "|<0>*46$9.yz1n4sDVwDVsD9t6M7nw|<1>*46$4.UAm9aN4M|<2>*46$8.yw38rDnsyTDbns41U|<3>*45$8.xw6MqDbnsz7lwT7X1ly|<4>*45$9.zjtyDVtD1mQnU00wTXwzbU|<5>*45$8.kA7TXsDlwT7lwyA77s|<6>*45$9.wD0loT7s309lC9lCNX0yTU|<7>*46$8.U83tyTDXtwzDblwzTs|<8>*46$9.wD0naQlC3sS1a9sD8lUTDU|<9>*46$9.zT1l6QXYwbYEk7tyDX0sDU"
IniRead, COORD_HAGGLE_PRICE_X, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_X, % " "
IniRead, COORD_HAGGLE_PRICE_Y, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_Y, % " "
IniRead, COORD_HAGGLE_PRICE_W, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_W, % " "
IniRead, COORD_HAGGLE_PRICE_H, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_H, % " "
IniRead, COORD_COINS_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_X, % " "
IniRead, COORD_COINS_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_Y, % " "
IniRead, COORD_COINS_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_W, % " "
IniRead, COORD_COINS_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_H, % " "
IniRead, COORD_LESSER_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_X, % " "
IniRead, COORD_LESSER_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_Y, % " "
IniRead, COORD_LESSER_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_W, % " "
IniRead, COORD_LESSER_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_H, % " "
IniRead, COORD_GREATER_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_X, % " "
IniRead, COORD_GREATER_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_Y, % " "
IniRead, COORD_GREATER_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_W, % " "
IniRead, COORD_GREATER_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_H, % " "
IniRead, COORD_GRAND_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_X, % " "
IniRead, COORD_GRAND_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_Y, % " "
IniRead, COORD_GRAND_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_W, % " "
IniRead, COORD_GRAND_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_H, % " "
IniRead, COORD_EXCEPTIONAL_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_X, % " "
IniRead, COORD_EXCEPTIONAL_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_Y, % " "
IniRead, COORD_EXCEPTIONAL_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_W, % " "
IniRead, COORD_EXCEPTIONAL_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_H, % " "
IniRead, MOVE_SPEED, % INI_FILE, OtherValues, MOVE_SPEED, 3
IniRead, EMPTY_COLORS, % INI_FILE, OtherValues, EMPTY_COLORS, 0x000100,0x020402,0x000000,0x020302,0x010101,0x010201,0x060906,0x050905,0x030303,0x020202
IniRead, EMPTY_COLORS_HAGGLE_WINDOW, % INI_FILE, OtherValues, EMPTY_COLORS_HAGGLE_WINDOW, 0x000100,0x020402,0x000000,0x020302,0x010101,0x010201,0x060906,0x050905,0x030303,0x020202
IniRead, EMPTY_INVENTORY_AFTER, % INI_FILE, OtherValues, EMPTY_INVENTORY_AFTER, 15
IniRead, PRICE_LESSER, % INI_FILE, Prices, PRICE_LESSER, 0.015
IniRead, PRICE_GREATER, % INI_FILE, Prices, PRICE_GREATER, 0.025
IniRead, PRICE_GRAND, % INI_FILE, Prices, PRICE_GRAND, 0.03
IniRead, PRICE_EXCEPTIONAL, % INI_FILE, Prices, PRICE_EXCEPTIONAL, 0.08
IniRead, ARTIFACT_ENABLED_LESSER, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_LESSER, 1
IniRead, ARTIFACT_ENABLED_GREATER, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_GREATER, 1
IniRead, ARTIFACT_ENABLED_GRAND, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_GRAND, 1
IniRead, ARTIFACT_ENABLED_EXCEPTIONAL, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_EXCEPTIONAL, 1
CURRENCY["EXCEPTIONAL"] := PRICE_EXCEPTIONAL
CURRENCY["GRAND"] := PRICE_GRAND
CURRENCY["GREATER"] := PRICE_GREATER
CURRENCY["LESSER"] := PRICE_LESSER

EMPTY_COLORS := StrSplit(EMPTY_COLORS, ",")
EMPTY_COLORS_HAGGLE_WINDOW := StrSplit(EMPTY_COLORS_HAGGLE_WINDOW, ",")

Gui, Tujen:+AlwaysOnTop

Gui Tujen:Font, s9, Calibri
Gui Tujen:Font
Gui Tujen:Font, s20, Calibri
Gui Tujen:Add, Text, x7 y3 w243 h34 +0x200, Tujen Haggler
Gui Tujen:Font
Gui Tujen:Font, s9, Calibri

Gui Tujen:Add, Button, gGui_OpenCaptureGui x222 y15 w111 h20, Open Capture GUI

xLabel          := 15
wLabel          := 110
xEdit           := 133
wEdit           := 150
xTestButton     := 285
hControl        := 20
spaceControl    := 5

GuiHelper_AddStringField(name, label, Y) {
    global xLabel, xEdit, xTestButton, hControl, wEdit, wLabel

    Gui Tujen:Add, Text, x%xLabel% y%Y% w%wLabel% h%hControl% +0x200, % label
    Gui Tujen:Add, Edit, v%name% x%xEdit% y%Y% w%wEdit% h%hControl%, % %name%
    Gui Tujen:Add, Button, gGui_Test_%name% x%xTestButton% y%Y% w40 h%hControl%, Test
}

GuiHelper_AddCoordinateField(name, label, Y) {
    global xLabel, xEdit, xTestButton, hControl, wEdit, wLabel, spaceControl

    wEditCoordinate := wEdit / 2 - spaceControl * 2
    xEditCoordinate := xEdit + wEditCoordinate + spaceControl
    yEditCoordinate := Y + hControl + spaceControl
    xTestCoordinate := xTestButton - 10

    Gui Tujen:Add, Text, x%xLabel% y%Y% w%wLabel% h%hControl% +0x200, % label
    Gui Tujen:Add, Edit, v%name%_X x%xEdit% y%Y% w%wEditCoordinate% h%hControl%, % %name%_X
    Gui Tujen:Add, Edit, v%name%_Y x%xEditCoordinate% y%Y% w%wEditCoordinate% h%hControl%, % %name%_Y
    Gui Tujen:Add, Edit, v%name%_W x%xEdit% y%yEditCoordinate% w%wEditCoordinate% h%hControl%, % %name%_W
    Gui Tujen:Add, Edit, v%name%_H x%xEditCoordinate% y%yEditCoordinate% w%wEditCoordinate% h%hControl%, % %name%_H
    Gui Tujen:Add, Button, gGui_Capture_%name% x%xTestCoordinate% y%Y% w50 h%hControl%, Capture
    Gui Tujen:Add, Button, gGui_Test_%name% x%xTestCoordinate% y%yEditCoordinate% w50 h%hControl%, Test
    
}

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Clickable targets
yPos := 45
boxHeight := 20 + 4 * (20 + 10) + 20
Gui Tujen:Add, GroupBox, x7 y%yPos% w328 h%boxHeight% -Theme, Click targets
yPos := yPos + 20

; Tujen Character
GuiHelper_AddStringField("STR_TUJEN_CHARACTER", "Tujen Character", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_HAGGLE_FOR_ITEMS", "Haggle for items", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_STASH", "Stash", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_REROLL_CURRENCY", "Reroll Currency", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_CONFIRM_BUTTON", "Confirm Button", yPos)
yPos := yPos + hControl + spaceControl

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Detectable targets

yPos := yPos + 20
boxHeight := 20 + 7 * (20 + 10) + 10
Gui Tujen:Add, GroupBox, x7 y%yPos% w328 h%boxHeight% -Theme, Detectable Targets
yPos := yPos + 20

GuiHelper_AddStringField("STR_TUJEN_WINDOW_OPEN", "Tujen Window Open", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_HAGGLE_WINDOW_OPEN", "Haggle Window Open", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_LESSER_ARTIFACT", "Lesser Artifact", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_GREATER_ARTIFACT", "Greater Artifact", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_GRAND_ARTIFACT", "Grand Artifact", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_EXCEPTIONAL_ARTIFACT", "Exceptional Artifact", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_NUMBERS_CURSIVE", "Cursive Numbers", yPos)
yPos := yPos + hControl + spaceControl
GuiHelper_AddStringField("STR_NUMBERS", "Numbers", yPos)
yPos := yPos + hControl + spaceControl

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Read From Screen Positions

yPos := yPos + 20
boxHeight := 20 + 5 * (40 + 20) + 10
Gui Tujen:Add, GroupBox, x7 y%yPos% w328 h%boxHeight% -Theme, Read From Screen Positions
yPos := yPos + 20

GuiHelper_AddCoordinateField("COORD_HAGGLE_PRICE", "Haggle Price", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2
GuiHelper_AddCoordinateField("COORD_COINS_LEFT", "Coins Left", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2
GuiHelper_AddCoordinateField("COORD_LESSER_LEFT", "Lesser Left", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2
GuiHelper_AddCoordinateField("COORD_GREATER_LEFT", "Greater Left", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2
GuiHelper_AddCoordinateField("COORD_GRAND_LEFT", "Grand Left", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2
GuiHelper_AddCoordinateField("COORD_EXCEPTIONAL_LEFT", "Exceptional Left", yPos)
yPos := yPos + hControl * 2 + spaceControl * 2

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Other values

yPos := yPos + 20
boxHeight := 20 + 2 * (20 + 5) + 10
Gui Tujen:Add, GroupBox, x7 y%yPos% w328 h%boxHeight% -Theme, Other values
yPos := yPos + 20

Gui Tujen:Add, Text, y%yPos% x%xLabel%, Move speed
Gui Tujen:Add, Slider, vMOVE_SPEED y%yPos% x%xEdit% w%wEdit% Range0-10 TickInterval1, % MOVE_SPEED
yPos := yPos + hControl + spaceControl

Gui Tujen:Add, Text, y%yPos% x%xLabel%, Inventory threshold
Gui Tujen:Add, Slider, vEMPTY_INVENTORY_AFTER y%yPos% x%xEdit% w%wEdit% Range1-12 TickInterval1, % EMPTY_INVENTORY_AFTER
yPos := yPos + hControl + spaceControl

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Global Buttons

yPos := yPos + 20
Gui Tujen:Add, Button, gGui_StartHaggling x7 y%yPos% w111 h20, Start Haggling
Gui Tujen:Add, Button, gGui_Detect_EmptyColors x119 y%yPos% w105 h20, Calibrate Colors
Gui Tujen:Add, Button, gGui_SaveValues x225 y%yPos% w111 h20, Save Values
yPos := yPos + 30

yPosMax := yPos

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Artifact types

yPos := 45
xPos := 7 + 328 + 7
boxHeight := 20 + 1 * (20 + 10) + 20
Gui Tujen:Add, GroupBox, x%xPos% y%yPos% w328 h%boxHeight% -Theme, Artifact types
xPos := xPos + 10
yPos := yPos + 20

Gui Tujen:Add, CheckBox, x%xPos% y%yPos% vARTIFACT_ENABLED_LESSER Checked%ARTIFACT_ENABLED_LESSER%, Lesser artifact
txPos := (xPos + xLabel + xEdit)
Gui Tujen:Add, CheckBox, x%txPos% y%yPos% vARTIFACT_ENABLED_GREATER Checked%ARTIFACT_ENABLED_GREATER%, Greater artifact
yPos := yPos + hControl + spaceControl
Gui Tujen:Add, CheckBox, x%xPos% y%yPos% vARTIFACT_ENABLED_GRAND Checked%ARTIFACT_ENABLED_GRAND%, Grand artifact
Gui Tujen:Add, CheckBox, x%txPos% y%yPos% vARTIFACT_ENABLED_EXCEPTIONAL Checked%ARTIFACT_ENABLED_EXCEPTIONAL%, Exceptional artifact

yPos := yPos + 10
xPos := xPos - 10

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Prices

yPos := yPos + 20
boxHeight := 20 + 2 * (20 + 5) + 10
Gui Tujen:Add, GroupBox, x%xPos% y%yPos% w328 h%boxHeight% -Theme, Artifact Prices
yPos := yPos + 20

xPos := xPos + 10

wEditCoordinate := wEdit / 2 - spaceControl * 2
xEditCoordinate := xPos + wEditCoordinate + spaceControl
yEditCoordinate := yPos + hControl + spaceControl
xTestCoordinate := xEditCoordinate + wEditCoordinate + 15
xEditCoordinate2 := xTestCoordinate + 70

Gui Tujen:Add, Text, x%xPos% y%yPos% w%wLabel% h%hControl% +0x200, Lesser
Gui Tujen:Add, Edit, vPRICE_LESSER x%xEditCoordinate% y%yPos% w%wEditCoordinate% h%hControl%, % PRICE_LESSER
Gui Tujen:Add, Edit, vPRICE_GREATER x%xEditCoordinate2% y%yPos% w%wEditCoordinate% h%hControl%, % PRICE_GREATER
Gui Tujen:Add, Text, x%xTestCoordinate% y%yPos% w60 h%hControl%, Greater
Gui Tujen:Add, Text, x%xPos% y%yEditCoordinate% w%wLabel% h%hControl% +0x200, Grand
Gui Tujen:Add, Edit, vPRICE_GRAND x%xEditCoordinate% y%yEditCoordinate% w%wEditCoordinate% h%hControl%, % PRICE_GRAND
Gui Tujen:Add, Edit, vPRICE_EXCEPTIONAL x%xEditCoordinate2% y%yEditCoordinate% w%wEditCoordinate% h%hControl%, % PRICE_EXCEPTIONAL
Gui Tujen:Add, Text, x%xTestCoordinate% y%yEditCoordinate% w60 h%hControl%, Exceptional
yPos := yPos + hControl * 2 + spaceControl * 2

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

GuiShowSettings() {
    global yPosMax, xPosition
    xPosition := A_ScreenWidth - 350 - 340
    Gui Tujen:Show, w680 h%yPosMax% x%xPosition% y10, Tujen Haggler
    if WinExist("Path of Exile") {
		WinActivate
	}
    return
}
GuiHideSettings() {
    Gui Tujen:Hide
    if WinExist("Path of Exile") {
		WinActivate
	}
    return
}
GuiShowSettings()

TujenGuiClose(GuiHwnd) {  ; Declaring this parameter is optional.
    MsgBox 4,, Do you want to quit?
    IfMsgBox Yes
        ExitApp
}
