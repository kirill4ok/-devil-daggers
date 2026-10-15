#NoEnv
Critical
SendMode Input
SetWorkingDir %A_ScriptDir%
SetMouseDelay, -1
SetBatchLines, -1

$XButton2::
    ; === 1. Стартовый клик (Строки 1-4 со скриншота) ===
    Click, Down
    USleep(48580)  ; ~50 мс (7 кадров по 6.94 мс)
    Click, Up
    USleep(76340)  ; ~76 мс (11 кадров по 6.94 мс)
    
    ; === 2. Бесконечный цикл Shotgun Tech (Строки 5-9 со скриншота) ===
    While GetKeyState("XButton2", "P")
    {
        Click, Down
        
        ; Удержание ЛКМ для отмены анимации. На 144 FPS вместо 295 мс 
        ; лучшую скорость дает фаза в 41 кадр (~284.5 мс)
        USleep(284540) 
        
        Click, Up
        
        ; Пауза между выстрелами. Вместо 75 мс используем 10 кадров (~69.4 мс)
        ; Это делает стрельбу значительно агрессивнее и быстрее
        USleep(69400) 
    }
return

; Высокоточный аппаратный таймер процессора (микросекунды)
USleep(Microseconds) {
    static Freq
    if (!Freq)
        DllCall("QueryPerformanceFrequency", "Int64*", Freq)
    DllCall("QueryPerformanceCounter", "Int64*", Start)
    Target := Start + (Microseconds * Freq / 1000000)
    Loop {
        DllCall("QueryPerformanceCounter", "Int64*", Current)
        if (Current >= Target)
            break
    }
}
