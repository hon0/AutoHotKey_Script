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
	
	/* ; Lock mouse to Window. LControl+LAlt+A. LControl+LAlt+S.
		{ ; Lock mouse to Window. LControl+LAlt+A. LControl+LAlt+S.
			^!a::
			LockMouseToWindow("Settlers 7 Window")
			Return
			
			^!s::
			LockMouseToWindow()
			Return
			
			
			LockMouseToWindow(llwindowname="")
			{
				VarSetCapacity(llrectA, 16)
				WinGetPos, llX, llY, llWidth, llHeight, %llwindowname%
				If (!llWidth AND !llHeight) {
					DllCall("ClipCursor")
					Return, False
				}
				Loop, 4 { 
					DllCall("RtlFillMemory", UInt,&llrectA+0+A_Index-1, UInt,1, UChar,llX >> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+4+A_Index-1, UInt,1, UChar,llY >> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+8+A_Index-1, UInt,1, UChar,(llWidth + llX)>> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+12+A_Index-1, UInt,1, UChar,(llHeight + llY) >> 8*A_Index-8) 
				} 
				DllCall("ClipCursor", "UInt", &llrectA)
				Return, True
			}
		}
	*/
	
	{ ; FullScreen Window.	
		^!f::
		WinGetTitle, currentWindow, A
		IfWinExist %currentWindow%
		{
			WinSet, Style, ^0xC00000 ; toggle title bar
			WinMove, , , 0, 0, 1920, 1080
		}
		return
	}
} ; End of AutoHotKey Script option.

/* ; Get exit cross cOlo
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

{ ; Layer modifier
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
		else
		{
			SetKeyDelay 10, 32
			Send, ^'
			KeyWait, XButton2
		}
		Return
	}
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
		Send {PgUp}
		Return
	}
	Else
	{
		Send {WheelUp}
		Return
	}
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
		Send {PgDn}
		Return
	}
	Else
	{
		Send {WheelDown}
		Return
	}
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
		Send {" Down}
		KeyWait, e
		Send {" Up}
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{
		Send {" Down}
		KeyWait, e
		Send {" Up}
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
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		Send {é Down}
		KeyWait, w
		Send {é Up}
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
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

$y::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait y, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {t down}
			Sleep 32
			SendInput {t up}
			ControlSend, Edit3, ^a21, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, y
		}
		else
		{
			SendInput {y down}
			sleep 32
			SendInput {y up}
			ControlSend, Edit3, ^a17, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, y
		}
		Return
	}
	Else
	{
		Send {y Down}
		KeyWait, y
		Send {y Up}
		Return
	}
}

$z::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait z, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {b down}
			Sleep 32
			SendInput {b up}
			ControlSend, Edit3, ^a19, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, z
		}
		else
		{
			SendInput {z down}
			sleep 32
			SendInput {z up}
			ControlSend, Edit3, ^a22, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, z
		}
		return
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{
		PixelGetColor, color, 1889, 95
		if color = 0x20396f ;0x20396F 
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			MouseClick, left, 1732, 208
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
		}
		else
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
}

$x::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		KeyWait x, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {n down}
			Sleep 32
			SendInput {n up}
			ControlSend, Edit3, ^a18, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, x
		}
		else
		{
			SendInput {x down}
			sleep 32
			SendInput {x up}
			ControlSend, Edit3, ^a17, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			KeyWait, x
		}
		Return
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
	{
		PixelGetColor, color, 1889, 95
		if color = 0x20396f ;0x20396F 
		{
			MouseGetPos, xpos, ypos 
			BlockInput, On
			Send, {PGUP Down}
			MouseClick, left, 1732, 208
			MouseMove, xpos, ypos 
			Send, {PGUP Up}
			BlockInput, Off
		}
		else
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
}

$c::
{
	If (Layer=1) and WinActive(Settlers 7 Window)
	{
		Send, {c Down}
		Sleep 32
		Send, {c Up}
		ControlSend, Edit3, ^a19, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
		ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
		KeyWait, c
		return
	}
	Else if (Layer=2) and WinActive(Settlers 7 Window)
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
			return
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
	If WinActive(Settlers 7 Window)
	{
		Send, {v Down}
		Sleep 32
		Send, {v Up}
		ControlSend, Edit3, ^a18, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
		ControlSend, Edit3, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
		KeyWait, v
		return
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
	If (Layer=2) and WinActive(Settlers 7 Window)
	{
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {h down}
			KeyWait f
			SendInput {h up}
		}
		else
		{
			SendInput {g down}
			sleep 32
			SendInput {g up}
		}
		return
	}
	Else if (Layer=3) and WinActive(Settlers 7 Window)
	{
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {k down}
			KeyWait f
			SendInput {k up}
		}
		else
		{
			SendInput {j down}
			sleep 32
			SendInput {j up}
		}
		return
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
	If (Layer=2) and WinActive(Settlers 7 Window)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {y down}
			KeyWait r
			SendInput {y up}
		}
		else
		{
			SendInput {t down}
			sleep 32
			SendInput {t up}
		}
		return
	}
	Else if (Layer=3) and WinActive(Settlers 7 Window)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {i down}
			KeyWait r
			SendInput {i up}
		}
		else
		{
			SendInput {u down}
			sleep 32
			SendInput {u up}
		}
		return
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

LAlt::
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
		Return
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
		Return
	}
}

Numpad1::
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
		KeyWait Numpad1
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
		KeyWait Numpad1
	}
	Return
}

Numpad2::
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
		KeyWait Numpad2
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
		KeyWait Numpad2
	}
	Return
}

Numpad3::
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
		KeyWait Numpad3
		return
	}
	else
	{
		MouseGetPos, xpos, ypos 
		BlockInput, On
		Send, {PGUP Down}
		SetKeyDelay 32, 32
		Send {NumpadEnter}
		MouseClick, left, 1732, 135
		MouseMove, xpos, ypos 
		Send, {PGUP Up}
		BlockInput, Off
		KeyWait Numpad3
	}
	Return
}

#IfWinActive