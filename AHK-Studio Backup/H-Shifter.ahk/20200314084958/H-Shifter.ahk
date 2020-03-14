;		Numpad7		Numpad8		Numpad9
;		   |		   |		   |
;		   |		   |		   |
;		   ---------------------------------
;		   |		   |		   |
;		   |		   |		   |
;		Numpad4		Numpad5		Numpad6
; 	{Numpad1 up}{numpad4 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 up}
;	{Numpad1 down} 	{numpad4 down}	{numpad5 down} 	{numpad6 down} 	{numpad7 down} 	{numpad8 down} 	{numpad9 down}

;key := 0

^s::
suspend, Permit
send, {ctrl down}s{ctrl up}
sleep 100
reload, "C:\Users\RubySapphire\Desktop\Scripts for AHK\ATS"
return
--------------------------------
pause::
Suspend, Permit
Suspend, Toggle
Return

#ifWinActive American Truck Simulator
	---------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------
$Numpad0::
Send, {Numpad1 up}{numpad4 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 up}
Return
---------------------------------------------------------------------------------------------------------
$Numpad7::
Send, {Numpad1 up}{numpad4 up}{numpad5 up}{numpad6 up}{numpad8 up}{numpad9 up}{numpad7 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad4::
Send, {Numpad1 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 up}{numpad4 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad8::
Send, {Numpad1 up}{numpad4 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad9 up}{numpad8 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad5::
Send, {Numpad1 up}{numpad4 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 up}{numpad5 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad9::
Send, {Numpad1 up}{numpad4 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad6::
Send, {Numpad1 up}{numpad4 up}{numpad5 up}{numpad7 up}{numpad8 up}{numpad9 up}{numpad6 down}
Return
---------------------------------------------------------------------------------------------------------
$Numpad1::
Send, {numpad4 up}{numpad5 up}{numpad6 up}{numpad7 up}{numpad8 up}{numpad9 up}{Numpad1 down}
Return
---------------------------------------------------------------------------------------------------------
#ifWinActive
	
; num1, num0, num7, num4, num8, num5, num9, num6

$MButton::
{
	key = 2
	Send, {Numpad0 down}{numpad1 up}{numpad7 up}{numpad4 up}{numpad8 up}{numpad5 up}{numpad9 up}{numpad6 up}
	Return
}

$WheelUp::
{
	if (key >= 8)
		Return
	key++
	if key = 1
		Send, {numpad0 up}{Numpad1 Down}
	else if key = 2
		Send, {numpad1 up}{numpad0 Down}
	else if key = 3
		Send, {numpad0 up}{numpad7 Down}
	else if key = 4
		Send, {numpad7 up}{numpad4 Down}
	else if key = 5
		Send, {numpad4 up}{numpad8 Down}
	else if key = 6
		Send, {numpad8 up}{numpad5 Down}
	else if key = 7
		Send, {numpad5 up}{numpad9 Down}
	else if key = 8
		Send, {numpad9 up}{numpad6 Down}
	return
}

; num1, num0, num7, num4, num8, num5, num9, num6

$WheelDown::
{
	if (key <= 1)
		Return
	key--
	if key = 8	
		Send, {numpad6 up}{Numpad9 Down}
	else if key = 7
		Send, {numpad9 up}{numpad5 Down}
	else if key = 6
		Send, {numpad5 up}{numpad8 Down}
	else if key = 5
		Send, {numpad8 up}{numpad4 Down}
	else if key = 4
		Send, {numpad4 up}{numpad7 Down}
	else if key = 3
		Send, {numpad7 up}{numpad0 Down}
	else if key = 2
		Send, {numpad0 up}{numpad1 Down}
	else if key = 11010711010101010748547011074859658470110748596584701107485965847011
		Send, {numpad0 up}{numpad1 Down}
	return
}