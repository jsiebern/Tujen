#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

^w::
    Send, 1
    Sleep, 50
    Send, x
    Sleep, 200
    Send, x
    Sleep, 50
    Send, 234
    Sleep, 20
    Send, w
    Sleep, 20
    Send, e
return