/*
------------------------------------------
  Simple script for selecting screen area v1.8  By FeiYue

  Instructions:

  1.Press the hotkey "F1" to start the LButton key to drag the selection range.

    Then you can use the LButton key to adjust and RButton to determine the scope.

  2.Return the scope through 4 parameters.

------------------------------------------
*/

;// http://www.autohotkey.com/forum/topic62195.html
;//
;// Rbutton::MsgBox,,, % SelectArea(), 1.5
;// Rbutton::MsgBox,,, % SelectArea("cLime t100 g55 mr"), 1.5

GetRange(ByRef x="",ByRef y="",ByRef w="",ByRef h="")
{
  ; Save the initial state and set the current state
  cmm:=A_CoordModeMouse
  CoordMode, Mouse, Screen

  ; Create canvas GUI
  nW:=A_ScreenWidth, nH:=A_ScreenHeight
  Gui, Canvas:New, +AlWaysOnTop +ToolWindow -Caption
  Gui, Canvas:Add, Picture, x0 y0 w%nW% h%nH% +0xE HwndPicID

  ; Create selection range GUI
  Gui, Range:New, +LastFound +AlWaysOnTop -Caption +Border
    +OwnerCanvas +HwndRangeID
  WinSet, Transparent, 100
  Gui, Range:Color, Yellow

  ; Screenshots to the memory image and sent to
  ; the picture control of the canvas window.
  Ptr:=A_PtrSize ? "UPtr":"UInt", int:="int"
  hDC:=DllCall("GetDC", Ptr,0, Ptr)
  mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
  hBM:=DllCall("CreateCompatibleBitmap", Ptr,hDC, int,nW, int,nH, Ptr)
  oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
  DllCall("BitBlt", Ptr,mDC, int,0, int,0, int,nW, int,nH
    , Ptr,hDC, int,0, int,0, int,0x00CC0020|0x40000000)
  DllCall("ReleaseDC", Ptr,0, Ptr,hDC)
  ;---------------------
  SendMessage, 0x172, 0, hBM,, ahk_id %PicID%
  if ( E:=ErrorLevel )
    DllCall("DeleteObject", Ptr,E)
  ;---------------------
  DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
  DllCall("DeleteDC", Ptr,mDC)

  ; Display the canvas window and start to wait for the selection range
  Gui, Canvas:Show, NA x0 y0 w%nW% h%nH%

  ; Prompt to hold down the LButton key
  ListLines, Off
  oldx:=oldy:=""
  Loop {
    Sleep, 100
    MouseGetPos, x, y
    if (oldx=x and oldy=y)
      Continue
    oldx:=x, oldy:=y
    ;--------------------
    ToolTip, Please hold down LButton key to select a range
  }
  Until GetkeyState("LButton","P")

  ; Prompt to release the LButton key
  x1:=x, y1:=y, oldx:=oldy:=""
  Loop {
    Sleep, 100
    MouseGetPos, x, y
    if (oldx=x and oldy=y)
      Continue
    oldx:=x, oldy:=y
    ;--------------------
    w:=Abs(x1-x), h:=Abs(y1-y)
    x:=(x1+x-w)//2, y:=(y1+y-h)//2
    Gui, Range:Show, NA x%x% y%y% w%w% h%h%
    ToolTip, Please drag the mouse and release the LButton key
  }
  Until !GetkeyState("LButton","P")

  ; Prompt to click the RButton key to determine the range
  oldx:=oldy:=""
  Loop {
    Sleep, 100
    MouseGetPos, x, y, id
    if (id=RangeID) and GetkeyState("LButton","P")
    {
      WinGetPos, x1, y1,,, ahk_id %RangeID%
      Loop {
        Sleep, 100
        MouseGetPos, x2, y2
        Gui, Range:Show, % "NA x" x1+x2-x " y" y1+y2-y
      }
      Until !GetkeyState("LButton","P")
    }
    if (oldx=x and oldy=y)
      Continue
    oldx:=x, oldy:=y
    ;--------------------
    ToolTip, Please click the RButton key to determine the scope`,`n
    and use the LButton key can adjust the scope
  }
  Until GetkeyState("RButton","P")
  KeyWait, RButton
  ToolTip
  ListLines, On

  ; Clean the canvas and selection range GUI
  WinGetPos, x, y, w, h, ahk_id %RangeID%
  Gui, Range:Destroy
  Gui, Canvas:Destroy

  ; Clean the memory image and restore the initial state
  DllCall("DeleteObject", Ptr,hBM)
  CoordMode, Mouse, %cmm%
}


;===== Script End =====

;