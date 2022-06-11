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
        return false
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
    global CURRENCY, HAGGLE_SUB_X, HAGGLE_SUB_Y, HAGGLE_SUB_W, HAGGLE_SUB_H, USE_ALTERNATE_PRICE_DETECTION

    ;if (USE_ALTERNATE_PRICE_DETECTION) {
        return Item_GetAlternativeHagglePrice2(false)
    ;}

    MouseGetPos, X, Y

    DirtyString := UI_ReadFromScreen(X - HAGGLE_SUB_X, Y - HAGGLE_SUB_Y, HAGGLE_SUB_W, HAGGLE_SUB_H, false, true)

    RegExMatch(DirtyString, "O)(?<nr>[0-9\.]{1,5})x", SubPat)
    Value := SubPat["nr"]
	Value := StrReplace(Value, ".", "")

    if (Value == "") {
        return Item_GetAlternativeHagglePrice2()
    }

    CType := "LESSER"
    if (InStr(DirtyString, "GRAND")) {
        CType := "GRAND"
    } else if (InStr(DirtyString, "GREATER")) {
        CType := "GREATER"
    } else if (InStr(DirtyString, "EXCEPTIONAL")) {
        CType := "EXCEPTIONAL"
    }

    return {Value: Value, Currency: CType, Total: CURRENCY[CType] * Value}
}

Item_GetAlternativeHagglePrice() {
    global CURRENCY, HAGGLE_SUB_X, HAGGLE_SUB_Y, HAGGLE_SUB_W, HAGGLE_SUB_H, Base_ScreenFactor

    MouseGetPos, X, Y

	bmpHaystack := Gdip_BitmapFromScreen(1)

    CType := "GREATER"
    path := A_ScriptDir . "\Lib\UI\artifact_sample_greater.png"
    bmpNeedle := Gdip_CreateBitmapFromFile(path)
	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
	Gdip_DisposeImage(bmpNeedle)
    offsetY := -10 * Base_ScreenFactor

    if (RET < 1) {
        CType := "LESSER"
        path := A_ScriptDir . "\Lib\UI\artifact_sample_lesser.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
        offsetY := -15 * Base_ScreenFactor
    }
    if (RET < 1) {
        CType := "GRAND"
        path := A_ScriptDir . "\Lib\UI\artifact_sample_grand.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 20, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
        offsetY := -25 * Base_ScreenFactor
    }
    if (RET < 1) {
        CType := "GRAND"
        path := A_ScriptDir . "\Lib\UI\artifact_sample_grand2.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 20, 0xFFFFFF, 20, 1)
        Gdip_DisposeImage(bmpNeedle)
        offsetY := -25 * Base_ScreenFactor
    }
    if (RET < 1) {
        CType := "EXCEPTIONAL"
        path := A_ScriptDir . "\Lib\UI\artifact_sample_exceptional.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
        offsetY := -10 * Base_ScreenFactor
    }
    if (RET < 1) {
        return false
    }
    spl := StrSplit(LST, ",")
    X := spl[1]
    Y := spl[2] + offsetY

    Gdip_DisposeImage(bmpHaystack)

    DirtyString := UI_ReadFromScreen(X - 70 * Base_ScreenFactor, Y, 100 * Base_ScreenFactor, HAGGLE_SUB_H, false)

    RegExMatch(DirtyString, "O)(?<nr>[0-9\.]{1,5})(x|X)", SubPat)
    Value := SubPat["nr"]
	Value := StrReplace(Value, ".", "")

    return {Value: Value, Currency: CType, Total: CURRENCY[CType] * Value}
}

Item_GetAlternativeHagglePrice2(ResetMousePosition = true) {
    global ARTIFACT_HOVER_X, ARTIFACT_HOVER_Y, CURRENCY, MOVE_SPEED, OFFER_FIELD_X, OFFER_FIELD_Y, HAGGLE_ALT_SUB_X, HAGGLE_ALT_SUB_Y, HAGGLE_ALT_SUB_W, HAGGLE_ALT_SUB_H

    MouseGetPos, STORE_X, STORE_Y

    Click
    
    bmpHaystack := Gdip_BitmapFromScreen(1)

    CType := "GREATER"
    path := A_ScriptDir . "\Lib\UI\artifact_large_sample_greater.png"
    bmpNeedle := Gdip_CreateBitmapFromFile(path)
	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
	Gdip_DisposeImage(bmpNeedle)
    offsetY := -10 * Base_ScreenFactor

    if (RET < 1) {
        CType := "LESSER"
        path := A_ScriptDir . "\Lib\UI\artifact_large_sample_lesser.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
    }
    if (RET < 1) {
        CType := "GRAND"
        path := A_ScriptDir . "\Lib\UI\artifact_large_sample_grand.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
    }
    if (RET < 1) {
        CType := "EXCEPTIONAL"
        path := A_ScriptDir . "\Lib\UI\artifact_large_sample_exceptional.png"
        bmpNeedle := Gdip_CreateBitmapFromFile(path)
        RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LST, 0, 0, 0, 0, 2, 0xFFFFFF, 2, 1)
        Gdip_DisposeImage(bmpNeedle)
    }
    if (RET < 1) {
        return false
    }

    Gdip_DisposeImage(bmpHaystack)

    Value := Offer_Read()

    if (ResetMousePosition) {
        Send, {Esc}
        MouseMove, STORE_X, STORE_Y, MOVE_SPEED
    }

    return {Value: Value, Currency: CType, Total: CURRENCY[CType] * Value, AltMethod: true}
}

