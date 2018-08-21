#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it
;#Warn  ; Enable warnings to assist with detecting common errors
Layer := 1 ; Layer initialization.
InChat := 0 ; If InChat = 1 then keyboard operate normally
FighterFilter := 0
BomberFilter := 0
HeavyFilter := 0
AssaultBotFilter := 0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds)
;#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
;CoordMode, mouse, Screen

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

{ ; AutoHotKey Script option
	#F1::Suspend, Toggle
	#F4::ExitApp
} ; AutoHotKey Script option

{ ; Testing
	
	/* ; If prior key ""
		{ ; If prior key ""
			m::
			Send o
			If (A_PriorKey = "space")
				SendInput {p}
			return
		}
		Else
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
				If color = 0x213A70
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
		Else {
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
				If (count = 1)
				{
					Send {F1}
				}
				Else If (count = 2)
				{
					Send {F2}
				}
				Else If (count = 3)
				{
					Send {F3}
				}
				count := 0
			}
			return
		}
	*/	
}

{ ; Layer modIfier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	keyEnter = 0
	Return
}

XButton1:: ; XButton1, Fire mode selector
{
	KeyWait, XButton1, T0.2
	If (ErrorLevel) ; Hold Fire
	{
		Send {RAlt Down}{F11}{RAlt Up}
	}
	Else {
		KeyWait, XButton1, D T0.2
		
		If (ErrorLevel) ; Fire at will
		{
			Send {RAlt Down}{F9}{RAlt Up}
		}
		Else ; Return Fire
		{
			Send {RAlt Down}{F10}{RAlt Up}
		}
	}
	KeyWait, XButton1
	return
}

XButton2:: ; XButton2, Move mode selector
{
	KeyWait, XButton2, T0.2
	If (ErrorLevel) ; Hold Position
	{
		Send {LControl Down}{F11}{LControl Up}
	}
	Else {
		KeyWait, XButton2, D T0.2
		If (ErrorLevel) ; Maneuver
		{
			Send {LControl Down}{F9}{LControl Up}
		}
		Else ; Roam
		{
			Send {LControl Down}{F10}{LControl Up}
		}
	}
	KeyWait, XButton2
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
	Else If (Layer=2)
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
	Else If (Layer=2)
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

F1:: ; Short press to select normal Land factories, Long press to select advanced Land factories, Double press to select ammo factories
{
	KeyWait, F1, T0.1
	If (ErrorLevel) ; Select advanced Land factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad1}{f}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}{MButton Down}
			KeyWait F1
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad1}{f}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}
			KeyWait F1
		}
	}
	Else ; Select normal Land factories
	{
		KeyWait, F1, D T0.1
		If (ErrorLevel)
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{F1}{Numpad1}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}{MButton Down}
				KeyWait F1
			}
			Else
			{
				Sendinput {LControl Down}{F1}{Numpad1}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}
				KeyWait F1
			}
		}
		Else ; Select ammo Land factories
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{F1}{Numpad1}{LAlt Down}{f}{LAlt Up}{LControl Up}{MButton Down}
				KeyWait F1
			}
			Else
			{
				Sendinput {LControl Down}{F1}{Numpad1}{LAlt Down}{f}{LAlt Up}{LControl Up}
				KeyWait F1
			}
		}
	}
	KeyWait, F1
	Return
}

LAlt & F1:: ; Select Unit cqnon
{
	If GetKeyState("MButton", "P")=1
	{
		Sendinput {MButton Up}{LControl Down}{F1}{LAlt Down}{f}{Numpad1}{LAlt Up}{LControl Up}{MButton Down}
		KeyWait F1
		Return
	}
	Else
	{
		Sendinput {LControl Down}{F1}{LAlt Down}{f}{Numpad1}{LAlt Up}{LControl Up}
		KeyWait F1
		Return
	}
}

F2:: ; Short press to select normal Air factories, Long press to select advanced Air factories
{
	KeyWait F2, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel ; Select advanced Air factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad2}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}{MButton Down}
			KeyWait F2
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad2}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}
			KeyWait F2
		}
	}
	Else ; Select normal Air factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}{MButton Down}
			KeyWait F2
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
			KeyWait F2
		}
	}
	Return
}

