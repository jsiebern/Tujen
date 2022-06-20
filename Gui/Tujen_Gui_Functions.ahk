Gui_OpenCaptureGui(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    FindText().Gui("Show")
    return
}

Gui_TestString(STR) {
    if (ok:=FindText(X, Y, 0, 0, 0, 0, 0, 0, STR)) {
        FindText().MouseTip(X, Y)
	}
    else {
        MsgBox, Sample not found on screen
    }
    return
}

Gui_TestCoordinate(X, Y, W, H) {
    ; TODO: Replace with FindText()
    ; result := CleanNumberRead(UI_ReadFromScreen(X, Y, W, H, true))
    MsgBox % result
    return
}

Gui_Test_STR_TUJEN_CHARACTER(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_TUJEN_CHARACTER
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_TUJEN_CHARACTER)
    return
}

Gui_Test_STR_HAGGLE_FOR_ITEMS(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_HAGGLE_FOR_ITEMS
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_HAGGLE_FOR_ITEMS)
    return
}

Gui_Test_STR_STASH(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_STASH
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_STASH)
    return
}

Gui_Test_STR_REROLL_CURRENCY(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_REROLL_CURRENCY
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_REROLL_CURRENCY)
    return
}

Gui_Test_STR_CONFIRM_BUTTON(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_CONFIRM_BUTTON
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_CONFIRM_BUTTON)
    return
}

Gui_Test_STR_TUJEN_WINDOW_OPEN(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_TUJEN_WINDOW_OPEN
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_TUJEN_WINDOW_OPEN)
    return
}

Gui_Test_STR_HAGGLE_WINDOW_OPEN(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_HAGGLE_WINDOW_OPEN
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_HAGGLE_WINDOW_OPEN)
    return
}

Gui_Test_STR_LESSER_ARTIFACT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_LESSER_ARTIFACT
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_LESSER_ARTIFACT)
    return
}

Gui_Test_STR_GREATER_ARTIFACT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_GREATER_ARTIFACT
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_GREATER_ARTIFACT)
    return
}

Gui_Test_STR_GRAND_ARTIFACT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_GRAND_ARTIFACT
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_GRAND_ARTIFACT)
    return
}

Gui_Test_STR_EXCEPTIONAL_ARTIFACT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global STR_EXCEPTIONAL_ARTIFACT
    Gui Tujen:Submit, NoHide
    Gui_TestString(STR_EXCEPTIONAL_ARTIFACT)
    return
}

Gui_Capture_COORD_HAGGLE_PRICE(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H
    GetRange(COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H)
    GuiControl, Tujen:, COORD_HAGGLE_PRICE_X, % COORD_HAGGLE_PRICE_X
    GuiControl, Tujen:, COORD_HAGGLE_PRICE_Y, % COORD_HAGGLE_PRICE_Y
    GuiControl, Tujen:, COORD_HAGGLE_PRICE_W, % COORD_HAGGLE_PRICE_W
    GuiControl, Tujen:, COORD_HAGGLE_PRICE_H, % COORD_HAGGLE_PRICE_H
    return
}

Gui_Test_COORD_HAGGLE_PRICE(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H)
    return
}

Gui_Capture_COORD_COINS_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H
    GetRange(COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H)
    GuiControl, Tujen:, COORD_COINS_LEFT_X, % COORD_COINS_LEFT_X
    GuiControl, Tujen:, COORD_COINS_LEFT_Y, % COORD_COINS_LEFT_Y
    GuiControl, Tujen:, COORD_COINS_LEFT_W, % COORD_COINS_LEFT_W
    GuiControl, Tujen:, COORD_COINS_LEFT_H, % COORD_COINS_LEFT_H
    return
}

Gui_Test_COORD_COINS_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H)
    return
}

Gui_Capture_COORD_LESSER_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H
    GetRange(COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H)
    GuiControl, Tujen:, COORD_LESSER_LEFT_X, % COORD_LESSER_LEFT_X
    GuiControl, Tujen:, COORD_LESSER_LEFT_Y, % COORD_LESSER_LEFT_Y
    GuiControl, Tujen:, COORD_LESSER_LEFT_W, % COORD_LESSER_LEFT_W
    GuiControl, Tujen:, COORD_LESSER_LEFT_H, % COORD_LESSER_LEFT_H
    return
}

Gui_Test_COORD_LESSER_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H)
    return
}

Gui_Capture_COORD_GREATER_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H
    GetRange(COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H)
    GuiControl, Tujen:, COORD_GREATER_LEFT_X, % COORD_GREATER_LEFT_X
    GuiControl, Tujen:, COORD_GREATER_LEFT_Y, % COORD_GREATER_LEFT_Y
    GuiControl, Tujen:, COORD_GREATER_LEFT_W, % COORD_GREATER_LEFT_W
    GuiControl, Tujen:, COORD_GREATER_LEFT_H, % COORD_GREATER_LEFT_H
    return
}

