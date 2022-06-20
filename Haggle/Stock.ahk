class Stock {
    lesser := 0
    greater := 0
    grand := 0
    exceptional := 0
    coins := 0

    lesserDisabled := false
    greaterDisabled := false
    grandDisabled := false
    exceptionalDisabled := false

    lesserPosition := new CoordinateBox(0, 0, 0, 0)
    greaterPosition := new CoordinateBox(0, 0, 0, 0)
    grandPosition := new CoordinateBox(0, 0, 0, 0)
    exceptionalPosition := new CoordinateBox(0, 0, 0, 0)
    coinPosition := new CoordinateBox(0, 0, 0, 0)

    __New() {
    }

    setDisabledState(lesser, greater, grand, exceptional) {
        this.lesserDisabled := lesser
        this.greaterDisabled := greater
        this.grandDisabled := grand
        this.exceptionalDisabled := exceptional
    }

    setLesserPosition(position) {
        this.lesserPosition := position
    }
    
    setGreaterPosition(position) {
        this.greaterPosition := position
    }
    
    setGrandPosition(position) {
        this.grandPosition := position
    }
    
    setExceptionalPosition(position) {
        this.exceptionalPosition := position
    }
}