F3:: ; Short press to select normal naval factories, Long press to select advanced naval factories
{
	KeyWait F3, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel ; Select normal naval factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad3}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}{MButton Down}
			KeyWait F3
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad3}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}
			KeyWait F3
		}
	}
	Else ; select advanced naval factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad3}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}{MButton Down}
			KeyWait F3
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad3}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
			KeyWait F3
		}
	}
	Return
}

F4:: ; Short press to select normal Orbital factories, Long press to select advanced Orbital factories
{
	KeyWait F4, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel ; Select normal Orbital factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad4}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}{MButton Down}
			KeyWait F4
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad4}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}
			KeyWait F4
		}
	}
	Else ; Select normal Orbital factories
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad4}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}{MButton Down}
			KeyWait F4
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad4}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
			KeyWait F4
		}
	}
	Return
}

$&:: ; Cycle unit one by one, long press to center on selection
{
	KeyWait SC002, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel ; Track selection
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{F11}{MButton Down}
			KeyWait F4
		}
		Else
		{
			Send {F11}
			KeyWait &
		}
	}
	Else ; Cycle unit one by one
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{SC002}{MButton Down}
			KeyWait F4
		}
		Else
		{
			Send {SC002}
			KeyWait &
		}
	}
	Return
}

$SC004:: ; Scout selection
{
	KeyWait, SC004, T0.1
	If (ErrorLevel) ; Select Skitter
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{SC004}{LControl Down}{Numpad1}{LControl Up}{MButton Down}
			KeyWait SC004
		}
		Else
		{
			Send {SC004}{LControl Down}{Numpad1}{LControl Up}
			KeyWait SC004
		}
	}
	Else 
	{
		KeyWait, SC004, D T0.1
		If (ErrorLevel) ; Select FireFly
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{SC004}{LControl Down}{Numpad2}{LControl Up}{MButton Down}
				KeyWait SC004
			}
			Else
			{
				Send {SC004}{LControl Down}{Numpad2}{LControl Up}
				KeyWait SC004
			}
		}
		Else ; Select Hermes
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{SC004}{LControl Down}{Numpad4}{LControl Up}{MButton Down}
				KeyWait SC004
			}
			Else
			{
				Send {SC004}{LControl Down}{Numpad4}{LControl Up}
				KeyWait SC004
			}
		}
	}
	KeyWait, SC004
	Return
}

*SC005:: ; Fighter selection, See LButton Filter
{
	KeyWait, SC005, T0.1
	If (ErrorLevel) ; Select Phoenix
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{SC005}{SC005 Down}{MButton Down} 
			FighterFilter := 2
			KeyWait SC005
			Send {SC005 Up}
		}
		Else
		{
			Send {SC005}{SC005 Down}
			FighterFilter := 2
			KeyWait SC005
			Send {SC005 Up}
		}
	}
	Else ; Select HummmingBird
	{
		KeyWait, SC005, D T0.1
		If (ErrorLevel)
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{SC005}{SC005 Down}{MButton Down} 
				FighterFilter := 1
				KeyWait SC005
			}
			Else
			{
				Send {SC005}{SC005}
				FighterFilter := 1
				KeyWait SC005
			}
		}
		Else ; Select Avenger
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{SC005}{SC005 Down}{MButton Down} 
				FighterFilter := 3
				KeyWait SC005
			}
			Else
			{
				Send {SC005}{SC005}
				FighterFilter := 3
				KeyWait SC005
			}
		}
	}
	KeyWait, SC005
	Return
}

