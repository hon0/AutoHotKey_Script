#SingleInstance force
#Persistent
{
	Layer := 1
	CapsLock_pressed := 0
	
	SC029_pressed := 0
	Tab_pressed := 0
	
	XButton2_pressed := 0
	XButton1_pressed := 0
	
	F13_pressed := 0
	F14_pressed := 0
	
	a_pressed := 0
	e_pressed := 0
	
	r_pressed := 0
	f_pressed := 0
	
	w_pressed := 0
	x_pressed := 0
	c_pressed := 0
	v_pressed := 0
}
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000
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
	#F1::Suspend, Toggle
	#F4::ExitApp
	;#SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
	F14::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
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

{ ; Layer modifier. Press and hold to get into Layer 2. Release to come back to Layer 1.
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
}

{ ; Mouse
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
			Send {F1}
			Sleep 100
			Return
		}
		Else if (Layer=1) and GetKeyState("RButton")
		{
			SetkeyDelay, 0, 32
			Send {v}
			Sleep 100
			Return
		}
		Else
		{
			SendInput {WheelUp}
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
			Send {F2}
			Sleep 100
			Return
		}
		Else if (Layer=1) and GetKeyState("RButton")
		{
			SetkeyDelay, 0, 32
			Send {v}
			Sleep 100
			Return
		}
		Else
		{
			SendInput {WheelDown}
			Return
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
		Else If (Layer=2)
		{
			SendInput {F3 Down}
		}
		Else
		{
			SendInput {XButton2 Down}
		}
		Return
	}
	
	$XButton2 Up::
	{
		If (Layer=2)
		{
			XButton2_pressed := 0
			SendInput {F3 Up}
			Return
		}
		Else
		{
			XButton2_pressed := 0
			SendInput {XButton2 Up}
			Return
		}
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
		Else If (Layer=2)
		{
			SendInput {F4 Down}
		}
		Else
		{
			SendInput {XButton1 Down}
		}
		Return
	}
	
	$XButton1 Up::
	{
		If (Layer=2)
		{
			XButton1_pressed := 0
			SendInput {F4 Up}
			Return
		}
		Else
		{
			XButton1_pressed := 0
			SendInput {XButton1 Up}
			Return
		}
	}
	
	$F13::
	{
		If (F13_pressed)
			Return
		F13_pressed := 1
		If WinActive("Discord")
		{
			KeyWait F13, t0.200
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
			SendInput {v Down}
		}
		Return
	}
	
	$F13 Up::
	{
		F13_pressed := 0
		SendInput {v Up}
		Return
	}
	
	$F14::
	{
		If (F14_pressed)
			Return
		F14_pressed := 1
		{
			Send {XButton1}
		}
		Return
	}
	
	$F14 Up::
	{
		F14_pressed := 0
		SendInput {XButton1 Up}
		Return
	}
} ; Mouse

{ ; Keypad and/or Keyboard.
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
			If (GetKeyState("SC029SC029"))
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
	
	$*a::
	{
		If (a_pressed)
			Return
		a_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{a Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{SC006 Down}
		}
		Return
	}
	
	$*a Up::
	{
		a_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("SC006"))
			{
				SendInput {Blind}{SC006 Up}
			}
			Else
				SendInput {Blind}{a Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("a"))
			{
				SendInput {Blind}{a Up}
			}
			Else
				SendInput {Blind}{SC006 Up}
		}
		Return
	}
	
	$*e::
	{
		If (e_pressed)
			Return
		e_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{e Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{SC007 Down}
		}
		Return
	}
	
	$*e Up::
	{
		e_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("SC007"))
			{
				SendInput {Blind}{SC007 Up}
			}
			Else
				SendInput {Blind}{e Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("e"))
			{
				SendInput {Blind}{e Up}
			}
			Else
				SendInput {Blind}{SC007 Up}
		}
		Return
	}
	
	$r::
	{
		If (r_pressed)
			Return
		r_pressed := 1
		If (Layer=1)
		{
			SendInput {r Down}
		}
		If (Layer=2)
		{
			SendInput {t Down}
		}
		Return
	}
	
	$r Up::
	{
		r_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("t"))
			{
				SendInput {t Up}
			}
			Else
				SendInput {r Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("r"))
			{
				SendInput {r Up}
			}
			Else
				SendInput {t Up}
		}
		Return
	}
	
	$f::
	{
		If (f_pressed)
			Return
		f_pressed := 1
		If (Layer=1)
		{
			SendInput {f Down}
		}
		If (Layer=2)
		{
			SendInput {g Down}
		}
		Return
	}
	
	$f Up::
	{
		f_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("g"))
			{
				SendInput {g Up}
			}
			Else
				SendInput {f Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("f"))
			{
				SendInput {f Up}
			}
			Else
				SendInput {g Up}
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
	
	$*Insert::
	{
		If (Layer=1)
		{
			Send {Insert}
			Sleep 32
			Return
		}
		If (Layer=2)
		{
			Send {Numpad1}
			Sleep 32
			Return
		}
	}
	
	$*Delete::
	{
		If (Layer=1)
		{
			Send {Delete}
			Sleep 32
			Return
		}
		If (Layer=2)
		{
			Send {Numpad3}
			Sleep 32
			Return
		}
	}
} ; Keypad and/or Keyboard.