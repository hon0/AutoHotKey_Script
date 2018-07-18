^!f::
WinGetTitle, currentWindow, A
IfWinExist %currentWindow%
{
	WinSet, Style, ^0xC00000 ; toggle title bar
	WinMove, , , 0, 0, 1920, 1080
}
return