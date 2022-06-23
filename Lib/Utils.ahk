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
    global ARTIFACT_ENABLED_LESSER, ARTIFACT_ENABLED_GREATER, ARTIFACT_ENABLED_GRAND, ARTIFACT_ENABLED_EXCEPTIONAL

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

    artifactIsDisabled := false
    if (CType == "LESSER" && !ARTIFACT_ENABLED_LESSER) {
        artifactIsDisabled := true
    }
    if (CType == "GREATER" && !ARTIFACT_ENABLED_GREATER) {
        artifactIsDisabled := true
    }
    if (CType == "GRAND" && !ARTIFACT_ENABLED_GRAND) {
        artifactIsDisabled := true
    }
    if (CType == "EXCEPTIONAL" && !ARTIFACT_ENABLED_EXCEPTIONAL) {
        artifactIsDisabled := true
    }

    if (!artifactIsDisabled) {
        Value := Offer_Read()
    }
    else {
        Value := 0
    }

    if (ResetMousePosition) {
        Send, {Esc}
    }

    return {Value: Value, Currency: CType, Total: CURRENCY[CType] * Value, IsDisabled: artifactIsDisabled}
}

Offer_Read() {
    global COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_H, STR_NUMBERS_CURSIVE

    ok := FindText(X, Y, COORD_HAGGLE_PRICE_X, COORD_HAGGLE_PRICE_Y, COORD_HAGGLE_PRICE_X+COORD_HAGGLE_PRICE_W, COORD_HAGGLE_PRICE_Y+COORD_HAGGLE_PRICE_H, 0.15, 0.15, STR_NUMBERS_CURSIVE, 1)
	if (ocr := FindText().OCR(ok, 20, 20, 5)) {
        return ocr.text
    }
    return -1
}

Coinage_Read() {
    global COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_W, COORD_COINS_LEFT_H, STR_NUMBERS

    ok := FindText(X, Y, COORD_COINS_LEFT_X, COORD_COINS_LEFT_Y, COORD_COINS_LEFT_X+COORD_COINS_LEFT_W, COORD_COINS_LEFT_Y+COORD_COINS_LEFT_H, 0.000001, 0.000001, STR_NUMBERS)
	if (ocr := FindText().OCR(ok)) {
        if (ocr.text != "") {
            return ocr.text
        }
    }
    return -1
}

Stock_Read() {
    global COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_H
    global COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_H
    global COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_H
    global COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_H
    global STR_NUMBERS

    FindText().ScreenShot()

    ok := FindText(X, Y, COORD_LESSER_LEFT_X, COORD_LESSER_LEFT_Y, COORD_LESSER_LEFT_X+COORD_LESSER_LEFT_W, COORD_LESSER_LEFT_Y+COORD_LESSER_LEFT_H, 0.000001, 0.000001, STR_NUMBERS, 0)
	if (ocr := FindText().OCR(ok)) {
        lesser := ocr.text
    }
    else {
        lesser := -1
    }
    ok := FindText(X, Y, COORD_GREATER_LEFT_X, COORD_GREATER_LEFT_Y, COORD_GREATER_LEFT_X+COORD_GREATER_LEFT_W, COORD_GREATER_LEFT_Y+COORD_GREATER_LEFT_H, 0.000001, 0.000001, STR_NUMBERS, 0)
    if (ocr := FindText().OCR(ok)) {
        greater := ocr.text
    }
    else {
        greater := -1
    }
    ok := FindText(X, Y, COORD_GRAND_LEFT_X, COORD_GRAND_LEFT_Y, COORD_GRAND_LEFT_X+COORD_GRAND_LEFT_W, COORD_GRAND_LEFT_Y+COORD_GRAND_LEFT_H, 0.000001, 0.000001, STR_NUMBERS, 0)
    if (ocr := FindText().OCR(ok)) {
        grand := ocr.text
    }
    else {
        grand := -1
    }
    ok := FindText(X, Y, COORD_EXCEPTIONAL_LEFT_X, COORD_EXCEPTIONAL_LEFT_Y, COORD_EXCEPTIONAL_LEFT_X+COORD_EXCEPTIONAL_LEFT_W, COORD_EXCEPTIONAL_LEFT_Y+COORD_EXCEPTIONAL_LEFT_H, 0.000001, 0.000001, STR_NUMBERS, 0)
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