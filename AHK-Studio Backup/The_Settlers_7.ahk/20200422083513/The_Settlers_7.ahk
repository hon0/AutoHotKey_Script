f1::     ;on
WinGetPos VarX, VarY, Width, Height, "A"
VarX2 := VarX + Width
VarY2 := VarY + Height
ClipCursor( True, VarX, VarY, VarX2, VarY2)
tooltip("Mouse cursor locked!")
SetTimer () => ToolTip(), -3000
Return

f2::	;off
ClipCursor( False,0,0,0,0)
tooltip("Mouse cursor unlocked!")
SetTimer () => ToolTip(), -3000
return

ClipCursor( Confine:=True, x1:=0 , y1:=0, x2:=1, y2:=1 ) {
	VarSetCapacity(R,16,0)  
	NumPut("UPtr",x1,&R+0)
	NumPut("UPtr",y1,&R+4)
	NumPut("UPtr",x2,&R+8)
	NumPut("UPtr",y2,&R+12)
	Return Confine ? DllCall( "ClipCursor", "UInt",&R ) : DllCall( "ClipCursor" )
}