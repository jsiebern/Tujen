BASE_PRICE_PATH := A_ScriptDir . "\Prices"

CURRENCY := {}
CURRENCY["EXCEPTIONAL"] := 0.08
CURRENCY["GRAND"] := 0.03
CURRENCY["GREATER"] := 0.025
CURRENCY["LESSER"] := 0.015
CURRENCY["COIN"] := 4

;ITEMS_OF_INTEREST := {}

Prices_Should_Update() {
    if (!FileExist(BASE_PRICE_PATH)) {
        return true
    }
}