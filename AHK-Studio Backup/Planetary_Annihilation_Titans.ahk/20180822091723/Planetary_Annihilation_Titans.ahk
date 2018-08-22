#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it
;#Warn  ; Enable warnings to assist with detecting common errors
Layer := 1 ; Layer initialization

InChat := 0 ; If InChat = 1 then keyboard operate normally

FighterFilter := 0
BomberFilter := 0
HeavyFilter := 0
TankFilter := 0
AssaultBotFilter := 0
RepairUnitFilter := 0
SupportFireFilter := 0
AirDefenseFilter := 0
NavalHeaviesFilter :=0
AntiShipShipFilter :=0
NavalSupportFireFilter :=0
NavalMiscellaneous := 0
ScoutFilter := 0
LandFabricatorFilter := 0
AirFabricatorFilter := 0
SeaFabricatorFilter := 0
OrbitalFabricatorFilter := 0

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
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
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
	KeyWait, F1, T0.2
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
		KeyWait, F1, D T0.2
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
	KeyWait F2, t0.1
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
	KeyWait F3, t0.1
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
	KeyWait F4, t0.1
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
	KeyWait SC002, t0.1
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
			Sendinput {F11}
			KeyWait &
		}
	}
	Else ; Cycle unit one by one
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{SC002}{MButton Down}
			KeyWait F4
		}
		Else
		{
			Sendinput {SC002}
			KeyWait &
		}
	}
	Return
}

$SC004:: ; Scout selection, See LButton Filter
{
	KeyWait, SC004, T0.1
	If (ErrorLevel) ; Select Skitter
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{SC004}{LControl Down}{Numpad1}{LControl Up}{MButton Down}
			ScoutFilter := 2
			KeyWait SC004
		}
		Else
		{
			Sendinput {SC004}{LControl Down}{Numpad1}{LControl Up}
			ScoutFilter := 2
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
				Sendinput {MButton Up}{SC004}{LControl Down}{Numpad2}{LControl Up}{MButton Down}
				ScoutFilter := 1
				KeyWait SC004
			}
			Else
			{
				Sendinput {SC004}{LControl Down}{Numpad2}{LControl Up}
				ScoutFilter := 1
				KeyWait SC004
			}
		}
		Else ; Select Hermes
		{
			If GetKeyState("MButton", "P")=1
			{
				Sendinput {MButton Up}{SC004}{LControl Down}{Numpad4}{LControl Up}{MButton Down}
				ScoutFilter := 3
				KeyWait SC004
			}
			Else
			{
				Sendinput {SC004}{LControl Down}{Numpad4}{LControl Up}
				ScoutFilter := 3
				KeyWait SC004
			}
		}
	}
	KeyWait, SC004
	Return
}

LAlt & SC004:: ; Only Scout in selection
{
	If GetKeyState("MButton", "P")=1
	{
		Sendinput {MButton Up}{LAlt Down}{Numpad3}{LAlt Up}{MButton Down}
		KeyWait SC004
	}
	Else
	{
		Sendinput {LAlt Down}{Numpad3}{LAlt Up}
		KeyWait SC004
	}
	Return
}

LAlt & f:: ; Air, Sea, Land Fabricator selection, See LButton Filter
{
	KeyWait, f, T0.150
	If (ErrorLevel) ; Select Air Fabricator
	{
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Up}{LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad2}{LControl Up}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			AirFabricatorFilter := 1
			KeyWait f
		}
		Else
		{
			SendInput {LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad2}{LControl Up}
			AirFabricatorFilter := 1
			KeyWait f
		}
	}
	Else 
	{
		KeyWait, f, D T0.150
		If (ErrorLevel) ; Select Land Fabricator
		{
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Up}{LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad1}{LControl Up}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				LandFabricatorFilter := 1
				KeyWait f
			}
			Else
			{
				SendInput {LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad1}{LControl Up}
				LandFabricatorFilter := 1
				KeyWait f
			}
		}
		Else ; Select Sea Fabricator
		{
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Up}{LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad3}{LControl Up}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				SeaFabricatorFilter := 1
				KeyWait f
			}
			Else
			{
				SendInput {LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad3}{LControl Up}
				SeaFabricatorFilter := 1
				KeyWait f
			}
		}
	}
	KeyWait, f
	Return
}

