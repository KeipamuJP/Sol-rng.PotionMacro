#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Value
global wh := Integer(A_ScreenHeight + A_ScreenWidth)
global pot := ""
global ctl := Integer(0)
global rw := Integer(0)
global rh := Integer(0)
global test := ""
global WinGetPos ,,&rw,&rh,"Roblox"
global rwh := Integer(rw + rh)

; classes
class main_gui() {
    global mn := Gui()
    mn.Add("Text", "Select Potion:")
    mn.Add("DDL", "vpotion", ["HP1", "HP2", "Warp"])
    mn.Add("Checkbox", "vrandomizer", "Use Randomizers?")
    mn.Show("Center")
}

class setup() {
    global
    data := mn.Submit(true)
    pot := data.potion
    ctl := data.randomizer
    SetKeyDelay 0, 0
    SetDefaultMouseSpeed 0
}

; Screen check
if (! wh = 2134){
    MsgBox "解像度を1366x768にセットしてください", "Error", 16
    ExitApp -4949
}
if (! rwh = wh){
    WinActivate "Roblox"
    Send "{F11}"
}

; Macro Main Part
F1::    
{
    global
    
}
; Stopping Macro
F2::
{
    Result := MsgBox("マクロを終了しますか？",, "YesNo")
    if (Result = "Yes"){
        ExitApp 0
    }
    else if (Result = "No"){
        return
    }
}
; TESTING PLACE!!
F6::
{
    global
    setup()
    MsgBox "Selected: " pot "Randomizer: " ctl,, 64
}