#SingleInstance, Force
;#IfWinActive, Path of Exile
SetWorkingDir, %A_ScriptDir%

#include Lib\Prices.ahk
#include Gdip\Gdip.ahk
#include Gdip\Gdip_ImageSearch.ahk
#Include Lib\FindText\FindText.ahk
#include Lib\Coordinates.ahk
#include Gui\Tujen_Gui.ahk
#include CSV.ahk
#include Lib\Utils.ahk
#include Lib\UI.ahk
#include Tujen_Functions.ahk
#include Lib\Inventory.ahk
#include Lib\Haggle.ahk

STOP_SCRIPT := false
pToken := Gdip_Startup()
OnExit, GdipShutdown

ShouldBreak() {
	if (GetKeyState("Del", "P") == 1) {
		return true
	}
	else {
		return false
	}
}

X_CONFIRM := 0
Y_CONFIRM := 0
ConfirmOffer() {
	global STR_CONFIRM_BUTTON, X_CONFIRM, Y_CONFIRM, MOVE_SPEED
	if (X_CONFIRM == 0) {
		if (FindText(X:="wait", Y:=3, 0, 0, 0, 0, 0, 0, STR_CONFIRM_BUTTON)) {
			X_CONFIRM := X
			Y_CONFIRM := Y
		}
	}
	MouseMove, X_CONFIRM, Y_CONFIRM, MOVE_SPEED
	Click
    return
}

BuyItem() {
	SubSequentOffers =
	isFirstOffer := true
	Loop {
		if (A_Index > 2) {
			ConfirmOffer()
			Break
		}
		LoopSize := 10 - ((A_Index - 1) * 4)
		Loop % LoopSize
		{
			Send {WheelDown 1}
			Sleep, 20
		}
		Sleep, 25
		ConfirmOffer()
		Sleep, 75
		isFirstOffer := false
	} Until !UI_IsOnHaggleWindow() || !WinActive("Path of Exile") || A_Index > 2 || ShouldBreak()
	if (UI_IsOnHaggleWindow()) {
		Sleep, 100
		if (UI_IsOnHaggleWindow()) {
			Send, {Esc}
		}
	}
	return SubSequentOffers
}

Haggle(guiStats) {
	global ARTIFACT_ENABLED_LESSER, ARTIFACT_ENABLED_GREATER, ARTIFACT_ENABLED_GRAND, ARTIFACT_ENABLED_EXCEPTIONAL

	Item := Item_GetInfo()
	if (!Item.Name) {
		return -1
	}

	guiStats.ListAdd(item.Name, item.Num, item.Value, "", "", "", "")

	if (item.Value > 0) {
		price := Item_GetHagglePrice()
		guiStats.ListModify(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "")

		artifactIsDisabled := false
		if (price.Currency == "LESSER" && !ARTIFACT_ENABLED_LESSER) {
			artifactIsDisabled := true
		}
		if (price.Currency == "GREATER" && !ARTIFACT_ENABLED_GREATER) {
			artifactIsDisabled := true
		}
		if (price.Currency == "GRAND" && !ARTIFACT_ENABLED_GRAND) {
			artifactIsDisabled := true
		}
		if (price.Currency == "EXCEPTIONAL" && !ARTIFACT_ENABLED_EXCEPTIONAL) {
			artifactIsDisabled := true
		}

		if (!WinActive("Path of Exile") || ShouldBreak()) {
			return -1
		}
		if (price.Total <= 0) {
			return 99999
		}

		if (item.Value > (price.Total * 0.8) && !artifactIsDisabled) {
			guiStats.ListModify(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "BUY")
			BuyItem()
			if (item.Name == "Prime Chaotic Resonator") {
				return 99999
			}
			return item.Value
		}
		else {
			if (artifactIsDisabled) {
				guiStats.ListModify(item.Name, item.Num, item.Value, "", "", "", "ARTIFACT DISABLED")
			} else {
				guiStats.ListModify(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "DISCARD")
			}
			if (UI_IsOnHaggleWindow()) {
				Sleep, 100
				if (UI_IsOnHaggleWindow()) {
					Send, {Esc}
				}
			}
			TT.Hide()
			return 0
		}
	}
	else {
		guiStats.ListModify(item.Name, item.Num, item.Value, "", "", "", "BLACKLISTED")
	}
	return 0
}