*SC006:: ; Air bomber selection, See LButton Filter
{
	KeyWait, SC006, T0.1
	If (ErrorLevel) ; Select Kestrel
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}{MButton Down} 
			BomberFilter := 2
			KeyWait SC006
		}
		Else
		{
			Sendinput {LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}
			BomberFilter := 2
			KeyWait SC006
		}
	}
	Else 
	{
		KeyWait, SC006, D T0.1
		If (ErrorLevel) ; Select BumbleBee
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}{MButton Down} 
				BomberFilter := 1
				KeyWait SC006
			}
			Else
			{
				Sendinput {LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}
				BomberFilter := 1
				KeyWait SC006
			}
		}
		Else ; Select Hornet
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}{MButton Down} 
				BomberFilter := 3
				KeyWait SC006
			}
			Else
			{
				Sendinput {LControl Down}{LShIft Down}{F9}{LShIft Up}{LControl Up}
				BomberFilter := 3
				KeyWait SC006
			}
		}
	}
	KeyWait, SC006
	Return
}

F13:: ; Scout selection
{
	KeyWait, F13, T0.1
	If (ErrorLevel) ; Select Vanguard
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}{MButton Down}
			BomberFilter := 2
			KeyWait F13
		}
		Else
		{
			Sendinput {LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}
			BomberFilter := 2
			KeyWait F13
		}
	}
	Else 
	{
		KeyWait, F13, D T0.1
		If (ErrorLevel) ; Select Inferno
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}{MButton Down}
				BomberFilter := 1
				KeyWait F13
			}
			Else
			{
				Sendinput {LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}
				BomberFilter := 1
				KeyWait F13
			}
		}
		Else ; Select Spark
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}{MButton Down}
				BomberFilter := 3
				KeyWait F13
			}
			Else
			{
				Sendinput {LControl Down}{LShIft Down}{F10}{LShIft Up}{Numpad8}{LControl Up}
				BomberFilter := 3
				KeyWait F13
			}
		}
	}
	KeyWait, F13
	Return
}

LControl & z:: ; Select all matching unit on screen then on planet
{
	Sendinput {LControl down}{LAlt Down}{z}{LAlt Up}{LControl up}
	Return
}

LControl & s:: ; Clear buld queue then stop
{
	Send {esc}
	KeyWait s
	Return
}

Tab:: ; Cycle unit in selection and center on it
{
	Send {&}{F11}
	KeyWait Tab
	Return
}

~LButton Up:: ; Selection filter
{
	If GetKeyState("F13", "P")=1 ; Remove Land from Selection
	{
		Send {LControl Down}{LAlt Down}{Numpad1}{LAlt Up}{LControl Up}
		Return
	}
	Else	If GetKeyState("F14", "P")=1 ; Selection filter ?
	{
		Send {u}
		Return
	}
	Else	If GetKeyState("F15", "P")=1 ; Selection filter ?
	{
		Send {u}
		Return
	}
	Else	If GetKeyState("F16", "P")=1 ; Selection filter ?
	{
		Send {u}
		Return
	}
	Else	If GetKeyState("F17", "P")=1 ; Selection filter ?
	{
		Send {u}
		Return
	}
	Else	If GetKeyState("F18", "P")=1 ; Selection filter ?
	{
		Send {u}
		Return
	}
	Else	If FighterFilter = 2 ; Selection filter Phoenix
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {h}
		FighterFilter := 0
		Return
	}	
	Else	If FighterFilter = 1 ; Selection filter HummmingBird
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {y}
		FighterFilter := 0
		Return
	}
	Else	If FighterFilter = 3 ; Selection filter Avenger
	{
		Sleep 67
		Send {LControl Down}{Numpad4}{LControl Up}
		Sleep 32
		Send {y}
		FighterFilter := 0
		Return
	}
	Else	If BomberFilter = 2 ; Selection filter Kestrel
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {j}
		BomberFilter := 0
		Return
	}
	Else	If BomberFilter = 1 ; Selection filter BumbleBee
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {u}
		BomberFilter := 0
		Return
	}
	Else	If BomberFilter = 3 ; Selection filter Hornet
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {k}
		BomberFilter := 0
		Return
	}
	Else	If HeavyFilter = 2 ; Selection filter Phoenix
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {j}
		HeavyFilter := 0
		Return
	}
	Else	If HeavyFilter = 1 ; Selection filter Phoenix
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {u}
		HeavyFilter := 0
		Return
	}
	Else	If HeavyFilter = 3 ; Selection filter Phoenix
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 32
		Send {p}
		HeavyFilter := 0
		Return
	}
	Return
}