Offer_Read() {
    global ARTIFACT_HOVER_X, ARTIFACT_HOVER_Y, CURRENCY, MOVE_SPEED, OFFER_FIELD_X, OFFER_FIELD_Y, OFFER_READ_SUB_X, OFFER_READ_SUB_Y, OFFER_READ_SUB_W, OFFER_READ_SUB_H

    DirtyString := UI_ReadFromScreen(OFFER_FIELD_X - OFFER_READ_SUB_X, OFFER_FIELD_Y - OFFER_READ_SUB_Y, OFFER_READ_SUB_W, OFFER_READ_SUB_H, true)

    RegExMatch(DirtyString, "O)(?<nr>[0-9]{1,4})", SubPat)
    Value := SubPat["nr"]

    return Value
}

Coinage_Read() {
    global COINAGE_X, COINAGE_Y

    DirtyString := UI_ReadFromScreen(COINAGE_X - 30, COINAGE_Y - 20, 60, 40, true)

    RegExMatch(DirtyString, "O)(?<nr>[0-9]{1,4})", SubPat)
    Value := SubPat["nr"]
    if (Value == "") {
        return 0
    }

    return Value
}

Stock_Read() {
    global COINAGE_X, COINAGE_Y, COINAGE_READ_SUB_X, COINAGE_READ_SUB_W, COINAGE_READ_SUB_H, COINAGE_READ_SUB_Y_LESSER, COINAGE_READ_SUB_Y_GREATER, COINAGE_READ_SUB_Y_GRAND, COINAGE_READ_SUB_Y_EXCEPTIONAL

    lesser := UI_ReadFromScreen(COINAGE_X - COINAGE_READ_SUB_X, COINAGE_Y + COINAGE_READ_SUB_Y_LESSER, COINAGE_READ_SUB_W, COINAGE_READ_SUB_H, true)
    RegExMatch(lesser, "O)(?<nr>[0-9]{1,4})", SubPat)
    lesser := SubPat["nr"]
    if (lesser == "") {
        lesser := 0
    }

    greater := UI_ReadFromScreen(COINAGE_X - COINAGE_READ_SUB_X, COINAGE_Y + COINAGE_READ_SUB_Y_GREATER, COINAGE_READ_SUB_W, COINAGE_READ_SUB_H, true)
    RegExMatch(greater, "O)(?<nr>[0-9]{1,4})", SubPat)
    greater := SubPat["nr"]
    if (greater == "") {
        greater := 0
    }

    grand := UI_ReadFromScreen(COINAGE_X - COINAGE_READ_SUB_X, COINAGE_Y + COINAGE_READ_SUB_Y_GRAND, COINAGE_READ_SUB_W, COINAGE_READ_SUB_H, true)
    RegExMatch(grand, "O)(?<nr>[0-9]{1,4})", SubPat)
    grand := SubPat["nr"]
    if (grand == "") {
        grand := 0
    }
    
    exceptional := UI_ReadFromScreen(COINAGE_X - COINAGE_READ_SUB_X, COINAGE_Y + COINAGE_READ_SUB_Y_EXCEPTIONAL, COINAGE_READ_SUB_W, COINAGE_READ_SUB_H, true)
    RegExMatch(exceptional, "O)(?<nr>[0-9]{1,4})", SubPat)
    exceptional := SubPat["nr"]
    if (exceptional == "") {
        exceptional := 0
    }

    return {LESSER: lesser, GREATER: greater, GRAND: grand, EXCEPTIONAL: exceptional}
}

Trade_Refresh() {
    global REFRESH_BUTTON_X, REFRESH_BUTTON_Y, MOVE_SPEED
    MouseMove, REFRESH_BUTTON_X, REFRESH_BUTTON_Y, MOVE_SPEED
    Click
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