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
	
$Up::
if (key >= 4)
	Return
key++
if key = 1
	Send, {SC002 down}

else if key = 2
	Send, {SC003 down}{SC002 up}

else if key = 3
	Send, {SC004 down}{SC003 up}

else if key = 4
	Send, {SC005 down}{SC004 up}
return

$Down::
if (key <= 1)
	Return
key--
if key = 1
	Send, {SC002 down}{SC003 up}

else if key = 2
	Send, {SC003 down}{SC004 up}

else if key = 3
	Send, {SC004 down}{SC005 up}

else if key = 4
	Send, {SC005 down}{SC006 up}
return