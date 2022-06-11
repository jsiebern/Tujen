INI_FILE := A_ScriptDir . "\Tujen.ini"
if not (FileExist(INI_FILE)) {
    FileAppend,
    (
[Config]
MOVE_SPEED=3
CELL_SIZE=70
[Positions]
GRID_START_X=444
GRID_START_Y=384
OFFER_FIELD_X=838
OFFER_FIELD_Y=1016
CONFIRM_BUTTON_X=838
CONFIRM_BUTTON_Y=1151
REFRESH_BUTTON_X=1258
REFRESH_BUTTON_Y=1167
ARTIFACT_HOVER_X=835
ARTIFACT_HOVER_Y=908
COINAGE_X=1424
COINAGE_Y=270
TOOLTIP_1_X=445
TOOLTIP_1_Y=175
TOOLTIP_2_X=1020
TOOLTIP_2_Y=175
[Distances]
HAGGLE_SUB_X=270
HAGGLE_SUB_Y=90
HAGGLE_SUB_W=540
HAGGLE_SUB_H=45
HAGGLE_ALT_SUB_X=180
HAGGLE_ALT_SUB_Y=190
HAGGLE_ALT_SUB_W=360
HAGGLE_ALT_SUB_H=37
OFFER_READ_SUB_X=90
OFFER_READ_SUB_Y=20
OFFER_READ_SUB_W=180
OFFER_READ_SUB_H=40
COINAGE_READ_SUB_X=40
COINAGE_READ_SUB_W=80
COINAGE_READ_SUB_H=40
COINAGE_READ_SUB_Y_LESSER=50
COINAGE_READ_SUB_Y_GREATER=125
COINAGE_READ_SUB_Y_GRAND=195
COINAGE_READ_SUB_Y_EXCEPTIONAL=270
    ), % INI_FILE, utf-16
}

IniRead, MOVE_SPEED,        % INI_FILE, Config, MOVE_SPEED
; IniRead, CELL_SIZE,         % INI_FILE, Config, CELL_SIZE

; IniRead, GRID_START_X, % INI_FILE, Positions, GRID_START_X
; IniRead, GRID_START_Y, % INI_FILE, Positions, GRID_START_Y
; IniRead, OFFER_FIELD_X, % INI_FILE, Positions, OFFER_FIELD_X
; IniRead, OFFER_FIELD_Y, % INI_FILE, Positions, OFFER_FIELD_Y
; IniRead, CONFIRM_BUTTON_X, % INI_FILE, Positions, CONFIRM_BUTTON_X
; IniRead, CONFIRM_BUTTON_Y, % INI_FILE, Positions, CONFIRM_BUTTON_Y
; IniRead, REFRESH_BUTTON_X, % INI_FILE, Positions, REFRESH_BUTTON_X
; IniRead, REFRESH_BUTTON_Y, % INI_FILE, Positions, REFRESH_BUTTON_Y
; IniRead, ARTIFACT_HOVER_X, % INI_FILE, Positions, ARTIFACT_HOVER_X
; IniRead, ARTIFACT_HOVER_Y, % INI_FILE, Positions, ARTIFACT_HOVER_Y
; IniRead, COINAGE_X, % INI_FILE, Positions, COINAGE_X
; IniRead, COINAGE_Y, % INI_FILE, Positions, COINAGE_Y
; IniRead, TOOLTIP_1_X, % INI_FILE, Positions, TOOLTIP_1_X
; IniRead, TOOLTIP_1_Y, % INI_FILE, Positions, TOOLTIP_1_Y
; IniRead, TOOLTIP_2_X, % INI_FILE, Positions, TOOLTIP_2_X
; IniRead, TOOLTIP_2_Y, % INI_FILE, Positions, TOOLTIP_2_Y
; IniRead, HAGGLE_SUB_X, % INI_FILE, Distances, HAGGLE_SUB_X
; IniRead, HAGGLE_SUB_Y, % INI_FILE, Distances, HAGGLE_SUB_Y
; IniRead, HAGGLE_SUB_W, % INI_FILE, Distances, HAGGLE_SUB_W
; IniRead, HAGGLE_SUB_H, % INI_FILE, Distances, HAGGLE_SUB_H
; IniRead, HAGGLE_ALT_SUB_X, % INI_FILE, Distances, HAGGLE_ALT_SUB_X
; IniRead, HAGGLE_ALT_SUB_Y, % INI_FILE, Distances, HAGGLE_ALT_SUB_Y
; IniRead, HAGGLE_ALT_SUB_W, % INI_FILE, Distances, HAGGLE_ALT_SUB_W
; IniRead, HAGGLE_ALT_SUB_H, % INI_FILE, Distances, HAGGLE_ALT_SUB_H
; IniRead, OFFER_READ_SUB_X, % INI_FILE, Distances, OFFER_READ_SUB_X
; IniRead, OFFER_READ_SUB_Y, % INI_FILE, Distances, OFFER_READ_SUB_Y
; IniRead, OFFER_READ_SUB_W, % INI_FILE, Distances, OFFER_READ_SUB_W
; IniRead, OFFER_READ_SUB_H, % INI_FILE, Distances, OFFER_READ_SUB_H
; IniRead, COINAGE_READ_SUB_X, % INI_FILE, Distances, COINAGE_READ_SUB_X
; IniRead, COINAGE_READ_SUB_W, % INI_FILE, Distances, COINAGE_READ_SUB_W
; IniRead, COINAGE_READ_SUB_H, % INI_FILE, Distances, COINAGE_READ_SUB_H
; IniRead, COINAGE_READ_SUB_Y_LESSER, % INI_FILE, Distances, COINAGE_READ_SUB_Y_LESSER
; IniRead, COINAGE_READ_SUB_Y_GREATER, % INI_FILE, Distances, COINAGE_READ_SUB_Y_GREATER
; IniRead, COINAGE_READ_SUB_Y_GRAND, % INI_FILE, Distances, COINAGE_READ_SUB_Y_GRAND
; IniRead, COINAGE_READ_SUB_Y_EXCEPTIONAL, % INI_FILE, Distances, COINAGE_READ_SUB_Y_EXCEPTIONAL

