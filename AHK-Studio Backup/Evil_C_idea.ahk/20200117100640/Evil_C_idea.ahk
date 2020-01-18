#SingleInstance force
OutputDebug DBGVIEWCLEAR

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
	#F2::Suspend, Toggle
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

Layers := {c: {LayerKeys: ["c", ","]}
          , v: {LayerKeys: ["v", "."]}}

for key, data in Layers {
    fn := Func("KeyEvent").Bind(key, 1)
    hotkey, % "$" key, % fn
    fn := Func("KeyEvent").Bind(key, 0)
    hotkey, % "$" key " up", % fn
}
SwitchLayer(1)
return

CapsLock::
    SwitchLayer(2)
    return

CapsLock up::
    SwitchLayer(1)
    return

KeyEvent(key, state){
    global Layer, Layers
    if (state && Layers[key].State)
        return
    keyToChange := Layers[key].LayerKeys[Layer]
    SendKey(keyToChange, state)
    Layers[key].State := state
}

SwitchLayer(newLayer){
    global Layer, Layers
    if (newLayer == Layer)
        return
    for key, data in Layers {
        if (data.State){ ; key currently held
            keyToRelease := data.LayerKeys[Layer]
            SendKey(keyToRelease, 0)
            keyToPress := data.LayerKeys[newLayer]
            SendKey(keyToPress, 1)
        }
    }
    Layer := newLayer
}

SendKey(key, state){
    keyStr := "{" key " " (state ? "down" : "up") "}"
    Debug("Sending " keyStr " @ " A_TickCount)
    Send % keyStr
}

Debug(text){
    OutputDebug, % "AHK| " text
}

^Esc::ExitApp