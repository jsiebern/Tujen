class ScreenGrab {
    capture2TextPath := "Capture2Text/Capture2Text_CLI.exe"
    temporaryScreenshotLocation := A_ScriptDir . "\tempScreenshot.png"
    temporaryTextOutput := A_ScriptDir . "\tempTextOut.txt"

    __New(newSreenShot = true)
    {
        if (newSreenShot) {
            FindText().ScreenShot()
        }
    }

    getColorAt(coordinate)
    {
        return FindText().GetColor(coordinate.x,coordinate.y)
    }

    readText(coordinateBox, numeric = false)
    {
        FindText().SavePic(this.temporaryScreenshotLocation, coordinateBox.x, coordinateBox.y, coordinateBox.x + coordinateBox.w, coordinateBox.y + coordinateBox.h, ScreenShot:=0)
        if (numeric) {
            command = %this.capture2TextPath% -i `"%this.temporaryScreenshotLocation%`" -o `"%this.temporaryTextOutput%`" -l English --trim-capture --whitelist "0123456789,."
            RunWait, %command% , , hide
            FileRead, Result, %this.temporaryTextOutput%
            
            return StrReplace(Result, ".", "")
        }
        else {
            command = %this.capture2TextPath% -i `"%this.temporaryScreenshotLocation%`" -o `"%this.temporaryTextOutput%`" -l English --trim-capture ; --whitelist `"%whitelist%`"
            RunWait, %command% , , hide
            FileRead, Result, %this.temporaryTextOutput%
            
            return StrReplace(Result, " ", "")
        }
    }

    findText(text, fast = true)
    {

    }

    hasText(text, fast = true)
    {
        if (fast) {
            if (FindText(X, Y, 0, 0, 0, 0, 0.000001, 0.000001, text, 0)) {
                return true
            }
        }
        else {
            if (FindText(X, Y, 0, 0, 0, 0, 0, 0, text, 0)) {
                return true
            }
        }
        
        return false
    }
}