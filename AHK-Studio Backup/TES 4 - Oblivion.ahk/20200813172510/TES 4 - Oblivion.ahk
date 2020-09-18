#SingleInstance force
#Persistent
{
	Layer := 1
	CapsLock_pressed := 0
	
	SC029_pressed := 0
	Tab_pressed := 0
	
	SC002_pressed := 0
	SC003_pressed := 0
	SC004_pressed := 0
	SC005_pressed := 0
	
	F24_pressed := 0
	F23_pressed := 0
	
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
	
	LAlt_pressed := 0
	Left_pressed := 0
	Right_pressed := 0
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
		
		Run, D:\Dropbox\EventTester.exe
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
	#F2::Suspend, Toggle
	#F4::ExitApp
	;#SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
	*F14::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
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
	F19:: ; Run, C:\Windows\System32\mmsys.cpl ; Run, C:\Users\vieil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Equalizer APO 1.2.1\Configuration Editor
	{
		KeyWait F19, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Run, C:\Windows\System32\mmsys.cpl
			KeyWait, F19
		}
		Else
		{
			Run, C:\Users\vieil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Equalizer APO 1.2.1\Configuration Editor
			KeyWait, F19
		}
		Return
	}
} ; AutoHotKey Script option.

{ ; Joystick ID (Use JoyID Program)
	;Joy = Vjoy1
	;2Joy = Vjoy2
	
	/*
		1Joy1::a
		2Joy2::b
	*/
	
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

{ ; Layer modifier. Press and hold to get into Layer 2. Release to come back to Layer 1.
	*$CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
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
	*WheelUp::
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
			SendInput {WheelUp}
			Return
		}
		Return
	}
	
	*WheelDown::
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
			SendInput {WheelDown}
			Return
		}
		Return
	}
	
	*$F24::
	{
		If (F24_pressed)
			Return
		F24_pressed := 1
		If WinActive("Discord")
		{
			KeyWait F24, t0.100
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SetKeyDelay 10, 32
				Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
			}
		}
		Else if (Layer=2)
		{
			SetkeyDelay, 0, 100
			Send {F9}
			Return
		}
		Else
		{
			Send {Blind}{XButton2 Down}
		}
		Return
	}
	
	*$F24 Up::
	{
		F24_pressed := 0
		If !WinActive("Discord")
		{
			SendInput {Blind}{XButton2 Up}
		}
		Return
	}
	
	*$F23::
	{
		If (F23_pressed)
			Return
		F23_pressed := 1
		If WinActive("Discord")
		{
			KeyWait F23, t0.100
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SetKeyDelay 10, 32
				Send, {LShift Down}{LAlt Down}{Down}{LShift Up}{LAlt Up}
			}
		}
		Else if (Layer=2)
		{
			SetkeyDelay, 0, 100
			Send {F5}
			Return
		}
		Else
		{
			Send {Blind}{XButton1 Down}
		}
		Return
	}
	
	*$F23 Up::
	{
		F23_pressed := 0
		If !WinActive("Discord")
		{
			SendInput {Blind}{XButton1 Up}
		}
		Return
	}
	
	*$F13::
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
			SendInput {Blind}{F13 Down}
		}
		Return
	}
	
	*$F13 Up::
	{
		F13_pressed := 0
		SendInput {Blind}{F13 Up}
		Return
	}
}

