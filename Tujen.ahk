#SingleInstance, Force
;#IfWinActive, Path of Exile
SetWorkingDir, %A_ScriptDir%

#include Lib\Eval.ahk
#include Lib\Load_Bar.ahk
#include Lib\WinHttpRequest.ahk
#include Lib\JSON.ahk
#include Lib\PriceFetch.ahk
#include Lib\Prices.ahk
#Include Lib\FindText\FindText.ahk
#include Lib\Coordinates.ahk
#include Gui\Tujen_Gui.ahk
#include Lib\Utils.ahk
#include Lib\UI.ahk
#include Lib\Inventory.ahk
#include Lib\Haggle.ahk

STOP_SCRIPT := false
Load_BarControl(0, "Initializing", 1)
Prices := new PriceFetch()
Load_BarControl(92, "Injecting Custom Prices", 1)
customPrices := StrSplit(PRICES_CUSTOM, "`n")
parsedPrices := {}
For i, Price in customPrices {
	spl := StrSplit(Price, ":")
	key := spl[1]
	value := spl[2]
	RegExMatch(value, "O)\{(?<key>[a-zA-Z ]*)\}", SubPat)
    if (SubPat["key"]) {
		value := StrReplace(value, "{" . SubPat["key"] . "}", Prices.PriceList[SubPat["key"]])
		value := Eval(value)
	}
	
	parsedPrices[key] := value
}
Prices.InjectPrices(parsedPrices)
Load_BarControl(100, "Done", -1)
GuiShowSettings()


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
		Sleep, 55
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

		if (!WinActive("Path of Exile") || ShouldBreak()) {
			return -1
		}

		if (item.Value > (price.Total * 0.8) && !price.IsDisabled) {
			guiStats.ListModify(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "BUY")
			BuyItem()
			if (item.Name == "Prime Chaotic Resonator") {
				return 99999
			}
			return item.Value
		}
		else {
			if (price.IsDisabled) {
				guiStats.ListModify(item.Name, item.Num, item.Value, "", "", "", "DISABLED")
			} else {
				guiStats.ListModify(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "DISCARD")
			}
			Send, {Esc}
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

F3::
	Inventory_Loop_Empty()
return

F4::
	guiStats := new Gui_Stats()
	guiStats.Show()
	guiStats.ListClear()
	guiStats.SetWindowItems(1)

	price := Item_GetAlternativeHagglePrice2()
	if WinExist("Path of Exile") {
		WinActivate
	}
	Sleep, 50
	MouseMove, 1, 1, 3, R
	Sleep, 50
	item := Item_GetInfo()
	Sleep, 50

	guiStats.ListAdd(item.Name, item.Num, item.Value, price.CURRENCY, price.Value, price.Total, "PRICECHECK")
	guiStats.IncreaseItemsProcessed()

	Sleep, 5000
	guiStats.Hide()
return