$f:: ; Oribtal Fabricator selection, See LButton Filter
{
	If (Layer=2)
	{
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Up}{LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad4}{LControl Up}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			OrbitalFabricatorFilter := 1
			KeyWait f
		}
		Else
		{
			SendInput {LAlt Down}{f}{LAlt Up}{LControl Down}{Numpad4}{LControl Up}
			OrbitalFabricatorFilter := 1
			KeyWait f
		}
	}
	Else
	{
		SendInput {f Down}
		KeyWait, f
		SendInput {f Up}
	}
	Return
}

SC005:: ; Fighter selection, See LButton Filter
{
	KeyWait, SC005, T0.1
	If (ErrorLevel) ; Select Phoenix
	{
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Up}{SC005}{SC005}{LControl Down}{Numpad2}{Numpad5}{LControl Up}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			FighterFilter := 2
			KeyWait SC005
		}
		Else
		{
			SendInput {SC005}{SC005}{LControl Down}{Numpad2}{Numpad5}{LControl Up}
			FighterFilter := 2
			KeyWait SC005
		}
	}
	Else ; Select HummmingBird
	{
		KeyWait, SC005, D T0.1
		If (ErrorLevel)
		{
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Up}{SC005}{SC005}{LControl Down}{Numpad2}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				FighterFilter := 1
				KeyWait SC005
			}
			Else
			{
				SendInput {SC005}{SC005}{LControl Down}{Numpad2}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
				FighterFilter := 1
				KeyWait SC005
			}
		}
		Else ; Select Avenger
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{SC005}{SC005}{LControl Down}{Numpad4}{LControl Up}{y}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				FighterFilter := 3
				KeyWait SC005
			}
			Else
			{
				Send {SC005}{SC005}{LControl Down}{Numpad4}{LControl Up}{y}
				FighterFilter := 3
				KeyWait SC005
			}
		}
	}
	KeyWait, SC005
	Return
}

SC006:: ; Air bomber selection, See LButton Filter
{
	KeyWait, SC006, T0.100
	If (ErrorLevel) ; Select Kestrel
	{
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Up}{LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
			Sleep 100
			Send {j}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			BomberFilter := 2
			KeyWait SC006
		}
		Else
		{
			SendInput {LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
			Sleep 100
			Send {j}
			BomberFilter := 2
			KeyWait SC006
		}
	}
	Else 
	{
		KeyWait, SC006, D T0.100
		If (ErrorLevel) ; Select BumbleBee
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
				Sleep 67
				Send {u}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				BomberFilter := 1
				KeyWait SC006
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
				Sleep 67
				Send {u}
				BomberFilter := 1
				KeyWait SC006
			}
		}
		Else ; Select Hornet
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
				Sleep 67
				Send {k}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				BomberFilter := 3
				KeyWait SC006
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}{k}
				Sleep 67
				Send {k}
				BomberFilter := 3
				KeyWait SC006
			}
		}
	}
	KeyWait, SC006
	Return
}

F13:: ; Heavies selection, See LButton Filter
{
	KeyWait, F13, T0.150
	If (ErrorLevel) ; Select Vanguard
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
			Sleep 67
			Send {j}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			HeavyFilter := 2
			KeyWait F13
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
			Sleep 67
			Send {j}
			HeavyFilter := 2
			KeyWait F13
		}
	}
	Else 
	{
		KeyWait, F13, D T0.150
		If (ErrorLevel) ; Select Inferno
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
				Sleep 67
				Send {u}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				HeavyFilter := 1
				KeyWait F13
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
				Sleep 67
				Send {u}
				HeavyFilter := 1
				KeyWait F13
			}
		}
		Else ; Select Spark
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
				Sleep 67
				Send {p}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				HeavyFilter := 3
				KeyWait F13
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad8}{LControl Up}
				Sleep 67
				Send {p}
				HeavyFilter := 3
				KeyWait F13
			}
		}
	}
	KeyWait, F13
	Return
}

