#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include ..\Lib\Coordinates.ahk
#Include ..\Lib\FindText\FindText.ahk
#Include ..\Gui\Tujen_Gui_Helpers.ahk
#Include Logbook_Helpers.ahk

F1::
    FindText().ScreenShot()
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
            while (Get_Quantity(info) < 70) {
                if (!WinActive("Path of Exile") || ShouldBreak()) {
                    break
                }
                if (!Is_Normal(info)) {
                    Scour_Item(ItemX, ItemY)
                }
                Alch_Item(ItemX, ItemY)
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
return