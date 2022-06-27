INI_FILE := A_ScriptDir . "\..\Tujen.ini"
IniRead, EMPTY_COLORS, % INI_FILE, OtherValues, EMPTY_COLORS, % " "
EMPTY_COLORS := StrSplit(EMPTY_COLORS, ",")

SCOUR_X := GameX + Round(GameW/(2560/578))
SCOUR_Y := GameY + Round(GameH/(1440/679))

ALCH_X := GameX + Round(GameW/(2560/656))
ALCH_Y := GameY + Round(GameH/(1440/359))

BLESS_X := GameX + Round(GameW/(2560/730))
BLESS_Y := GameY + Round(GameH/(1440/679))

MOVE_SPEED := 1
SLEEP_TIMING := 30

ShouldBreak() {
	if (GetKeyState("Del", "P") == 1) {
		return true
	}
	else {
		return false
	}
}

Scour_Item(X, Y) {
    global SCOUR_X, SCOUR_Y, MOVE_SPEED, SLEEP_TIMING
    MouseMove, SCOUR_X, SCOUR_Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click, Right
    Sleep, SLEEP_TIMING
    MouseMove, X, Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click
    Sleep, SLEEP_TIMING
}

Alch_Item(X, Y) {
    global ALCH_X, ALCH_Y, MOVE_SPEED, SLEEP_TIMING
    MouseMove, ALCH_X, ALCH_Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click, Right
    Sleep, SLEEP_TIMING
    MouseMove, X, Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click
    Sleep, SLEEP_TIMING
}

Bless_Item(X, Y) {
    global BLESS_X, BLESS_Y, MOVE_SPEED, SLEEP_TIMING
    MouseMove, BLESS_X, BLESS_Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click, Right
    Sleep, SLEEP_TIMING
    MouseMove, X, Y, MOVE_SPEED
    Sleep, SLEEP_TIMING
    Click
    Sleep, SLEEP_TIMING
}

Item_Info() {
    clipboard := ""
    Send, !^c
    ClipWait 0.05
    C := clipboard
    return C
}

Is_Logbook(description) {
    Has := InStr(description, "Expedition Logbook")
    if (Has > 0) {
        return true
    }
    return false
}

Is_Rare(description) {
    Has := InStr(description, "Rarity: Rare")
    if (Has > 0) {
        return true
    }
    return false
}

Is_Normal(description) {
    Has := InStr(description, "Rarity: Normal")
    if (Has > 0) {
        return true
    }
    return false
}

Get_Quantity(description) {
    Has := InStr(description, "Item Quantity")
    if (Has <= 0) {
        return 0
    }
    RegExMatch(description, "O)Item Quantity: \+(?<nr>[0-9]{1,3})%", SubPat)
    return SubPat["nr"]
}