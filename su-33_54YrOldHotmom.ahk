;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include <TapHoldManager>
;#InstallKeybdHook
#SingleInstance force


SetKeyDelay, 0, 50

; Joystick ID SWAPPER INFO
; ID#1	Vpc-MongooseT-50
; ID#2	Throttle - HOTAS Warthog
; ID#3	MFG Crosswind V2
; ID#4	Saitek Pro Flight Throttle Quadrant

; TapholdManager
;-----------------------------------------------
;-----------------------------------------------

thm := new TapHoldManager(200, 350)			; TapTime / Prefix can now be set here
thm1 := new TapHoldManager(100, 200)		; TapFunc / HoldFunc now always one function
thm2 := new TapHoldManager(0, 10)			; "instant" hold for fire
thm2.add("1joy9", Func("MyFunc1"))			; trim up
thm2.add("1joy11", Func("MyFunc2"))			; trim down
thm2.add("1joy10", Func("MyFunc3"))			; trim right
thm2.add("1joy12", Func("MyFunc4"))			; trim left
thm1.Add("1joy1", Func("MyFunc5"))			; first stage fire button
thm2.Add("1joy2", Func("MyFunc6"))			; second stage fire button
thm.Add("1joy8", Func("MyFunc7"))			; change weapon
thm.Add("1joy3", Func("MyFunc8"))			; joystick missile button
thm2.add("1joy19", Func("Myfunc9"))			; wheelbrake ladle
thm.Add("1joy13", Func("MyFunc10")) 		; DMS up
thm1.Add("1joy14", Func("MyFunc11")) 		; DMS right
thm.Add("1joy15", Func("MyFunc12")) 		; DMS down
thm1.Add("1joy16", Func("MyFunc13")) 		; DMS left
thm.Add("F17", Func("MyFunc14"))			; TMS up
thm.Add("F18", Func("MyFunc15"))			; TMS right
thm.Add("F19", Func("MyFunc16"))			; TMS down
thm.Add("F20", Func("MyFunc17"))			; TMS left
thm.Add("1joy17", Func("MyFunc18"))			; countermeasure press down
thm.Add("1joy6", Func("MyFunc19"))			; countermeasure hat up
thm.Add("1joy6", Func("MyFunc20"))			; countermeasure hat right
thm.Add("1joy7", Func("MyFunc21"))			; countermeasure hat left
thm.Add("1joy7", Func("MyFunc22"))			; countermeasure hat down
thm.Add("1joy18", Func("MyFunc23"))			; Nose Wheel steering button (pinky)
thm.Add("2joy15", Func("MyFunc24"))			; throttle autopilot
thm.Add("f21", Func("MyFunc25"))			; Coolie hat up
thm.Add("f22", Func("MyFunc26"))			; Coolie hat right
thm.Add("f23", Func("MyFunc27"))			; Coolie hat down
thm.Add("f24", Func("MyFunc28"))			; Coolie hat left


ph := new PovHelper(1)
Loop 4
    ph.Subscribe(A_Index, Func("Pov1").Bind("F" 16 + A_Index))

ph2 := new PovHelper(2)
Loop 4
    ph2.Subscribe(A_Index, Func("Pov2").Bind("F" 20 + A_Index))

Pov1(key, state){
     ; dir will hold direction: 1, 2, 3 or 4
    global thm
    thm.Bindings[key].KeyEvent(state)
}
Pov2(key, state){
     ; dir will hold direction: 1, 2, 3 or 4
    global thm
    thm.Bindings[key].KeyEvent(state)
}


;--- Stick