SC029 & F13:: ; Naval heavies, See LButton Filter
{
	KeyWait, F13, T0.150
	If (ErrorLevel) ; Select Leviathan
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {h}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			NavalHeaviesFilter := 2
			KeyWait F13
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {h}
			NavalHeaviesFilter := 2
			KeyWait F13
		}
	}
	Else 
	{
		KeyWait, F13, D T0.150
		If (ErrorLevel) ; Select Orca
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {u}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalHeaviesFilter := 1
				KeyWait F13
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {u}
				NavalHeaviesFilter := 1
				KeyWait F13
			}
		}
		Else ; Select Typhoon
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalHeaviesFilter := 3
				KeyWait F13
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				NavalHeaviesFilter := 3
				KeyWait F13
			}
		}
	}
	KeyWait, F13
	Return
}

F14:: ; Tank selection, See LButton Filter
{
	KeyWait, F14, T0.150
	If (ErrorLevel) ; Select Leveler
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {h}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			TankFilter := 2
			KeyWait F14
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {h}
			TankFilter := 2
			KeyWait F14
		}
	}
	Else 
	{
		KeyWait, F14, D T0.150
		If (ErrorLevel) ; Select Ant
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {y}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				TankFilter := 1
				KeyWait F14
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {y}
				TankFilter := 1
				KeyWait F14
			}
		}
		Else ; Select Drifter
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {p}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				TankFilter := 3
				KeyWait F14
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {p}
				TankFilter := 3
				KeyWait F14
			}
		}
	}
	KeyWait, F14
	Return
}

SC029 & F14:: ; Anti Ship Ship, See LButton Filter
{
	KeyWait, F14, T0.150
	If (ErrorLevel) ; Select Kraken
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {k}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			AntiShipShipFilter := 2
			KeyWait F14
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {k}
			AntiShipShipFilter := 2
			KeyWait F14
		}
	}
	Else 
	{
		KeyWait, F14, D T0.150
		If (ErrorLevel) ; Select Barracuda
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {i}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				AntiShipShipFilter := 1
				KeyWait F14
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {i}
				AntiShipShipFilter := 1
				KeyWait F14
			}
		}
		Else ; Select Typhoon
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalHeaviesFilter := 3
				KeyWait F14
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				NavalHeaviesFilter := 3
				KeyWait F14
			}
		}
	}
	KeyWait, F14
	Return
}

F15:: ; Assault Bot selection, See LButton Filter
{
	KeyWait, F15, T0.1
	If (ErrorLevel) ; Select Slammer
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
			Sleep 67
			Send {h}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			AssaultBotFilter := 2
			KeyWait F15
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
			Sleep 67
			Send {h}
			AssaultBotFilter := 2
			KeyWait F15
		}
	}
	Else 
	{
		KeyWait, F15, D T0.1
		If (ErrorLevel) ; Select Dox
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {y}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				AssaultBotFilter := 1
				KeyWait F15
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {y}
				AssaultBotFilter := 1
				KeyWait F15
			}
		}
		Else ; Select Drifter
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {m}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				AssaultBotFilter := 3
				KeyWait F15
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {m}
				AssaultBotFilter := 3
				KeyWait F15
			}
		}
	}
	KeyWait, F15
	Return
}

SC029 & F15:: ; Naval support fire, See LButton Filter
{
	KeyWait, F15, T0.150
	If (ErrorLevel) ; Select Stingray
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {j}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			NavalSupportFireFilter := 2
			KeyWait F15
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {j}
			NavalSupportFireFilter := 2
			KeyWait F15
		}
	}
	Else 
	{
		KeyWait, F15, D T0.150
		If (ErrorLevel) ; Select Narwhal
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {y}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalSupportFireFilter := 1
				KeyWait F15
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {y}
				NavalSupportFireFilter := 1
				KeyWait F15
			}
		}
		Else ; Select Typhoon
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalSupportFireFilter := 3
				KeyWait F15
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {n}
				NavalSupportFireFilter := 3
				KeyWait F15
			}
		}
	}
	KeyWait, F15
	Return
}

F16:: ; Support Fire Bot selection, See LButton Filter
{
	KeyWait, F16, T0.1
	If (ErrorLevel) ; Select Sheller
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {k}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			SupportFireFilter := 2
			KeyWait F16
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {k}
			SupportFireFilter := 2
			KeyWait F16
		}
	}
	Else 
	{
		KeyWait, F16, D T0.1
		If (ErrorLevel) ; Select Grenadier
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {u}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				SupportFireFilter := 1
				KeyWait F16
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {u}
				SupportFireFilter := 1
				KeyWait F16
			}
		}
		Else ; Select BlueHawk
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {l}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				SupportFireFilter := 3
				KeyWait F16
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {l}
				SupportFireFilter := 3
				KeyWait F16
			}
		}
	}
	KeyWait, F16
	Return
}

