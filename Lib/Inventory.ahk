Inventory_Loop_Empty() {
    global InventoryGridX, InventoryGridY, EMPTY_COLORS, MOVE_SPEED, CELL_SIZE

    GuiHideSettings()

	FindText().ScreenShot()
	Send, {Ctrl Down}
	;Send, {Shift Down}
    For C, GridX in InventoryGridX {
        For R, GridY in InventoryGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if !(indexOf(PointColor, EMPTY_COLORS)) {
				MouseMove, GridX + CELL_SIZE/2, GridY - CELL_SIZE/2, MOVE_SPEED
				Sleep, 10
				Click
			}
			if (!WinActive("Path of Exile") || ShouldBreak()) {
                break
            }
		}
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
	}
	;Send, {Shift Up}
	Send, {Ctrl Up}

	return true
}

Inventory_Check_Threshold() {
    global EMPTY_INVENTORY_AFTER, InventoryGridX, InventoryGridY, EMPTY_COLORS
	thresholdReached := false
	FindText().ScreenShot()
	For C, GridX in InventoryGridX {
		if (C < EMPTY_INVENTORY_AFTER) {
			continue
		}
		For R, GridY in InventoryGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if !(indexOf(PointColor, EMPTY_COLORS)) {
				thresholdReached := true
				break
			}
		}
		if (thresholdReached) {
			break
		}
	}
	return thresholdReached
}

Inventory_Click_Chest() {
    global STR_STASH, MOVE_SPEED
    if (FindText(X, Y, 0, 0, 0, 0, 0, 0, STR_STASH)) {
        MouseMove, X, Y, MOVE_SPEED
        Click
	}
    return
}

Inventory_Exit() {
    Send, {Esc}
    return
}

Inventory_Ensure_Tujen() {
    global STR_TUJEN_WINDOW_OPEN, STR_HAGGLE_WINDOW_OPEN, MOVE_SPEED
    if (FindText(X, Y, 0, 0, 0, 0, 0, 0, STR_TUJEN_WINDOW_OPEN)) {
        return true
	} else if (FindText(X, Y, 0, 0, 0, 0, 0, 0, STR_HAGGLE_WINDOW_OPEN)) {
        Send, {Esc}
        return true
	} else {
        Inventory_Open_Tujen()
        return true
    }
}

Inventory_Open_Tujen() {
    global STR_TUJEN_CHARACTER, MOVE_SPEED
    if (FindText(X:="wait", Y:=3, 0, 0, 0, 0, 0, 0, STR_TUJEN_CHARACTER)) {
        MouseMove, X, Y, MOVE_SPEED
        Click
	}
    Sleep, 200
    Inventory_Open_Tujen_HaggleMenu()
    return
}

Inventory_Open_Tujen_HaggleMenu() {
    global STR_HAGGLE_FOR_ITEMS, MOVE_SPEED
    if (FindText(X:="wait", Y:=3, 0, 0, 0, 0, 0, 0, STR_HAGGLE_FOR_ITEMS)) {
        MouseMove, X, Y, MOVE_SPEED
        Click
	}
    return
}

Inventory_Empty_Perform_Sequence() {
    Inventory_Exit()
    Sleep, 200
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