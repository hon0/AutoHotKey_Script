#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#Warn  ; Enable warnings to assist with detecting common errors.

Layer := 1 ; To initialise my 3 layer keymap.

; Crounch and Prone to deal with toggle.
Crounch := 0
Prone := 0

SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
;#InstallKeybdHook
;#InstallMouseHookccccccccccccccccccccccccccccccccccccccccccc


{ ;Monitoring Windows
	
	BlockInput, On
	
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	;sleep 32
	
	#IfWinExist Event Tester
	{
		WinClose Event Tester
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
		WinWait, Event Tester
		SetKeyDelay 0, 32
		Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
		Sleep 32
		MouseClick, left, 36, 40
		MouseClick, left, 104, 62
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
}

{ ;Before running a Game. Run and/or close Program.
	
	#F1::Suspend, Toggle
	#F4::ExitApp
	
	#t::
	{
		If !WinExist("MSI Afterburner")
		{
			Run, C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe
			WinWait MSI Afterburner
			MsgBox Rat Pro S profile Crysis.
			MsgBox Razer Orbweaver Profile AHK_Crysis.
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
	
} ;Before running a Game. Run and/or close Program.

;Testing

/*
	m::
	Send o
	if (A_PriorKey = "space")
		SendInput {p}
	return
*/

/* ;Testing
	{	
		#If InGame = 0
			#g::
		InGame :=1
		return
		#If InGame = 1
			#g::
		InGame :=0
		return
		#If
			
		^#g::MsgBox %InGame%
		return
	}
*/


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

{ ; Global remapping
	
	z::z
	s::s
	q::q
	d::d
	
	{ ; w ;*[Crysis_]
		w::
		If Prone = 1
		{
			SendInput w
			Prone := 0
		}
		else if Crounch = 1
		{
			sendinput {space}{w}
			Crounch := 0
			Prone := 1
		}
		Else if Prone = 0
		{
			SendInput w
			Prone := 1
		}	
		return
	}
	
	{ ; Space
		~Space::
		Prone := 0
		If  (Prone = 1)
			Crounch := 1
		Else If Crounch = 1
			Crounch := 0
		return
	}
	
	{ ; Down
		$Down::
		If Prone = 1
		{
			sendinput {w}{Down}
			Prone := 0
			Crounch := 1
		}
		Else
		{
			send {down}
			Crounch := 1
		}
		return
	}
	
	{ ; v
		$v::
		KeyWait v, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {Numpad7 down}
			KeyWait v
			SendInput {Numpad7 Up}
		}
		else
		{
			SendInput {v down}
			sleep 32
			SendInput {v Up}	
		}
		return
	}
	
	/*
		esc::
		KeyWait esc, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {esc down}
			KeyWait esc
			SendInput {esc up}
		}
		else
		{
			SendInput {i down}
			sleep 32
			SendInput {i Up}
		}
		return
	*/
	
	{ ; Nuopad 5
		Numpad5::
		{
			BlockInput, On
			SendInput {Numpad2 Down}
		;SendInput {Numpad5}{Numpad5}
			MouseMove, 400, -150 , 2, R
			SendInput {Numpad2 Up}
			BlockInput, Off
			return
		}
	}
	
	{ ; XButton1
		~XButton1::
		KeyWait XButton1, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {Backspace down}
			KeyWait XButton1
			SendInput {Backspace up}
		}
		else
		{
			SendInput i	
		}
		return
	}
	
	{ ; Xbutton2
		~XButton2::
		/*
			KeyWait XButton2, t0.200
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SendInput {Numpad7 down}
				KeyWait XButton2
				SendInput {Numpad7 up}
			}
			else
		*/
		{
			BlockInput, On
			SendInput {Numpad2 Down}
		;SendInput {Numpad5}{Numpad5}
			MouseMove, 0, -400 , 2, R
			SendInput {Numpad2 Up}
			BlockInput, Off
			sendinput {XButton2}
		}
		return
	}
	
}

{ ; Mouse Wheel Layer 1
	
	{ ; WheelUp
		~WheelUp:: 
		SetkeyDelay, 0, 32
		If GetKeyState("MButton") 
			send {Home}
		;Else
		;	If (GetKeyState("6Joy1")==1)
		;		send g
		Return
	}
	
	{ ; WheelDown
		~WheelDown:: 
		SetkeyDelay, 0, 32
		If GetKeyState("MButton") 
			send {End}
		
		;Else 
		;	If GetKeyState("Space") 
		;		send {End}
		Return
	}
	
}	

{ ; All Layer 1 Digit remapping Layer 1 Short/Long, Layer 2 Short/Long, Layer 3 Short/Long
	
	$SC002:: ;[1, F1], [7, F7], [F13, F19]
	KeyWait SC002, t0.200&
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		SendInput {F1 down}
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
	
	$SC006::
	{
		BlockInput, On
		SendInput {Numpad2 Down}
			;SendInput {Numpad5}{Numpad5}
		MouseMove, -400, -150 , 2, R
		SendInput {Numpad2 Up}
		BlockInput, Off
	}
	return
	/*
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
			BlockInput, On
			SendInput {Numpad2 Down}
			;SendInput {Numpad5}{Numpad5}
			MouseMove, -400, -150 , 2, R
			SendInput {Numpad2 Up}
			BlockInput, Off
			
		}
		return
	*/
	
	$SC007::
	{
		BlockInput, On
		SendInput {Numpad2 Down}
			;SendInput {Numpad5}{Numpad5}
		MouseMove, 400, 150 , 2, R
		SendInput {Numpad2 Up}
		BlockInput, Off
	}
	return
	
	
	/*
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
			BlockInput, On
			SendInput {Numpad2 Down}
			;SendInput {Numpad5}{Numpad5}
			MouseMove, 400, 150 , 2, R
			SendInput {Numpad2 Up}
			BlockInput, Off
		}
		return
	*/
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
	
	tab::!l
	w::b
	x::i
	c::,
	v::Del
	
	F8::F9
	F9::F10
	
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
	
	F8::F9
	F9::F10
	
	;#IfWinActive
}

{ ; Mouse Wheel Layer 3
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
	
::ahk::AutoHotKey
::viei@::vieillefont.antoine@gmail.com
	
}

#g::
MouseGetPos, xpos, ypos 
MsgBox, The cursor is at X%xpos% Y%ypos%. 
return

#s::
MouseClick, left, 36, 40
MouseClick, left, 104, 62
return

#x::
MouseMove, 50, -50 , 10, R ;moves the mouse in a box
MouseMove, -100, 0 , 10, R ;around it's starting position
MouseMove, 0, 100 , 10, R
MouseMove, 100, 0 , 10, R
MouseMove, 0, -100 , 10, R
MouseMove, -50, 50 , 10, R
return