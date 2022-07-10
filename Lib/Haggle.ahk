Haggle_Get_Positions() {
    global HaggleGridX, HaggleGridY, EMPTY_COLORS_HAGGLE_WINDOW, CELL_SIZE

    ignored := []
    ;Haggle_Get_IgnoredPositions()
    FindText().Screenshot()

    positions := []
	For C, GridX in HaggleGridX {
        if (C > 4) {
            continue
        }
        For R, GridY in HaggleGridY {
        	PointColor := FindText().GetColor(GridX,GridY)
			if !(indexOf(PointColor, EMPTY_COLORS_HAGGLE_WINDOW)) {
                isIgnored := false
                For i, ig in ignored {
                    if (ig.x > GridX && ig.x < GridX + CELL_SIZE && ig.y < GridY && ig.y > GridY - CELL_SIZE) {
                        isIgnored := true
                        break
                    }
                }
                if (isIgnored) {
                    continue
                }
                positions.Push({ X: GridX + Round(CELL_SIZE / 2), Y: GridY - Round(CELL_SIZE / 2) })
			}
		}
	}

    return positions
}

Haggle_Get_IgnoredPositions() {
    StringIgnore := "|<ArmourersScrap>*102$25.w007T000zU00DM01zoE1yA47z23zrV7zz0zznsDzww3Tzy07zzU7zzk3zzsBzrs7TzwTzzt3vznvzzzrzTzzzjwTzzwTzzwDzzzDU|<Transmutation>*74$13.TrjnsvwzuTxjwNyAw0QMDw6y0D03X1lVy7u|<BlacksmithWhetstone>*95$14.000000y1TUTs7y1zUTo7n3zkzzzzzzs|<SacrificeAtDusk>*41$19.0E00A832F3oV2R2074BR6TU4Tk0Tk0Tv0Tt0zz0zxVTzLzyzTwTzzzzzzTzzjzzrzzrzz3zz7|<SacrificeAtNoon>*34$23.lnzrVjzxnzzz7zzyTzzgTzz8zzzxzzXzzz7zzwDzzuzzzVzzz1zzz3zjz7zDzjzTzzzBzzraTzr2zzv3zzm3zvkWE"
    ignored := []
	if (ok := FindText(X, Y, GameX + Round(GameW/(2560/412)), GameY + Round(GameH/(1440/343)), GameX + Round(GameW/(2560/1260)), GameY + Round(GameH/(1440/1128)), 0.15, 0.15, StringIgnore)) {
		For i,v in ok {
			if (!WinActive("Path of Exile") || ShouldBreak()) {
			    break
			}
			ignored.Push({ x: ok[i].x, y: ok[i].y })
		}
	}
    return ignored
}