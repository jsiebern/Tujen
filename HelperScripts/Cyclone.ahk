#SingleInstance, Force
#IfWinActive, Path of Exile
SendMode Input
SetWorkingDir, %A_ScriptDir%

toggle = 0

w::
toggle := !toggle

if toggle {
    Send, {LButton down}
    Send, {RButton down}
}
else {
    Send, {LButton up}
    Send, {RButton up}
}

