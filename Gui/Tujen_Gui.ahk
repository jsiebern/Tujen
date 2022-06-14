#include Gui\GetRange.ahk
#include Gui\Tujen_Gui_Functions.ahk

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

Gui, Tujen:+AlwaysOnTop +ToolWindow

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

GuiHelper_AddSingleCoordinateField(name, label, Y) {

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
boxHeight := 20 + 5 * (20 + 10) + 10
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
boxHeight := 20 + 1 * (20 + 10) + 10
Gui Tujen:Add, GroupBox, x7 y%yPos% w328 h%boxHeight% -Theme, Other values
yPos := yPos + 20

Gui Tujen:Add, Text, y%yPos% x%xLabel%, Move speed
Gui Tujen:Add, Slider, vMOVE_SPEED y%yPos% x%xEdit% w%wEdit% Range0-10 TickInterval1, % MOVE_SPEED
yPos := yPos + hControl + spaceControl

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

; Global Buttons

yPos := yPos + 20
Gui Tujen:Add, Button, gGui_StartHaggling x7 y%yPos% w111 h20, Start Haggling
Gui Tujen:Add, Button, gGui_SaveValues x225 y%yPos% w111 h20, Save Values
yPos := yPos + 30

; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------

GuiShowSettings() {
    global yPos, xPosition
    xPosition := A_ScreenWidth - 350
    Gui Tujen:Show, w340 h%yPos% x%xPosition% y10, Tujen Haggler
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

;GuiClose:
;    ExitApp