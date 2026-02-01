#Requires AutoHotkey v2.0

F1::{
    loop{
        Send("e")
        Sleep(100)
        MouseMove(256,490)
        MouseClick('Left')
        Sleep(100)
    }
}

F2::{
    status := MsgBox("Exit?","Exitting macro",'OKCancel Iconi')
    if (status == "OK") {
        ExitApp()
    }
}