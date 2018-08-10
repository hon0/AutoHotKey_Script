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
} ; End of AutoHotKey Script option.

/*
	#z::	
	PixelGetColor, color, 1889, 95
	MsgBox The color at X1889 Y95 is %color%.
	Clipboard = %color%
	return
*/

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

{ ; Layer modifier
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	Return	
}

#if Layer = 1
{
	;#if Layer = 1
	
	{ ; Mouse Remapping Layer 1
		XButton2::
		SetKeyDelay 32, 32
		send, ^'
		return
		
		XButton1::
		SetKeyDelay 32, 32
		send, ^"
		return
		
		{ ; Mouse Wheel Remapping Layer 1
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
	}
	
	{ ; Keyboard Remapping Layer 1
		{ ; z Reampping Layer 1
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
		
		{ ; x Reampping Layer 1
			$x::
			KeyWait x, t0.200
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				SendInput {n down}
				Sleep 32
				SendInput {n up}
				ControlSend, Edit4, ^a18, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
				ControlSend, Edit4, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			}
			else
			{
				SendInput {x down}
				sleep 32
				SendInput {x up}
				ControlSend, Edit4, ^a17, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
				ControlSend, Edit4, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
				return
			}
			return
			
		}
		
		{ ; c Remapping Layer 1
			$c::
			Send, {c Down}
			Sleep 32
			Send, {c Up}
			ControlSend, Edit4, ^a19, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			ControlSend, Edit4, {Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide.pdf - Foxit Reader
			return
		}
		
		#IfWinActive Settlers 7 Window
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
		#IfWinActive
			
	} ; End of Keyboard remapping	
}
#If ; End of If Layer 1	
	

{ ;#if Layer = 2 
	#if Layer = 2 
		
	{ ; Mouse Remapping Layer 2
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
	}
	
	{ ; Keyboard Remapping Layer 2
		q::&
		w::é
		e::"
		tab::esc
		
		{ ; f Remapping Layer 2
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
		
		{ ; r Remapping Layer 2
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
		
		#IfWinActive Settlers 7 Window
		{ ; x Remapping Layer 2
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
		
		{ ; c Remapping Layer 2
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
		#IfWinActive Settlers 7 Window
			
	} ; End of Keyboard Remapping Layer 2
	
	#If ; End of If Layer 2	
}

{ ;#if Layer = 3
	#if Layer = 3
		
	{ ; Mouse Remapping Layer 3
		LButton::F3
		RButton::F2
		XButton1::^F5
		XButton2::F5	
		
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
	}
	
	{ ; Keyboard Remapping Layer 3
		tab::AppsKey
		
		{ ; f Remapping Layer 3
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
		
		{ ; r Remapping Layer 3
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
	
	#If ; End of If Layer 3
}