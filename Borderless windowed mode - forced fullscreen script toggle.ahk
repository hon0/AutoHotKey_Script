#SingleInstance force

;;; Known issues:
;;;
;;; - Weird results for windows with custom decorations such as
;;; Chrome, or programs with a Ribbon interface.
;;; - Emacs will be maximized behind instead of in front of
;;; the taskbar. Workaround: WinHide ahk_class Shell_TrayWnd
ToggleFakeFullscreen()
{
CoordMode Screen, Window
static WINDOW_STYLE_UNDECORATED := -0xC40000
static savedInfo := Object() ;; Associative array!
WinGet, id, ID, A
if (savedInfo[id])
{
inf := savedInfo[id]
WinSet, Style, % inf["style"], ahk_id %id%
WinMove, ahk_id %id%,, % inf["x"], % inf["y"], % inf["width"], % inf["height"]
savedInfo[id] := ""
}
else
{
savedInfo[id] := inf := Object()
WinGet, ltmp, Style, A
inf["style"] := ltmp
WinGetPos, ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
inf["x"] := ltmpX
inf["y"] := ltmpY
inf["width"] := ltmpWidth
inf["height"] := ltmpHeight
WinSet, Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
mon := GetMonitorActiveWindow()
SysGet, mon, Monitor, %mon%
WinMove, A,, %monLeft%, %monTop%, % monRight-monLeft, % monBottom-monTop
}
}

GetMonitorAtPos(x,y)
{
;; Monitor number at position x,y or -1 if x,y outside monitors.
SysGet monitorCount, MonitorCount
i := 0
while(i < monitorCount)
{
SysGet area, Monitor, %i%
if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom )
{
return i
}
i := i+1
}
return -1
}

GetMonitorActiveWindow(){
;; Get Monitor number at the center position of the Active window.
WinGetPos x,y,width,height, A
return GetMonitorAtPos(x+width/2, y+height/2)
}

F12::ToggleFakeFullscreen()rrors
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F13::
While GetKeyState("F13","p"){
	SetKeyDelay 100, 100
	Send,{SC01A}
	Sleep 10
}
return