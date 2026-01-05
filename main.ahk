#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; 変数
inifile := A_WorkingDir "\config.ini"
potions := ["1. Godlike Potion", "2. Godly Potion[Zeus]", "3. Godly Potion[Poseidon]", "4. Godly Potion[Hades]", "5. Heavenly Potion", "6. Potion of bound", "7. Diver Potion", "8. Zombie Potion"]
potwords := ["Godlike", "GodlyZeus", "GodlyPoseidon", "GodlyHades", "Heavenly", "Bound", "Diver", "Zombie"]
potmat := [
    1, 1, 1, 600,
    25, 25, 1, 0,
    50, 1, 1, 0,
    50, 1, 0, 0,
    250, 2, 1, 0,
    1, 3, 0, 100,
    20, 1, 0, 0,
    10, 1, 0, 0
]
ww := 0
wh := 0
Autoadd := 0
moveanim := 2
interval := 100

; 関数
/*
    config.iniが存在しない場合に設定するスクリプト
*/
ini_setup(*) {
    if not FileExist(inifile) {
        try {
            FileAppend("[Crafting]`nAutoadd=1", inifile)
            MsgBox("初めて起動されたので、`n現在のフォルダにコンフィグファイルを生成しました。", "初回起動", "OK Iconi")
        } catch Any as err {
            errout(err)
        }
    }
    try {
        global Autoadd := IniRead(inifile, "Crafting", "Autoadd")
    }
}

/*
    マウス移動用の関数
    x: x座標
    y: y座標
*/
mmove(x:=0, y:=0){
    nx := Round(x / 1366 * A_ScreenWidth)
    ny := Round(y / 768 * A_ScreenHeight)
    MouseMove(nx, ny, moveanim)
    Sleep(interval)
}

/*
    マウスクリック用の関数
    dc: <Boolean>, ダブルクリックにするかどうか
    Scr: <up or down>, スクロールするかどうか
    ScrLoop: <int>, スクロールのループ回数
*/
mclick(dc:=False,Scr:="",ScrLoop:=0) {
    if (dc) {
        loop (2) {
            Click('Left')
            Sleep(interval / 4)
        }
    } else {
        Click('Left')
        Sleep(interval / 2)
    }
    Sleep(interval / 2)
    ; スクロールの動作
    if (StrLower(Scr) == "down") {
        loop (ScrLoop) {
            Click('WheelDown')
            Sleep(interval)
        }
    } else if (StrLower(Scr) == "up") {
        loop (ScrLoop) {
            Click('WheelUp')
            Sleep(interval)
        }
    }
}

/*
    エラー文
*/
errout(err) {
    MsgBox("Error Catched: " err, "Exeption", "OK IconX")
    ExitApp(-1)
}

/*
    メインスクリプト、ループ
*/
main(*) {
    ; guiから数値取得
    global
    guistat := mgui.Submit(False)
    mgui.Minimize()
    IniWrite(guistat.Autoadd, inifile, "Crafting", "Autoadd")
    SendMode("Event")

    ; config取得
    try {
        WinGetPos(,, &ww, &wh, "Roblox")
        potnum := Integer(SubStr(guistat.pot, 1, 1))
        Autoadd := IniRead(inifile, "Crafting", "Autoadd")
    } catch Any as err {
        errout(err)
    }

    ; セットアップ
    WinActivate("Roblox")
    if (ww != A_ScreenWidth or wh != A_ScreenHeight) {
        Send('{F11}')
    }
    Send('f')
    mmove(820, 300)
    mclick(, "up", 15)
    mmove(820, 240)
    mclick()
    SendText(potwords[potnum])
    mmove(820, 300)
    mclick()
    if (Autoadd == 1) {
        mmove(505, 410)
        mclick()
    }

    ; メインループ
    loop {
        mmove(410, 410)
        mclick()
        i := 1
        loop (4) {
            potid := Integer(4 * potnum - 4 + i)
            mousey := 38 * i + 410
            if (potmat[potid] != 0) {
                if (potmat[potid] != 1) {
                    mmove(510, mousey)
                    mclick(True)
                    SendText(potmat[potid])
                }
                mmove(567, mousey)
                mclick()
            }
            i++
        }
    }
}

/*
    スクリプト中断
*/
exitscript(*) {
    status := MsgBox("マクロを終了しますか？", "Exiting Macro", "OKCancel Iconi Default2")
    if (status == "OK") {
        ExitApp()
    } else {
        WinActivate("Roblox")
    }
}

/*
    マクロの設定や開始ができるウィンドウ
*/
main_gui(*) {
    global mgui := Gui("-MinimizeBox -Resize -SysMenu")
    mgui.Title := "Potion Macro"
    mgui.Add("Text", , "Select Potion:")
    mgui.Add("DropDownList", "vpot Choose1", potions)
    if (Autoadd == 1) {
        mgui.Add("Checkbox", "vAutoadd Checked", "Reset auto add")
    } else {
        mgui.Add("Checkbox", "vAutoadd", "Reset auto add")
    }
    Submit := mgui.Add("Button", "xm", "Start").OnEvent("Click", main)
    Exit := mgui.Add("Button", "x+2", "Exit").OnEvent("Click", exitscript)
    mgui.Show("Center")
}

; メイン
ini_setup
main_gui

F1:: {
    main
}

F2:: {
    exitscript
}