SC029 & F16:: ; Naval miscellaneous, See LButton Filter
{
	KeyWait, F16, T0.150
	If (ErrorLevel) ; Select Kaiju
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {l}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			NavalMiscellaneous := 2
			KeyWait F16
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
			Sleep 67
			Send {l}
			NavalMiscellaneous := 2
			KeyWait F16
		}
	}
	Else 
	{
		KeyWait, F16, D T0.150
		If (ErrorLevel) ; Select Piranha
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {o}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalMiscellaneous := 1
				KeyWait F16
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {o}
				NavalMiscellaneous := 1
				KeyWait F16
			}
		}
		Else ; Select Barnacle
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {p}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				NavalMiscellaneous := 3
				KeyWait F16
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F11}{LShift Up}{Numpad3}{LControl Up}
				Sleep 67
				Send {p}
				NavalMiscellaneous := 3
				KeyWait F16
			}
		}
	}
	KeyWait, F16
	Return
}

F17:: ; Air Defense selection, See LButton Filter
{
	KeyWait, F17, T0.1
	If (ErrorLevel) ; Select Storm
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {l}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			AirDefenseFilter := 2
			KeyWait F17
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
			Sleep 67
			Send {l}
			AirDefenseFilter := 2
			KeyWait F17
		}
	}
	Else 
	{
		KeyWait, F17, D T0.1
		If (ErrorLevel) ; Select Spinner
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {o}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				AirDefenseFilter := 1
				KeyWait F17
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad9}{LControl Up}
				Sleep 67
				Send {o}
				AirDefenseFilter := 1
				KeyWait F17
			}
		}
		Else ; Select Gil-E
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {j}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				AirDefenseFilter := 3
				KeyWait F17
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {j}
				AirDefenseFilter := 3
				KeyWait F17
			}
		}
	}
	KeyWait, F17
	Return
}

F18:: ; Repair unit selection, See LButton Filter
{
	KeyWait, F18, T0.150
	If (ErrorLevel) ; Select Mend
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
			Sleep 67
			Send {k}
			If GetKeyState("MButton", "P")=1
			{
				SendInput {MButton Down}
			}
			RepairUnitFilter := 2
			KeyWait F18
		}
		Else
		{
			Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
			Sleep 67
			Send {k}
			RepairUnitFilter := 2
			KeyWait F18
		}
	}
	Else 
	{
		KeyWait, F18, D T0.150
		If (ErrorLevel) ; Select Sticht
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {i}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				RepairUnitFilter := 1
				KeyWait F18
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F10}{LShift Up}{Numpad6}{LControl Up}
				Sleep 67
				Send {i}
				RepairUnitFilter := 1
				KeyWait F18
			}
		}
		Else ; Select Angel
		{
			If GetKeyState("MButton", "P")=1
			{
				Send {MButton Up}{LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
				Sleep 67
				Send {n}
				If GetKeyState("MButton", "P")=1
				{
					SendInput {MButton Down}
				}
				RepairUnitFilter := 3
				KeyWait F18
			}
			Else
			{
				Send {LControl Down}{LShift Down}{F9}{LShift Up}{LControl Up}
				Sleep 67
				Send {n}
				RepairUnitFilter := 3
				KeyWait F18
			}
		}
	}
	KeyWait, F18
	Return
}

LControl & z:: ; Select all matching unit on screen then on planet
{
	If GetKeyState("MButton", "P")=1
	{
		Sendinput {MButton Up}{LControl down}{LAlt Down}{z}{LAlt Up}{LControl up}
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Down}
		}
	}
	Else
	{
		Sendinput {LControl down}{LAlt Down}{z}{LAlt Up}{LControl up}
	}
	Return
}

LControl & s:: ; Clear buld queue then stop
{
	If GetKeyState("MButton", "P")=1
	{
		Sendinput {MButton Up}{esc}
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Down}
		}
	}
	Else
	{
		Sendinput {esc}
	}
	KeyWait s
	Return
}

