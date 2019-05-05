#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#InstallKeybdHook
;#InstallMouseHook


{ ; Monitoring Windows
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
		WinClose Event Tester
	
	Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
	WinWait, Event Tester
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
	MouseClick, left, 36, 40
	MouseClick, left, 104, 62
	BlockInput, Off	
	return
	#IfWinExist
}

{ ; AutoHotKey Script option.
	#F1::Suspend, Toggle
	#F4::ExitApp
	;^SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
	^!f:: ; FullScreen Window. Control+Alt+F
	{
		WinGetTitle, currentWindow, A
		IfWinExist %currentWindow%
		{
			WinSet, Style, ^0xC00000 ; toggle title bar
			WinMove, , , 0, 0, 1920, 1080
		}
		return
	}
} ; AutoHotKey Script option.

/* ; Get exit cross color
	#z::	
	PixelGetColor, color, 1889, 95
	MsgBox The color at X1889 Y95 is %color%.
	Clipboard = %color%
	return
*/

{ ;Testing	
	/*; Pixel color as as condition
		{ ; Pixel color as as condition
			!#z::	
			PixelGetColor, color, 1889, 95
			MsgBox The color at X1889 Y95 is %color%.
			Clipboard = %color%
			return
			
			{ ; Numpad1
				Numpad9::
				PixelGetColor, color, 1889, 95
				if color = 0x213A70
					
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					MouseClick, left, 1732, 171
					MouseMove, xpos, ypos 
					BlockInput, Off
					return
				}
				Else
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					SetKeyDelay 32, 32
					Send {NumpadEnter}
					MouseClick, left, 1732, 171
					MouseMove, xpos, ypos 
					BlockInput, Off
				}
				Return
			}
		}
	*/
}

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1.
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	Return	
}

XButton2::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, ^(
			KeyWait, XButton2
		}
		Else
		{
			SetKeyDelay 10, 32
			Send, ^'
			KeyWait, XButton2
		}
		Return
	}
	Else If (Layer=1) and WinActive("Discord")
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
			KeyWait, XButton2
		}
		Return
	}
	Else
	{
		Send {XButton2 Down}
		KeyWait XButton2
		Send {XButton2 Up}
	}
	Return
}

XButton1::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait XButton1, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, ^è
			KeyWait, XButton1
		}
		else
		{
			SetKeyDelay 10, 32
			Send, ^"
			KeyWait, XButton1
		}
		Return
	}
	Else If (Layer=1) and WinActive("Discord")
	{
		KeyWait XButton1, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Down}{LShift Up}{LAlt Up}
			KeyWait, XButton1
		}
		Return
	}
	Else
	{
		Send {XButton1 Down}
		KeyWait XButton1
		Send {XButton1 Up}
	}
	Return
}

WheelUp::
{
	If (Layer=1) and GetKeyState("MButton")
	{
		SetkeyDelay, 0, 32
		Send {Home}
		Return
	}
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {PgDn}
		Return
	}
	Else
	{
		Send {WheelUp}
		Return
	}
	Return
}

WheelDown::
{
	If (Layer=1) and GetKeyState("MButton")
	{
		SetkeyDelay, 0, 32
		Send {End}
		Return
	}
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {PGUP}
		Return
	}
	Else
	{
		Send {WheelDown}
		Return
	}
	Return
}

$q::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		Send {& Down}
		KeyWait, q
		Send {& Up}
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{
		Send {& Down}
		KeyWait, q
		Send {& Up}
	}
	Else
	{
		Send {q Down}
		KeyWait, q
		Send {q Up}
	}
	Return
}

$e::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		Send {SC004 Down}
		KeyWait, e
		Send {SC004 Up}
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{
		Send {SC004 Down}
		KeyWait, e
		Send {SC004 Up}
	}
	Else
	{
		Send {e Down}
		KeyWait, e
		Send {e Up}
	}
	Return
}

$w::
{
	If (Layer=2) and WinActive(Settlers 7 Window)
	{
		Send {é Down}
		KeyWait, w
		Send {é Up}
	}
	Else
	{
		Send {w Down}
		KeyWait, w
		Send {w Up}
	}
	Return
}

$Tab::
{
	If (Layer=2)
	{
		Send {esc Down}
		KeyWait, Tab
		Send {esc Up}
	}
	Else If (Layer=1) and WinActive(Settlers 7 Window)
	{
		Send ^é
		KeyWait, Tab
	}
	Else
	{
		Send {Tab Down}
		KeyWait, Tab
		Send {Tab Up}
	}
	Return
}

