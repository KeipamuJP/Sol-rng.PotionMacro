#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Value
wh := A_ScreenHeight+A_ScreenWidth
pot := 0
ctl := 0
rw := 0
rh := 0
WinGetPos ,,&rw,&rh,"Roblox"
rwh := rw+rh

; Screen check
if (! wh = 2134){
    MsgBox "解像度を1366x768にセットしてください", "Error", 16
    ExitApp -4949
}

mn := Gui()
mn.Add("Text",, "Select Potion:")
mn.Add("DropDownList", "vpot Choose1", ["", "HP1", "HP2", "Warp"])
mn.Add("Checkbox", "vctl", "Use Controllers?")
mn.Show("Center")

Setup() {
    SetDefaultMouseSpeed 0
    SetKeyDelay 0, 0
    WinActivate "Roblox"
    if (! %rwh% = 2134) {
        send "{F11}"
    }
}

HP1() {
    MsgBox "HP1", "Info", 64
}

HP2() {
    MsgBox "HP2", "Info", 64
}

Warp() {
    MsgBox "Warp", "Info", 64
}

itemctl() { 
    MsgBox "Enabled item", "Info", 64
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
F2::
{
    ExitApp 0
}
F6::
{
    MsgBox "wh:" wh "rwh:" rwh, "Info", 64
}