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
if (pot = ""){
    goto('rndm')
}
Setup: ; Activate Roblox, Set MouseSpeed & KeyDelay to 0
SetDefaultMouseSpeed 0
SetKeyDelay 0, 0
WinActivate "Roblox"
MouseMove 810, 300
Sleep 100
Send "F" ; Auto Add Reset
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
if (pot = "HP1"){ ; Heavenly Potion I
    MouseMove 810, 375
    Sleep 100
    Send "{Click}"
    MouseMove 500, 410
    Sleep 100
    Send "{Click}"
    Sleep 100
}
if (pot = "HP2"){ ; Heavenly Potion II
    MouseMove 810, 450
    Sleep 100
    Send "{Click}"
    MouseMove 500, 410
    Sleep 100
    Send "{Click}"
    Sleep 100
}
if (pot = "Warp"){ ; Warp Potion
    MouseMove 810, 525
    Sleep 100
    Send "{Click}"
    MouseMove 500, 410
    Sleep 100
    Send "{Click}"
    Sleep 100
}
rndm:
loop { ; Crafting Loop
    if (pot = "HP1"){

    }
    if (pot = "HP2"){

    }
    if (pot = "Warp"){

    }
    if (ctl = 1){ ; Use Randomizers
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

F2::
{
    ExitApp 0
}
F6::
{
    MsgBox "DDL:" pot, "Info", 64
}