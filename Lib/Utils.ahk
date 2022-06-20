#Include Lib\Prices.ahk
#Include Lib\Prices_Poe.ahk
#Include Gdip\Gdip.ahk

Item_GetInfo() {
    global ITEMS_OF_INTEREST

    clipboard := ""
    Send, ^c
    ClipWait 0.05
    C := clipboard
    C := StrReplace(C, ".", "")
    lines := StrSplit(C, "`r`n")
    I_Name := Trim(lines[3])
    I_Alt_Name := Trim(lines[4])
    ; Customizations
    if (InStr(C, "Contract") && InStr(C, "Deception")) {
        I_Name := "Contract"
    }
    if (InStr(C, "Blueprints")) {
        I_Name := "Blueprint"
    }
    if (Item_Description_IsMap(C) || Item_Description_Is_Ignored(C)) {
        if (Item_Description_GetMapTier(C) < 14 && !Item_Description_Is_Unique(C)) {
            I_Name := "-"
            I_Alt_Name := "-"
        }
    }
    if (Item_Description_IsOccupied(C)) {
        I_Name := "Occupied Map"
    }
    if (Item_Description_IsIncubator(C)) {
        I_Name := "-"
        I_Alt_Name := "-"
    }
    ; End Customizations
    I_Num := Item_Description_GetStackSize(C)
    I_Of_Interest := ITEMS_OF_INTEREST.HasKey(I_Name)
    if (!I_Of_Interest) {
        I_Of_Interest := ITEMS_OF_INTEREST.HasKey(I_Alt_Name)
        if (I_Of_Interest) {
            I_Name := I_Alt_Name
        }
    }
    I_Value := 0
    if (I_Of_Interest) {
        V := ITEMS_OF_INTEREST[I_Name]
        I_Value := V * I_Num
    }
    item := {Name: I_Name, Num: I_Num, Value: I_Value}
    return item
}

Item_Description_Is_Ignored(description) {
    Has := InStr(description, "Whetstone")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Abyss Jewels")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Scrap")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Silver Coin")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Transmutation")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Orb of Binding")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Breach Ring")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Clear Oil")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Sepia Oil")
    if (Has > 0) {
        return true
    }
    Has := InStr(description, "Amber Oil")
    if (Has > 0) {
        return true
    }
    return false
}

Item_Description_IsOccupied(description) {
    HasOccupied := InStr(description, "Map is occupied")
    if (HasOccupied > 0) {
        return true
    }
    HasContains := InStr(description, "Map contains")
    if (HasContains > 0) {
        return true
    }
    HasContains := InStr(description, "Area is influenced")
    if (HasContains > 0) {
        return true
    }
    return false
}

Item_Description_IsIncubator(description) {
    HasIncubator := InStr(description, "Incubator")
    if (HasIncubator <= 0) {
        return false
    }
    return true
}

Item_Description_Is_Unique(description) {
    HasUnique := InStr(description, "Rarity: Unique")
    if (HasUnique <= 0) {
        return false
    }
    HasMemory := InStr(description, "Memory")
    if (HasMemory <= 0) {
        ; return false
    }
    return true
}

Item_Description_IsMap(description) {
    HasTier := InStr(description, "Map Tier")
    if (HasTier <= 0) {
        return false
    }
    return true
}

Item_Description_GetMapTier(description) {
    RegExMatch(description, "O)Map Tier: (?<nr>[0-9]{1,2})\/", SubPat)
    return SubPat["nr"]
}

Item_Description_GetStackSize(description) {
    HasStackSize := InStr(description, "Stack Size")
    if (HasStackSize <= 0) {
        return 1
    }
    RegExMatch(description, "O)Stack Size: (?<nr>[0-9]{1,4})\/", SubPat)
    return SubPat["nr"]
}

Item_GetHagglePrice() {
    return Item_GetAlternativeHagglePrice2(false)
}

