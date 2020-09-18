#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
{
	Layer := 1
	CapsLock_pressed := 0
	
	SC029_pressed := 0
	Tab_pressed := 0
	LControl_pressed := 0
	
	XButton2_pressed := 0
	XButton1_pressed := 0
	
	F24_pressed := 0
	F23_pressed := 0
	
	F13_pressed := 0
	
	a_pressed := 0
	e_pressed := 0
	
	r_pressed := 0
	f_pressed := 0
	
	w_pressed := 0
	x_pressed := 0
	c_pressed := 0
	v_pressed := 0
	
	LAlt_pressed := 0
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
	#F2::Suspend, Toggle
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

#IfWinActive Deep Rock Galactic
	
$F24::
{
	If (F24_pressed) or GetKeyState("LButton")
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
		SendInput {XButton2 Down}
	}
	Return
}

$F24 Up::
{
	F24_pressed := 0
	SendInput {XButton2 Up}
	Return
}

$F23::
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
		SendInput {XButton1 Down}
	}
	Return
}

$F23 Up::
{
	F23_pressed := 0
	SendInput {XButton1 Up}
	Return
}

$F13::
{
	If (F13_pressed)
		Return
	F13_pressed := 1
	{
		SendInput {g Down}
	}
	Return
}

$F13 Up::
{
	F13_pressed := 0
	SendInput {g Up}
	Return
}

*WheelUp::
{
	If (Layer=1)
	{
		If GetKeyState("Tab")
		{
			Send {WheelUp}
			Return
		}
		Else
		{
			SetkeyDelay, 0, 32
			Send {SC002}
			Sleep 100
			Return
		}
	}
	Return
}

*WheelDown::
{
	If (Layer=1)
	{
		If GetKeyState("Tab")
		{
			Send {WheelDown}
			Return
		}
		Else
		{
			SetkeyDelay, 0, 32
			Send {SC004}
			Sleep 100
			Return
		}
	}
	Return
}

$LControl::
{
	If (LControl_pressed)
		Return
	LControl_pressed := 1
	{
		Send {LControl}
		Sleep 400
	}
	Return
}

$LControl Up::
{
	LControl_pressed := 0
	Return
}

$LAlt::
{
	If (LAlt_pressed)
		Return
	LAlt_pressed := 1
	{
		Send {LControl}{LControl}
	}
	Return
}

$LAlt Up::
{
	LAlt_pressed := 0
	Return
}

#IfWinActive
	
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
	SendInput {XButton2 Up}
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
	SendInput {XButton1 Up}
	Return
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
		SendInput {F13 Down}
	}
	Return
}

$F13 Up::
{
	F13_pressed := 0
	SendInput {F13 Up}
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
		Send {F5 Down}
		KeyWait, a
		Send {F5 Up}
		Return
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
		Send {F8 Down}
		KeyWait, e
		Send {F8 Up}
		Return
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


#If WinActive("Fallout Shelter")
{
	Left::b
	/*
		SC002::F1
		SC003::F2
		SC004::F3
		SC005::F4
	*/
}
#IfWinActive