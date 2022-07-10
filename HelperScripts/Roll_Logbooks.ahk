#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include ..\Lib\Coordinates.ahk
#Include ..\Lib\FindText\FindText.ahk
#Include ..\Gui\Tujen_Gui_Helpers.ahk
#Include Logbook_Helpers.ahk

UseChaos := true

F1::
    FindText().ScreenShot()
    if (UseChaos) {
        Hold_Chaos()
    }
    For C, GridX in InventoryGridX {
        For R, GridY in InventoryGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if (indexOf(PointColor, EMPTY_COLORS)) {
                continue
			}
            ItemX := GridX + CELL_SIZE/2
            ItemY := GridY - CELL_SIZE/2
            MouseMove, ItemX, ItemY, 3
            info := Item_Info()
            if (!Is_Logbook(info)) {
                continue
            }
            if (Is_Corrupted(info)) {
                continue
            }
            if (Is_Unidentified(info)) {
                if (UseChaos) {
                    Release_Chaos()
                }
                Wisdom_Item(ItemX, ItemY)
                if (UseChaos) {
                    Hold_Chaos()
                    MouseMove, ItemX, ItemY, 3
                }
            }
            if (UseChaos) {
                if (!Is_Rare(info)) {
                    Release_Chaos()
                    if (!Is_Normal(info)) {
                        Scour_Item(ItemX, ItemY)
                    }
                    Alch_Item(ItemX, ItemY)
                    Hold_Chaos()
                    MouseMove, ItemX, ItemY, 3
                }
            }
            while (Get_Quantity(info) < 70) {
                if (!WinActive("Path of Exile") || ShouldBreak()) {
                    break
                }
                if (UseChaos) {
                    Chaos_Item()
                } else {
                    if (!Is_Normal(info)) {
                        Scour_Item(ItemX, ItemY)
                    }
                    Alch_Item(ItemX, ItemY)
                }
                Sleep, 100
                info := Item_Info()
                Sleep, 100
            }
            if (!WinActive("Path of Exile") || ShouldBreak()) {
                break
            }
		}
        if (!WinActive("Path of Exile") || ShouldBreak()) {
            break
        }
	}
    if (UseChaos) {
        Release_Chaos()
    }
    ExitApp
return