{ ; Keypad and/or Keyboard.
	*$SC029::
	{
		If (SC029_pressed)
			Return
		SC029_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{SC029 Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{esc Down}
		}
		Return
	}
	
	*$SC029 Up::
	{
		SC029_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("esc"))
			{
				SendInput {Blind}{esc Up}
			}
			Else
				SendInput {Blind}{SC029 Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("SC029"))
			{
				SendInput {Blind}{SC029 Up}
			}
			Else
				SendInput {Blind}{esc Up}
		}
		Return
	}
	
	*$Tab::
	{
		If (Tab_pressed)
			Return
		Tab_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{Tab Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{esc Down}
		}
		Return
	}
	
	*$Tab Up::
	{
		Tab_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("esc"))
			{
				SendInput {Blind}{esc Up}
			}
			Else
				SendInput {Blind}{Tab Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("Tab"))
			{
				SendInput {Blind}{Tab Up}
			}
			Else
				SendInput {Blind}{esc Up}
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
	
	*$r::
	{
		If (r_pressed)
			Return
		r_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{r Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{t Down}
		}
		Return
	}
	
	*$r Up::
	{
		r_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("t"))
			{
				SendInput {Blind}{t Up}
			}
			Else
				SendInput {Blind}{r Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("r"))
			{
				SendInput {Blind}{r Up}
			}
			Else
				SendInput {Blind}{t Up}
		}
		Return
	}
	
	*$f::
	{
		If (f_pressed)
			Return
		f_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{f Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{g Down}
		}
		Return
	}
	
	*$f Up::
	{
		f_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("g"))
			{
				SendInput {Blind}{g Up}
			}
			Else
				SendInput {Blind}{f Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("f"))
			{
				SendInput {Blind}{f Up}
			}
			Else
				SendInput {Blind}{g Up}
		}
		Return
	}
	
	*$w::
	{
		If (w_pressed)
			Return
		w_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{w Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{b Down}
		}
		Return
	}
	
	*$w Up::
	{
		w_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("b"))
			{
				SendInput {Blind}{b Up}
			}
			Else
				SendInput {Blind}{w Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("w"))
			{
				SendInput {Blind}{w Up}
			}
			Else
				SendInput {Blind}{b Up}
		}
		Return
	}
	
	*$x::
	{
		If (x_pressed)
			Return
		x_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{x Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{n Down}
		}
		Return
	}
	
	*$x Up::
	{
		x_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("n"))
			{
				SendInput {Blind}{n Up}
			}
			Else
				SendInput {Blind}{x Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("x"))
			{
				SendInput {Blind}{x Up}
			}
			Else
				SendInput {Blind}{n Up}
		}
		Return
	}
	
	*$c::
	{
		If (c_pressed)
			Return
		c_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{c Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{, Down}
		}
		Return
	}
	
	*$c Up::
	{
		c_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState(","))
			{
				SendInput {Blind}{, Up}
			}
			Else
				SendInput {Blind}{c Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("c"))
			{
				SendInput {Blind}{c Up}
			}
			Else
				SendInput {Blind}{, Up}
		}
		Return
	}
	
	*$v::
	{
		If (v_pressed)
			Return
		v_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{v Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{; Down}
		}
		Return
	}
	
	*$v Up::
	{
		v_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState(";"))
			{
				SendInput {Blind}{; Up}
			}
			Else
				SendInput {Blind}{v Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("v"))
			{
				SendInput {Blind}{v Up}
			}
			Else
				SendInput {Blind}{; Up}
		}
		Return
	}
} ; Keypad and/or Keyboard.

