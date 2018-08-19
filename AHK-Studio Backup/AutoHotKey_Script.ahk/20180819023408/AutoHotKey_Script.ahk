#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
;#MaxHotkeysPerInterval 500
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
}

{ ; AutoHotKey Script option.
	#F1::Suspend, Toggle
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

{ ; Layer checker
	/*
		#z::
		ToolTip %Layer%
		SetTimer, RemoveToolTip, 2000
		return
		
		RemoveToolTip:
		SetTimer, RemoveToolTip, Off
		ToolTip
		return
	*/
}

{ ; Layer modifier
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 333)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	Return
}

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
		Send {PgDn}
		Return
	}
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
		Send {PGUP}
		Return
	}
	Else
	{
		Send {WheelDown}
		Return
	}
	Return
}

LButton::F1
RButton::F2
XButton1::F3
XButton2::F4

PGUP::Insert
PGDN::Del

tab::esc
w::b
x::n
c::,
v::Del

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
		{
			SendInput {g down}
			sleep 32
			SendInput {g up}
			KeyWait, f
		}
		return
	}
	Else if (Layer=3)
	{
		KeyWait f, t0.100
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
	Else
	{
		Send {f Down}
		KeyWait, f
		Send {f Up}
		Return
	}
}


{ ;HotStrings
	
:*:ahk::AutoHotKey
	
}
