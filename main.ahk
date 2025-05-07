#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; ===== Values =====
global pw := A_ScreenWidth
global ph := A_ScreenHeight
global wh := Integer(pw + ph)
global pot := ""
global godlypos := Integer(0)
global godlike := Integer(0)
global ctl := Integer(0)
global rw := Integer(0)
global rh := Integer(0)
global spd := Integer(2)
global pots := ["For", "Pos", "li", "Ze", "Had", "Bo", "He"]
global uipots := ["1. Godly Potion[Zeus]", "2. Godly Potion[Hades]", "3. Potion of Bound", "4. Heavenly Potion", "5. Only use Randomizers"]
global materials := [ ; based var is pots
    0, 0, 0, 0, ; Fortune Potion
    50, 1 , 1, 1, ; Godly Potion[Poseidon]
    1, 1, 1, 600, ; Godlike Potion
    25, 25, 1, 0, ; Godly Potion[Zeus]
    50, 1, 0, 0 ; Godly Potion[Hades]
    1, 3, 0, 100 ; Potion of Bound
    250, 2, 1, 0 ; Heavenly Potion
]
; ===== ^^^^^^ =====

; ===== classes =====

; UI class, DDL, Checkbox
main_gui() {
    global mn := Gui()
    mn.Add("Text",, "Select Potion:")
    mn.Add("DDL", "vpotion Choose1", uipots)
    mn.Add("Checkbox", "vgodlypos", "Craft Godly Potion[Poseidon]")
    mn.Add("Checkbox", "vgodlike", "Craft Godlike Potion")
    mn.Add("Checkbox", "vrandomizer", "Use Randomizers?")
    mn.Show("Center")
}

; get roblox wh
getrobloxwh() {
    global
    if WinExist("Roblox") {
        WinGetPos ,,&rw,&rh,"Roblox"
    } 
    else
    {
        MsgBox "Robloxを起動してください。 / Launch Roblox.", "ERROR 404", "OK IconX"
        ExitApp -4949
    }
    rwh := Integer(rw + rh)
}

; check roblox
check() {
    if WinExist("Roblox") {
        return
    } else if not WinExist("Roblox") {
        MsgBox "Robloxが開いていません、マクロを終了します。 / Roblox is not open, exit macro.", "ERROR-404", "OK IconX"
        ExitApp -4949
    }
}

; send text
inputsend(text) {
    Send text
    Sleep 100
}

; Mouseclicking with different res
mouseclick(mx, my, spd, dc) {
    x1 := (mx / 1366) 
    y1 := (my / 768)
    x := Integer(A_ScreenWidth * x1)
    y := Integer(A_ScreenHeight * y1)
    MouseMove x, y, spd
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
mousescroll(mx, my, spd, lp, ud) {
    ; mx = x pos
    ; my = y pos
    ; spd = mouse speed
    ; lp = scroll loops
    ; ud = up or down
    x1 := (mx / 1366) 
    y1 := (my / 768)
    x := Integer(A_ScreenWidth * x1)
    y := Integer(A_ScreenHeight * y1)
    MouseMove x, y, spd
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
        MsgBox("mousescroll error","ERROR: 4949", "OK IconX")
        ExitApp -4949
    }
}

; ===== IMPORTANT ARIA =====
; setup class, submit gui options(Potion select, use randomizer), Fullscreen, Potion Auto Add Reset
setup() {
    global
    SendMode "Event"
    local data := mn.Submit(true)
    pot := data.potion
    ctl := data.randomizer
    spot := Integer(SubStr(pot, 1, 1))
    mpot := spot + 3
    SetKeyDelay 0, 2
    WinActivate "Roblox"
    getrobloxwh()
    if (not rwh = wh){
        Send "{F11}"
    }
    if (not spot = 5) {
        inputsend("f")
        mouseclick(815, 240, spd, "no")
        SendText(pots[1])
        mouseclick(815, 295, spd, "no")
        mouseclick(500, 410, spd, "no")
        mouseclick(815, 240, spd, "no")
        SendText(pots[mpot])
        mouseclick(815, 295, spd, "no")
        mouseclick(500, 410, spd, "no")
    }
}

/*
    Crafting Potions
    mat = Crafting Materials, 0 or 1, 4strs
*/
craft(mat) {

}

; Use Randomizers
item() {
    global
    mouseclick(32, 365, spd, "no")
    mouseclick(900, 235, spd, "no")
    mouseclick(785, 260, spd, "no")
    SendText "Strange Controller"
    mouseclick(600, 315, spd, "no")
    mouseclick(485, 410, spd, "yes")
    mouseclick(785, 260, spd, "no")
    SendText "Biome Randomizer"
    mouseclick(600, 315, spd, "no")
    mouseclick(485, 410, spd, "no")
}

; Only use Strange Controller and Biome Randomizer
onlyrandom() {
    global
    mouseclick(785, 260, spd, "no")
    SendText "Strange Controller"
    mouseclick(600, 315, spd, "no")
    mouseclick(485, 410, spd, "yes")
    mouseclick(785, 260, spd, "no")
    SendText "Biome Randomizer"
    mouseclick(600, 315, spd, "no")
    mouseclick(485, 410, spd, "no")
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
    if (spot = 5) {
        mouseclick(32, 485, spd, "no")
        mouseclick(32, 365, spd, "no")
        mouseclick(900, 235, spd, "no")
    }
    loop {
        check()
        if (not spot = 5) {
            
        }
        if (spot = 5) {
            onlyrandom()
        }
        else if (ctl = 1) {
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