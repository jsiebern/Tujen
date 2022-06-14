#SingleInstance, Force
;#IfWinActive, Path of Exile
SetWorkingDir, %A_ScriptDir%

#include Gdip\Gdip.ahk
#include Gdip\Gdip_ImageSearch.ahk
#Include Lib\FindText\FindText.ahk
#include Lib\Coordinates.ahk
#include Gui\Tujen_Gui.ahk
#include CSV.ahk
#include Lib\Prices.ahk
#include Lib\Utils.ahk
#include Lib\UI.ahk
#include Tujen_Functions.ahk
#include Lib\Inventory.ahk

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
	global OFFER_FIELD_X, OFFER_FIELD_Y, CONFIRM_BUTTON_X, CONFIRM_BUTTON_Y

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
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			TT.Hide()
			return -1
		}
		if (price.Total <= 0) {
			return 99999
		}
		
		symb := item.Value > price.Total ? ">" : "<"
		TT.Text(Round(Item.Value, 1) "c " symb " " Round(price.Total, 1) "c")
		if (item.Value > (price.Total * 0.8)) {
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
	
	Move_Initial()
	Loop, 2 {
		if (!WinActive("Path of Exile") || ShouldBreak()) {
			break
		}
		Loop, 11 {
			if (!WinActive("Path of Exile") || ShouldBreak()) {
				break
			}
			MouseGetPos, STORE_X, STORE_Y
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
			MouseMove, STORE_X, STORE_Y, MOVE_SPEED
			Move_Down()
		}
		Sleep, 50
		if (A_Index < 2) {
			Move_NextRow()
		}
	}
	TT.Hide()
	; T_Csv_Save()
	return false
}

Start_Haggling() {
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
		if (A_Index == 1 || Mod(A_Index, 3) == 0) {
			stock := Stock_Read()

			if (stock.LESSER < 300) {
				MsgBox % "Not enough lesser currency to continue: " stock.LESSER
				break
			}
			if (stock.GREATER < 300) {
				MsgBox % "Not enough greater currency to continue: " stock.GREATER
				break
			}
			if (stock.GRAND < 300) {
				MsgBox % "Not enough grand currency to continue: " stock.GRAND
				break
			}
			if (stock.EXCEPTIONAL < 300) {
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
		; TODO: Integrate "10" as a slider
		if (Mod(A_Index, 10) == 0) {
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
	Sleep, 1000
	TT.Hide()
}

F1::
	Start_Haggling()
return

^F2::
	FindText().Gui("Show")
return
F2::


	; ok:=FindText(X:="wait", Y:=3, 0,0,0,0,0,0,Text)    ; Wait 3 seconds for appear
	; ok:=FindText(X:="wait0", Y:=-1, 0,0,0,0,0,0,Text)  ; Wait indefinitely for disappear

		
	; if (UI_IsOnHaggleWindow()) {
	; 	MsgBox, Yes
	; }
	; else {
	; 	MsgBox, No
	; }
return

F3::
	MsgBox, Calibration: Position chest and Tujen so the character does not have to move to reach both

	; MsgBox, 4, , Would you like to use the alternative price detection mode?
	; IfMsgBox, Yes
	; 	USE_ALTERNATE_PRICE_DETECTION := true

	MsgBox, Mouse over Stash and press Enter
	MouseGetPos, X, Y
	CHEST_X := X
	CHEST_Y := Y

	MsgBox, Mouse over Tujen and press Enter
	MouseGetPos, X, Y
	TUJEN_X := X
	TUJEN_Y := Y

	InputBox, N, Empty inventory after how many windows?, Default is 10
	INVENTORY_EMPTY_AFTER_WINDOWS := N

	IS_CALIBRATED := true
	MsgBox, Calibration complete - press F1 to start haggling

	Inventory_Open_Tujen()
    Sleep, 200
	
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

F6::
	path := A_ScriptDir . "\Lib\UI\haggle_window_open.png"
	xStart := 589
    xEnd := 589 + 300
    yStart := 256
    yEnd := 256 + 60

	pBitmap := Gdip_BitmapFromScreen(xStart "|" yStart "|" xEnd - xStart "|" yEnd - yStart)
    Gdip_SaveBitmapToFile(pBitmap, path, 100)
    Gdip_DisposeImage(pBitmap)

	return

    bmpNeedle := Gdip_CreateBitmapFromFile(path)

	bmpHaystack := Gdip_BitmapFromScreen(1)

	RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,LIST,0,0,0,0,0,0xFFFFFF,1,0)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)

	MsgBox, % "Returned: " RET "`n`n" LIST
return

GdipShutdown:
	Gdip_Shutdown(pToken)
ExitApp