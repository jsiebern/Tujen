#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F1::
    MouseGetPos, X, Y
    Loop, 3 {
        if (A_Index > 1) {
            MouseMove, X + (80 * (A_Index - 1)), Y, 0
            Sleep, 50
        }
        Sleep, 50
        Click
        MouseMove, 1120, 652, 0
        Sleep, 50
        Click
        Sleep, 50
        MouseMove, X, Y, 0
    }
return

!F1::
    MouseGetPos, X, Y
    Loop, 3 {
        if (A_Index > 1) {
            MouseMove, X + (50 * (A_Index - 1)), Y, 0
            Sleep, 50
        }
        Sleep, 50
        Click
        MouseMove, 1120, 652, 0
        Sleep, 50
        Click
        Sleep, 50
        MouseMove, X, Y, 0
    }
return