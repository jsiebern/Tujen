#SingleInstance, Force
#IfWinActive, Path of Exile
SendMode Input
SetWorkingDir, %A_ScriptDir%

ShouldBreak() {
	if (GetKeyState("Del", "P") == 1) {
		return true
	}
	else {
		return false
	}
}

*MButton::
    while (GetKeyState("MButton", "P")) {
        if (ShouldBreak()) {
            break
        }
        if (GetKeyState("Shift", "P")) {
            Send, ^+{LButton}
        }
        else {
            Send, ^{LButton}
        }
        Sleep, 30
        if (ShouldBreak()) {
            break
        }
    }
return