#SingleInstance force
#Persistent
{
	Layer := 1
	CapsLock_pressed := 0
	
	Space_pressed := 0
	Down_pressed := 0
	Left_pressed := 0
	Right_pressed := 0
	
	Toggle_Right := 0
	
	SC029_pressed := 0
	Tab_pressed := 0
	LAlt_pressed := 0
	
	XButton2_pressed := 0
	XButton1_pressed := 0
	
	F13_pressed := 0
	
	SC002_pressed := 0
	SC003_pressed := 0
	SC004_pressed := 0
	SC005_pressed := 0
	
	a_pressed := 0
	e_pressed := 0
	
	r_pressed := 0
	f_pressed := 0
	
	w_pressed := 0
	x_pressed := 0
	c_pressed := 0
	v_pressed := 0
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
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
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

#IfWinActive ANNO 2070
	
*Right:: ; Toggle time deceleration
{
	If (Right_pressed)
		Return
	Right_pressed := 1
	If Toggle_Right = 0
	{
		Toggle_Right := 1
		SendInput {NumpadSub Down}
	}
	Else If Toggle_Right = 1
	{
		Toggle_Right := 0
		SendInput {NumpadSub Up}
	}
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
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{Down}{NumpadSub Down}
	}
	Else
	{
		SendInput {Down}
	}
	Return
}

*Down Up::
{
	Down_pressed := 0
	Return
}

*Space:: ; Centrer la caméra sur la dernière notification.
{
	If (Space_pressed)
		Return
	Space_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{Space}{NumpadSub Down}
	}
	Else
	{
		SendInput {Space}
	}
	Return
}

*Space Up::
{
	Space_pressed := 0
	Return
}

XButton2:: ; Quick save
{
	If (XButton2_pressed)
		Return
	XButton2_pressed := 1
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

XButton2 Up::
{
	XButton2_pressed := 0
	Return
}

XButton1:: ; Quick save
{
	If (XButton2_pressed)
		Return
	XButton1_pressed := 1
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

XButton1 Up::
{
	XButton1_pressed := 0
	Return
}

$Tab:: ; Faire défiler la sélection des Navires et centrer la caméra sur la sélection
{
	If (Tab_pressed)
		Return
	Tab_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{Tab}{NumpadSub Down}
	}
	Else
	{
		SendInput {Tab}
	}
	Return
}

$Tab Up::
{
	Tab_pressed := 0
	Return
}

LAlt & Tab:: ; Faire défiler les Navires et centrer la caméra sur eux.
{
	If (Tab_pressed)
		Return
	Tab_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{LControl Down}{k}{LControl Up}{NumpadSub Down}
	}
	Else
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

LControl & c:: ; Caméra sur et selection de l'Ark	
{
	If (c_pressed)
		Return
	c_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {Blind}{NumpadSub Up}{LControl Down}{c}{LControl Up}{NumpadSub Down}
		If GetKeyState("LControl", "P")
			SendInput {LControl Down}
	}
	Else
	{
		SendInput {LControl Down}{c}{LControl Up}
		If GetKeyState("LControl", "P")
			SendInput {LControl Down}
	}
	Return
}

LControl & c Up::
{
	c_pressed := 0
	Return
}

SC002:: ; Layer 1 = Faire défiler la sélection des Navires et centrer la caméra sur la sélection. Layer 2 = Vue carte postale.
{
	If (SC002_pressed)
		Return
	SC002_pressed := 1
	If (Layer = 1)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{LControl Down}{TAB}{LControl Up}{NumpadSub Down}
		}
		Else
		{
			SendInput {LControl Down}{TAB}{LControl Up}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{F1}{NumpadSub Down}
		}
		Else
		{
			SendInput {F1}
		}
	}
	Return
}

SC002 Up::
{
	SC002_pressed := 0
	Return
}

SC003:: ; Layer 1 = Décharger toutes les marchandises du véhicule dans l'entrepot à portée. Layer 2 = Vue carte postale.
{
	If (SC003_pressed)
		Return
	SC003_pressed := 1
	If (Toggle_Right = 1)
	{
		SendInput {NumpadSub Up}{l}{NumpadSub Down}
	}
	Else
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

LControl & f:: ; Faire défiler la sélection des Entrepôts et centrer la caméra sur la sélection
{
	If (f_pressed)
		Return
	f_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{LControl Down}{f}{LControl Up}{NumpadSub Down}
	}
	Else
	{
		SendInput {LControl Down}{f}{LControl Up}
	}
	Return
}

