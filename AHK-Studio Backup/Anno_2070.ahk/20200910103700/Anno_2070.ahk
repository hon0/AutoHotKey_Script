#SingleInstance force
#Persistent
{
	Layer := 1
	CapsLock_pressed := 0
	
	/* ; Toggle Slow Time + an exemple
		;Toggle_Right := 0 ; Toggle Slow Time
		
		*Space:: ; Centrer la caméra sur la dernière notification.
		{
			If (Space_pressed)
				Return
			Space_pressed := 1
			If Toggle_Right = 1
			{
				SendInput {Blind}{NumpadSub Up}{Space}{NumpadSub Down}
			}
			Else
			{
				SendInput {Blind}{Space}
			}
			Return
		}
		
		*Space Up::
		{
			Space_pressed := 0
			Return
		}
	*/
	
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
	
	LControl_pressed := 0
	LShift_pressed := 0
	LAlt_pressed := 0
	Space_pressed := 0
	Down_pressed := 0	
	Left_pressed := 0
	Right_pressed := 0
	
	NumpadEnter_pressed := 0
	
	Quantity_ImageSearch := 0
}
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
	#F3::Suspend, Toggle
	#F4::ExitApp
	#SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.
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

{ ; Testing
	
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
} ; Mouse

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
	
	$v::
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
	
	$v Up::
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

#IfWinActive ANNO 2070
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
	
	F13:: ; Mouse on Minimap
	{
		If (F13_pressed)
			Return
		F13_pressed := 1
		{
			BlockInput, On
			MouseGetPos, xpos, ypos 
			MouseMove, 115, 985
			BlockInput, Off
		}
		Return
	}
	
	F13 Up::
	{
		F13_pressed := 0
		SendInput {LButton Up}
		MouseMove, xpos, ypos
		Return
	}
	
	F24:: ; Quick save
	{
		If (F24_pressed)
			Return
		F24_pressed := 1
		If Toggle_Right = 1
		{
			Send {NumpadSub Up}{F5}{NumpadSub Down}
		}
		Else
		{
			Send {F5}
		}
		Return
	}
	
	F24 Up::
	{
		F24_pressed := 0
		Return
	}
	
	F23:: ; Quick load
	{
		If (F23_pressed)
			Return
		F23_pressed := 1
		If Toggle_Right = 1
		{
			Send {NumpadSub Up}{LControl Down}{F5}{LControl Up}{NumpadSub Down}
		}
		Else
		{
			Send {LControl Down}{F5}{LControl Up}
		}
		Return
	}
	
	F23 Up::
	{
		F23_pressed := 0
		Return
	}
}

