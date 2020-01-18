#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
CapsLock_pressed := 0

Tab_pressed := 0
SC029_pressed := 0

XButton2_pressed := 0
XButton1_pressed := 0

F13_pressed := 0

w_pressed := 0
x_pressed := 0
c_pressed := 0
v_pressed := 0

a_pressed := 0
e_pressed := 0

Toggle_LButton := 0
LAlt_pressed := 0

SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ; Monitoring Windows
	
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 10, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
	{
		WinClose Event Tester
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
		WinWait, Event Tester
		SetKeyDelay 10, 32
		Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
		Sleep 100
		MouseClick, left, 1950, 70
		MouseClick, left, 2016, 95
		BlockInput, Off	
		return
	}
	#IfWinExist
		
}

{ ; AutoHotKey Script option.
	#F3::Suspend, Toggle
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
	
	/*;Cycle
		{
			$&::
			key++
			if key = 1
				Send, {SC002}
			
			else if key = 2
				Send, {SC003}
			
			else if key = 3
				Send, {SC004}
			
			else if key = 4
			{
				Send, {SC005}
				key = 0              
			}
			return
		}
	*/
}

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1.
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	{
		If (CapsLock_pressed)
			Return
		CapsLock_pressed := 1
		Layer := 2
		Return
	}
	
	CapsLock Up::
	{
		CapsLock_pressed := 0
		Layer := 1
		Return
	}
	Return
}

#IfWinActive Sea of Thieves
	
*$LShift::
{
	If (LShift_pressed)
		Return
	LShift_pressed := 1
	SendInput {Blind}{LShift}
	Toggle_Walk := !Toggle_Walk
	Return
}

~*LShift Up::
{
	LShift_pressed := 0
	Return
}

LControl::
{
	If (LControl_pressed)
		Return
	LControl_pressed := 1
	If (Toggle_Walk = 0)
	{
		Send {LControl}
	}
	Else if (Toggle_Walk = 1)
	{
		Send {LShift}
		Sleep 32
		Send {LControl}
	}
	Return
}

~LControl Up::
{
	LControl_pressed := 0
	Return
}

~z::
{
	If (z_pressed)
		Return
	z_pressed := 1
	If (Toggle_Walk = 1) and (Moving = 0)
	{
		Sleep 64
		SendInput {LShift}
	}
	Moving := 1
	Return
}

~z Up::
{
	z_pressed := 0
	If (q_pressed = 0) and (s_pressed = 0) and (d_pressed = 0)
		Moving := 0
	Return
}

~s::
{
	If (s_pressed)
		Return
	s_pressed := 1
	If (Toggle_Walk = 1) and (Moving = 0)
	{
		Sleep 64
		SendInput {LShift}
	}
	Moving := 1
	Return
}

~s Up::
{
	s_pressed := 0
	If (z_pressed = 0) and (q_pressed = 0) and (d_pressed = 0)
		Moving := 0
	Return
}

~q::
{
	If (q_pressed)
		Return
	q_pressed := 1
	If (Toggle_Walk = 1) and (Moving = 0)
	{
		Sleep 64
		SendInput {LShift}
	}
	Moving := 1
	Return
}

~q Up::
{
	q_pressed := 0
	If (z_pressed = 0) and (s_pressed = 0) and (d_pressed = 0)
		Moving := 0
	Return
}

~d::
{
	If (d_pressed)
		Return
	d_pressed := 1
	If (Toggle_Walk = 1) and (Moving = 0)
	{
		Sleep 64
		SendInput {LShift}
	}
	Moving := 1
	Return
}

~d Up::
{
	d_pressed := 0
	If (z_pressed = 0) and (q_pressed = 0) and (s_pressed = 0)
		Moving := 0
	Return
}

#IfWinActive
	
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
	/*
		Else if (Layer=3)
		{
			SetkeyDelay, 0, 32
			Send {Right}
			Return
		}
	*/
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
		Send {PgDn}
		Return
	}
	/*
		Else if (Layer=3)
		{
			SetkeyDelay, 0, 32
			Send {Left}
			Return
		}
	*/
	Else
	{
		Send {WheelDown}
		Return
	}
	Return
}

LAlt::
{
	If (LAlt_pressed)
		Return
	LAlt_pressed := 1
	If Toggle_LButton = 0
	{
		Toggle_LButton := !Toggle_LButton
		SendInput {LButton Down}
	}
	Else If Toggle_LButton = 1
	{
		Toggle_LButton := !Toggle_LButton
	}
	Return
}

LAlt Up::
{
	LAlt_pressed := 0
	{
		SendInput {LAlt Up}
	}
	Return
}

Right:: ; Toggle time deceleration
{
	If Toggle_LAlt = 0
	{
		Toggle_LAlt := !Toggle_LAlt
		SendInput {NumpadSub Down}
		KeyWait Right
	}
	Else If Toggle_LAlt = 1
	{
		SendInput {NumpadSub Up}
		Toggle_LAlt := !Toggle_LAlt
		KeyWait Right
	}
	Return
}

