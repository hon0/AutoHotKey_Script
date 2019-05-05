#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#include Lib\AutoHotInterception.ahk
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyModifierTimeout -1
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
;#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

;Razer Orbweaver
AHI := new AutoHotInterception()
id3 := AHI.GetKeyboardId(0x1532, 0x0113, 1)
cm3 := AHI.CreateContextManager(id3)

;Trust Numpad
AHI := new AutoHotInterception()
id6 := AHI.GetKeyboardId(0x05A4, 0x9862, 1)
cm6 := AHI.CreateContextManager(id6)

{ ; Monitoring Windows
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
	{
		WinClose Event Tester
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
		WinWait, Event Tester
		SetKeyDelay 0, 32
		Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
		Sleep 32
		MouseClick, left, 1952, 66
		MouseClick, left, 2016, 91
		BlockInput, Off	
		return
	}
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

{ ; Joystick ID (Use JoyID Program)
	;4Joy = T16000L (See JoyID)
	;Joy = Vjoy
}

{ ; Testing
	
	/* ; If prior key ""
		$m::
		If (A_PriorKey = "space")
		{
			SendInput {p Down}
			KeyWait m
			Send {p Up}
		}
		Else
		{
			Send {m Down}
			KeyWait m
			Send {m Up}
		}
		return
		
	*/
	
	/* ; Pixel color as as condition
		{
			!#z::
			MouseGetPos, xpos, ypos 	
		;PixelGetColor, color, xpos, xpos
			PixelGetColor, color, 1889, 95
		;MsgBox The color at X%xpos% Y%ypos% is %color%.
			MsgBox The color is %color%.
			return
			
			{ ; Numpad1
				Numpad1::
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
	
	/* ; On press != on double press != on long press.
		$a::
		KeyWait, a, T0.1
		If (ErrorLevel)
		{
			Send {b down}
			KeyWait a
			Send {b up}
		}
		Else 
		{
			KeyWait, a, D T0.1
			If (ErrorLevel)
			{
				Send {a down}
				KeyWait a
				Send {a up}
			}
			Else
			{
				Send {c down}
				KeyWait a
				Send {c up}
			}
		}
		KeyWait, a
		Return
	*/
	
	/* ; Multi-Tap
		
		{ 
			$f1::
			{
				count++
				settimer, actions, 333
			}
			return
			
			actions:
			{
				if (count = 1)
				{
					send {F1}
				}
				else if (count = 2)
				{
					send {F2}
				}
				else if (count = 3)
				{
					send {F3}
				}
				count := 0
			}
			return
		}
	*/
	
	/* ; Watch axis
		
		SetTimer, WatchAxis, 5
		return
		
		WatchAxis:
		GetKeyState, 6JoyX, 6JoyX  ; Get position of X axis.
		GetKeyState, 6JoyY, 6JoyY  ; Get position of Y axis.
		KeyToHoldDownPrev = %KeyToHoldDown%  ; Prev now holds the key that was down before (if any).
		
		if 6JoyX > 70
			KeyToHoldDown = Right
		else if 6JoyX < 30
			KeyToHoldDown = Left
		else if 6JoyY > 70
			KeyToHoldDown = Down
		else if 6JoyY < 30
			KeyToHoldDown = Up
		else
			KeyToHoldDown =
		
		if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
			return  ; Do nothing.
		
	; Otherwise, release the previous key and press down the new key:
		SetKeyDelay -1  ; Avoid delays between keystrokes.
		if KeyToHoldDownPrev   ; There is a previous key to release.
			Send, {%KeyToHoldDownPrev% up}  ; Release it.
		if KeyToHoldDown   ; There is a key to press down.
			Send, {%KeyToHoldDown% down}  ; Press it down.
		return
	*/	
	
	/* ; Joystick layer, shift
		
		6Joy1::
		If GetKeyState("6Joy2", "P")=1
		{
			send {d Down}
			keywait 6Joy1
			send, {d Up}
		}
		else 
			if GetKeyState("6joy3", "p")=1
			{
				send {v Down}
				keywait 6Joy1
				send, {v Up}
			}
		Else 
		{
			send {c Down}
			keywait 6Joy1
			send, {c Up}
		}
		Return
	*/	
	
	/* ; Multi-Tap
		$f8::
		{
			count++
			settimer, actionsF8, 200
		}
		return
		
		actionsF8:
		{
			if (count = 1)
			{
				send {F8}
			}
			else if (count = 2)
			{
				send {F9}
			}
			else if (count = 3)
			{
				send {F10}
			}
			count := 0
		}
		return
		}
	*/	
	
}

{ ; Layer checker
	/*
		#z::
		ToolTip %Layer%
		SetTimer, RemoveToolTip, 2000
		return
		
		RemoveToolTip:
		SetTimer, RemoveToolTip, Off
		ToolTip
		return
	*/
}

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1.
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 333)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
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

$Tab::
{
	If (Layer=1)
	{
		Send {Tab Down}
		KeyWait, Tab
		Send {Tab Up}
	}
	Else If (Layer=2)
	{
		Send {esc Down}
		KeyWait, Tab
		Send {esc Up}
	}
	Else
	{
		Send {Tab Down}
		KeyWait, Tab
		Send {Tab Up}
	}
	Return
}

