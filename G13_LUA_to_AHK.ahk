#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it*
#Warn  ; Enable warnings to assist with detecting common errors.

SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
;SetNumlockState, AlwaysOnxn

;#InstallKeybdHook
;#InstallMouseHook

Layer := 1


;Layer checker
z::
ToolTip %Layer%
SetTimer, RemoveToolTip, 2000
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return


;Layer modifier
CapsLock::
Layer := 2
if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
	Layer := 3
KeyWait, CapsLock
Layer := 1
Return


;Layer test
#if Layer=2
tab::!l
w::b
x::n
c::,
v::;
f::g
r::t
#if

#if layer =3
tab::AppsKey
w::Numpad0
x::Numpad1
c::Numpad2
v::Numpad3
#if
	
a::bbn1