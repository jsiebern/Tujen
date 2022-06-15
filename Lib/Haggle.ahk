Haggle_Get_Positions() {
    global HaggleGridX, HaggleGridY, EMPTY_COLORS_HAGGLE_WINDOW, CELL_SIZE

    FindText().Screenshot()

    positions := []
	For C, GridX in HaggleGridX {
        For R, GridY in HaggleGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if !(indexOf(PointColor, EMPTY_COLORS_HAGGLE_WINDOW)) {
                positions.Push({ X: GridX + Round(CELL_SIZE / 2), Y: GridY - Round(CELL_SIZE / 2) })
			}
		}
	}

    return positions
}