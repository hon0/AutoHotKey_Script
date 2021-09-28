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
	F15_pressed := 0
	
	a_pressed := 0
	e_pressed := 0
	
	r_pressed := 0
	f_pressed := 0
	
	z_pressed := 0
	q_pressed := 0
	s_pressed := 0
	d_pressed := 0
	
	w_pressed := 0
	x_pressed := 0
	c_pressed := 0
	v_pressed := 0
	
	F1_pressed := 0
	
	LControl_pressed := 0
	LShift_pressed := 0
	LAlt_pressed := 0
	Space_pressed := 0
	Down_pressed := 0	
	Left_pressed := 0
	Right_pressed := 0
}
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
DetectHiddenWindows, on
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ; AutoHotKey Script option.
	#F2:: ; Monitoring Windows
	{
		CoordMode, mouse, Relative
		KeyWait F2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			KeyHistory
			KeyWait, F2
		}
		Else
		{
			IfWinNotExist, Event Tester
			{
				BlockInput, On
				Run, E:\Google Drive\HOTAS_Joysticks_USB_Software\EventTester.exe
				WinWait, Event Tester
				SetKeyDelay 10, 32
				Send {LWin Up}
				MouseClick, left, 39, 41
				Send {Down}{Enter}
				MouseClick, left, 86, 42
				WinMove, , , 3175, 648 , 432, 409, , 
				BlockInput, Off
				Send {LWin Up}
				return
			}
			else
			{
				BlockInput, On
				WinActivate, Event Tester
				Send {LWin Up}
				MouseClick, left, 39, 41
				Send {Down}{Enter}
				MouseClick, left, 86, 42
				WinMove, , , 3175, 648 , 432, 409, , 
				BlockInput, Off
				Send {LWin Up}
				return
			}
			CoordMode, mouse, Screen
			KeyWait, F2
		}
		return
	}
	#F3::Suspend, Toggle
	#F4::ExitApp
	#F5:: ; WinGetPos
	{
		WinGetTitle, Title, A
		WinGetPos, X, Y, Width, Height, %Title%
		MsgBox, %Title% is at %X%`,%Y%, its size is %Width%, %Height%.
		Return
	}
	#SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.
	*F14::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.
	^!f:: ; FullScreen Window. Windows+Alt+F
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
	
	F15::
	{	
		If WinActive("Tabs Outliner")
		{
			Send {F2}
			Send ^v
			Send {Enter}
		}
		Return
	}
	
	F20:: ; Ear Trumpet 
	{
		KeyWait, F20, t0.100
		if (ErrorLevel)
		{
			Send ^+!{F1}
			keywait F20
		}
		else {
			KeyWait, F20, D T0.1
			
			if (ErrorLevel)
			{
				Send ^+!{F2}
				keywait F20
			}
			
			else
			{
				Send ^+!{F3}
				keywait F20
			}
		}
		KeyWait, F20
		return
	}
	
	/*
		#IfWinActive ahk_exe chrome.exe
		{
			*e::
			{
				If (e_pressed)
					Return
				e_pressed := 1
				{
					If GetKeyState("LShift") && GetKeyState("LAlt")
					{
						Send {LShift Up}{LAlt Up}
						Send ^t
						Sleep 32
						SendInput https://app.raindrop.io/my/0
						Sleep 32
						Send {Enter}
						Return
					}
					Else
					{
						If (Layer=1)
						{
							SendInput {Blind}{e Down}
						}
						If (Layer=2)
						{
							SendInput {Blind}{SC007 Down}
						}
					}
					return
				}
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
			#If
		}
	*/
} ; AutoHotKey Script option.

{ ; Testing
	
	/* ; Hotbuild
		$f1::
		{
			If (F1_pressed)
				Return
			F1_pressed := 1
			{
				F1_count++
				settimer, F1_actions, 500
			}
			{
				if (F1_count = 1)
				{
					send {F1}
				}
				else if (F1_count = 2)
				{
					send {F2}
				}
				else if (F1_count = 3)
				{
					send {F3}
					F1_count := 0
				}
			}
			return
			
			F1_actions:
			{
				F1_count := 0
			}
			return
		}
		
		*$F1 Up::
		{
			F1_pressed := 0
			Return
		}
		
	*/
	
	/* ; If prior key ""
		{ ; If prior key ""
			m::
			Send o
			if (A_PriorKey = "space")
				SendInput {p}
			return
		}
		
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
		
		if (ErrorLevel)
		{
			Send {b down}
			keywait a
			Send {b up}
		}
		else {
			KeyWait, a, D T0.1
			
			if (ErrorLevel)
			{
				Send {a down}
				keywait a
				Send {a up}
			}
			
			else
			{
				Send {c down}
				keywait a
				Send {c up}
			}
			
		}
		
		KeyWait, a
		return
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
			Send {Blind}{Home}
			Return
		}
		Else if (Layer=2)
		{
			SetkeyDelay, 0, 32
			Send {Blind}{PgUp}
			Return
		}
		Else
		{
			SendInput {Blind}{WheelUp}
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
			Return
		}
		Else
		{
			SendInput {Blind}{WheelDown}
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
				Send {Enter}
			}
			Return
		}
		If WinActive("Tabs Outliner")
		{
			SendInput {LControl Down}{u}{LControl Up}
			SendInput {LControl Down}{w}{u}{LControl Up}
			Return
		}
		If WinActive("ahk_exe chrome.exe")
		{
			SendInput {LControl Down}{u}{LControl Up}
			Return
		}
		Else
		{
			If WinExist("Tabs Outliner")
			{
				WinActivate Tabs Outliner
				SendInput {LControl Down}{u}{LControl Up}
				SendInput {LControl Down}{w}{u}{LControl Up}
			}
		}
		Return
	}
	
	*$F13 Up::
	{
		F13_pressed := 0
		SendInput {Blind}{F13 Up}
		Return
	}
} ; Mouse

{ ; Keypad and/or Keyboard.
	*$SC029::
	{
		If (SC029_pressed)
			Return
		SC029_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{esc Down}
		}
		If (Layer=2)
		{
			SendInput {Blind}{SC029 Down}
		}
		Return
	}
	
	*$SC029 Up::
	{
		SC029_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("SC029"))
			{
				SendInput {Blind}{SC029 Up}
			}
			Else
				SendInput {Blind}{esc Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("esc"))
			{
				SendInput {Blind}{esc Up}
			}
			Else
				SendInput {Blind}{SC029 Up}
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
	
	$*SC003::
	{
		If (SC003_pressed)
			Return
		SC003_pressed := 1
		If (Layer=1)
		{
			SendInput {Blind}{SC003 Down}
		}
		If (Layer=2) and WinActive("ahk_exe chrome.exe")
		{
			SendInput ^+e
		}
		If (Layer=2) and WinActive("Tabs Outliner")
		{
			SendInput {F2}
		}
		If (Layer=2)
		{
			Send {F2}
		}
		Return
	}
	
	$*SC003 Up::
	{
		SC003_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("F2"))
			{
				SendInput {Blind}{F2 Up}
			}
			Else
				SendInput {Blind}{SC003 Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("SC003"))
			{
				SendInput {Blind}{SC003 Up}
			}
			Else
				SendInput {Blind}{F2 Up}
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
	
	LControl & s::
	{
		If (s_pressed)
			Return
		s_pressed := 1		
		If WinActive("Tabs Outliner")
		{
			SendInput {Backspace}
		}
		Else
		{
			SendInput {Blind}{s Down}
		}
		Return
	}
	
	LControl & s Up::
	{
		s_pressed := 0
		{
			SendInput {Blind}{s Up}
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
	
	$w Up::
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
	
	$Insert::
	{
		If (Layer=1)
		{
			
			SetKeyDelay 0, 32
			Send {Insert}
			Sleep 32
			Return
		}
		If (Layer=2)
		{
			SetKeyDelay 0, 32
			Send {Numpad1}
			Sleep 32
			Return
		}
	}
	
	$Delete::
	{
		If (Layer=1)
		{
			SetKeyDelay 0, 32
			Send {Delete}
			Sleep 32
			Return
		}
		If (Layer=2)
		{
			SetKeyDelay 0, 32		
			Send {Numpad3}
			Sleep 32
			Return
		}
	}
	
	$*Space::
	{
		If (Space_pressed)
			Return
		Space_pressed := 1
		If WinActive("Tabs Outliner") and GetKeyState("LControl")
		{
			SendInput {Blind}{Up}
			Return
		}
		Else
		{
			SendInput {Blind}{Space Down}
			Return
		}
		Return
	}
	
	$*Space Up::
	{
		Space_pressed := 0
		{
			SendInput {Blind}{Space Up}
		}
		Return
	}
} ; Keypad and/or Keyboard.

#IfWinActive StateOfDecay:YOSE
*$SC002::
{
	SetKeyDelay 0, 32
	Send {SC029 Down}{SC002}{SC029 Up}
	Return
}

*$SC003::
{
	SetKeyDelay 0, 32
	Send {SC029 Down}{SC003}{SC029 Up}
	Return
}

*$SC004::
{
	SetKeyDelay 0, 32
	Send {SC029 Down}{SC004}{SC029 Up}
	Return
}

*$SC005::
{
	SetKeyDelay 0, 32
	Send {SC029 Down}{SC005}{SC029 Up}
	Return
}
#IfWinActive