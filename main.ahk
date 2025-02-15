#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Value
wh := Integer(A_ScreenHeight + A_ScreenWidth)
pot := Integer(0)
ctl := Integer(0)
rw := Integer(0)
rh := Integer(0)
WinGetPos ,,&rw,&rh,"Roblox"
rwh := Integer(rw + rh)

; Screen check
if (! wh = 2134){
    MsgBox "解像度を1366x768にセットしてください", "Error", 16
    ExitApp -4949
}
if (! rwh = wh){
    WinActivate "Roblox"
    Send "{F11}"
}

; Main GUI
mn := Gui()
mn.Add("Text",, "Select Potion:")
mn.Add("DropDownList", "vpot Choose1", ["", "HP1", "HP2", "Warp"])
mn.Add("Checkbox", "vctl", "Use Randomizers?")
mn.Show("Center")

; Macro Main Part
KeyWait "F1", "D"
Setup: ; Activate Roblox, Set MouseSpeed & KeyDelay to 0
SetDefaultMouseSpeed 0
SetKeyDelay 0, 0
WinActivate "Roblox"
MouseMove 810, 300
Send "F"
Sleep 100
Send "{WheelUp Down}"
Sleep 500
if (pot = "HP1"){
    
}

F2::
{
    ExitApp 0
}
F6::
{
    MsgBox "wh:" wh "rwh:" rwh, "Info", 64
}