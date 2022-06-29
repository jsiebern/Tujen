#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

XButton1::
    Send, {q Down}
    Sleep, 800
    Send, 1
    Sleep, 300
    Send, {q Up}
return