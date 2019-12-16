#SingleInstance force
#Persistent
;SetCapsLockState, AlwaysOff
;SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2

/*; Monitoring Windows
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
		MouseClick, left, 1952, 71
		MouseClick, left, 2016, 96
		BlockInput, Off	
		return
	}
	#IfWinExist
}
*/

{ ; AutoHotKey Script option.
	#F2::Suspend, Toggle
	#F4::ExitApp
}

#IfWinActive Deep Rock Galactic
	
*WheelUp::
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

*WheelDown::
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

#IfWinActive