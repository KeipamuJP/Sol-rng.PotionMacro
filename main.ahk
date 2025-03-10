#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; ===== Values =====
global pw := A_ScreenWidth
global ph := A_ScreenHeight
global tx := Integer(0)
global ty := Integer(0)
global wh := Integer(pw + ph)
global pot := ""
global ctl := Integer(0)
global rw := Integer(0)
global rh := Integer(0)
global test := ""
global spd := Integer(2)
if WinExist("Roblox") {
    WinGetPos ,,&rw,&rh,"Roblox"
} 
else
{
    MsgBox "Robloxを起動してください。 / Launch Roblox.", "ERROR 404", "OK IconX"
    ExitApp -4949
}
global rwh := Integer(rw + rh)
; ===== ^^^^^^ =====

; ===== classes =====

; UI class, DDL, Checkbox
main_gui() {
    global mn := Gui()
    mn.Add("Text",, "Select Potion:")
    mn.Add("DDL", "vpotion Choose1", ["HP1", "HP2", "Warp", "Only Randomizer"])
    mn.Add("Checkbox", "vrandomizer", "Use Randomizers?")
    mn.Show("Center")
}

; send text
inputsend(text) {
    Send text
    Sleep 100
}

; Mousemove and Mouseclick
mmc(x, y, spd, dc) {
    px1 := (x / 1366) 
    py1 := (y / 768)
    px2 := Integer(A_ScreenWidth * px1)
    py2 := Integer(A_ScreenHeight * py1)
    MouseMove px2, py2, spd
    Sleep 100
    if (dc = "yes") {
        loop 2 {
            Send "{Click}"
            Sleep 10
        }
        Sleep 80
    }
    else
    {
        Send "{Click}"
        Sleep 100
    }
}

; Scroll class
ms(x, y, spd, lp, ud) {
    px1 := (x / 1366) 
    py1 := (y / 768)
    px2 := Integer(A_ScreenWidth * px1)
    py2 := Integer(A_ScreenHeight * py1)
    MouseMove px2, py2, spd
    Sleep 100
    ; Scroll Up
    if (ud = "up") {
        loop lp {
            Send "{WheelUp}"
            Sleep 100
        }
    } ; Scroll Down
    else if (ud = "down") {
        loop lp {
            Send "{WheelDown}"
            Sleep 100
        }
    } ; error
    else { 
        result := MsgBox("Developer are an idiot! Invalid Parameter","ERROR: 4949", "OK IconX")
        if (result = "OK"){
            ExitApp -4949
        }
    }
}

; ===== IMPORTANT ARIA =====
; setup class, submit gui options(Potion select, use randomizer), Fullscreen, Potion Auto Add Reset
setup() {
    global
    SendMode "Event"
    data := mn.Submit(true)
    pot := data.potion
    ctl := data.randomizer
    SetKeyDelay 0, 2
    WinActivate "Roblox"
    if (not rwh = wh){
        Send "{F11}"
    }
    if (pot = "HP1" or pot = "HP2" or pot = "Warp") {
        inputsend("f")
        mmc(810, 300, spd, "yes")
        ms(810, 300, spd, 5, "up")
        mmc(810, 300, spd, "no")
        mmc(500, 410, spd, "no")
        if (pot = "HP1"){
            ms(810, 375, spd, 5, "down")
            mmc(810, 375, spd, "no")
            mmc(500, 410, spd, "no")
        }
        else if(pot = "HP2"){
            ms(810, 450, spd, 5, "down")
            mmc(810, 450, spd, "no")
            mmc(500, 410, spd, "no")
        }
        else if(pot = "Warp"){
            ms(810, 525, spd, 5, "down")
            mmc(810, 525, spd, "no")
            mmc(500, 410, spd, "no")
        }
    }
}

; Crafting Heavenly Potion I
hp1() {
    global
    mmc(410, 410, spd, "no")
    ms(510, 450, spd, 2, "up")
    mmc(510, 450, spd, "yes")
    SendText "100"
    mmc(570, 450, spd, "no")
    ms(570, 545, spd, 2, "down")
    mmc(570, 545, spd, "no")
    mmc(410, 410, spd, "no")
}

; Crafting Heavenly Potion II
hp2() {
    global
    mmc(410, 410, spd, "no")
    ms(510, 450, spd, 2, "up")
    mmc(510, 450, spd, "yes")
    SendText "2"
    mmc(570, 450, spd, "no")
    mmc(510, 485, spd, "yes")
    SendText "125"
    mmc(575, 485, spd, "no")
    ms(570, 545, spd, 2, "down")
    mmc(570, 545, spd, "no")
    mmc(410, 410, spd, "no")
}

; Crafting Warp Potion
warp() {
    global
    mmc(410, 410, spd, "no")
    ms(570, 450, spd, 2, "up")
    mmc(570,450, spd, "no")
    ms(510, 545, spd, 2, "down")
    mmc(510, 545, spd, "yes")
    SendText "1000"
    mmc(570, 545, spd, "no")
    mmc(410, 410, spd, "no")
}

; Use Randomizers
item() {
    global
    mmc(32, 385, spd, "no")
    mmc(900, 235, spd, "no")
    mmc(785, 260, spd, "no")
    SendText "Strange Controller"
    mmc(600, 315, spd, "no")
    mmc(485, 410, spd, "yes")
    mmc(785, 260, spd, "no")
    SendText "Biome Randomizer"
    mmc(600, 315, spd, "no")
    mmc(485, 410, spd, "no")
}

onlyrandom() {
    global
    mmc(785, 260, spd, "no")
    SendText "Strange Controller"
    mmc(600, 315, spd, "no")
    mmc(485, 410, spd, "yes")
    mmc(785, 260, spd, "no")
    SendText "Biome Randomizer"
    mmc(600, 315, spd, "no")
    mmc(485, 410, spd, "no")
}
; ===== ^^^^^^^^^^^^^^ =====

; ===== classes end =====

; Create UI
main_gui()

; Macro Start
F1::    
{
    global
    setup()
    if (pot = "Only Randomizer") {
        mmc(32, 475, spd, "no")
        mmc(32, 385, spd, "no")
        mmc(900, 235, spd, "no")
    }
    loop {
        if WinExist("Roblox") {
            continue
        } else if not WinExist("Roblox") {
            Result := MsgBox("Robloxが開いていません、マクロを終了します。", "ERROR-404", "OK IconX")
            ExitApp -1
        }
        if (pot = "HP1") {
            hp1()
        }
        else if (pot = "HP2") {
            hp2()
        }
        else if (pot = "Warp") {
            warp()
        }
        if (pot = "Only Randomizer") {
            onlyrandom()
        } else if (ctl = 1) {
            item()
            inputsend("f")
        }
    }
}
; Stopping Macro
F2::
{
    Result := MsgBox("マクロを終了しますか？ / Do you want to exit the macro?",, "YesNo")
    if (Result = "Yes"){
        ExitApp 0
    }
    else if (Result = "No"){
        WinActivate "Roblox"
        return
    }
}
; TESTING PLACE!!
F6::
{

}