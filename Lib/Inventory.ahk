Inventory_Loop_Empty() {
    global INVENTORY_START_X, INVENTORY_START_Y, MOVE_SPEED, CELL_SIZE

    ; if (!UI_IsInventoryOpen() || !UI_IsStashOpen()) {
    ;    return false
    ; }

    Send, {Ctrl Down}
	Loop, 12 {
		iX := A_Index - 1
		Loop, 5 {
			iY := A_Index - 1

			MouseMove, INVENTORY_START_X + (iX * CELL_SIZE), INVENTORY_START_Y + (iY * CELL_SIZE), MOVE_SPEED
            Sleep, 10
			Click

            if (!WinActive("Path of Exile") || ShouldBreak()) {
                break
            }
		}
        if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
	}
    Send, {Ctrl Up}
	return true
}

Inventory_Click_Chest() {
    global CHEST_X, CHEST_Y, MOVE_SPEED

    MouseMove, CHEST_X, CHEST_Y, MOVE_SPEED
	Click
    return
}

Inventory_Exit() {
    Send, {Esc}
    return
}

Inventory_Open_Tujen() {
    global TUJEN_X, TUJEN_Y, MOVE_SPEED
    MouseMove, TUJEN_X, TUJEN_Y, MOVE_SPEED
	Click
    Sleep, 200
    Inventory_Open_Tujen_HaggleMenu()
    return
}

Inventory_Open_Tujen_HaggleMenu() {
    global TUJEN_HAGGLE_X, TUJEN_HAGGLE_Y, MOVE_SPEED
    MouseMove, TUJEN_HAGGLE_X, TUJEN_HAGGLE_Y, MOVE_SPEED
	Click
    return
}

Inventory_Empty_Perform_Sequence() {
    Sleep, 400
    Inventory_Exit()
	Sleep, 400
	Inventory_Click_Chest()
	Sleep, 400
	Inventory_Loop_Empty()
	Sleep, 400
	Inventory_Exit()
	Sleep, 400
	Inventory_Open_Tujen()
    Sleep, 400
}