LControl & f Up::
{
	f_pressed := 0
	Return
}

LShift & f:: ; Faire défiler la sélection des Entrepôts sans déplacer la caméra
{
	If (f_pressed)
		Return
	f_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{LShift Down}{f}{LShift Up}{NumpadSub Down}
	}
	Else
	{
		SendInput {LShift Down}{f}{LShift Up}
	}
	Return
}

LShift & f Up::
{
	f_pressed := 0
	Return
}

LAlt & f:: ; Faire défiler la sélection des Entrepôts et centrer la caméra
{
	If (f_pressed)
		Return
	f_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{LAlt Down}{f}{LAlt Up}{NumpadSub Down}
	}
	Else
	{
		SendInput {LAlt Down}{f}{LAlt Up}
	}
	Return
}

LAlt & f Up::
{
	f_pressed := 0
	Return
}

Left:: ; Ouvrir la flotte de véhicule et les bâtiments.
{
	If (Left_pressed)
		return
	Left_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{F11}{NumpadSub Down}
	}
	Else
	{
		SendInput {F11}
	}
	Return
}

Left Up::
{
	Left_pressed := 0
	Return
}

SC029:: ; Déselectionner, menu.
{
	If (f_pressed)
		Return
	SC029_pressed := 1
	If Toggle_Right = 1
	{
		SendInput {NumpadSub Up}{esc}{NumpadSub Down}
	}
	Else
	{
		SendInput {esc}
	}
	Return
}

SC029 Up::
{
	SC029_pressed := 0
	Return
}

$w:: ; Layer 1 = Mode démolition. Layer 2 = Améliorer la Maison.
{
	If (w_pressed)
		Return
	w_pressed := 1
	If (Layer = 1)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{w}{NumpadSub Down}
		}
		Else
		{
			SendInput {w}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{u}{NumpadSub Down}
		}
		Else
		{
			SendInput {u}
		}
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
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{x Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {x Down}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{n Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {n Down}
		}
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

$r::
{
	If (r_pressed)
		Return
	r_pressed := 1
	If (Layer = 1)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{r Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {r Down}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{t Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {t Down}
		}
	}
	Return
}

$r Up::
{
	x_pressed := 0
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
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{f Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {f Down}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{g Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {g Down}
		}
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
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{c Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {c Down}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{, Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {, Down}
		}
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
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{v Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {v Down}
		}
	}
	If (Layer = 2)
	{
		If (Toggle_Right = 1)
		{
			SendInput {NumpadSub Up}{; Down}{NumpadSub Down}
		}
		Else
		{
			SendInput {; Down}
		}
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

#IfWinActive
	
{ ; Mouse
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
			Send {PgUp}
			Return
		}
		Else
		{
			SendInput {WheelUp}
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
			Send {PgDn}
			Return
		}
		Else
		{
			SendInput {WheelDown}
			Return
		}
		Return
	}
	
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
} ; Mouse

{ ; Keypad and/or Keyboard.
	$SC029::
	{
		If (SC029_pressed)
			Return
		SC029_pressed := 1
		If (Layer=1)
		{
			SendInput {SC029 Down}
		}
		If (Layer=2)
		{
			SendInput {esc Down}
		}
		Return
	}
	
	$SC029 Up::
	{
		SC029_pressed := 0
		If (Layer=1)
		{
			If (GetKeyState("esc"))
			{
				SendInput {esc Up}
			}
			Else
				SendInput {SC029 Up}
		}
		If (Layer=2)
		{
			If (GetKeyState("SC029"))
			{
				SendInput {SC029 Up}
			}
			Else
				SendInput {esc Up}
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
	
	$r::
	{
		If (Layer=1)
		{
			Send {r Down}
			KeyWait, r
			Send {r Up}
			Return
		}
		Else If (Layer=2)
		{
			KeyWait r, t0.100
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SendInput {y down}
				Sleep 32
				SendInput {y up}
				KeyWait, r
			}
			else
			{
				SendInput {t down}
				sleep 32
				SendInput {t up}
				KeyWait, r
			}
			return
		}
		Else
		{
			Send {r Down}
			KeyWait, r
			Send {r Up}
			Return
		}
		Return
	}
	
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
			Return
		}
		Else
		{
			Send {f Down}
			KeyWait, f
			Send {f Up}
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
} ; Keypad and/or Keyboard.

{ ; Keyboard
	
} ; Keyboard