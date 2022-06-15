; Item Inventory Grid
GamePID := WinExist("Path of Exile")
WinGetPos, GameX, GameY, GameW, GameH
InventoryGridX := [ GameX + Round(GameW/(1920/1274)), GameX + Round(GameW/(1920/1326)), GameX + Round(GameW/(1920/1379)), GameX + Round(GameW/(1920/1432)), GameX + Round(GameW/(1920/1484)), GameX + Round(GameW/(1920/1537)), GameX + Round(GameW/(1920/1590)), GameX + Round(GameW/(1920/1642)), GameX + Round(GameW/(1920/1695)), GameX + Round(GameW/(1920/1748)), GameX + Round(GameW/(1920/1800)), GameX + Round(GameW/(1920/1853)) ]
InventoryGridY := [ GameY + Round(GameH/(1080/638)), GameY + Round(GameH/(1080/690)), GameY + Round(GameH/(1080/743)), GameY + Round(GameH/(1080/796)), GameY + Round(GameH/(1080/848)) ]  

xBase := 419
yBase := 416
cSize := 70
HaggleGridX := [GameX + Round(GameW/(2560/xBase)), GameX + Round(GameW/(2560/(xBase + cSize))), GameX + Round(GameW/(2560/(xBase + (2 * cSize)))), GameX + Round(GameW/(2560/(xBase + (3 * cSize)))), GameX + Round(GameW/(2560/(xBase + (4 * cSize)))), GameX + Round(GameW/(2560/(xBase + (5 * cSize) + 1))), GameX + Round(GameW/(2560/(xBase + (6 * cSize) + 1))), GameX + Round(GameW/(2560/(xBase + (7 * cSize) + 1))), GameX + Round(GameW/(2560/(xBase + (8 * cSize) + 1))), GameX + Round(GameW/(2560/(xBase + (9 * cSize) + 1))), GameX + Round(GameW/(2560/(xBase + (10 * cSize) + 2))), GameX + Round(GameW/(2560/(xBase + (11 * cSize) + 2)))]
HaggleGridY := [GameY + Round(GameH/(1440/yBase)), GameY + Round(GameH/(1440/(yBase + cSize + 1))), GameY + Round(GameH/(1440/(yBase + (2 * cSize) + 1))), GameY + Round(GameH/(1440/(yBase + (3 * cSize) + 1))), GameY + Round(GameH/(1440/(yBase + (4 * cSize) + 1))), GameY + Round(GameH/(1440/(yBase + (5 * cSize) + 1))), GameY + Round(GameH/(1440/(yBase + (6 * cSize) + 2))), GameY + Round(GameH/(1440/(yBase + (7 * cSize) + 2))), GameY + Round(GameH/(1440/(yBase + (8 * cSize) + 2))), GameY + Round(GameH/(1440/(yBase + (9 * cSize) + 2))), GameY + Round(GameH/(1440/(yBase + (10 * cSize) + 2)))]

CELL_SIZE := InventoryGridX[2] - InventoryGridX[1]

INI_FILE := A_ScriptDir . "\Tujen.ini"
Base_ScreenWidth := 2560
Base_ScreenFactor := A_ScreenWidth / Base_ScreenWidth

GRID_START_X := 444 * Base_ScreenFactor
GRID_START_Y := 384 * Base_ScreenFactor
TOOLTIP_1_X := 445 * Base_ScreenFactor
TOOLTIP_1_Y := 0 * Base_ScreenFactor
TOOLTIP_2_X := 1020 * Base_ScreenFactor
TOOLTIP_2_Y := 0 * Base_ScreenFactor

INVENTORY_EMPTY_AFTER_WINDOWS := 10

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