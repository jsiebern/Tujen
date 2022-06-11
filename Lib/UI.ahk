UI_IsOnHaggleWindow() {
    path := A_ScriptDir . "\Lib\UI\haggle_window_open.png"

    bmpNeedle := Gdip_CreateBitmapFromFile(path)
	bmpHaystack := Gdip_BitmapFromScreen(1)

	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LIST, 0, 0, 0, 0, 0, 0xFFFFFF, 1, 1)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)
    
    return RET > 0
}

UI_IsInventoryOpen() {
    path := A_ScriptDir . "\Lib\UI\inventory.png"

    bmpNeedle := Gdip_CreateBitmapFromFile(path)
	bmpHaystack := Gdip_BitmapFromScreen(1)

	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LIST, 0, 0, 0, 0, 0, 0xFFFFFF, 1, 1)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)
    
    return RET > 0
}

UI_IsStashOpen() {
    path := A_ScriptDir . "\Lib\UI\stash.png"

    bmpNeedle := Gdip_CreateBitmapFromFile(path)
	bmpHaystack := Gdip_BitmapFromScreen(1)

	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, LIST, 0, 0, 0, 0, 0, 0xFFFFFF, 1, 1)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)
    
    return RET > 0
}

; UI_ReadFromScreen(xStart, xEnd, yStart, yEnd) {
; 	path := A_ScriptDir . "\GdipCapture.png"
; 	outPath := A_ScriptDir . "\GdipOut.txt"

; 	pBitmap := Gdip_BitmapFromScreen(xStart "|" yStart "|" xEnd - xStart "|" yEnd - yStart)
;     Gdip_SaveBitmapToFile(pBitmap, path, 100)
;     Gdip_DisposeImage(pBitmap)

;     RunWait, %A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe -i %path% > %outPath% , , hide
; 	FileRead, Result, %outPath%
; 	;FileDelete % outPath
; 	return Result
; }

MCode(ByRef code, hex) { ; allocate memory and write Machine Code there
   VarSetCapacity(code,StrLen(hex)//2)
   Loop % StrLen(hex)//2
      NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "Char")
}

MCode(blackwhite, "518B4424188B4C24149983E20303C2C1F80285C90F8E820000008B54240C535503C05603C0578B7C24208944241089542428894C242"
. "485FF7E4C8B7424182B74241C8B04168BD8C1FB108BE8C1FD0881E3FF00000081E5FF0000008BC803DD25FF00000003D881E1000000FF81FB7E010000"
. "7C0681C1FFFFFF00890A83C2044F75C08B7C24208B54242803542410FF4C242489542428759E5F5E5D5B33C059C3")

BlackWhite(pBitmap, ByRef pBitmapOut, Width, Height)
{
	global blackwhite
	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)

	R := DllCall(&blackwhite, "uint", Scan01, "uint", Scan02, "int", Width, "int", Height, "int", Stride1)

	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)

	return (R)
}

UI_ReadFromScreen(x, y, w, h, num = false, bw = false) {
    ; whitelist := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`'-,.:0123456789"
	path := A_ScriptDir . "\GdipCapture.png"
	outPath := A_ScriptDir . "\GdipOut.txt"

    FileDelete % path
    FileDelete % outPath

	pBitmap := Gdip_BitmapFromScreen(x "|" y "|"w "|" h)

	if (!bw) {
		Gdip_SaveBitmapToFile(pBitmap, path, 100)
	}
	else {
		Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
		pBitmapOut := Gdip_CreateBitmap(Width, Height)
		BlackWhite(pBitmap, pBitmapOut, Width, Height)
		Gdip_SaveBitmapToFile(pBitmapOut, path, 100)
		Gdip_DisposeImage(pBitmapOut)
	}
    Gdip_DisposeImage(pBitmap)
	

    ; RunWait, %A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe -i "%path%" > "%outPath%" --whitelist "%whitelist%" , , hide
	if num {
		command = Capture2Text/Capture2Text_CLI.exe -i `"%path%`" -o `"%outPath%`" -l English --trim-capture --whitelist "0123456789,."
		RunWait, %command% , , hide
		FileRead, Result, %outPath%
		
		return StrReplace(Result, ".", "")
	}
	else {
		command = Capture2Text/Capture2Text_CLI.exe -i `"%path%`" -o `"%outPath%`" -l English --trim-capture ; --whitelist `"%whitelist%`"
		RunWait, %command% , , hide
		FileRead, Result, %outPath%
		
		return StrReplace(Result, " ", "")
	}
}