Gui_Test_COORD_GREATER_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H)
    return
}

Gui_Capture_COORD_GRAND_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H
    GetRange(COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H)
    GuiControl, Tujen:, COORD_GRAND_LEFT_X, % COORD_GRAND_LEFT_X
    GuiControl, Tujen:, COORD_GRAND_LEFT_Y, % COORD_GRAND_LEFT_Y
    GuiControl, Tujen:, COORD_GRAND_LEFT_W, % COORD_GRAND_LEFT_W
    GuiControl, Tujen:, COORD_GRAND_LEFT_H, % COORD_GRAND_LEFT_H
    return
}

Gui_Test_COORD_GRAND_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H)
    return
}

Gui_Capture_COORD_EXCEPTIONAL_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H
    GetRange(COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H)
    GuiControl, Tujen:, COORD_EXCEPTIONAL_LEFT_X, % COORD_EXCEPTIONAL_LEFT_X
    GuiControl, Tujen:, COORD_EXCEPTIONAL_LEFT_Y, % COORD_EXCEPTIONAL_LEFT_Y
    GuiControl, Tujen:, COORD_EXCEPTIONAL_LEFT_W, % COORD_EXCEPTIONAL_LEFT_W
    GuiControl, Tujen:, COORD_EXCEPTIONAL_LEFT_H, % COORD_EXCEPTIONAL_LEFT_H
    return
}

Gui_Test_COORD_EXCEPTIONAL_LEFT(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H
    Gui Tujen:Submit, NoHide
    Gui_TestCoordinate(COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H)
    return
}

Gui_Detect_EmptyColors(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global InventoryGridX, InventoryGridY, HaggleGridX, HaggleGridY, EMPTY_COLORS, EMPTY_COLORS_HAGGLE_WINDOW, INI_FILE

    GuiHideSettings()

    EMPTY_COLORS := []
    if WinExist("Path of Exile") {
		WinActivate
	}

    FindText().ScreenShot()
    ; Loop through the whole grid, and add unknown colors to the lists
    For c, GridX in InventoryGridX  {
        For r, GridY in InventoryGridY
        {
            PointColor := FindText().GetColor(GridX,GridY)

            if !(indexOf(PointColor, EMPTY_COLORS)){
                ; We dont have this Empty color already
                EMPTY_COLORS.Push(PointColor)
            }
        }
    }
    strToSave := hexArrToStr(EMPTY_COLORS)
    IniWrite % strToSave, % INI_FILE, OtherValues, EMPTY_COLORS

    EMPTY_COLORS_HAGGLE_WINDOW := []
    ; Loop through the whole grid, and add unknown colors to the lists
    For c, GridX in HaggleGridX  {
        For r, GridY in HaggleGridY
        {
            PointColor := FindText().GetColor(GridX,GridY)

            if !(indexOf(PointColor, EMPTY_COLORS_HAGGLE_WINDOW)) {
                ; We dont have this Empty color already
                EMPTY_COLORS_HAGGLE_WINDOW.Push(PointColor)
            }
        }
    }
    strToSave := hexArrToStr(EMPTY_COLORS_HAGGLE_WINDOW)
    IniWrite % strToSave, % INI_FILE, OtherValues, EMPTY_COLORS_HAGGLE_WINDOW

    MsgBox, Empty inventory/haggle window colors calibrated

    GuiShowSettings()
    return
}