#IfWinActive ahk_class Oblivion
{ ; Mouse
	*WheelUp::
	{
		If (Layer=1) and GetKeyState("MButton")
		{
			SetkeyDelay, 0, 32
			Send {Blind}{Home}
			Return
		}
		Else if (Layer=2)
		{
			SetkeyDelay, 0, 32
			Send {Blind}{PgUp}
			Sleep 200
			Return
		}
		Else
		{
			Send {Blind}{SC008}
			Sleep 200
			Return
		}
		Return
	}
	
	*WheelDown::
	{
		If (Layer=1) and GetKeyState("MButton")
		{
			SetkeyDelay, 0, 32
			Send {Blind}{End}
			Return
		}
		Else if (Layer=2)
		{
			SetkeyDelay, 0, 32
			Send {Blind}{PgDn}
			Sleep 200
			Return
		}
		Else
		{
			Send {Blind}{SC009}
			Sleep 200
			Return
		}
		Return
	}
	
	*$F24::
	{
		If (F24_pressed)
			Return
		F24_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{XButton2 Down}
			return
		}
		If (Layer=2)
			KeyWait F24, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel and (Layer=2)
		{
			Send {Blind}{F9}
		}
		Else
		{
			Send {Blind}{Insert}
			return
		}
		return
	}
	
	*$F24 Up::
	{
		F24_pressed := 0
			SendInput {Blind}{XButton2 Up}
		Return
	}
	
	*$F23::
	{
		If (F23_pressed)
			Return
		F23_pressed := 1
		KeyWait F23, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{F7}
				return
			}
			If (Layer=2)
			{
				SetkeyDelay, 0, 100				
				Send {Blind}{F5}
				return
			}
		}	
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{XButton1}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{Delete}
				return
			}
		}
		return
	}
	
	*$F23 Up::
	{
		F23_pressed := 0
		Return
	}
	
	*$F13::
	{
		If (F13_pressed)
			Return
		F13_pressed := 1
		KeyWait F13, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{SC01A}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{j}
				return
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC00C}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{h}
				return
			}
		}
		return
	}
	
	*$F13 Up::
	{
		F13_pressed := 0
		Return
	}
	
	*$F14::
	{
		If (F14_pressed)
			Return
		F14_pressed := 1
		KeyWait F14, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{SC01B}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{l}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC00D}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{k}
				return
			}
		}
		return
	}
	
	*$F14 Up::
	{
		F14_pressed := 0
		Return
	}	
} ; Mouse

