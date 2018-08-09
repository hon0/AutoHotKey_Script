#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#Warn  ; Enable warnings to assist with detecting common errors.
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
} ; Before running a Game. Run and/or close Program.

{ ; The Settlers manual interAction while in Game.
	
	
	
}

#z::	
PixelGetColor, color, 1889, 95
MsgBox The color at X1889 Y95 is %color%.
Clipboard = %color%
return

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

{ ;Layer modifier
	
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	Return
	
}

{ ; Global remapping
	
	; All 3 layer remapping
	
}


{ #if Layer = 1

{ ; Keyboard remapping
	
	XButton2::
	SetKeyDelay 32, 32
	send, ^'
	return
	
	XButton1::
	SetKeyDelay 32, 32
	send, ^"
	return
	
	{ ; Layer 1 "z" remapping
		$z::
		KeyWait z, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {b down}
			KeyWait z
			SendInput {b up}
		}
		else
		{
			SendInput {z down}
			sleep 32
			SendInput {z up}
		}
		return
	}
	
	
	{ ; Layer 1 "x" remapping
		$x::
		KeyWait x, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {n down}
			KeyWait x
			SendInput {n up}
		}
		else
		{
			SendInput {x down}
			sleep 32
			SendInput {x up}
			sleep 32
			;SetKeyDelay, 10, 10
			ControlSend, FoxitDocWnd1, {LControl Down}{g}{LControl Up}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit1, {LControl Down}{a}{LControl Up}{Numpad1}{Numpad5}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, FoxitDocWnd1, {NumpadEnter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
		}
		return
	}
	
	/* ; Layer 1 "c" remapping
		{ ; Layer 1 "c" remapping
			~c::
			sleep 32		
			ControlSend,, {LControl Down}{LShift Down}{n}{LControl Up}{LShift Up}, The Settlers 7 Paths to a Kingdom Prima Official Guide - PDF-XChange Editor
			ControlSend,, 19, Aller à la page 
			ControlSend,, {NumpadEnter}, Aller à la page
			sleep 100
			return
		}
	*/
	
	{ ; LAlt
		LAlt::
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
			return
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
		}
		Return
	}
	
	{ ; Numpad1
		Numpad1::
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
			return
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
		}
		Return
	}
	
	{ ; Numpad 2
		Numpad2::
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
		}
		Return
		
	}
	
	{ ; Numpad 3
		Numpad3::
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
		}
		Return
	}
	
} ; End of Keyboard remapping

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

{ ; All Layer 1 Digit remapping Layer 1 Short/Long, Layer 2 Short/Long, Layer 3 Short/Long
	
	$SC002:: ;[1, F1], [7, F7], [F13, F19]
	KeyWait SC002, t0.200&
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

#If

}

{ #if Layer = 2 

{ ; Global remapping
	
	XButton2::
	SetKeyDelay 32, 32
	send, ^(
	return
	
	XButton1::
	SetKeyDelay 32, 32
	send, ^è
	return	
	
	XButton2::F3
	
	XButton1::F4
	
	q::&
	w::é
	e::"
	
	
	tab::esc
	;w::b
	;x::n
	;c::,
	;v::Del
	;f::g
	;r::t
	
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
	
	{ ; X remapping Layer 2
		x:: 
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
			return
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
	
	{ ; c remapping Layer 2
		c::
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
	
} ; End of Global remapping Layer 2

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

#If ; End of If Layer 2

}

{ #if Layer = 3

{ ; Global remapping
	
	;#IfWinActive Setttlers 7 Window	
	
	LButton::F3
	
	RButton::F2
	
	XButton1::F3
	
	XButton2::F4
	
	;#IfWinActive
	
	tab::AppsKey
	w::Numpad0
	x::Numpad1
	c::Numpad2
	v::Numpad3
	;r::y
	;f::h
	
	
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

#If ; End of If Layer 3
	
}