Tab:: ; Cycle unit in selection and center on it
{
	If GetKeyState("MButton", "P")=1
	{
		Send {MButton Up}{&}{F11}
		If GetKeyState("MButton", "P")=1
		{
			SendInput {MButton Down}
		}
	}
	Else
	{
		Sendinput {&}{F11}
	}
	KeyWait Tab
	Return
}

$LButton:: ; Selection Filter
{
	If LandFabricatorFilter = 1 ; Selection filter Land Fabricator
	{
		Sendinput {LButton Up}{Backspace}{LButton Down}{LShift Down}
	}
	Else	If AirFabricatorFilter = 1 ; Selection filter Air Fabricator
	{
		Sendinput {LButton Up}{Backspace}{LButton Down}{LShift Down}
	}
	Else	If SeaFabricatorFilter = 1 ; Selection filter Sea Fabricator
	{
		Sendinput {LButton Up}{Backspace}{LButton Down}{LShift Down}
	}
	Else	If OrbitalFabricatorFilter = 1 ; Selection filter Sea Fabricator
	{
		Sendinput {LButton Up}{Backspace}{LButton Down}{LShift Down}
	}
	Else
	{
		Send {LButton Down}
		KeyWait, LButton
		Send {LButton Up}
	}
	Return
}

~LButton Up:: ; Selection filter
{
	If FighterFilter = 2 ; Selection filter Phoenix
	{
		Sleep 67
		SendInput {LControl Down}{Numpad2}{Numpad5}{LControl Up}
		Send {h}
		FighterFilter := 0
		Return
	}	
	Else	If FighterFilter = 1 ; Selection filter HummmingBird
	{
		Sleep 67
		SendInput {LControl Down}{Numpad2}{LControl Up}
		;Sleep 32
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
	Else	If HeavyFilter = 2 ; Selection filter Vanguard
	{
		Sleep 67
		Send {LControl Down}{Numpad8}{LControl Up}
		Sleep 32
		Send {j}
		HeavyFilter := 0
		Return
	}
	Else	If HeavyFilter = 1 ; Selection filter Inferno
	{
		Sleep 67
		Send {LControl Down}{Numpad8}{LControl Up}
		Sleep 32
		Send {u}
		HeavyFilter := 0
		Return
	}
	Else	If HeavyFilter = 3 ; Selection filter Spark
	{
		Sleep 67
		Send {LControl Down}{Numpad8}{LControl Up}
		Sleep 32
		Send {p}
		HeavyFilter := 0
		Return
	}
	Else	If TankFilter = 2 ; Selection filter Leveler
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 32
		Send {h}
		TankFilter := 0
		Return
	}
	Else	If TankFilter = 1 ; Selection filter Ant
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 32
		Send {y}
		TankFilter := 0
		Return
	}
	Else	If TankFilter = 3 ; Selection filter Drifter
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 32
		Send {p}
		TankFilter := 0
		Return
	}
	Else	If AssaultBotFilter = 2 ; Selection filter Slammer
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 32
		Send {h}
		AssaultBotFilter := 0
		Return
	}
	Else	If AssaultBotFilter = 1 ; Selection filter Dox
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 32
		Send {y}
		AssaultBotFilter := 0
		Return
	}
	Else	If AssaultBotFilter = 3 ; Selection filter Locusts
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 32
		Send {m}
		AssaultBotFilter := 0
		Return
	}
	Else	If SupportFireFilter = 2 ; Selection filter Sheller
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 32
		Send {k}
		SupportFireFilter := 0
		Return
	}
	Else	If SupportFireFilter = 1 ; Selection filter Grenadier
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 32
		Send {u}
		SupportFireFilter := 0
		Return
	}
	Else	If SupportFireFilter = 3 ; Selection filter BlueHawk
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 32
		Send {l}
		SupportFireFilter := 0
		Return
	}
	Else	If RepairUnitFilter = 2 ; Selection filter Mend
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 67
		Send {k}
		RepairUnitFilter := 0
		Return
	}
	Else	If RepairUnitFilter = 1 ; Selection filter Sticht
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 67
		Send {i}
		RepairUnitFilter := 0
		Return
	}
	Else	If RepairUnitFilter = 3 ; Selection filter Angel
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 67
		Send {n}
		RepairUnitFilter := 0
		Return
	}
	Else	If AirDefenseFilter = 2 ; Selection filter Storm
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 67
		Send {l}
		AirDefenseFilter := 0
		Return
	}
	Else	If AirDefenseFilter = 1 ; Selection filter Spinner
	{
		Sleep 67
		Send {LControl Down}{Numpad9}{LControl Up}
		Sleep 67
		Send {o}
		AirDefenseFilter := 0
		Return
	}
	Else	If AirDefenseFilter = 3 ; Selection filter Gil-E
	{
		Sleep 67
		Send {LControl Down}{Numpad6}{LControl Up}
		Sleep 67
		Send {j}
		AirDefenseFilter := 0
		Return
	}
	Else	If NavalHeaviesFilter = 2 ; Selection filter Leviathan
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {h}
		NavalHeaviesFilter := 0
		Return
	}
	Else	If NavalHeaviesFilter = 1 ; Selection filter Orca
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {u}
		NavalHeaviesFilter := 0
		Return
	}
	Else	If NavalHeaviesFilter = 3 ; Selection filter Typhoon
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {n}
		NavalHeaviesFilter := 0
		Return
	}
	Else	If AntiShipShipFilter = 2 ; Selection filter Kraken
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {k}
		AntiShipShipFilter := 0
		Return
	}
	Else	If AntiShipShipFilter = 1 ; Selection filter Barracuda
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {i}
		AntiShipShipFilter := 0
		Return
	}
	Else	If AntiShipShipFilter = 3 ; Selection filter Typhoon
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {n}
		AntiShipShipFilter := 0
		Return
	}
	Else	If NavalSupportFireFilter = 2 ; Selection filter Stingray
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {j}
		NavalSupportFireFilter := 0
		Return
	}
	Else	If NavalSupportFireFilter = 1 ; Selection filter Narwhal
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {y}
		NavalSupportFireFilter := 0
		Return
	}
	Else	If NavalSupportFireFilter = 3 ; Selection filter Typhoon
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {n}
		NavalSupportFireFilter := 0
		Return
	}
	Else	If NavalMiscellaneous = 2 ; Selection filter Kaiju
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {l}
		NavalMiscellaneous := 0
		Return
	}
	Else	If NavalMiscellaneous = 1 ; Selection filter Piranha
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {o}
		NavalMiscellaneous := 0
		Return
	}
	Else	If NavalMiscellaneous = 3 ; Selection filter Barnacle
	{
		Sleep 67
		Send {LControl Down}{Numpad3}{LControl Up}
		Sleep 67
		Send {p}
		NavalMiscellaneous := 0
		Return
	}
	Else	If ScoutFilter = 2 ; Selection filter Skitter
	{
		Sleep 67
		Send {LControl Down}{Numpad1}{Numpad9}{LControl Up}
		Sleep 67
		Send {i}
		ScoutFilter := 0
		Return
	}
	Else	If ScoutFilter = 1 ; Selection filter FireFly
	{
		Sleep 67
		Send {LControl Down}{Numpad2}{LControl Up}
		Sleep 67
		Send {i}
		ScoutFilter := 0
		Return
	}
	Else	If ScoutFilter = 3 ; Selection filter Hermes
	{
		Sleep 67
		Send {LControl Down}{Numpad4}{LControl Up}
		Sleep 67
		Send {o}
		ScoutFilter := 0
		Return
	}
	Else	If AirFabricatorFilter = 1 ; Selection filter Air Fabricator
	{
		Send {LButton Up}{LShift Up}{LControl Down}{Numpad2}{f}{LControl Up}
		AirFabricatorFilter := 0
		Return
	}
	Else	If LandFabricatorFilter = 1 ; Selection filter Land Fabricator
	{
		Send {LButton Up}{LShift Up}{LControl Down}{Numpad1}{f}{i}{k}{LControl Up}
		LandFabricatorFilter := 0
		Return
	}
	Else	If SeaFabricatorFilter = 1 ; Selection filter Sea Fabricator
	{
		Send {LButton Up}{LShift Up}{LControl Down}{Numpad3}{f}{p}{LControl Up}
		SeaFabricatorFilter := 0
		Return
	}
	Else	If OrbitalFabricatorFilter = 1 ; Selection filter Orbital Fabricator
	{
		SendInput {LButton Up}{LShift Up}{LControl Down}{Numpad4}{f}{LControl Up}
		OrbitalFabricatorFilter := 0
		Return
	}
	Return
}