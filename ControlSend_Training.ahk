#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
#Warn  ; Enable warnings to assist with detecting common errors.
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A

SetTitleMatchMode, 2
;p::
ControlSend, Edit1, a, Sans titre�- Bloc-notes
return

;o::
ControlSend, Edit1, This is a test, Sans titre�- Bloc-notes
return

~i::
ControlSend, DSUI:PagesView1, {Down}{Enter}, The Settlers 7 Paths to a Kingdom Prima Official Guide - PDF-XChange Viewer
return


SetTitleMatchMode, 2

~c::
ControlSend, ahk_parent, {LControl Down}{LShift Down}{n}{LControl Up}{LShift Up}, The Settlers 7 Paths to a Kingdom Prima Official Guide - PDF-XChange Viewer
ControlSend, Edit1, 19, Atteindre la page
ControlSend, Edit1, {NumpadEnter}, Atteindre la page
return

~x::
ControlSend, ahk_parent, {LControl Down}{LShift Down}{n}{LControl Up}{LShift Up}, The Settlers 7 Paths to a Kingdom Prima Official Guide - PDF-XChange Viewer
ControlSend, Edit1, 17, Atteindre la page
ControlSend, Edit1, {NumpadEnter}, Atteindre la page
return

^SPACE::  Winset, Alwaysontop, , A 