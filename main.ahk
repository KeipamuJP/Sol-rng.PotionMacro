#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Value
wh := Integer(A_ScreenHeight + A_ScreenWidth)
pot := String("")
ctl := Integer(0)
rw := Integer(0)
rh := Integer(0)
test := String("")
WinGetPos ,,&rw,&rh,"Roblox"
rwh := Integer(rw + rh)

; classes


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
    ; Setup part Submit DDL, Activate Roblox, Set MouseSpeed & KeyDelay to 0
    SetDefaultMouseSpeed 0
    SetKeyDelay 0, 0
    WinActivate "Roblox"
    MouseMove 810, 300
    Sleep 100
    ; Auto Add Reset
    Send "F" 
    Sleep 100
    Send "{Click}"
    Sleep 100
    loop 5{
        Send "{WheelUp}"
        Sleep 200
    }
    Send "{Click}"
    Sleep 100
    MouseMove 500, 410
    Sleep 100
    Send "{Click}"
    Sleep 100
    ; Auto Add Heavenly Potion I
    if (pot = "HP1"){
        MouseMove 810, 375
        Sleep 100
        Send "{Click}"
        MouseMove 500, 410
        Sleep 100
        Send "{Click}"
        Sleep 100
    }
    ; Auto Add Heavenly Potion II
    if (pot = "HP2"){
        MouseMove 810, 450
        Sleep 100
        Send "{Click}"
        MouseMove 500, 410
        Sleep 100
        Send "{Click}"
        Sleep 100
    }
    ; Auto Add Warp Potion
    if (pot = "Warp"){
        MouseMove 810, 525
        Sleep 100
        Send "{Click}"
        MouseMove 500, 410
        Sleep 100
        Send "{Click}"
        Sleep 100
    }
    ; Crafting Loop
    loop {
        ; Craft Heavenly Potion I
        if (pot = "HP1"){
    
        }
        ; Craft Heavenly Potion II
        if (pot = "HP2"){
    
        }
        ; Craft Warp Potion
        if (pot = "Warp"){
    
        }
        ; Use Randomizers
        if (ctl = 1){
            MouseMove 32, 385
            Sleep 100
            Send "{Click}" ; strage button
            Sleep 100
            MouseMove 900, 240
            Sleep 100
            Send "{Click}" ; items button
            Sleep 100
            MouseMove 785, 260
            Sleep 100
            Send "{Click}" ; search box
            Sleep 100
            SendText "biome randomizer" ; item name
            Sleep 100
            MouseMove 600, 315
            Sleep 100
            Send "{Click}" ; item click
            Sleep 100
            MouseMove 485, 415
            Sleep 100
            loop 2 {
                Send "{Click}" ; use click
                Sleep 100
            }
            MouseMove 785, 260
            Sleep 100
            Send "{Click}" ; search box
            Sleep 100
            SendText "strange controller" ; item name
            Sleep 100
            MouseMove 600, 315
            Sleep 100
            Send "{Click}" ; item click
            Sleep 100
            MouseMove 485, 415
            Sleep 100
            loop 2 {
                Send "{Click}" ; use click
                Sleep 100
            }
            Send "F" ; Cauldron
        }
    }
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
    
}