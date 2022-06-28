#SingleInstance Force
SetBatchLines -1
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

GamePID := WinExist("Path of Exile")
WinGetPos, GameX, GameY, GameW, GameH

MOVE_SPEED := 1
CELL_SIZE := Round(GameW/(2560/70))

GRID_START_X := GameX + Round(GameW/(1920/1274)) + CELL_SIZE / 2
GRID_START_Y := GameY + Round(GameH/(1080/638)) - CELL_SIZE / 2

IsWorking := false
ShouldStop := false

ShouldBreak() {
	if (GetKeyState("Del", "P") == 1) {
		return true
	}
	else {
		return false
	}
}

HasItem() {
    clipboard := ""
    Send, ^c
    ClipWait 0.05
    If ErrorLevel
    {
        return false
    }
    C := clipboard
    return C != ""
}

StackSize() {
    clipboard := ""
    Send, ^c
    ClipWait 0.05
    If ErrorLevel
    {
        return 0
    }
    C := clipboard
    RegExMatch(C, "O)Stack Size: (?<nr>[0-9]{1,4})\/([0-9]{1,4})", SubPat)
    return SubPat["nr"]
}

MoveDown() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, 0, CELL_SIZE, MOVE_SPEED, R
    return
}
MoveNextRow() {
    global CELL_SIZE, MOVE_SPEED
    MouseMove, CELL_SIZE, -(CELL_SIZE * 4), MOVE_SPEED, R
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
MoveToInitial() {
    global GRID_START_X, GRID_START_Y
    MouseMove, GRID_START_X, GRID_START_Y, MOVE_SPEED
    return
}

MoveItem() {
    Sleep, 50
    if (HasItem()) {
        Sleep, 150
        Send, ^{Click}
        Loop {
            Sleep, 100
        } Until !HasItem() || A_Index > 10 || !WinActive("Path of Exile")
    }
    return
}

MoveItemFromStack() {
    global ShouldStop
    Sleep, 50
    stack := StackSize()
    if (stack > 1) {
        Send ^{Click}
        Loop {
            Sleep, 50
        } Until StackSize() < stack || ShouldStop || ShouldBreak() || A_Index > 5 || !WinActive("Path of Exile")
    }
    Sleep, 50
    if (HasItem()) {
        Sleep, 50
        Send ^{Click}
        Loop {
            Sleep, 50
        } Until !HasItem() || ShouldBreak() || A_Index > 5 || !WinActive("Path of Exile")
    }
    return
}

SetInitialMousePosition() {
    global GRID_START_X, GRID_START_Y, INI_FILE
    MouseGetPos, GRID_START_X, GRID_START_Y
    IniWrite, % GRID_START_X, % INI_FILE, Positions, GRID_START_X
    IniWrite, % GRID_START_Y, % INI_FILE, Positions, GRID_START_Y
    MsgBox, Grid position set to %GRID_START_X%x%GRID_START_Y%
    return
}

^!y::
SetInitialMousePosition()
return

#if (IsWorking)
Esc::
ShouldStop := true
return

#if (!IsWorking)
^y::
IsWorking := true
MoveToInitial()
Loop, 12 {
    if (!WinActive("Path of Exile") || ShouldStop || ShouldBreak()) {
        break
    }
    Loop, 5 {
        if (!WinActive("Path of Exile") || ShouldStop || ShouldBreak()) {
			break
		}
        MoveItem()
        if (!WinActive("Path of Exile") || ShouldStop || ShouldBreak()) {
			break
		}
        if (A_Index < 5) {
            MoveDown()
        }
    }
    if (A_Index < 12) {
        MoveNextRow()
    }
}
IsWorking := false
ShouldStop := false
return

!y::
IsWorking := true
Loop {
    MoveItemFromStack()
} Until !WinActive("Path of Exile") || ShouldStop || ShouldBreak()
IsWorking := false
ShouldStop := false
return