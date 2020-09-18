#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.

;#InstallKeybdHook
;#InstallMouseHook

;6Joy   = T16000L ;

;Testing

/*
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
*/

/*
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

/*
	
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

;Testing

$g::
KeyWait g, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {h down}
	KeyWait g
	SendInput {h up}
}
else
{
	SendInput {g down}
	sleep 32
	SendInput {g up}
}
return

$k::
KeyWait k, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {l down}
	KeyWait k
	SendInput {l up}
}
else
{
	SendInput {k down}
	sleep 32
	SendInput {k up}
}
return



;EscapeFromTarkov

;#IfWinActive EscapeFromTarkov

~WheelUp:: 
	SetkeyDelay,32, 32
		If GetKeyState("MButton") 
			send {PGUP}
	
		Else
			If GetKeyState("Space") 
				send {Home}
		Else
			If (GetKeyState("6Joy1")==1)
				send g
	Return
	
~WheelDown:: 
	SetkeyDelay,32, 32
		If GetKeyState("MButton") 
			send {PGDN}
	
		Else 
			If GetKeyState("Space") 
				send {End}
	Return


;#IfWinActive EscapeFromTarkov
XButton2::
SetKeyDelay 32, 32
send ^t
Return

XButton1::t

~Right & LButton::F1
Return

~Right & RButton::F2
Return

~Right & XButton1::F3
Return

~Right & XButton2::F4
Return

~Right & WheelUp::
send, {F5}
Sleep, 100
Return

~Right & WheelDown::
send, {F6}
Sleep, 100
Return

~Right & MButton::F7
Return

~Right & F8::F9
Return

~Right & F9::F10
Return
#IfWinActive

capslock::
KeyWait, capslock, T0.200
SetKeyDelay, 32, 32
If ErrorLevel
	Send, {NumpadDot}
else
	Send, {Numpad0}
return


$SC002::
KeyWait SC002, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC007 down}
	KeyWait SC002
	SendInput {SC007 up}
}
else
{
	SendInput {SC002 down}
	sleep 32
	SendInput {SC002 up}
}
return

$SC003::
KeyWait SC003, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC008 down}
	KeyWait SC003
	SendInput {SC008 up}
}
else
{
	SendInput {SC003 down}
	sleep 32
	SendInput {SC003 up}
}
return

$SC004::
KeyWait SC004, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC009 down}
	KeyWait SC004
	SendInput {SC009 up}
}
else
{
	SendInput {SC004 down}
	sleep 32
	SendInput {SC004 up}
}
return

$SC005::
KeyWait SC005, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC00A down}
	KeyWait SC005
	SendInput {SC00A up}
}
else
{
	SendInput {SC005 down}
	sleep 32
	SendInput {SC005 up}
}
return

$SC006::
KeyWait SC006, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC00B down}
	KeyWait SC006
	SendInput {SC00B up}
}
else
{
	SendInput {SC006 down}
	sleep 32
	SendInput {SC006 up}
}
return

$SC007::
KeyWait SC007, t0.200
t:= A_TimeSinceThisHotkey
If ErrorLevel
{
	SendInput {SC00C down}
	KeyWait SC007
	SendInput {SC00C up}
}
else
{
	SendInput {SC007 down}
	sleep 32
	SendInput {SC007 up}
}
return