Gui_SaveValues(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Gui Tujen:Submit, NoHide

    global INI_FILE
    global STR_TUJEN_CHARACTER
    global STR_HAGGLE_FOR_ITEMS
    global STR_STASH
    global STR_REROLL_CURRENCY
    global STR_CONFIRM_BUTTON
    global STR_TUJEN_WINDOW_OPEN
    global STR_HAGGLE_WINDOW_OPEN
    global STR_LESSER_ARTIFACT
    global STR_GREATER_ARTIFACT
    global STR_GRAND_ARTIFACT
    global STR_EXCEPTIONAL_ARTIFACT
    global COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H
    global COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H
    global COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H
    global COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H
    global COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H
    global COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H
    global MOVE_SPEED
    global EMPTY_INVENTORY_AFTER
    global PRICE_EXCEPTIONAL, PRICE_GRAND, PRICE_GREATER, PRICE_LESSER
    global ARTIFACT_ENABLED_LESSER, ARTIFACT_ENABLED_GREATER, ARTIFACT_ENABLED_GRAND, ARTIFACT_ENABLED_EXCEPTIONAL

    Gui Tujen:Submit, NoHide
    
    IniWrite % STR_TUJEN_CHARACTER, % INI_FILE, FindTextStrings, STR_TUJEN_CHARACTER
    IniWrite % STR_HAGGLE_FOR_ITEMS, % INI_FILE, FindTextStrings, STR_HAGGLE_FOR_ITEMS
    IniWrite % STR_STASH, % INI_FILE, FindTextStrings, STR_STASH
    IniWrite % STR_REROLL_CURRENCY, % INI_FILE, FindTextStrings, STR_REROLL_CURRENCY
    IniWrite % STR_CONFIRM_BUTTON, % INI_FILE, FindTextStrings, STR_CONFIRM_BUTTON
    IniWrite % STR_TUJEN_WINDOW_OPEN, % INI_FILE, FindTextStrings, STR_TUJEN_WINDOW_OPEN
    IniWrite % STR_HAGGLE_WINDOW_OPEN, % INI_FILE, FindTextStrings,STR_HAGGLE_WINDOW_OPEN
    IniWrite % STR_LESSER_ARTIFACT, % INI_FILE, FindTextStrings, STR_LESSER_ARTIFACT
    IniWrite % STR_GREATER_ARTIFACT, % INI_FILE, FindTextStrings, STR_GREATER_ARTIFACT
    IniWrite % STR_GRAND_ARTIFACT, % INI_FILE, FindTextStrings, STR_GRAND_ARTIFACT
    IniWrite % STR_EXCEPTIONAL_ARTIFACT, % INI_FILE, FindTextStrings, STR_EXCEPTIONAL_ARTIFACT
    IniWrite % COORD_HAGGLE_PRICE_X, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_X
    IniWrite % COORD_HAGGLE_PRICE_Y, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_Y
    IniWrite % COORD_HAGGLE_PRICE_W, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_W
    IniWrite % COORD_HAGGLE_PRICE_H, % INI_FILE, CapturedCoordinates, COORD_HAGGLE_PRICE_H
    IniWrite % COORD_COINS_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_X
    IniWrite % COORD_COINS_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_Y
    IniWrite % COORD_COINS_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_W
    IniWrite % COORD_COINS_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_COINS_LEFT_H
    IniWrite % COORD_LESSER_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_X
    IniWrite % COORD_LESSER_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_Y
    IniWrite % COORD_LESSER_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_W
    IniWrite % COORD_LESSER_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_LESSER_LEFT_H
    IniWrite % COORD_GREATER_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_X
    IniWrite % COORD_GREATER_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_Y
    IniWrite % COORD_GREATER_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_W
    IniWrite % COORD_GREATER_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_GREATER_LEFT_H
    IniWrite % COORD_GRAND_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_X
    IniWrite % COORD_GRAND_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_Y
    IniWrite % COORD_GRAND_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_W
    IniWrite % COORD_GRAND_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_GRAND_LEFT_H
    IniWrite % COORD_EXCEPTIONAL_LEFT_X, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_X
    IniWrite % COORD_EXCEPTIONAL_LEFT_Y, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_Y
    IniWrite % COORD_EXCEPTIONAL_LEFT_W, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_W
    IniWrite % COORD_EXCEPTIONAL_LEFT_H, % INI_FILE, CapturedCoordinates, COORD_EXCEPTIONAL_LEFT_H
    IniWrite % MOVE_SPEED, % INI_FILE, OtherValues, MOVE_SPEED
    IniWrite % EMPTY_INVENTORY_AFTER, % INI_FILE, OtherValues, EMPTY_INVENTORY_AFTER
    IniWrite % PRICE_LESSER, % INI_FILE, Prices, PRICE_LESSER
    IniWrite % PRICE_GREATER, % INI_FILE, Prices, PRICE_GREATER
    IniWrite % PRICE_GRAND, % INI_FILE, Prices, PRICE_GRAND
    IniWrite % PRICE_EXCEPTIONAL, % INI_FILE, Prices, PRICE_EXCEPTIONAL
    IniWrite % ARTIFACT_ENABLED_LESSER, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_LESSER
    IniWrite % ARTIFACT_ENABLED_GREATER, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_GREATER
    IniWrite % ARTIFACT_ENABLED_GRAND, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_GRAND
    IniWrite % ARTIFACT_ENABLED_EXCEPTIONAL, % INI_FILE, ArtifactsEnabled, ARTIFACT_ENABLED_EXCEPTIONAL

    CURRENCY["EXCEPTIONAL"] := PRICE_EXCEPTIONAL
    CURRENCY["GRAND"] := PRICE_GRAND
    CURRENCY["GREATER"] := PRICE_GREATER
    CURRENCY["LESSER"] := PRICE_LESSER

    MsgBox, Values Saved
    return
}

Gui_StartHaggling(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Start_Haggling()
    return
}