$w::
{
	If (Layer=1)
	{
		Send {w Down}
		KeyWait, w
		Send {w Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {b Down}
		KeyWait, w
		Send {b Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad1 Down}
		KeyWait, w
		Send {Numpad1 Up}
		Return
	}
}

$x::
{
	If (Layer=1)
	{
		Send {x Down}
		KeyWait, x
		Send {x Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {n Down}
		KeyWait, x
		Send {n Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad2 Down}
		KeyWait, x
		Send {Numpad2 Up}
		Return
	}
}

$c::
{
	If (Layer=1)
	{
		Send {c Down}
		KeyWait, c
		Send {c Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {, Down}
		KeyWait, c
		Send {, Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad3 Down}
		KeyWait, c
		Send {Numpad3 Up}
		Return
	}
}

$r::
{
	If (Layer=1)
	{
		Send {r Down}
		KeyWait, r
		Send {r Up}
		Return
	}
	Else If (Layer=2)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {y down}
			Sleep 32
			SendInput {y up}
			KeyWait, r
		}
		else
		{
			SendInput {t down}
			sleep 32
			SendInput {t up}
			KeyWait, r
		}
		return
	}
	Else if (Layer=3)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {i down}
			sleep 32
			SendInput {i up}
			KeyWait, r
		}
		else
		{
			SendInput {u down}
			sleep 32
			SendInput {u up}
			KeyWait, r			
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

$f::
{
	If (Layer=1)
	{
		Send {f Down}
		KeyWait, f
		Send {f Up}
		Return
	}
	Else If (Layer=2)
	{
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {h down}
			Sleep 32
			SendInput {h up}
			KeyWait, f
		}
		else
		{
			SendInput {g down}
			sleep 32
			SendInput {g up}
			KeyWait, f
		}
		Return
	}
	Else if (Layer=3)
	{
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {k down}
			sleep 32
			SendInput {k up}
			KeyWait, f
		}
		else
		{
			SendInput {j down}
			sleep 32
			SendInput {j up}
			KeyWait, f
		}
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

$v::
{
	If (Layer=1)
	{
		Send {v Down}
		KeyWait, v
		Send {v Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {; Down}
		KeyWait, v
		Send {; Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {! Down}
		KeyWait, v
		Send {! Up}
		Return
	}
}


#If cm6.IsActive

SetkeyDelay 0

Numpad0::
Send {RControl Down}{Numpad0 Down}
Return
Numpad0 Up::
Send {Numpad0 Up}{RControl Up}
Return

Numpad1::
Send {RControl Down}{Numpad1 Down}
Return
Numpad1 Up::
Send {Numpad1 Up}{RControl Up}
Return


Numpad2::
Send {RControl Down}{Numpad2 Down}
Return
Numpad2 Up::
Send {Numpad2 Up}{RControl Up}
Return


Numpad3::
Send {RControl Down}{Numpad3 Down}
Return
Numpad3 Up::
Send {Numpad3 Up}{RControl Up}
Return

Numpad4::
Send {RControl Down}{Numpad4 Down}
Return
Numpad4 Up::
Send {Numpad4 Up}{RControl Up}
Return


Numpad5::
Send {RControl Down}{Numpad5 Down}
Return
Numpad5 Up::
Send {Numpad5 Up}{RControl Up}
Return


Numpad6::
Send {RControl Down}{Numpad6 Down}
Return
Numpad6 Up::
Send {Numpad6 Up}{RControl Up}
Return

Numpad7::
Send {RControl Down}{Numpad7 Down}
Return
Numpad7 Up::
Send {Numpad7 Up}{RControl Up}
Return


Numpad8::
Send {RControl Down}{Numpad8 Down}
Return
Numpad8 Up::
Send {Numpad8 Up}{RControl Up}
Return

Numpad9::
Send {RControl Down}{Numpad9 Down}
Return
Numpad9 Up::
Send {Numpad9 Up}{RControl Up}
Return


NumpadDot::
Send {RControl Down}{NumpadDot Down}
Return
NumpadDot Up::
Send {NumpadDot Up}{RControl Up}
Return


Enter::
Send {RControl Down}{Enter Down}
Return
Enter Up::
Send {Enter Up}{RControl Up}
Return


NumpadAdd::
Send {RControl Down}{NumpadAdd Down}
Return
NumpadAdd Up::
Send {NumpadAdd Up}{RControl Up}
Return

NumpadSub::
Send {RControl Down}{NumpadSub Down}
Return
NumpadSub Up::
Send {NumpadSub Up}{RControl Up}
Return

Backspace::
Send {RControl Down}{Backspace Down}
Return
Backspace Up::
Send {Backspace Up}{RControl Up}
Return

NumpadMult::
Send {RControl Down}{NumpadMult Down}
Return
NumpadMult Up::
Send {NumpadMult Up}{RControl Up}
Return


NumpadDiv::
Send {RControl Down}{NumpadDiv Down}
Return
NumpadDiv Up::
Send {NumpadDiv Up}{RControl Up}
Return


#If