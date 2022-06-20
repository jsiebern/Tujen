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