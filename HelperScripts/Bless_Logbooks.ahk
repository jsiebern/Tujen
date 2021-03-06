#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include ..\Lib\Coordinates.ahk
#Include ..\Lib\FindText\FindText.ahk
#Include ..\Gui\Tujen_Gui_Helpers.ahk
#Include Logbook_Helpers.ahk
#Include Class_Logbook.ahk

ShouldBless(LogbookArea) {
    modCount := LogbookArea.Modifiers.Count()
    multiplier := modCount > 2 ? 0.6 : modCount > 1 ? 0.7 : 0.8
    goodMods := 0
    For i, M in LogbookArea.Modifiers {
        if (M.Value >= M.Max * multiplier) {
            goodMods := goodMods + 1
        }
    }
    return goodMods < modCount
}

F1::
    FindText().ScreenShot()
    Hold_Bless()
    For C, GridX in InventoryGridX {
        For R, GridY in InventoryGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if (indexOf(PointColor, EMPTY_COLORS)) {
                continue
			}
            ItemX := GridX + CELL_SIZE/2
            ItemY := GridY - CELL_SIZE/2
            MouseMove, ItemX, ItemY, 3
            info := ""
            Loop {
                Sleep, 100
                info := Item_Info()
            } Until info != ""
            if (!Is_Logbook(info)) {
                continue
            }
            if (Is_Corrupted(info)) {
                continue
            }
            l := new Logbook(info)
            a := l.GetBestArea()
            While (ShouldBless(a)) {
                if (!WinActive("Path of Exile") || ShouldBreak()) {
                    break
                }
                Click_Bless()
                ; Bless_Item(ItemX, ItemY)
                Sleep, 100
                info := Item_Info()
                l.Refresh(info)
                a := l.GetBestArea()
            }
            if (!WinActive("Path of Exile") || ShouldBreak()) {
                break
            }
        }
        if (!WinActive("Path of Exile") || ShouldBreak()) {
            break
        }
    }
    Release_Bless()
    ExitApp
return