ProcessWindow() {
	guiStats := new Gui_Stats()
	guiStats.ListClear()
	guiStats.Show()

	positions := Haggle_Get_Positions()

	guiStats.SetWindowItems(positions.Count())

	For Index, Position In positions {
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
		MouseMove, Position.X, Position.Y, MOVE_SPEED
		itemValue := Haggle(guiStats)

		guiStats.IncreaseItemsProcessed()

		if (itemValue < 0) {
			break
		}
		else if (itemValue == 99999) {
			return true
		}
		Sleep, 10
	}

	guiStats.Hide()
	
	return false
}
Start_Haggling() {
	global EMPTY_INVENTORY_AFTER, ARTIFACT_ENABLED_LESSER, ARTIFACT_ENABLED_GREATER, ARTIFACT_ENABLED_GRAND, ARTIFACT_ENABLED_EXCEPTIONAL

	GuiHideSettings()

	if WinExist("Path of Exile") {
		WinActivate
	}
	Inventory_Ensure_Tujen()
	Sleep, 50

	coins := Coinage_Read() + 1
	Loop, %coins% {
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
		if (A_Index == 1 || Mod(A_Index, 5) == 0) {
			stock := Stock_Read()

			if (ARTIFACT_ENABLED_LESSER && stock.LESSER < 300) {
				MsgBox % "Not enough lesser currency to continue: " stock.LESSER
				break
			}
			if (ARTIFACT_ENABLED_GREATER && stock.GREATER < 300) {
				MsgBox % "Not enough greater currency to continue: " stock.GREATER
				break
			}
			if (ARTIFACT_ENABLED_GRAND && stock.GRAND < 300) {
				MsgBox % "Not enough grand currency to continue: " stock.GRAND
				break
			}
			if (ARTIFACT_ENABLED_EXCEPTIONAL && stock.EXCEPTIONAL < 300) {
				MsgBox % "Not enough exceptional currency to continue: " stock.EXCEPTIONAL
				break
			}
		}

		refreshItemPositions := ProcessWindow()
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
		if (refreshItemPositions == true) {
			Inventory_Exit()
			Sleep, 400
			Inventory_Open_Tujen_HaggleMenu()
			Sleep, 400
			continue
		}
		if (Inventory_Check_Threshold()) {
			Inventory_Empty_Perform_Sequence()
		}
		if (coins - A_Index > 0) {
			if (!WinActive("Path of Exile") || ShouldBreak()) {
				break
			}
			Trade_Refresh()
		}
	}

	GuiShowSettings()
}

F1::
	Start_Haggling()
return

F2::
	k := "|<0>*48$12.y3w1lknsXsbs7s7s7s7s7l7l7X37UDszU|<1>*48$6.wU0stllllnXXXXXU|<2>*48$11.w7k766SDwTlzXyDwTlz7wTny040Q|<3>*48$10.sD0AsnXyDlyDkzVz7wTlz7sz3Uw7s|<4>*48$11.ztzXy7sDYy1wXn7CAQs00001yDwzlzXk|<5>*48$11.s1k7USTwzsTkDwTsTszlzXy7wTky7kTk|<6>*48$12.z1w0sQkzlzXzXD033X7V7V7V7X7X7b37UDtzU|<7>*47$11.U1030DwTlzXyDwzlz7yDsznz7wTtznzk|<8>*48$12.y3w1ssssksstsHs7w7k3n1bV7l7l7XX3U7szU|<9>*48$12.y3w1sklslsXsXsXsVkk0s1zlzVzXT70D0TnzU"
    ok := FindText(X, Y, COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_X+COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_Y+COORD_HAGGLE_PRICE_H, 0.15, 0.15, k, 1)
	if (ocr := FindText().OCR(ok, 20, 20, 5)) {
        MsgBox % ocr.text
    }
	return

	s := Stock_Read()
	MsgBox % s.LESSER
	MsgBox % s.GREATER
	MsgBox % s.GRAND
	MsgBox % s.EXCEPTIONAL
	
	
return

F3::
	Inventory_Loop_Empty()
return


F4::
	guiStats := new Gui_Stats()
	guiStats.Show()
	guiStats.ListClear()
	guiStats.SetWindowItems(1)

	item := Item_GetInfo()
	price := Item_GetAlternativeHagglePrice2()

	guiStats.ListAdd(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "")
	guiStats.IncreaseItemsProcessed()

	Sleep, 5000
	guiStats.Hide()
return

GdipShutdown:
	Gdip_Shutdown(pToken)
ExitApp