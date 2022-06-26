#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F1::
    MouseGetPos, X, Y
    Click
    MouseMove, 1120, 652, 0
    Sleep, 20
    Click
    Sleep, 20
    MouseMove, X, Y, 0
return