$z::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait z, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {z down}
			Sleep 32
			SendInput {z up}
			KeyWait, z
		}
		else
		{
			SendInput {b down}
			Sleep 32
			SendInput {b up}
			KeyWait, z
		}
		Return
	}
	Else
	{
		Send {z Down}
		KeyWait, z
		Send {z Up}
		Return
	}
	Return
}

$x::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait x, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{ ; Pavillong
			SendInput {n down}
			Sleep 32
			SendInput {n up}
			KeyWait, x
		}
		Else ; Noble Demeure
		{
			SendInput {x down}
			Sleep 32
			SendInput {x up}
			KeyWait, x
		}
		Return
	}
	Else
	{
		Send {x Down}
		KeyWait, x
		Send {x Up}
		Return
	}
	Return
}

$c::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{ ; Entrepôt
		Send, {c Down}
		Sleep 32
		Send, {c Up}
		KeyWait, c
		Return
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{ ; Nourriture
		PixelGetColor, color, 1889, 95
		If color = 0x20396f ;0x20396F 
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			MouseClick, left, 1732, 208
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
			KeyWait, c
		}
		Else
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			SetKeyDelay 32, 32
			Send {NumpadEnter}
			MouseClick, left, 1732, 208
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
			KeyWait, c
		}
		Return
	}
	Else
	{
		Send {c Down}
		KeyWait, c
		Send {c Up}
		Return
	}
	Return
}

$v::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{ ; Ferme
		Send, {v Down}
		Sleep 32
		Send, {v Up}
		KeyWait, v
		Return
	}	
	Else If (Layer=2) and WinActive(Settlers 7 Window)
	{ ; Géologue
		PixelGetColor, color, 1889, 95
		if color = 0x20396f ;0x20396F 
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			MouseClick, left, 1732, 242
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
			KeyWait, v
		}
		Else
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			SetKeyDelay 32, 32
			Send {NumpadEnter}
			MouseClick, left, 1732, 242
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
			KeyWait, v
		}
		Return
	}
	Else
	{
		Send {v Down}
		KeyWait, v
		Send {v Up}
		Return
	}
	Return
}

$f::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel ; Eglise
		{
			SendInput {g down}
			Sleep 32
			SendInput {g up}
			KeyWait, f
		}
		Else ; Caserne
		{
			SendInput {f down}
			Sleep 32
			SendInput {f up}
			KeyWait, f
		}
		Return
	}
	If (Layer=2) and WinActive(Settlers 7 Window)
	{ ; Guilde des commerçants
		SendInput {h down}
		Sleep 32
		SendInput {h up}
		KeyWait, f
		Return
	}
	Else
	{
		Send {f Down}
		KeyWait, f
		Send {f Up}
		Return
	}
}

$r::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel ; Baraque de chantier
		{
			SendInput {t down}
			Sleep 32
			SendInput {t up}
			KeyWait, r
		}
		Else ; Demeure
		{
			SendInput {y down}
			Sleep 32
			SendInput {y up}
			KeyWait, r
		}
		Return
	}
	Else
	{
		Send {r Down}
		KeyWait, r
		Send {r Up}
		Return
	}
}

#IfWinActive Settlers 7 Window
	
LAlt:: ; Art de la guerre
{
	PixelGetColor, color, 1889, 95
	if color = 0x20396f ;0x20396F 
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		MouseClick, left, 1732, 135
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait LAlt
	}
	else
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		SetKeyDelay 32, 32
		Send, {PGUP Down}
		MouseClick, left, 1732, 135
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait LAlt
	}
	Return
}

F13:: ; Lieux de travail
{
	PixelGetColor, color, 1889, 95
	if color = 0x20396f ;0x20396F
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		MouseClick, left, 1732, 171
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait F13
	}
	Else
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		SetKeyDelay 32, 32
		Send {NumpadEnter}
		MouseClick, left, 1732, 171
		MouseMove, xpos, ypos
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait F13
	}
	Return
}

F14:: ; Construction
{	
	PixelGetColor, color, 1889, 95
	if color = 0x20396f ;0x20396F 
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		MouseClick, left, 1732, 279
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait F14
	}
	Else
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		SetKeyDelay 32, 32
		Send {NumpadEnter}
		MouseClick, left, 1732, 279
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait F14
	}
	Return
}

F15:: ; Géologue
{
	PixelGetColor, color, 1889, 95
	if color = 0x20396f ;0x20396F 
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		MouseClick, left, 1732, 242
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait, F15
	}
	else
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		SetKeyDelay 32, 32
		Send {NumpadEnter}
		MouseClick, left, 1732, 242
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait, F15
	}
	Return
}

#IfWinActive