Item_GetAlternativeHagglePrice2(ResetMousePosition = true) {
    global CURRENCY, STR_LESSER_ARTIFACT, STR_GREATER_ARTIFACT, STR_GRAND_ARTIFACT, STR_EXCEPTIONAL_ARTIFACT, MOVE_SPEED

    Click
    Sleep, 50

    if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, STR_LESSER_ARTIFACT, 1, 0)) {
        CType := "LESSER"
	} else if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, STR_GREATER_ARTIFACT, 0, 0)) {
        CType := "GREATER"
    } else if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, STR_GRAND_ARTIFACT, 0, 0)) {
        CType := "GRAND"
    } else if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, STR_EXCEPTIONAL_ARTIFACT, 0, 0)) {
        CType := "EXCEPTIONAL"
    } else {
        return false
    }

    Value := Offer_Read()

    if (ResetMousePosition) {
        Send, {Esc}
    }

    return {Value: Value, Currency: CType, Total: CURRENCY[CType] * Value, AltMethod: true}
}

CleanNumberRead(result) {
    result := StrReplace(result, " ", "")
    RegExMatch(result, "O)(?<nr>[0-9\.]{1,6})", SubPat)
    Value := SubPat["nr"]
	return StrReplace(Value, ".", "")
}

Offer_Read() {
    global COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H

    k := "|<0>*48$12.y3w1lknsXsbs7s7s7s7s7l7l7X37UDszU|<1>*48$6.wU0stllllnXXXXXU|<2>*48$11.w7k766SDwTlzXyDwTlz7wTny040Q|<3>*48$10.sD0AsnXyDlyDkzVz7wTlz7sz3Uw7s|<4>*48$11.ztzXy7sDYy1wXn7CAQs00001yDwzlzXk|<5>*48$11.s1k7USTwzsTkDwTsTszlzXy7wTky7kTk|<6>*48$12.z1w0sQkzlzXzXD033X7V7V7V7X7X7b37UDtzU|<7>*47$11.U1030DwTlzXyDwzlz7yDsznz7wTtznzk|<8>*48$12.y3w1ssssksstsHs7w7k3n1bV7l7l7XX3U7szU|<9>*48$12.y3w1sklslsXsXsXsVkk0s1zlzVzXT70D0TnzU"
    ok := FindText(X, Y, COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_X+COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_Y+COORD_HAGGLE_PRICE_H, 0.15, 0.15, k, 1)
	if (ocr := FindText().OCR(ok, 20, 20, 5)) {
        return ocr.text
    }
    return -1
}

Coinage_Read() {
    global COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H

    n := "|<0>*47$10.sT0sV74QHsDUy3s7YSFlWC1yTU|<1>*47$7.yQ04XlswSD7XlswS8|<2>*46$9.kw16Bkz7lyDnwT7lwT000U|<3>*47$9.kw16BsyDlwz1y7sz7sy7lkMDU|<4>*46$11.zDwDsTUz1wXn7aCQQsk000z7yDwTss|<5>*45$9.kA0UAzbwDUTVyDsz7syDVkMDU|<6>*47$10.yTUQRXyTlz4Q0Fl7US1s7YSMlkDXs|<7>*46$10.04081z7wTnyDtz7wzXyDtz7wzXy|<8>*48$10.sy0tl7YSEnUD1w3Y4QHsDUyFlUDXs|<9>*47$10.sy0tV74QFl7US0kU74Tlz7sk70zjs"

    ok := FindText(COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_X+COORD_COINS_LEFT_W, COORD_COINS_LEFT_Y+COORD_COINS_LEFT_H, 0.000001, 0.000001, n)
	if (ocr := FindText().OCR(ok)) {
        return ocr.text
    }
    return -1
}

