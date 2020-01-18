#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
CapsLock_pressed := 0

c_pressed := 0
d_pressed := 0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
;#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1.
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

$*c::
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

$*c Up::
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