Base_ScreenWidth := 2560
Base_ScreenFactor := A_ScreenWidth / Base_ScreenWidth

CELL_SIZE := 70 * Base_ScreenFactor
GRID_START_X := 444 * Base_ScreenFactor
GRID_START_Y := 384 * Base_ScreenFactor
OFFER_FIELD_X := 838 * Base_ScreenFactor
OFFER_FIELD_Y := 1016 * Base_ScreenFactor
CONFIRM_BUTTON_X := 838 * Base_ScreenFactor
CONFIRM_BUTTON_Y := 1151 * Base_ScreenFactor
REFRESH_BUTTON_X := 1258 * Base_ScreenFactor
REFRESH_BUTTON_Y := 1167 * Base_ScreenFactor
ARTIFACT_HOVER_X := 835 * Base_ScreenFactor
ARTIFACT_HOVER_Y := 908 * Base_ScreenFactor
COINAGE_X := 1424 * Base_ScreenFactor
COINAGE_Y := 270 * Base_ScreenFactor
TOOLTIP_1_X := 445 * Base_ScreenFactor
TOOLTIP_1_Y := 175 * Base_ScreenFactor
TOOLTIP_2_X := 1020 * Base_ScreenFactor
TOOLTIP_2_Y := 175 * Base_ScreenFactor
HAGGLE_SUB_X := 270 * Base_ScreenFactor
HAGGLE_SUB_Y := 90 * Base_ScreenFactor
HAGGLE_SUB_W := 540 * Base_ScreenFactor
HAGGLE_SUB_H := 45 * Base_ScreenFactor
HAGGLE_ALT_SUB_X := 180 * Base_ScreenFactor
HAGGLE_ALT_SUB_Y := 190 * Base_ScreenFactor
HAGGLE_ALT_SUB_W := 360 * Base_ScreenFactor
HAGGLE_ALT_SUB_H := 37 * Base_ScreenFactor
OFFER_READ_SUB_X := 90 * Base_ScreenFactor
OFFER_READ_SUB_Y := 20 * Base_ScreenFactor
OFFER_READ_SUB_W := 180 * Base_ScreenFactor
OFFER_READ_SUB_H := 40 * Base_ScreenFactor
COINAGE_READ_SUB_X := 40 * Base_ScreenFactor
COINAGE_READ_SUB_W := 80 * Base_ScreenFactor
COINAGE_READ_SUB_H := 40 * Base_ScreenFactor
COINAGE_READ_SUB_Y_LESSER := 50 * Base_ScreenFactor
COINAGE_READ_SUB_Y_GREATER := 125 * Base_ScreenFactor
COINAGE_READ_SUB_Y_GRAND := 195 * Base_ScreenFactor
COINAGE_READ_SUB_Y_EXCEPTIONAL := 270 * Base_ScreenFactor
INVENTORY_START_X := 1728 * Base_ScreenFactor
INVENTORY_START_Y := 818 * Base_ScreenFactor
INVENTORY_EMPTY_AFTER_WINDOWS := 10
CHEST_X := 1226 * Base_ScreenFactor
CHEST_Y := 552 * Base_ScreenFactor
TUJEN_X := 1151 * Base_ScreenFactor
TUJEN_Y := 505 * Base_ScreenFactor
TUJEN_HAGGLE_X := 1497 * Base_ScreenFactor
TUJEN_HAGGLE_Y := 389 * Base_ScreenFactor



Coord_SetGridStart() {
    global GRID_START_X, GRID_START_Y, INI_FILE
    MouseGetPos, GRID_START_X, GRID_START_Y
    IniWrite, % GRID_START_X, % INI_FILE, Positions, GRID_START_X
    IniWrite, % GRID_START_Y, % INI_FILE, Positions, GRID_START_Y
    MsgBox, Grid position set to %GRID_START_X%x%GRID_START_Y%
    return
}

Coord_Echo() {
    MouseGetPos, GRID_START_X, GRID_START_Y
    MsgBox, Position: %GRID_START_X%x%GRID_START_Y%
    return
}

Move_Initial() {
    global GRID_START_X, GRID_START_Y
    MouseMove, GRID_START_X, GRID_START_Y, MOVE_SPEED
    return
}

Move_Down() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, 0, CELL_SIZE, MOVE_SPEED, R
    return
}

Move_NextRow() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, CELL_SIZE, -(CELL_SIZE * 11), MOVE_SPEED, R
    return
}

MoveLeft() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, -CELL_SIZE, 0, MOVE_SPEED, R
    return
}

MoveRight() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, CELL_SIZE, 0, MOVE_SPEED, R
    return
}