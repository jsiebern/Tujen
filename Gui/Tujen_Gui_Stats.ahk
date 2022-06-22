#SingleInstance, Force

LView :=
StatsValue :=
StatsItemCount :=

class Gui_Stats {
    windowItems := 0
    windowItemsProcessed := 0
    windowValue := 0

    __New()
    {
        this.Hide()
        Gui Stats:+AlwaysOnTop +ToolWindow
        Gui Stats:Default
        Gui Stats:Font, s20, Calibri
        
        Gui Stats:Add, Text, vStatsValue x7 y3 w200 h34 +0x200, 
        Gui Stats:Add, Text, vStatsItemCount x380 y3 w100 h34 +0x200, 

        Gui Stats:Font, s9, Calibri

        Gui, Stats:Add, ListView, vLView AltSubmit -ReadOnly R15 x7 w440, Name|Artifact|Value|Price|Action
        LV_ModifyCol(1, 150)
        LV_ModifyCol(2, 100)
        LV_ModifyCol(4, 60)
        LV_ModifyCol(5, 80)
    }

    RefreshWindowText()
    {
        valueText := "Value: " . Round(this.windowValue, 1) . "c"
        GuiControl Stats:Text, StatsValue , % valueText

        if (this.windowItems > 0) {
            itemCountText := this.windowItemsProcessed . "/" . this.windowItems
            GuiControl Stats:Text, StatsItemCount, % itemCountText
        } else {
            GuiControl Stats:Text, StatsItemCount,
        }
    }

    SetWindowItems(itemNum)
    {
        this.windowItems := itemNum
        this.RefreshWindowText()
    }

    IncreaseItemsProcessed()
    {
        this.windowItemsProcessed := this.windowItemsProcessed + 1
        this.RefreshWindowText()
    }

    ListAdd(Name, Num, Value, Currency, AskingNum, TotalPrice, Action)
    {
        Gui, Stats:ListView, LView
        LV_Add("", Name, AskingNum . " " . Currency, Round(Value, 1) . "c", Round(TotalPrice, 1) . "c", Action)
        if (Action == "BUY") {
            this.windowValue := this.windowValue + Value
            this.RefreshWindowText()
        }
    }

    ListModify(Name, Num, Value, Currency, AskingNum, TotalPrice, Action)
    {
        Gui, Stats:ListView, LView
        c := LV_GetCount()
        LV_Modify(c, "", Name, AskingNum . " " . Currency, Round(Value, 1) . "c", Round(TotalPrice, 1) . "c", Action)
        if (Action == "BUY") {
            this.windowValue := this.windowValue + Value
            this.RefreshWindowText()
        }
    }

    ListClear()
    {
        LV_Delete()
        this.windowValue := 0
        this.windowItems := 0
        this.windowItemsProcessed := 0
        this.RefreshWindowText()
    }

    Show()
    {
        w := 453
        x := A_ScreenWidth - 10 - w
        Gui Stats:Show, w%w% h358 x%x% y10, Tujen Haggler
        if WinExist("Path of Exile") {
            WinActivate
        }
    }

    Hide()
    {
        Gui Stats:Destroy
        if WinExist("Path of Exile") {
            WinActivate
        }
    }
}

StatsGuiClose(GuiHwnd) {  ; Declaring this parameter is optional.
    Gui %GuiHwnd%:Destroy
}