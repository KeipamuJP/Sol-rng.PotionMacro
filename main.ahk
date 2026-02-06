#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; 変数
inifile := A_WorkingDir "\config.ini"
potions := ["1. Godlike Potion", "2. Godly Potion[Zeus]", "3. Godly Potion[Poseidon]", "4. Godly Potion[Hades]", "5. Heavenly Potion", "6. Potion of bound", "7. Diver Potion", "8. Zombie Potion"]
potwords := ["Godlike", "Godly", "Godly", "Godly", "Heavenly", "Bound", "Diver", "Zombie"]
items := ["con", "bio"]
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
moveanim := 2
interval := 100

; 関数
/*
    config.iniが存在しない場合に設定するスクリプト
*/
ini_setup(*) {
    if not FileExist(inifile) {
        try {
            FileAppend("[Crafting]`nAutoadd=1`nAutorandomizer=1", inifile)
            MsgBox("初めて起動されたので、`n現在のフォルダにコンフィグファイルを生成しました。", "初回起動", "OK Iconi")
        } catch Any as err {
            errout(err)
        }
    }
    try {
        global Autoadd := IniRead(inifile, "Crafting", "Autoadd")
        global Autorandomizer := IniRead(inifile, "Crafting", "Autorandomizer")
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
    MsgBox("Error Catched: " String(err), "Exeption", "OK IconX")
    ExitApp(-1)
}

/*
    ポーションセレクト
*/
selpot(num:=1) {
    mmove(1163, 190)
    mclick(True)
    SendText(potwords[potnum])
    Sleep(interval)
    Send('{Enter}')
    Sleep(interval)
    local mousey := 96 * num + 242 - 96
    mmove(1163, mousey)
    mclick()
}

/*
    セットアップ
*/
setup(startup:=False) {
    Send('f')
    Sleep(1500)
    if InStr(guistat.pot, "Godly") {
        selnum := potnum - 1
        selpot(selnum)
    } else {
        selpot()
    }
    if (Autoadd == 1 and startup) {
        mmove(310, 586)
        mclick()
    }
    mmove(156, 585)
    mclick()
}

/*
    自動ランダマイザー使用
*/
userandom() {
    mmove(28, 365)
    mclick()
    mmove(905, 240)
    mclick()
    local i := 1
    loop(2) {
        mmove(785, 262)
        mclick()
        SendText(items[i])
        mmove(606, 341)
        mclick()
        mmove(486, 412)
        mclick()
        i++
    }
    mmove(28, 365)
    mclick()
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
    IniWrite(guistat.Autorandomizer, inifile, "Crafting", "Autorandomizer")
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
    setup(True)

    ; メインループ
    loop {
        mmove(770, 488)
        mclick()
        i := 1
        loop (4) {
            potid := Integer(4 * potnum - 4 + i)
            mousey := 38 * i + 270
            if (potmat[potid] != 0) {
                if (potmat[potid] != 1) {
                    mmove(728, mousey)
                    mclick(True)
                    SendText(potmat[potid])
                }
                mmove(803, mousey)
                mclick()
            }
            i++
        }
        if (Autorandomizer == 1) {
            loop(3) {
                mmove(1163, 190)
                mclick(True)
                Send('{Delete}')
                Sleep(interval)
                Send('{Enter}')
                Sleep(interval)
            }
            mmove(1317, 128)
            mclick()
            Sleep(1500)
            userandom()
            setup()
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
    if (Autorandomizer == 1) {
        mgui.Add("Checkbox", "vAutorandomizer Checked", "Auto Randomizer")
    } else {
        mgui.Add("Checkbox", "vAutorandomizer", "Auto Randomizer")
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