{ ; Keypad and/or Keyboard.
	~LControl::
	{
		If (LControl_pressed)
			Return
		LControl_pressed := 1
		ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *75, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Quantity_Icon.bmp
		if (ErrorLevel = 2)
		{
			Quantity_ImageSearch := 0
		;MsgBox Could not conduct the search.
			return
		}
		else if (ErrorLevel = 1)
		{
			Quantity_ImageSearch := 0
		;MsgBox Icon could not be found on the screen.
			ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *75, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Quantity_Icon_10.bmp
			if (ErrorLevel = 2)
			{
				Quantity_ImageSearch := 0
		;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				Quantity_ImageSearch := 0
		;MsgBox Icon could not be found on the screen.
				return
			}
			else
			{
				Quantity_ImageSearch := 1
		;MsgBox The icon was found at %FoundX%x%FoundY%.
				{
					BlockInput, On
					MouseGetPos, xpos, ypos 
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 75, 10, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
			}
			return
		}
		else
		{
			Quantity_ImageSearch := 1
		;MsgBox The icon was found at %FoundX%x%FoundY%.
			{
				BlockInput, On
				MouseGetPos, xpos, ypos 
				MouseMove, %FoundX%, %FoundY%
				MouseMove, 75, 10, 0, R
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
		}
		return
	}
	
	~LControl Up::
	{
		LControl_pressed := 0
		If Quantity_ImageSearch = 1
		{
			BlockInput, On
			MouseGetPos, xpos, ypos 
			MouseMove, %FoundX%, %FoundY%
			MouseMove, 20, 10, 0, R
			MouseClick, left
			MouseMove, xpos, ypos
			BlockInput, Off
			SendInput {LControl Up}
			Quantity_ImageSearch := 0
			return
		}
		Else
		{
			Quantity_ImageSearch := 0
			Return
		}
		Return
	}
	
	~LShift::
	{
		If (LShift_pressed)
			Return
		LShift_pressed := 1
		ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *75, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Quantity_Icon.bmp
		if (ErrorLevel = 2)
		{
			;MsgBox Could not conduct the search.
			return
		}
		else if (ErrorLevel = 1)
		{
			Quantity_ImageSearch := 0
		;MsgBox Icon could not be found on the screen.
			ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *75, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Quantity_Icon_10.bmp
			if (ErrorLevel = 2)
			{
				Quantity_ImageSearch := 0
		;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				Quantity_ImageSearch := 0
		;MsgBox Icon could not be found on the screen.
				return
			}
			else
			{
				Quantity_ImageSearch := 1
		;MsgBox The icon was found at %FoundX%x%FoundY%.
				{
					BlockInput, On
					MouseGetPos, xpos, ypos 
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 50, 10, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
			}
			return
		}
		else
		{
			Quantity_ImageSearch := 1
		;MsgBox The icon was found at %FoundX%x%FoundY%.
			{
				MouseGetPos, xpos, ypos 
				BlockInput, On
				MouseMove, %FoundX%, %FoundY%
				MouseMove, 50, 10, 0, R
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
		}
		return
	}
	
	~LShift Up::
	{
		LShift_pressed := 0
		If Quantity_ImageSearch = 1
		{
		;ImageSearch, FoundX, FoundY, 1550, 400, A_ScreenWidth, A_ScreenHeight, *25, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Icon_1.png
			{
		;MsgBox The icon was found at %FoundX%x%FoundY%.
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 20, 10, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
					SendInput {LShift Up}
					Quantity_ImageSearch := 0
				}
			}
			return
		}
		Else
			Return
	}
	
	*$SC029:: ; Déselectionner, menu.
	{
		If (SC029_pressed)
			Return
		SC029_pressed := 1
		If (Layer = 1)
		{
			KeyWait SC029, t0.200
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SendInput {p}
			}
			Else
			{
				SendInput {esc}
			}
			Return
		}
		If (Layer = 2)
		{
			SendInput {F1}
		}
		return
	}
	
	*$SC029 Up::
	{
		SC029_pressed := 0
		Return
	}
	
	$Tab:: ; Faire défiler la sélection des Navires et centrer la caméra sur la sélection
	{
		If (Tab_pressed)
			Return
		Tab_pressed := 1
		If (Layer = 1)
		{
			SendInput {Tab}
		}
		If (Layer = 2)
		{
			SendInput {Numpad0}
		}
		Return
	}
	
	$Tab Up::
	{
		Tab_pressed := 0
		Return
	}
	
	LAlt & Tab:: ; Faire défiler les Navires sans les selectionner et centrer la caméra sur eux.
	{
		If (Tab_pressed)
			Return
		Tab_pressed := 1
		{
			SendInput {LControl Down}{k}{LControl Up}
		}
		Return
	}
	
	LAlt & Tab Up::
	{
		Tab_pressed := 0
		Return
	}
	
	*$SC002:: ; Layer 1 = Faire défiler la sélection des Navires. Layer 2 = Vue carte postale.
	{
		If (SC002_pressed)
			Return
		SC002_pressed := 1
		If (Layer = 1)
			KeyWait SC002, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			ImageSearch, FoundX, FoundY, 1500, 750, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Eco-ctr-icon.png
			if (ErrorLevel = 2)
			{
				;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Eco-ctr-icon.png
				if (ErrorLevel = 2)
				{
					return
				}
				else if (ErrorLevel = 1)
				{
					return
				}
				else
				{
					BlockInput, On
					MouseGetPos, xpos, ypos 
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 10, 10, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
				return
			}
			else
			{
				MouseGetPos, xpos, ypos
				BlockInput, On
				MouseMove, %FoundX%, %FoundY%
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
			return
		}
		Else
		{
			SendInput {Blind}{SC002}
		}
		If (Layer = 2)
		{
			SendInput {F1}
		}
		Return
	}
	
	SC002 Up::
	{
		SC002_pressed := 0
		Return
	}
	
	*$SC003:: ; Layer 1 = Décharger toutes les marchandises du véhicule dans l'entrepot à portée.
	{
		If (SC003_pressed)
			Return
		SC003_pressed := 1
		If (Layer = 1)
		{
			SendInput {Blind}{SC003}
		}		
		If (Layer = 2)
		{
			SendInput {l}
		}
		Return
	}
	
	SC003 Up::
	{
		SC003_pressed := 0
		Return
	}
	
	*$SC004:: ; Groupe 3
	{
		If (SC004_pressed)
			Return
		SC004_pressed := 1
		If (Layer = 1)
		{
			SendInput {Blind}{SC004}
		}		
		If (Layer = 2)
		{
			SendInput {F3}
		}
		Return
	}
	
	SC004 Up::
	{
		SC004_pressed := 0
		Return
	}
	
	*$SC005:: ; Groupe 4
	{
		If (SC005_pressed)
			Return
		SC005_pressed := 1
		If (Layer = 1)
		{
			SendInput {Blind}{SC005}
		}
		If (Layer = 2)
		{
			SendInput {F4}
		}
		Return
	}
	
	SC005 Up::
	{
		SC005_pressed := 0
		Return
	}
	
	*Left:: ; Ouvrir la flotte de véhicule et les bâtiments.
	{
		If (Left_pressed)
			return
		Left_pressed := 1
		KeyWait Left, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			ImageSearch, FoundX, FoundY, 1500, 750, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Route_Commercial_02.png
			if (ErrorLevel = 2)
			{
				;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Route_Commercial_02_bis.png
				if (ErrorLevel = 2)
				{
					return
				}
				else if (ErrorLevel = 1)
				{
					ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Route_Commercial_01.png
					if (ErrorLevel = 2)
					{
						return
					}
					else if (ErrorLevel = 1)
					{
						return
					}
					else
					{
						BlockInput, On
						MouseGetPos, xpos, ypos 
						MouseMove, %FoundX%, %FoundY%
						MouseMove, 10, 3, 0, R
						MouseClick, left
						MouseMove, xpos, ypos
						BlockInput, Off
					}
					return
				}
				else
				{
					BlockInput, On
					MouseGetPos, xpos, ypos 
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 10, 3, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
				return
			}
			else
			{
				MouseGetPos, xpos, ypos
				BlockInput, On
				MouseMove, %FoundX%, %FoundY%
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
			return
		}
		Else
		{
			SendInput {Blind}{z Up}{q Up}{s Up}{d Up}{F11}
			If GetKeyState("z", "P")
				SendInput {z Down}
			If GetKeyState("q", "P")
				SendInput {q Down}
			If GetKeyState("s", "P")
				SendInput {s Down}
			If GetKeyState("d", "P")
				SendInput {d Down}
		}
		Return
	}
	
	Left Up::
	{
		Left_pressed := 0
		Return
	}
	
	$w:: ; Layer 1 = Mode démolition. Layer 2 = Améliorer la Maison.
	{
		If (w_pressed)
			Return
		w_pressed := 1
		If (Layer = 1)
		{
			SendInput {w}
		}
		If (Layer = 2)
		{
			SendInput {u}
		}
		Return
	}
	
	w Up::
	{
		w_pressed := 0
		Return
	}
	
	$x::
	{
		If (x_pressed)
			Return
		x_pressed := 1
		If (Layer = 1)
		{
			SendInput {x Down}
		}
		If (Layer = 2)
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
	
	$*e::
	{
		If (e_pressed)
			Return
		e_pressed := 1
		If (Layer=1)
		{
			ImageSearch, FoundX, FoundY, 1500, 750, A_ScreenWidth, A_ScreenHeight, *25, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Icon_Load.png
			if (ErrorLevel = 2)
			{
				;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				;MsgBox Icon could not be found on the screen.
				ImageSearch, FoundX, FoundY, 1500, 750, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Transaction_Icon.png
				if (ErrorLevel = 2)
				{
				;MsgBox Could not conduct the search.
					return
				}
				else if (ErrorLevel = 1)
				{
				;MsgBox Icon could not be found on the screen.
					return
				}
				else
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					MouseMove, %FoundX%, %FoundY%
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
				return
			}
			else
			{
				MouseGetPos, xpos, ypos 
				BlockInput, On
				MouseMove, %FoundX%, %FoundY%
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
			return
		}
		If (Layer=2)
		{
			SendInput {Blind}{e}
		}	
		Return
	}
	
	$*e Up::
	{
		e_pressed := 0
		/*
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
		*/
		Return
	}
	
	$r::
	{
		If (r_pressed)
			Return
		r_pressed := 1
		If (Layer = 1)
		{
			SendInput {r Down}
		}
		If (Layer = 2)
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
		If (Layer = 1)
		{
			SendInput {f Down}
		}
		If (Layer = 2)
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
			If (GetKeyState("g"))
			{
				SendInput {g Up}
			}
			Else
				SendInput {f Up}
		}
		Return
	}
	
	$c::
	{
		If (c_pressed)
			Return
		c_pressed := 1
		If (Layer = 1)
		{
			SendInput {c Down}
		}
		If (Layer = 2)
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
		If (Layer = 1)
		{
			SendInput {v Down}
		}
		If (Layer = 2)
		{
			SendInput {SC033 Down}
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
	
	*$Insert::
	{
		If (Layer = 1)
		{
			SendInput {v}
			Sleep 200
		}
		If (Layer = 2)
		{
			SendInput {SC033}
			Sleep 200
		}
		Return
	}
	
	*$Delete::
	{
		If (Layer = 1)
		{
			SendInput {v}
			Sleep 200
		}
		If (Layer = 2)
		{
			SendInput {SC033}
			Sleep 200
		}
		Return
	}
	
	*Right:: ; Toggle time deceleration
	{
		If (Right_pressed)
			Return
		Right_pressed := 1
		BlockInput, On
		MouseGetPos, xpos, ypos 
		SendInput {F10}
		Click, 1637, 923  ; Click left mouse button at specified coordinates.		
		MouseMove, xpos, ypos
		SendInput {F10}²
		BlockInput, Off
		Return
	}
	
	*Right Up::
	{
		Right_pressed := 0
		Return
	}
	
	*Down:: ; Ouvrir la carte stratégique.
	{
		If (Down_pressed)
			Return
		Down_pressed := 1
		KeyWait Down, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {Blind}{F7}
		}
		Else
		{
			SendInput {Blind}{Down}
		}
		Return
	}
	
	*Down Up::
	{
		Down_pressed := 0
		Return
	}
	
	*Space:: ; Tempo : Centrer la caméra sur la dernière notification ; Pause ou reprise de la route commerciale
	{
		If (Space_pressed)
			Return
		Space_pressed := 1
		KeyWait Space, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			ImageSearch, FoundX, FoundY, 1500, 750, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Pause_Route_Commerciale.png
			if (ErrorLevel = 2)
			{
				;MsgBox Could not conduct the search.
				return
			}
			else if (ErrorLevel = 1)
			{
				ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Pause_Route_Commerciale_bis.png
				if (ErrorLevel = 2)
				{
					return
				}
				else if (ErrorLevel = 1)
				{
					ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Resume_Route_Commerciale.png
					if (ErrorLevel = 2)
					{
						return
					}
					else if (ErrorLevel = 1)
					{
						ImageSearch, FoundX, FoundY, 1550, 575, A_ScreenWidth, A_ScreenHeight, *100, E:\- Téléchargements sur E\Anno 2070\AutoHotKey Image Search\Resume_Route_Commerciale_bis.png
						if (ErrorLevel = 2)
						{
							return
						}
						else if (ErrorLevel = 1)
						{
							return
						}
						else
						{
							BlockInput, On
							MouseGetPos, xpos, ypos 
							MouseMove, %FoundX%, %FoundY%
							MouseMove, 0, 10, 0, R
							MouseClick, left
							MouseMove, xpos, ypos
							BlockInput, Off
						}
						return
					}
					else
					{
						BlockInput, On
						MouseGetPos, xpos, ypos 
						MouseMove, %FoundX%, %FoundY%
						MouseMove, 0, 10, 0, R
						MouseClick, left
						MouseMove, xpos, ypos
						BlockInput, Off
					}
					return
				}
				else
				{
					BlockInput, On
					MouseGetPos, xpos, ypos 
					MouseMove, %FoundX%, %FoundY%
					MouseMove, 0, 10, 0, R
					MouseClick, left
					MouseMove, xpos, ypos
					BlockInput, Off
				}
				return
			}
			else
			{
				MouseGetPos, xpos, ypos
				BlockInput, On
				MouseMove, %FoundX%, %FoundY%
				MouseClick, left
				MouseMove, xpos, ypos
				BlockInput, Off
			}
			return
		}
		Else
		{
			SendInput {Blind}{Space}
		}
		Return
	}
	
	*Space Up::
	{
		Space_pressed := 0
		Return
	}
	
	*NumpadEnter:: ; Enter
	{
		If (NumpadEnter_pressed)
			Return
		NumpadEnter_pressed := 1
		{
			SendInput {Blind}{NumpadEnter}{Escape}
		}
		Return
	}
	
	*NumpadEnter Up::
	{
		NumpadEnter_pressed := 0
		Return
	}
}
#IfWinActive