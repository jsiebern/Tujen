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

#include TT.ahk

TTF := TT()
TTF_Hide := false
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

BuyItem(offer, isExalted = false, AltMethod = false) {
	if (!AltMethod) {
		Click
	}
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

Haggle(windowId, stock) {
	global ARTIFACT_ENABLED_LESSER, ARTIFACT_ENABLED_GREATER, ARTIFACT_ENABLED_GRAND, ARTIFACT_ENABLED_EXCEPTIONAL

	Item := Item_GetInfo()
	if (!Item.Name) {
		return -1
	}

	TT := TT()
	iconPath := A_ScriptDir . "\Currencies\" . Item.Name . ".png"
	TT.Title(item.Name, iconPath, "")
	TT.Font("S40 bold striceout underline, Arial")
	TT.Show(Round(Item.Value, 1) "c", 1020, 0)

	if (item.Value > 0) {
		price := Item_GetHagglePrice()
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
			TT.Hide()
			return -1
		}
		if (price.Total <= 0) {
			return 99999
		}
		
		symb := item.Value > price.Total ? ">" : "<"
		TT.Text(Round(Item.Value, 1) "c " symb " " Round(price.Total, 1) "c")
		if (item.Value > (price.Total * 0.8) && !artifactIsDisabled) {
			if (item.Value > price.Total * 3) {
				offer := Ceil(price.Value * 0.6)
			}
			SubSequentOffers := BuyItem(offer, item.Name == "Exalted Orb", price.AltMethod == true)
			; T_Csv_AddEntry(windowId, item.Name, "", item.Num, item.Value, price.Value, price.Currency, price.Total, offer, SubSequentOffers, Generate_DateTime())
			TT.Hide()
			if (item.Name == "Prime Chaotic Resonator") {
				return 99999
			}
			return item.Value
		}
		else {
			; T_Csv_AddEntry(windowId, item.Name, "", item.Num, item.Value, price.Value, price.Currency, price.Total, "", "", Generate_DateTime())
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
	TT.Hide()
	return 0
}

ProcessWindow(stock) {
	global TOOLTIP_1_X, TOOLTIP_1_Y
	windowId := T_Csv_NewWindow()
	windowValue := 0

	TT := TT("Color=0x008000 PARENT=77")
	TT.Title("Window Value", A_ScriptDir . "\Currencies\Chaos Orb.png", "")
	TT.Font("S40 bold striceout underline, Arial")
	TT.Show("0c", TOOLTIP_1_X, TOOLTIP_1_Y)

	positions := Haggle_Get_Positions()
	For Index, Position In positions {
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
		MouseMove, Position.X, Position.Y, MOVE_SPEED
		itemValue := Haggle(windowId, stock)
		if (itemValue < 0) {
			break
		}
		else if (itemValue == 99999) {
			return true
		}
		windowValue := windowValue + itemValue
		TT.Text(Round(windowValue, 1) "c")
		Sleep, 10
	}
	
	TT.Hide()
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

		refreshItemPositions := ProcessWindow(stock)
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
	TT := TT()
	TT.Font("S40 bold striceout underline, Arial")
	TT.Show("Stopped...", TOOLTIP_2_X, TOOLTIP_2_Y)

	GuiShowSettings()

	Sleep, 1000
	TT.Hide()
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
	item := Item_GetInfo()
	price := Item_GetAlternativeHagglePrice2()
	
	lim := Ceil(item.Value / CURRENCY[price.Currency])
	addLimit := "`r`nMax: " lim " " price.Currency
	
	TTF.Title(item.Name, A_ScriptDir . "\Currencies\" . Item.Name . ".png", "")
	TTF.Font("S40 bold striceout underline, Arial")
	
	symb := item.Value > price.Total ? ">" : "<"
	TTF.Show(Round(item.Value, 1) "c " symb " " Round(price.Total, 1) "c" addLimit, 1020, 0)
	Sleep, 5000
	TTF.Hide()
return

GdipShutdown:
	Gdip_Shutdown(pToken)
ExitApp