$XButton2::
{
	If (XButton2_pressed)
		Return
	XButton2_pressed := 1
	If WinActive("Discord")
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
		}
	}
	Else
	{
		Send {XButton2 Down}
	}
	Return
}

$XButton2 Up::
{
	XButton2_pressed := 0
	If (GetKeyState("XButton2"))
	{
		SendInput {XButton2 Up}
	}
	Return
}

$XButton1::
{
	If (XButton1_pressed)
		Return
	XButton1_pressed := 1
	If WinActive("Discord")
	{
		KeyWait XButton1, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Down}{LShift Up}{LAlt Up}
		}
	}
	Else
	{
		Send {XButton1 Down}
	}
	Return
}

$XButton1 Up::
{
	XButton1_pressed := 0
	If (GetKeyState("XButton1"))
	{
		SendInput {XButton1 Up}
	}
	Return
}

$F13::
{
	If (F13_pressed)
		Return
	F13_pressed := 1
	If WinActive("Discord")
	{
		KeyWait F13, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {LControl Down}{LAlt Down}{Right}{LAlt Up}{LControl Up}
		}
		Else
		{
			SendInput {LControl Down}{k}{LControl Up}
			;Sleep 32		
			Send {Enter}
		}
	}
	Else
	{
		Send {F13 Down}
	}
	Return
}

$F13 Up::
{
	F13_pressed := 0
	If (GetKeyState("F13"))
	{
		SendInput {F13 Up}
	}
	Return
}

$SC029::
{
	If (SC029_pressed)
		Return
	SC029_pressed := 1
	If (Layer=1)
	{
		SendInput {esc Down}
	}
	If (Layer=2)
	{
		SendInput {SC029 Down}
	}
	Return
}

$SC029 Up::
{
	SC029_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("SC029"))
		{
			SendInput {SC029 Up}
		}
		Else
			SendInput {esc Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("esc"))
		{
			SendInput {esc Up}
		}
		Else
			SendInput {SC029 Up}
	}
	Return
}

$Tab::
{
	If (Tab_pressed)
		Return
	Tab_pressed := 1
	If (Layer=1)
	{
		SendInput {Tab Down}
	}
	If (Layer=2)
	{
		SendInput {esc Down}
	}
	Return
}

$Tab Up::
{
	Tab_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("esc"))
		{
			SendInput {esc Up}
		}
		Else
			SendInput {Tab Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("Tab"))
		{
			SendInput {Tab Up}
		}
		Else
			SendInput {esc Up}
	}
	Return
}

$w::
{
	If (w_pressed)
		Return
	w_pressed := 1
	If (Layer=1)
	{
		SendInput {w Down}
	}
	If (Layer=2)
	{
		SendInput {b Down}
	}
	Return
}

$w Up::
{
	w_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("b"))
		{
			SendInput {b Up}
		}
		Else
			SendInput {w Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("w"))
		{
			SendInput {w Up}
		}
		Else
			SendInput {b Up}
	}
	Return
}

$x::
{
	If (x_pressed)
		Return
	x_pressed := 1
	If (Layer=1)
	{
		SendInput {x Down}
	}
	If (Layer=2)
	{
		SendInput {n Down}
	}
	Return
}

$x Up::
{
	x_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("n"))
		{
			SendInput {n Up}
		}
		Else
			SendInput {x Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("x"))
		{
			SendInput {x Up}
		}
		Else
			SendInput {n Up}
	}
	Return
}

$c::
{
	If (c_pressed)
		Return
	c_pressed := 1
	If (Layer=1)
	{
		SendInput {c Down}
	}
	If (Layer=2)
	{
		SendInput {, Down}
	}
	Return
}

$c Up::
{
	c_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState(","))
		{
			SendInput {, Up}
		}
		Else
			SendInput {c Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("c"))
		{
			SendInput {c Up}
		}
		Else
			SendInput {, Up}
	}
	Return
}

$v::
{
	If (v_pressed)
		Return
	v_pressed := 1
	If (Layer=1)
	{
		SendInput {v Down}
	}
	If (Layer=2)
	{
		SendInput {; Down}
	}
	Return
}

$v Up::
{
	v_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState(";"))
		{
			SendInput {; Up}
		}
		Else
			SendInput {v Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("v"))
		{
			SendInput {v Up}
		}
		Else
			SendInput {; Up}
	}
	Return
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
		/*
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
		*/
		{
			SendInput {g down}
			;sleep 32
			KeyWait, f
			SendInput {g up}
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

$a::
{
	If (Layer=1)
	{
		Send {a Down}
		KeyWait, a
		Send {a Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {SC006 Down}
		KeyWait, a
		Send {SC006 Up}
		Return
	}
	Else If (Layer=3)
	{
		
	}
	Return
}

$e::
{
	If (Layer=1)
	{
		Send {e Down}
		KeyWait, e
		Send {e Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {SC007 Down}
		KeyWait, e
		Send {SC007 Up}
		Return
	}
	Else If (Layer=3)
	{
		
	}
	Return
}