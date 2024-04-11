; This script expects that the physical Alt key has been reassigned as logical Ctrl, physical Win as Alt, and physical Ctrl as Win. (SharpKeys)

#NoEnv ; dunno what this means
#KeyHistory 0 ; this neither

; *** General Shortcuts
;#If not WinActive("ahk_exe VirtualBoxVM.exe")
;Not using If because AltTab shortcuts ignore it.


; Fix Alt-Tab to be like Command-Tab and Command-`
<^Tab::AltTab
<^`::ShiftAltTab

!Tab::Send ^{Tab}
!+Tab::Send ^+{Tab}

; RSI relief...
#If, GetKeyState("CapsLock","t")
  d::LButton
  e::RButton
  a::MButton
  s::Click WheelUp
  f::Click WheelDown
  w::Click WheelLeft
  r::Click WheelRight
  ~LButton::
    SetCapsLockState, off
    return
  `;::
    SetCapsLockState, off
    return

#If not WinActive("ahk_exe VirtualBoxVM.exe")

; Date stamp
^+Ins::Send, %A_YYYY%-%A_MM%-%A_DD%

; Minimize as "Command"-H. For actual Ctrl-H, use physical Ctrl-H
$^H::WinMinimize, A ; $ means only trigger if physical keys pressed, not if AHK sends those keystrokes
#H::Send {Ctrl down}{h}{Ctrl up}

; Window resizer
; https://superuser.com/questions/18215/is-there-a-way-to-resize-a-window-to-specific-sizes-eg-800x600-1024x768
#\:: ; [Win]+[\]
    WinGet, window, ID, A
    InputBox, width, Resize, Width:, , 140, 130
    InputBox, height, Resize, Height:, , 140, 130
    WinMove, ahk_id %window%, , , , width, height
    return

; Text editing, except in Premiere
#If not (WinActive("ahk_exe VirtualBoxVM.exe") || WinActive("ahk_class Premiere Pro"))

; Recreate Option-left/right/backspace for manipulating words in text editors
Alt & Backspace::Send {Ctrl down}{Backspace}{Ctrl up}

Alt & Left::
GetKeyState, state, shift
if state = D
Send {Ctrl down}{Shift down}{Left}{Shift up}{Ctrl up}
else
Send {Ctrl down}{Left}{Ctrl up}
Return

Alt & Right::
GetKeyState, state, shift
if state = D
Send {Ctrl down}{Shift down}{Right}{Shift up}{Ctrl up}
else
Send {Ctrl down}{Right}{Ctrl up}
Return



; Browsers
#If WinActive("ahk_class Chrome_WidgetWin_1") || WinActive("ahk_class MozillaWindowClass")

Ctrl & Left::
If GetKeyState("LWin", "P") { 
 Send {Blind}{Left}
 Return
}
GetKeyState, state, Shift
if state = D
Send {RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}
else
Send {LAlt down}{Left}{LAlt up}
Return

Ctrl & Right::
If GetKeyState("LWin", "P") { 
 Send {Blind}{Right}
 Return
}
GetKeyState, state, Shift
if state = D
Send {RCtrl down}{Tab}{RCtrl up}
else
Send {LAlt down}{Right}{LAlt up}
Return

Ctrl & [::Send {LAlt down}{Left}{LAlt up}

Ctrl & ]::Send {LAlt down}{Right}{LAlt up}

;LAlt & Tab::
;GetKeyState, state, LShift
;if state = D
;Send {RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}
;else
;Send {RCtrl down}{Tab}{RCtrl up}
;Return



; Outlook
#If WinActive("ahk_class rctrl_renwnd32")

LWin & 1:: ; fix so that my Ctrl-Shift-1 Outlook shortcut stays with the same physical keys
GetKeyState, state, LShift
if state = D
KeyWait, LShift
KeyWait, LWin
KeyWait, 1
Send {RShift down}{RCtrl down}{1}{RCtrl up}{RShift up}{LShift up}
Return



; Windows Explorer
; Back and Forward shortcuts. TODO: make this more universal.
; As is, there is no way to send (generically) a logical Alt-Left/Right.
#If WinActive("ahk_class CabinetWClass")
Ctrl & Left::
Send {LAlt down}{Left}{LAlt up}
Return

Ctrl & Right::
Send {LAlt down}{Right}{LAlt up}
Return

Ctrl & Up::
Send {LAlt down}{Up}{LAlt up}
Return

Ctrl & Down::
Send {LAlt down}{Down}{LAlt up}
Return
