#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; ~= Variable =~
mspeed := 2
interval := 100
old_w := 1366
old_h := 768
rw := 0
rh := 0
pots := ["1. Godly Potion [Zeus]", "2. Godly Potion [Poseidon]", "3. Godly Potion [Hades]", "4. Godlike Potion"]
q_len := 4
pot_q := ["GodlyZeus", "GodlyPos", "GodlyHades", "Godlike Potion"]
craft_yq := [445, 485, 525, 560]
craft_q := [
    25, 25, 1, 0, ; GodlyZeus
    50, 1, 1, 1, ; GodlyPos
    50, 1, 0, 0, ; GodlyHades
    1, 1, 1, 600 ; Godlike
]

; ~= Definition =~
/*
    Use for clicking
    x: Select x pos
    y: Select y pos
*/
mouseclick(x, y) {
    global
    new_x := Round(x / old_w * A_ScreenWidth)
    new_y := Round(y / old_h * A_ScreenHeight)

    SendMode "Event"
    MouseMove(new_x, new_y, mspeed)
    Send("{Click}")
    Sleep(interval)
}

/*
    Use for Scrolling page
    x: Select x pos
    y: Select y pos
    ud: Select up or down for scrolling direction
    lp: Scroll loops
*/
mousescroll(x, y, ud, lp) {
    global
    new_x := Round(x / old_w * A_ScreenWidth)
    new_y := Round(y / old_h * A_ScreenHeight)

    SendMode "Event"
    MouseMove(new_x, new_y, mspeed)
    Send("{Click}")

    if (ud = "up") {
        loop(lp) {
            Send("{WheelUp}")
            Sleep(interval * 1.5)
        }
    } else if (ud = "down") {
        loop(lp) {
            Send("{WheelDown}")
            Sleep(interval * 1.5)
        }
    } else {
        MsgBox("Mousescroll's ud value is incorrect! please fix it")
        ExitApp(-1)
    }
}

c_loop() {
    global
    a_query := data_pot * q_len - 3
    c_yquery := 1
    loop(4) {
        if (craft_q[a_query] != 0) {
            if (craft_q[a_query] = 1) {
                mouseclick(568, craft_yq[c_yquery])
            } else {
                mouseclick(510, craft_yq[c_yquery])
                SendText(craft_q[a_query])
                mouseclick(568, craft_yq[c_yquery])
            }
        }
        a_query++
        c_yquery++
    }
    mouseclick(410, 410)
}

; Main script
main_macro() {
    global
    SendMode "Event"

    local data := mg.Submit(true)
    data_pot := SubStr(data.SelPot, 1, 1)
    data_aar := data.bool_aar

    WinActivate("Roblox")
    WinGetClientPos(,,&rw,&rh,"Roblox")
    ; MsgBox(rw " | " rh)
    if (rw != A_ScreenWidth or rh != A_ScreenHeight) {
        Send("{F11}")
    }
    
    Send("f")
    mousescroll(815, 300, "up", 8)
    mouseclick(815, 240)
    mouseclick(815, 300)
    if (data_aar = 1) {
        mouseclick(505, 410)
    }
    mouseclick(815, 240)
    SendText(pot_q[data_pot])
    mouseclick(815, 300)
    if (data_aar = 1) {
        mouseclick(505, 410)
    }

    loop {
        c_loop()
    }
}

; Use for stopping macro
stop_macro() {
    ask := MsgBox("マクロを終了しますか？", "", "OKCancel Icon!")
    if (ask = 'OK') {
        ExitApp(0)
    } else if (ask = 'Cancel') {
        
    } else {
        ExitApp(-1)
    }
}

; Making GUI
make_gui() {
    global
    mg := Gui()
    mg.Add("Text", "", "制作するポーションを選択してください:")
    mg.Add("DDL", "vSelPot Choose1", pots)
    mg.Add("Checkbox", "vbool_aar Checked", "Auto Add Reset")
    mg.Show("Center AutoSize")
}

; ~= main =~
make_gui()

F1:: {
    main_macro()
}

F2:: {
    stop_macro()
}
