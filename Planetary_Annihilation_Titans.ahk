#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
keyEnter := 0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
#HotkeyInterval 2000  ; This is  the default value (milliseconds).
#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ;Monitoring Windows
	
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
		
	#If WinActive("Event Tester") || WinActive("AHK Studio - C:\Users\hon0_Corsair\Documents\GitHub\AutoHotKey_Script\AutoHotKey_Script.ahk")
	{
		$F5::
		WinActivate %Title%
		SetKeyDelay 2000, 32
		Send {F5}
		return
	}
	#IfWinActive
		
	{ ; Tray Icon If Pause and/or Suspend
		
		OnMessage(0x111,"WM_COMMAND")
		return
		
		WM_Command(wP) {
			
			static Suspend:=65305, Pause:=65306
			
			If (wP = Suspend)
				If !A_IsSuspended
					Menu, Tray, Icon, Shell32.dll, 132, 1
			Else If A_IsPaused
				Menu, Tray, Icon, Shell32.dll, 110, 1
			Else
				Menu, Tray, Icon, %A_AhkPath%
			
			
			Else If (wP = Pause)
				If !A_IsPaused
					Menu, Tray, Icon, Shell32.dll, 110, 1
			Else If A_IsSuspended
				Menu, Tray, Icon, Shell32.dll, 132, 1
			Else
				Menu, Tray, Icon, %A_AhkPath%
		}	
	}
}

{ ;Before running a Game. Run and/or close Program.
	
	#F1::Suspend, Toggle
	#F4::ExitApp	
	^#!SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.
	
	#t::
	{
		If !WinExist("MSI Afterburner")
		{
			Run, C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe
			WinWait MSI Afterburner
			MsgBox Check Mouse and keyboard profile!
		}
		Else If !WinExist("Set Timer Resolution")
		{
			Run, D:\-  T?chargements sur D\TimerResolution.exe
			WinWait Set Timer Resolution
			WinMinimize Set Timer Resolution
			WinWait MSI Afterburner
		}
		Else if WinExist("MSI Afterburner") || WinExist("Set Timer Resolution")
		{
			WinActivate, MSI Afterburner
			WinActivate, Set Timer Resolution
		}
		return
	}	
	
} ;Before running a Game. Run and/or close Program.

{ ;Joystick ID (Use JoyID Program)
	;6Joy = T16000L (See JoyID)
	;5Joy = Vjoy
}

{ ;Testing
	
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
	
	/*
		
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


/*
	 ;Layer checker
	
	z::
	ToolTip %Layer%
	SetTimer, RemoveToolTip, 2000
	return
	
	RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
	return
*/



{ ; Layer modifier
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	keyEnter = 0
	Return
}


{ #if Layer = 1

{ ;Global remapping
	
	XButton1:: ; Fire mode selector
	KeyWait, XButton1, T0.2
	
	if (ErrorLevel)
	{
		Send {RAlt Down}{F11}{RAlt Up}
	}
	else {
		KeyWait, XButton1, D T0.2
		
		if (ErrorLevel)
		{
			Send {RAlt Down}{F9}{RAlt Up}
		}
		
		else
		{
			Send {RAlt Down}{F10}{RAlt Up}
		}
		
	}
	
	KeyWait, XButton1
	return
	
	XButton2:: ; Move mode selector
	KeyWait, XButton2, T0.2
	
	if (ErrorLevel)
	{
		Send {LControl Down}{F11}{LControl Up}
	}
	else {
		KeyWait, XButton2, D T0.2
		
		if (ErrorLevel)
		{
			Send {LControl Down}{F9}{LControl Up}
		}
		
		else
		{
			Send {LControl Down}{F10}{LControl Up}
		}
		
	}
	
	KeyWait, XButton2
	return
	
	F1::
	send {LControl Down}{F1}{Numpad1}{LControl Up}
	return
	
	F2::
	send {LControl Down}{F1}{Numpad2}{LControl Up}
	return
	
	F3::
	send {LControl Down}{F1}{Numpad3}{LControl Up}
	return
	
	LControl & z::
	sendinput {LControl down}{z}{LControl up}
	sleep 200
	return
	
	SC002:: ; 
	KeyWait SC002, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		Send {F11}
		sleep 333
	}
	else
	{
		Send {SC002}
	}
	return
	
	Tab::Send {SC002}{F11}
	
	SC006::
	{
		SendInput	{LShift Down}{LControl Down}{F10}{LControl Up}{LShift Up}
	}
	sleep 64 
	SendInput {b}
	return
	
	~LButton Up::
	{
		If GetKeyState("F13") 
			send {LAlt Down}{LControl Down}{Numpad1}{LControl Up}{LAlt Up}
		Else
			If GetKeyState("F14")
				send {u}
	}
	return
	
	
	/*
		SC004:: ; Scout selection
		KeyWait SC004, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Send {SC004}{SC004}{LControl Down}{Numpad2}{LControl Up}
		}
		else
		{
			Send {SC004}{SC004}{LControl Down}{Numpad1}{LControl Up}
		}
		return
	*/
	
	SC056:: ; > <
	KeyWait SC056, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {m down}ll
		KeyWait SC056
		SendInput {m up}
	}
	else
	{
		SendInput {p}
	}
	return
	
	;#IfWinActive Planetary Annihilation
	
}

{ ; Mouse Wheel Layer 1
	~WheelUp:: 
	SetkeyDelay, 0, 32
	If GetKeyState("MButton") 
		send {Home}
		;Else
		;	If (GetKeyState("6Joy1")==1)
		;		send g
	Return
	
	~WheelDown:: 
	SetkeyDelay, 0, 32
	If GetKeyState("MButton") 
		send {End}
	
		;Else 
		;	If GetKeyState("Space") 
		;		send {End}
	Return
}	

#If ; End of "If Layer = 1".
	
}

{ #if Layer = 2 

{ ; Global remapping
	
	;#IfWinActive Planetary Annihilation
	w::b
	x::n
	c::,
	v::
	s::esc
	Send {LShift down}{F11}{LShift Up}{&}{F11}
	return
	
	~LButton Up:: ; Remove Air
	Send {}
	return
	
	Tab::Send {SC002}{F11}
	
	;#IfWinActive
}

{ ; Mouse Wheel Layer 2
	
	WheelUp:: 
	SetkeyDelay, 0, 32
	send {PgUp}
	Return
	
	WheelDown:: 
	SetkeyDelay, 0, 32
	send {PgDn}
	sleep, 100
	Return
	
}	

#If ; End of "If Layer = 2".

}

{ #if Layer = 3

{ ; Global remapping
	
	;#IfWinActive Planetary Annihilation
	
	LButton::F1	
	RButton::F2
	XButton1::F3
	XButton2::F4
	
	tab::AppsKey
	w::Numpad0
	x::Numpad1
	c::Numpad2
	v::Numpad3
	;r::y
	;f::h
	
	F8::F9
	F9::F10
	
	;#IfWinActive
}

{ ; Mouse Wheel Layer 3
	~WheelUp:: 
	SetkeyDelay, 0, 32
	If GetKeyState("MButton") 
		send {PGUP}
	else
		send {Insert}
		;Else
		;	If (GetKeyState("6Joy1")==1)
		;		send g
	Return
	
	~WheelDown:: 
	SetkeyDelay, 0, 32
	If GetKeyState("MButton") 
		send {PGDN}
	Else
		send {Del}
		;Else 
		;	If GetKeyState("Space") 
		;		send {End}
	Return
}



#If ; End of "If Layer = 3".
	
}