MyFunc1(isHold, taps, state){							;trim up
	if (isHold){
		Send % BuildKey(["RCtrl", ";"], state)
	}
}
MyFunc2(isHold, taps, state){							;trim down
	if (isHold){
		Send % BuildKey(["RCtrl", "."], state)
	}
}
MyFunc3(isHold, taps, state){							;trim right
	if (isHold){
		Send % BuildKey(["RCtrl", "/"], state)
	}
}
MyFunc4(isHold, taps, state){							;trim left
	if (isHold){
		Send % BuildKey(["RCtrl", ","], state)
	}
}
MyFunc5(isHold, taps,state){							;first stage fire button
	if (isHold){										
		Send % BuildKey(["enter"], state)				;LOCK TARGET
	} else { if (taps == 1){
		Send {backspace}								;back to search
		}
	}
}
MyFunc6(isHold, taps,state){							;second stage fire button
	if (isHold){
		Send % BuildKey(["space"], state)				;fire
	}
}
MyFunc7(isHold, taps, state){							;Joystick Change Weapon
	if (isHold){
		if (taps == 1){									;tap & hold
			Send % BuildKey(["3"], state)				;vertical scan
		} else if (taps == 2){							;double tap & hold
			Send % BuildKey(["1"], state)				;nav
		}												
	} else {
		if (taps == 1){									;tap 1
			Send {d}									;Change weapons
		} else if (taps == 2){							;double tap
			Send {f15}									;trackir Center
		}
	}	
}		
MyFunc8(isHold, taps, state){							;Joystick Missile button
	if (isHold){
		if (taps == 1){
			Send % BuildKey(["RAlt", "w"], state)		;override missile launch
		} 
	} else {
		if (taps == 1){									;cannon
			Send {c}
		} else if (taps == 2){							;gun reticle
			Send {8}
		}
	}
}
MyFunc9(isHold, taps, state){							;wheelbrake
	if (isHold){
		Send % BuildKey(["LShift", "w"], state)
	}
}
MyFunc10(isHold, taps, state){							;DMS up
	if (isHold){
		if (taps == 1){									
			Send % BuildKey(["2"], state)				;BVR
		} 
	} else if (taps == 1){
		Send {1}										;nav
	}
}
MyFunc11(isHold, taps, state){							;DMS right
	if (state == 1){									
		if (taps == 1){
			Send {RCtrl Down}{= Down}					;expected range increase AUTOFIRE
			Settimer, wfbu1joy14, 80
			return
			
			wfbu1joy14:
			if not GetKeyState("1joy14"){
				Send {RCtrl Up}{= Up}
				Settimer, wfbu1joy14, off
				return
			}
			Send {RCtrl down}{= down}
			Send {RCtrl up}{= Up}
			return
		}
	} else if (!isHold){
		if (taps == 1){
			Send ^``									;next nav
		}			
	}	
}
MyFunc12(isHold, taps, state){							;DMS down
	if (isHold){
		if (taps == 1){									
			Send % BuildKey(["7"], state)				;air to ground mode
		} 
	} else if (taps == 1){
		Send {4}										;bore mode
	}
}
MyFunc13(isHold, taps, state){							;DMS left
	if (state == 1){									
		if (taps == 1){
			Send {RCtrl Down}{- Down}					;expected range decrease AUTOFIRE
			Settimer, wfbu1joy16, 80
			return
			
			wfbu1joy16:
			if not GetKeyState("1joy16"){
				Send {Rctrl up}{- up}
				Settimer, wfbu1joy16, off
			return
			}
			
			Send {RCtrl down}{- down}
			Send {RCtrl up}{- up}
			return
		}
	} else if (!isHold){
		if (taps == 1){
			Send +``									;Previous nav
		}			
	}	
}
MyFunc14(isHold, taps, state){							;TMS up
    if (isHold){
		send % BuildKey([""], state)					;empty
	} else {
		Send {=}										;Zoom in display
	}
}
MyFunc15(isHold, taps, state){							;TMS right
    ToolTip % "2`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state
	send {f18}
}
MyFunc16(isHold, taps, state){							;TMS down
    if (isHold){
		send % BuildKey([""], state)					;empty
	} else {
		Send {-}										;Zoom out display
	}
}
MyFunc17(isHold, taps, state){							;TMS left
    ToolTip % "2`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state
	send {f20}
}
MyFunc18(isHold, taps, state){							;countermeasure hat press down
	if (isHold){
		if (taps == 1){
			Send % BuildKey(["e"], state)				;ECM
		} else if (taps == 2){
			Send % Buildkey(["LCtrl", "t"], state)		;trim reset
		}
	} else {
		if (taps == 1){
			Send {q} 									;release countermeasures
		} else if (taps == 2){
			Send +q										;continously dispense
		}
	}
}
MyFunc19(isHold,taps,state){							;Countermeasure hat up
}
MyFunc20(isHold,taps,state){							;Countermeasure hat right
	if (isHold){
		Send % BuildKey(["RShift", "i"], state)			;radar puls repeat frequency select
	} else Send {o}										;electrical optical system
}
MyFunc21(isHold,taps,state){							;Countermeasure hat down
}
MyFunc22(isHold,taps,state){							;Countermeasure hat left
	if (isHold){
		Send % BuildKey(["RAlt", "i"], state)			;radar rws/tws mode select
	} else Send {i}										;radar
}
MyFunc23(isHold,taps,state){							;nose steering button (pinky)
	if (isHold){
		Send % BuildKey(["LAlt", "q"], state)
	}
}


;--- Throttle

MyFunc24(isHold,taps,state){							;autopilot button
	if (isHold){
		if (taps == 1){
			Send % BuildKey(["LShift", "e"], state)		;afterburner max
		}
	} else if (taps == 1){								
		Send {a}										;Autopilot
	}
}

MyFunc25(isHold,taps,state){							;Coolie hat up
    if (!isHold){
		Send {RShift down}{raw};
		Send {RShift up}
	}													;scan up
}

