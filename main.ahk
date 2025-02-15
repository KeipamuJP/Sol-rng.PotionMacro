#Requires AutoHotkey v2.0
#SingleInstance Force

; Value
wh := A_ScreenHeight+A_ScreenWidth
pot := 0

; Screen check
if (not wh = 2134){
    MsgBox "解像度を1366x768にセットしてください", "Error", 16
    ExitApp -4949
}

mn := Gui()
mn.Add("Text",, "Select Potion:")
mn.Add("DropDownList", "vpot Choose1", ["", "HP1", "HP2", "Warp"])
mn.Show("Center")

Setup() {
    SetDefaultMouseSpeed 0
    WinActivate "Roblox"
}

HP1() {
    MouseMove 0, 0
}

HP2() {

}

Warp() {

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