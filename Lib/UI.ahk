UI_IsOnHaggleWindow() {
    path := A_ScriptDir . "\Lib\UI\haggle_window_open.png"

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

UI_ReadFromScreen(x, y, w, h, num = false) {
    ; whitelist := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`'-,.:0123456789"
	path := A_ScriptDir . "\GdipCapture.png"
	outPath := A_ScriptDir . "\GdipOut.txt"

    FileDelete % path
    FileDelete % outPath

	pBitmap := Gdip_BitmapFromScreen(x "|" y "|"w "|" h)
    Gdip_SaveBitmapToFile(pBitmap, path, 100)
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
		
		return Result
	}
}