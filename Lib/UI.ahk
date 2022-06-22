UI_IsOnHaggleWindow() {
	global STR_HAGGLE_WINDOW_OPEN, MOVE_SPEED
    if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, STR_HAGGLE_WINDOW_OPEN)) {
        return true
	}
	return false
}

UI_IsInventoryOpen() {
    return false
}

UI_IsStashOpen() {
    return false
}

UI_ReadFromScreen(X, Y, W, H) {
    global STR_NUMBERS, STR_NUMBERS_CURSIVE

    ok := FindText(xX, yY, X, Y, X+W, Y+H, 0.15, 0.15, STR_NUMBERS_CURSIVE, 1)
	if (ocr := FindText().OCR(ok, 20, 20, 5)) {
        if (ocr.text != "") {
            return ocr.text
        }
    }
    ok := FindText(xX, yY, X, Y, X+W, Y+H, 0.15, 0.15, STR_NUMBERS, 1)
	if (ocr := FindText().OCR(ok, 20, 20, 5)) {
        if (ocr.text != "") {
            return ocr.text
        }
    }
    return ""
}