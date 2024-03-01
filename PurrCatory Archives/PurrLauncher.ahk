#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 1.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

IniWrite "", A_Temp "\Purr.ini", "launch", "Dir"
IniWrite "", A_Temp "\Purr.ini", "launch", "Game"

MyGui := Gui()

; call dark mode for window title + menu
SetWindowAttribute(MyGui)

; call dark mode for controls
SetWindowTheme(MyGui)

;Requires DarkMode for AutoHotkey v2
#include .Cmpl8r\DarkMode.scriptlet

MyGui.Title := "PurrCatory Archive"

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	FileDelete A_Temp "\Purr.ini"
	ExitApp
}

MyGui.Add("Text", "x140" , "Select a version")

MyGui.Add("Text", "x5" , "")

MyRadio := MyGui.AddRadio("vMyRadioGroup cwhite", "Demo Build`n  Contains unique test levels that aren't in the alpha build")
MyRadio.OnEvent("Click", MyBtn_op1)

MyRadio2 := MyGui.AddRadio("vMyRadioGroup2 cwhite", "Alpha v0.3a`n  An incomplete version of the full game")
MyRadio2.OnEvent("Click", MyBtn_op2)

MyGui.Add("Text",, "")

MyBtn := MyGui.AddButton("Default x130 w80", "OK")
MyBtn.OnEvent("Click", MyBtn_Click)

MyBtn_op1(*)
{
	IniWrite "Demo Build", A_Temp "\Purr.ini", "launch", "Dir"
	IniWrite "PurrCatory (Demo Build).exe", A_Temp "\Purr.ini", "launch", "Game"
}

MyBtn_op2(*)
{
	IniWrite "Alpha-0.3a", A_Temp "\Purr.ini", "launch", "Dir"
	IniWrite "PurrCatory.exe", A_Temp "\Purr.ini", "launch", "Game"
}

MyBtn_Click(*) {
Value1 := IniRead(A_Temp "\Purr.ini", "launch", "Dir")
Value2 := IniRead(A_Temp "\Purr.ini", "launch", "Game")

if Value := IniRead(A_Temp "\Purr.ini", "launch", "Game", "")
	{
		MyGui.Hide()
		SetWorkingDir Value1
		RunWait Value2
		SetWorkingDir ".."
		MyGui.Show()
	} else {
		MyGui.Hide()
		MsgBox "Error! Please select a game", "Error!"
		MyGui.Show()
	}
}

MyGui.Show("w350")