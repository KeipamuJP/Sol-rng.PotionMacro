#Requires AutoHotkey v2.0
#SingleInstance Force

; Value
wh := A_ScreenHeight+A_ScreenWidth
pot := 0
ctl := 0
rw := 0
rh := 0
WinGetPos ,,&rw,&rh
rwh := rw+rh

; Screen check
if (not wh = 2134){
    MsgBox "解像度を1366x768にセットしてください", "Error", 16
    ExitApp -4949
}

mn := Gui()
mn.Add("Text",, "Select Potion:")
mn.Add("DropDownList", "vpot Choose1", ["", "HP1", "HP2", "Warp"])
mn.Add("Checkbox", "vctl")
mn.Show("Center")

Setup() {
    SetDefaultMouseSpeed 0
    WinActivate "Roblox"
    if (not rwh = wh) {
        send "{F11}"
    }
}

HP1() {
    MsgBox "HP1", "Info", 16
}

HP2() {
    MsgBox "HP2", "Info", 16
}

Warp() {
    MsgBox "Warp", "Info", 16
}

itemctl() { 
    MsgBox "Enabled item", "Info", 16
}

F1::
{
    Setup()
    if (pot = HP1) {
        HP1()
    }
    else If (pot = HP2) {
        HP2()
    }
    else If (pot = Warp) {
        Warp()
    }
}