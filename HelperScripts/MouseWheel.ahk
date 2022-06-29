#SingleInstance, Force
#IfWinActive, Path of Exile
SendMode Input
SetWorkingDir, %A_ScriptDir%

^WheelDown::Send, ^{LButton}
^WheelUp::Send, ^{LButton}