{ ; Keypad and/or Keyboard.	
	*$SC029::
	{
		If (SC029_pressed)
			Return
		SC029_pressed := 1
		KeyWait SC029, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Backspace}
				return
			}
			If (Layer=2)
			{
				BlockInput, On
				Send {SC029}
				BlockInput, Off
				return
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{esc}
				return
			}
			If (Layer=2)
			{
				BlockInput, On
				Send {SC029}{t}{d}{t}{Enter}{SC029}
				BlockInput, Off
				return
			}
		}
		return
	}
	
	*$SC029 Up::
	{
		SC029_pressed := 0
		Return
	}
	
	*$Tab::
	{
		If (Tab_pressed)
			Return
		Tab_pressed := 1
		KeyWait Tab, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{SC035}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{p}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{Tab}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{p}
				return
			}
		}
		return
	}
	
	*$Tab Up::
	{
		Tab_pressed := 0
		Return
	}
	
	*$SC002::
	{
		If (SC002_pressed)
			Return
		SC002_pressed := 1
		KeyWait SC002, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad1}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{F3}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC002}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{Numpad6}
				return
			}
		}
		return
	}
	
	*$SC002 Up::
	{
		SC002_pressed := 0
		Return
	}
	
	*$SC003::
	{
		If (SC003_pressed)
			Return
		SC003_pressed := 1
		KeyWait SC003, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad2}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{F3}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC003}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{Numpad7}
				return
			}
		}
		return
	}
	
	*$SC003 Up::
	{
		SC003_pressed := 0
		Return
	}
	
	*$SC004::
	{
		If (SC004_pressed)
			Return
		SC004_pressed := 1
		KeyWait SC004, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad3}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{i}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC004}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{i}
				return
			}
		}
		return
	}
	
	*$SC004 Up::
	{
		SC004_pressed := 0
		Return
	}
	
	*$SC005::
	{
		If (SC005_pressed)
			Return
		SC005_pressed := 1
		KeyWait SC005, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad4}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{NumpadSub}
				return
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{SC005}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{NumpadSub}
				return
			}
		}
		return
	}
	
	*$SC005 Up::
	{
		SC005_pressed := 0
		Return
	}
	
	*$a::
	{
		If (a_pressed)
			Return
		a_pressed := 1
		KeyWait a, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad5}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{y}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{a}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{y}
				return
			}
		}
		return
	}
	
	*$a Up::
	{
		a_pressed := 0
		Return
	}
	
	*$e::
	{
		If (e_pressed)
			Return
		e_pressed := 1
		KeyWait e, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad6}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{u}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{e}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{u}
				return
			}
		}
		return
	}
	
	*$e Up::
	{
		e_pressed := 0
		Return
	}
	
	*$r::
	{
		If (r_pressed)
			Return
		r_pressed := 1
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad7}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{NumpadAdd}
				return
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{r}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{NumpadAdd}
				return
			}
		}
		return
	}
	
	*$r Up::
	{
		r_pressed := 0
		Return
	}
	
	*$f::
	{
		If (f_pressed)
			Return
		f_pressed := 1
		KeyWait f, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad8}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{NumpadEnter}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{f}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{g}
				return
			}
		}
		return
	}
	
	*$f Up::
	{
		f_pressed := 0
		Return
	}
	
	*$w::
	{
		If (w_pressed)
			Return
		w_pressed := 1
		If (Layer=1)
		{
			Send {Blind}{w Down}
			return
		}
		If (Layer=2)
			KeyWait w, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel and (Layer=2)
		{
			Send {Blind}{F3}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{w Down}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{b}
				return
			}
		}
		return
	}
	
	*$w Up::
	{
		w_pressed := 0
		If (Layer=1)
		{
			SendInput {Blind}{w Up}
		}
		Return
	}
	
	*$x::
	{
		If (x_pressed)
			Return
		x_pressed := 1
		KeyWait x, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad9}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{F3}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{x}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{n}
				return
			}
		}
		return
	}
	
	*$x Up::
	{
		x_pressed := 0
		Return
	}
	
	*$c::
	{
		If (c_pressed)
			Return
		c_pressed := 1
		KeyWait c, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{Numpad0}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{F3}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{c}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{,}
				return
			}
		}
		return
	}
	
	*$c Up::
	{
		c_pressed := 0
		Return
	}
	
	*$v::
	{
		If (v_pressed)
			Return
		v_pressed := 1
		KeyWait v, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			If (Layer=1)
			{
				Send {Blind}{NumpadDot}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{F3}
			}
		}
		Else
		{
			If (Layer=1)
			{
				Send {Blind}{v}
				return
			}
			If (Layer=2)
			{
				Send {Blind}{SC033}
				return
			}
		}
		return
	}
	
	*$v Up::
	{
		v_pressed := 0
		Return
	}
	
	*$Insert::
	{
		If (Layer=1)
		{
			Send {Blind}{SC006}
			Sleep 64
			Return
		}
		If (Layer=2)
		{
			Send {Blind}{SC00A}
			Sleep 64
			Return
		}
		Return
	}
	
	*$Delete::
	{
		If (Layer=1)
		{
			Send {Blind}{SC007}
			Sleep 64
			Return
		}
		If (Layer=2)
		{
			Send {Blind}{SC00B}
			Sleep 64
			Return
		}
		Return
	}	
	
	*$Left::
	{
		If (Left_pressed)
			Return
		Left_pressed := 1
		KeyWait Left, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Send {Blind}{Home}
			return
		}
		Else
		{
			Send {Blind}{Left}
			return
		}
		return
	}
	
	*$Left Up::
	{
		Left_pressed := 0
		Return
	}
	
	*$Right::
	{
		If (Right_pressed)
			Return
		Right_pressed := 1
		KeyWait Right, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Send {Blind}{End}
			return
		}
		Else
		{
			Send {Blind}{Right}
			return
		}
		return
	}
	
	*$Right Up::
	{
		Right_pressed := 0
		Return
	}
	
	/* ; AutoChangeNightEye.ini
		F18::
		{
			BlockInput, On
			SetkeyDelay, 0, 32
			Send {SC029}
			Sleep 32
			SetkeyDelay, 0, 5
			Send setnighteyeshader{space}13{Enter}{SC029}
			BlockInput, Off
			return
		}
	*/
} ; Keypad and/or Keyboard.
#IfWinActive