MyFunc26(isHold,taps,state){							;Coolie hat right
    if (isHold){
		send % BuildKey(["RShift", "/"], state)					;empty
	} else {
		Send +/
	}													;scan up
}

MyFunc27(isHold,taps,state){							;Coolie hat down
    if (!isHold){
		Send {RShift down}.
		Send {RShift up}
	}													;scan down
}
MyFunc28(isHold,taps,state){							;Coolie hat left
    if (isHold){
		send % BuildKey(["RShift", ","], state)					;empty
	} else {
		Send +,
	}													;scan left
}


; Universal Plane Binds
;-----------------------------------------------
;-----------------------------------------------



; Throttle toggles
;-----------------------------------------------




{2Joy28::												; --- Throttle LASTE 3-way switch Button 27/28
	Send !4
	SetTimer, WaitForButton2Up28, 10 
	return
	
	WaitForButton2Up28:
	if GetKeyState("2Joy28")
	return
	Send !2
	SetTimer, WaitForButton2Up28, off
return

;---

2Joy27::
	Send !6
	SetTimer, WaitForButton2Up27, 10
	return
	
	WaitForButton2Up27:
	if GetKeyState("2Joy27")
	return
	Send !2
	SetTimer, WaitForButton2Up27, off
return
}

{2Joy7::												; --- Throttle airbrake 3-way switch button 7/8
	Send +b												; toggle switch open airbrake
	SetTimer, WaitForButton2Up7, 10
	return
	
	WaitForButton2Up7:
	if GetKeyState("2Joy7")
	return
	Send ^b												; close airbrake
	SetTimer, WaitForButton2Up7, off
return


; --- 

2Joy8:: 												; Momentary switch 
	Send {s Down}{s Up}									; Activate Cobra 
	SetTimer, WaitForButton2Up8, 10
	return
	
	WaitForButton2Up8:
	if GetKeyState("2Joy8")
	return
	
	Send ^b												; close airbrake (redundant?)
	Send {s Down}{s Up}									; Deactivate Cobra
	SetTimer, WaitForButton2Up8, off
return
}

{2Joy23::												; --- Throttle Flap 3-way switch 23/22
	Send +g												; landing gear down
	Send +f												; flaps down
	SetTimer, WaitForButton2Up23, 10 
	return
	
	WaitForButton2Up23:
	if GetKeyState("2Joy23")
	return
	Send ^f												; Flaps Up
	SetTimer, WaitForButton2Up23, off
return

;---

2Joy22::
	Send ^g												; Landing Gear up
	Send ^f												; Flaps Up
	SetTimer, WaitForButton2Up22, 10
	return
	
	WaitForButton2Up22:
	if GetKeyState("2Joy22")
	return
	Send +f												; flaps down
	SetTimer, WaitForButton2Up22, off
return
}
; Joystick binds
; -----------------------------------------------



BuildKey(keys, state){						; isHold for tapholdmanager syntax: Send % BuildKey(["RCtrl", "t"], state) or Send % BuildKey(["t"], state)
    max := keys.Length()
    upDown := state ? " Down" : " Up"
    
    if (state){
        inc := 1
        i := 1
    } else {
        inc := -1
        i := max
    }
    Loop % max {
        key := keys[i]
        str .= "{" key updown "}"
        i += inc
    }
    return str
}

class PovHelper {							; HOTAS Pov/hat code
    static PovMap := {-1: [0,0,0,0], 1: [1,0,0,0], 2: [1,1,0,0] , 3: [0,1,0,0], 4: [0,1,1,0], 5: [0,0,1,0], 6: [0,0,1,1], 7: [0,0,0,1], 8: [1,0,0,1]}
    static directionNames := {Up: 1, Right: 2, Down: 3, Left: 4}
    callbacks := {}
    currentAngle := -1
    directionStates := [0,0,0,0]
    
    __New(stickId){
        fn := this.WatchPov.Bind(this)
        this.stickId := stickId
        this.povStr := stickId "JoyPOV"
        
        SetTimer, % fn, 10
    }
    
    Subscribe(dir, callback){
        if (this.directionNames.HasKey(dir)){   ; Translate from direction name to index, if needed
            dir := this.directionNames[dir]
        }
        this.Callbacks[dir] := callback
    }
    
    WatchPov(){
        angle := GetKeyState(this.povStr)
        if (angle == this.currentAngle)
            return
        this.currentAngle := angle
        angle := (angle = -1 ? -1 : round(angle / 4500) + 1)
        newStates := this.PovMap[angle]
        Loop 4 {
            if (this.directionStates[A_Index] != newStates[A_Index]){
                this.directionStates[A_Index] := newStates[A_Index]
                if (this.callbacks.HasKey(A_Index)){
                    this.callbacks[A_Index].call(newStates[A_Index])
                }
            }
        }
    }
}