Stock_Read() {
    global COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H
    global COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H
    global COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H
    global COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H

    n := "|<0>*47$10.sT0sV74QHsDUy3s7YSFlWC1yTU|<1>*47$7.yQ04XlswSD7XlswS8|<2>*46$9.kw16Bkz7lyDnwT7lwT000U|<3>*47$9.kw16BsyDlwz1y7sz7sy7lkMDU|<4>*46$11.zDwDsTUz1wXn7aCQQsk000z7yDwTss|<5>*45$9.kA0UAzbwDUTVyDsz7syDVkMDU|<6>*47$10.yTUQRXyTlz4Q0Fl7US1s7YSMlkDXs|<7>*46$10.04081z7wTnyDtz7wzXyDtz7wzXy|<8>*48$10.sy0tl7YSEnUD1w3Y4QHsDUyFlUDXs|<9>*47$10.sy0tV74QFl7US0kU74Tlz7sk70zjs"

    FindText().ScreenShot()

    ok := FindText(X, Y, COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_X+COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_Y+COORD_LESSER_LEFT_H, 0.000001, 0.000001, n, 0)
	if (ocr := FindText().OCR(ok)) {
        lesser := ocr.text
    }
    else {
        lesser := -1
    }
    ok := FindText(X, Y, COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_X+COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_Y+COORD_GREATER_LEFT_H, 0.000001, 0.000001, n, 0)
    if (ocr := FindText().OCR(ok)) {
        greater := ocr.text
    }
    else {
        greater := -1
    }
    ok := FindText(X, Y, COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_X+COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_Y+COORD_GRAND_LEFT_H, 0.000001, 0.000001, n, 0)
    if (ocr := FindText().OCR(ok)) {
        grand := ocr.text
    }
    else {
        grand := -1
    }
    ok := FindText(X, Y, COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_X+COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_Y+COORD_EXCEPTIONAL_LEFT_H, 0.000001, 0.000001, n, 0)
    if (ocr := FindText().OCR(ok)) {
        exceptional := ocr.text
    }
    else {
        exceptional := -1
    }

    return {LESSER: lesser, GREATER: greater, GRAND: grand, EXCEPTIONAL: exceptional}
}

X_REFRESH := 0
Y_REFRESH := 0
Trade_Refresh() {
    global STR_REROLL_CURRENCY, X_REFRESH, Y_REFRESH, MOVE_SPEED
    if (X_REFRESH == 0) {
        if (FindText(X:="wait", Y:=3, 0, 0, 0, 0, 0, 0, STR_REROLL_CURRENCY)) {
            X_REFRESH := X
            Y_REFRESH := Y
        }
    }
    MouseMove, X_REFRESH, Y_REFRESH, MOVE_SPEED
    Click
    return
}

Generate_Id() {
    str := "0123456789abcdefghijklmnopqrstuvwxyz"
    loop 10000
    {
        start:
            Random, rnd, 1, 36
            fin := SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin := SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
            Random, rnd, 1, 36
            fin .= SubStr(str, rnd, 1)
        if RegexMatch(fin, "^(.)\1+$")
            goto start
    }
    return fin
}

Generate_DateTime() {
    FormatTime, dateTime,, dd-MM-yy HH:mm:ss
    return dateTime
}

CreateFont(options="", font="") {
    Loop 99 {
        g = %a_index%
        Gui %g%: +LastfoundExist
        If ! WinExist()
        break
    }
    Gui, %g%: +Lastfound
    Gui, %g%: Font, %options%, %font%
    Gui, Add, Button
    SendMessage, 0x31, 0, 0, Button1  ;WM_GETFONT
    Gui, %g%: Destroy
    return errorLevel
}

SetFont(ctrl, win, font=0) {
    SendMessage, 0x30, %font%, 1, %ctrl%, ahk_id%win% 
    return errorLevel
}

; TT(txt, x, y) {
;     font := CreateFont("bold s50", "Matisse ITC")
;     Tooltip % txt, x, y
;     WinWait ahk_class tooltips_class32
;     SetFont("", WinExist(), font)
; }