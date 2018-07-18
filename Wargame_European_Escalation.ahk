#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#Warn  ; Enable warnings to assist with detecting common errors.
#HotkeyInterval 2000  ; This is  the default value (milliseconds).
#MaxHotkeysPerInterval 500
Layer := 1
Count := 1
x := 0
y := 0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

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

{ ; Before running a Game. Run and/or close Program.
	
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
			Run, D:\-  Téléchargements sur D\TimerResolution.exe
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
	
} ; Before running a Game. Run and/or close Program.

/* ;Layer checker
	
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
	Return
}


{ #if Layer = 1

{ ;Global remapping
	
	#IfWinActive Wargame - DirectX 11
	
	v::
	{	
		KeyWait v, t0.100
		SetkeyDelay 0, 32
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Send {i}
			keywait, v
		}
		else
		{
			Send {v}
			keywait, v
		}
		return
	}
	
	~a::
	keywait, a, T0.100
	if (ErrorLevel)
	{
		Send {t}
		keywait, a
	}
	return
	
	b::
	{	
		KeyWait b, t0.200
		SetkeyDelay 0, 32
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			Send {u}
			keywait, b
		}
		else
		{
			Send {l}
			keywait, b
		}
		return
	}
	
	; Tank sequential fire 7-8-9-0
	
	Numpad2:: ;Set group 7-8-9-0
	{
		SetTimer, Reset, 3000		
		x++
		if x = 1
			send {LControl Down}{è}{LControl Up}
		else if x = 2
			send {LControl Down}{_}{LControl Up}
		else if x = 3
			send {LControl Down}{ç}{LControl Up}
		else if x = 4
		{
			send {LControl Down}{à}{LControl Up}
			x := 0
		}
		
		
		return
		
		Reset:
		x := 0
		return
	}
	
	Numpad3::
	{
		BlockInput, On
		SetTimer, ResetNP3, 3000
		y++
		if y = 1
		{
			send {è}
			MouseMove, 900, 1015, 1
			sleep 3
			Click
			MouseMove, 1020, 1015, 1
			sleep 3
			Click
		}
		else if y = 2
		{
			send {_}
			MouseMove, 900, 1015, 1
			sleep 3
			Click
			MouseMove, 1020, 1015, 1
			sleep 3
			Click
		}
		else if y = 3
		{
			send {ç}
			MouseMove, 900, 1015, 1
			sleep 3
			Click
			MouseMove, 1020, 1015, 1
			sleep 3
			Click
		}
		else if y = 4
		{
			send {à}
			MouseMove, 900, 1015, 1
			sleep 3
			Click
			MouseMove, 1020, 1015, 1
			sleep 3
			Click	
			y := 0
		}
		
		BlockInput, Off
		return
		
		ResetNP3:
		y := 0
		return
	}
	
	XButton2::
	{
		BlockInput, On	
		MouseGetPos, xpos, ypos
		MouseClick, left, 900, 1015, 1, 1
		MouseMove, 1020, 1015, 1
		sleep 3
		Click
		MouseMove, 1150, 1015, 1
		sleep 3
		Click
		MouseMove, xpos, ypos
		BlockInput, Off
		Return
	}
	
	XButton1::e
	
	NumpadDot::
	{
		BlockInput, On
		MouseGetPos xpos, ypos
		Click
		sleep 3
		MouseMove, 900, 1015, 1
		sleep 3
		Click
		MouseMove, 1020, 1015, 1
		sleep 3
		Click
		MouseMove xpos, ypos
		BlockInput, Off
		return
	}
	
	#IfWinActive
	
	
	;Numpad0 Up::SendInput {y Up}
	
	²::
	{
		KeyWait ², t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {Enter down}
			KeyWait ²
			SendInput {Enter up}
		}
		else
		{
			SendInput {Backspace down}
			sleep 32
			KeyWait ²
			SendInput {Backspace up}
		}
		return
	}
	
	SC056::m
	
	~Right & LButton::F1
	Return
	
	~Right & RButton::F2
	Return
	
	~Right & XButton1::F3
	Return
	
	~Right & XButton2::F4
	Return
	
	~Right & WheelUp::
	send, {F5}
	Sleep, 100
	Return
	
	~Right & WheelDown::
	send, {F6}
	Sleep, 100
	Return
	
	~Right & MButton::F7
	Return
	
	;#IfWinActive
	
}

{ ; Mouse Wheel Layer 1
	~WheelUp:: 
	{
		If GetKeyState("MButton") 
		{
			send {Home Down}
			sleep 32
			send {Home Up}
		}
		;Else
		;	If (GetKeyState("6Joy1")==1)
		;		send g
		Return
	}
	
	~WheelDown:: 
	{
		If GetKeyState("MButton") 
		{
			send {End Down}
			sleep 32
			send {End Up}
		}
		;Else 
		;	If GetKeyState("Space") 
		;		send {End}
		Return
	}
}

{ ; All Layer 1 Digit remapping Layer 1 Short/Long, Layer 2 Short/Long, Layer 3 Short/Long
	
	$SC002:: ;[1, F1], [7, F7], [F13, F19]
	KeyWait SC002, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		Send {F1 down}
		KeyWait SC002
		SendInput {F1 up}
	}
	else
	{
		SendInput {SC002 down}
		sleep 32
		KeyWait SC002
		SendInput {SC002 up}
	}
	return
	
	
	
	$SC003:: ;[2, F2], [8, F8], [F14, F20]
	KeyWait SC003, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F2 down}
		KeyWait SC003
		SendInput {F2 up}
	}
	else
	{
		SendInput {SC003 down}
		sleep 32
		KeyWait SC003
		SendInput {SC003 up}
	}
	return
	
	$SC004:: ;[3, F3], [9, F9], [F15, F21]
	KeyWait SC004, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F3 down}
		KeyWait SC004
		SendInput {F3 up}
	}
	else
	{
		SendInput {SC004 down}
		sleep 32
		KeyWait SC004
		SendInput {SC004 up}
	}
	return
	
	$SC005:: ;[4, F4], [10, F10], [F16, F22]
	KeyWait SC005, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F4 down}
		KeyWait SC005
		SendInput {F4 up}
	}
	else
	{
		SendInput {SC005 down}
		sleep 32
		KeyWait SC005
		SendInput {SC005 up}
	}
	return
	
	$SC006:: ;[5, F5], [11, F11], [F17, F23]
	KeyWait SC006, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F5 down}
		KeyWait SC006
		SendInput {F5 up}
	}
	else
	{
		SendInput {SC006 down}
		sleep 32
		KeyWait SC006
		SendInput {SC006 up}
	}
	return
	
	$SC007:: ;[6, F6], [12, F12], [F18, F24]
	KeyWait SC007, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F6 down}
		KeyWait SC007
		SendInput {F6 up}
	}
	else
	{
		SendInput {SC007 down}
		sleep 32
		KeyWait SC007
		SendInput {SC007 up}
	}
	return
}

#If ; End of "If Layer = 1".

}

{ #if Layer = 2 

{ ; Global remapping
	
	;#IfWinActive EscapeFromTarkov
	
	LButton::F1
	RButton::F2
	XButton1::F3
	XButton2::F4
	
	tab::esc
	
	SC056:: 
	KeyWait SC056, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {p down}
		KeyWait SC056
		SendInput {p up}
	}
	else
	{
		SendInput {o down}
		sleep 32
		KeyWait SC056
		SendInput {o up}
	}
	return
	
	w::b
	x::n
	c::,
	v::;
	
	
	
	;#IfWinActive
}

{ ; Mouse Wheel Layer 2
	~WheelUp:: 
	SetkeyDelay, 0, 32
	send {PgUp}
	Return
	
	~WheelDown:: 
	SetkeyDelay, 0, 32
	send {PgDn}
	Return
}	

{ ;All Layer 2 Digit remapping Layer 1 Short/Long, Layer 2 Short/Long, Layer 3 Short/Long
	
	$SC002:: ;[1, F1], [7, F7], [F13, F19]
	KeyWait SC002, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F7 down}
		KeyWait SC002
		SendInput {F7 up}
	}
	else
	{
		SendInput {SC008 down}
		sleep 32
		KeyWait SC002
		SendInput {SC008 up}
	}
	return
	
	
	$SC003:: ;[2, F2], [8, F8], [F14, F20]
	KeyWait SC003, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F8 down}
		KeyWait SC003
		SendInput {F8 up}
	}
	else
	{
		SendInput {SC009 down}
		sleep 32
		KeyWait SC003
		SendInput {SC009 up}
	}
	return
	
	$SC004:: ;[3, F3], [9, F9], [F15, F21]
	KeyWait SC004, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F9 down}
		KeyWait SC004
		SendInput {F9 up}
	}
	else
	{
		SendInput {SC00A down}
		sleep 32
		KeyWait SC004
		SendInput {SC00A up}
	}
	return
	
	$SC005:: ;[4, F4], [10, F10], [F16, F22]
	KeyWait SC005, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F10 down}
		KeyWait SC005
		SendInput {F10 up}
	}
	else
	{
		SendInput {SC00B down}
		sleep 32
		KeyWait SC005
		SendInput {SC00B up}
	}
	return
	
	$SC006:: ;[5, F5], [11, F11], [F17, F23]
	KeyWait SC006, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F11 down}
		KeyWait SC006
		SendInput {F11 up}
	}
	else
	{
		SendInput {SC00C down}
		sleep 32
		KeyWait SC006
		SendInput {SC00C up}
	}
	return
	
	$SC007:: ;[6, F6], [12, F12], [F18, F24]
	KeyWait SC007, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F12 down}
		KeyWait SC007
		SendInput {F12 up}
	}
	else
	{
		SendInput {SC00D down}
		sleep 32
		KeyWait SC007
		SendInput {SC00D up}
	}
	return
}

{ ;Layer 2 "f" remapping
	$f::
	KeyWait f, t0.200
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

{ ;Layer 2 "r" remapping
	$r::
	KeyWait r, t0.200
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

#If ; End of "If Layer = 2".
	
}

{ #if Layer = 3

{ ; Global remapping
	
	;#IfWinActive EscapeFromTarkov	
	
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
	
	;#IfWinActive
}

{ ; Mouse Wheel Layer 3
	~WheelUp:: 
	SetkeyDelay, 0, 32
	send {Insert}
	Return
	
	~WheelDown:: 
	SetkeyDelay, 0, 32
	send {Del}
	Return
}

{ ;All Layer 3 Digit remapping Layer 1 Short/Long, Layer 2 Short/Long, Layer 3 Short/Long
	
	$SC002:: ;[1, F1], [7, F7], [F13, F19]
	KeyWait SC002, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F19 down}
		KeyWait SC002
		SendInput {F19 up}
	}
	else
	{
		SendInput {F13 down}
		sleep 32
		KeyWait SC002
		SendInput {F13 up}
	}
	return
	
	
	$SC003:: ;[2, F2], [8, F8], [F14, F20]
	KeyWait SC003, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F20 down}
		KeyWait SC003
		SendInput {F20 up}
	}
	else
	{
		SendInput {F14 down}
		sleep 32
		KeyWait SC003
		SendInput {F14 up}
	}
	return
	
	$SC004:: ;[3, F3], [9, F9], [F15, F21]
	KeyWait SC004, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F21 down}
		KeyWait SC004
		SendInput {F21 up}
	}
	else
	{
		SendInput {F15 down}
		sleep 32
		KeyWait SC004
		SendInput {F15 up}
	}
	return
	
	$SC005:: ;[4, F4], [10, F10], [F16, F22]
	KeyWait SC005, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F22 down}
		KeyWait SC005
		SendInput {F22 up}
	}
	else
	{
		SendInput {F16 down}
		sleep 32
		KeyWait SC005
		SendInput {F16 up}
	}
	return
	
	$SC006:: ;[5, F5], [11, F11], [F17, F23]
	KeyWait SC006, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F23 down}
		KeyWait SC006
		SendInput {F23 up}
	}
	else
	{
		SendInput {F17 down}
		sleep 32
		KeyWait SC006
		SendInput {F17 up}
	}
	return
	
	$SC007:: ;[6, F6], [12, F12], [F18, F24]
	KeyWait SC007, t0.200
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F24 down}
		KeyWait SC007
		SendInput {F24 up}
	}
	else
	{
		SendInput {F18 down}
		sleep 32
		KeyWait SC007
		SendInput {F18 up}
	}
	return
}



{ ;Layer 3 "f" remapping
	$f::
	KeyWait f, t0.200
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

{ ;Layer 3 "r" remapping
	$r::
	KeyWait r, t0.200
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

#If ; End of "If Layer = 3".
	
}


{ ;HotStrings
	
:*:ahk::AutoHotKey
::viei@::vieillefont.antoine@gmail.com
	
}
