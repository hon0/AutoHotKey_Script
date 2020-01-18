#SingleInstance force
OutputDebug DBGVIEWCLEAR

Layers := {c: {LayerKeys: ["c", ","]}
          , v: {LayerKeys: ["v", ";"]}}

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