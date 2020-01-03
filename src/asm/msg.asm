; msg.asm

Messages                proc
  InitESP:              db "Initialising WiFi...", CR, 0
  InitDone:             db "Initialised", CR, 0
  Connect1:             db "Connecting to ", 0
  Connect2:             db "...", CR, 0
  Connected:            db "Connected", CR, 0
  UsingTZ:              db "Getting ", 0
  UsingTZDef:           db "Getting default zone (GMT)...", CR, 0
  Sending1:             db "Sending ", 0
  Sending2:             db " chars...", CR, 0
  Received:             db "Received ", 0
  Setting:              db "Setting date and time...", CR, 0
pend

Errors                  proc
  HostLen:              db "1 HOSTNAME too lon", 'g'|128
  ESPComms1:            db "2 WiFi communication erro", 'r'|128
  ESPComms2:            db "3 WiFi communication erro", 'r'|128
  ESPComms3:            db "4 WiFi communication erro", 'r'|128
  ESPComms4:            db "5 WiFi communication erro", 'r'|128
  ESPComms5:            db "6 WiFi communication erro", 'r'|128
  ESPComms6:            db "7 WiFi communication erro", 'r'|128
  ESPConn1:             db "8 Server connection erro", 'r'|128
  ESPConn2:             db "9 Server connection erro", 'r'|128
  ESPConn3:             db "A Server connection erro", 'r'|128
  ESPConn4:             db "B Server connection erro", 'r'|128
  ZoneLen:              db "C ZONE too lon", 'g'|128
  Break:                db "D BREAK - CONT repeat", 's'|128
  NotNext:              db "E Next require", 'd'|128
  ESPTimeout:           db "F WiFi or server timeou", 't'|128
  DateNFF:              db "G Missing .date comman", 'd'|128
  TimeNFF:              db "H Missing .time comman", 'd'|128
  BadResp1:             db "I Invalid server respons", 'e'|128
  BadResp2:             db "J Invalid server respons", 'e'|128
  BadResp3:             db "K Invalid server respons", 'e'|128
  BadResp4:             db "L Invalid server respons", 'e'|128
  BadResp5:             db "M Invalid server respons", 'e'|128
  BadResp6:             db "N Invalid server respons", 'e'|128
  BadResp7:             db "O Invalid server respons", 'e'|128
  BadResp8:             db "P Invalid server respons", 'e'|128
  BadResp9:             db "Q Invalid server respons", 'e'|128
  BadResp10:            db "R Invalid server respons", 'e'|128
  BadResp11:            db "S Invalid server respons", 'e'|128
  BadResp12:            db "T Invalid server respons", 'e'|128
  BadResp13:            db "U Invalid server respons", 'e'|128
  BadResp14:            db "V Invalid server respons", 'e'|128
  BadResp15:            db "W Invalid server respons", 'e'|128
  BadResp16:            db "X Invalid server respons", 'e'|128
  BadResp17:            db "Y Invalid server respons", 'e'|128
  BadResp18:            db "Z Invalid server respons", 'e'|128
  BadResp19:            db "a Invalid server respons", 'e'|128
  BadResp20:            db "b Invalid server respons", 'e'|128
  BadResp21:            db "c Invalid server respons", 'e'|128
pend

Commands                proc
  CIPSTART1:            db "AT+CIPSTART=\"TCP\",\""
                        CIPSTART1Len equ $-CIPSTART1
  CIPSTART2:            db "\","
                        CIPSTART2Len equ $-CIPSTART2
  Terminate:            db CR, LF, 0
                        TerminateLen equ $-Terminate
  CIPSEND:              db "AT+CIPSEND="
                        CIPSENDLen equ $-CIPSEND
pend

Files                   proc
  Date:                 db "/dot/date", 0
  Time:                 db "/dot/time", 0
pend

PrintRst16              proc
                        ei
Loop:                   ld a, (hl)
                        inc hl
                        or a
                        jr z, Return
                        rst 16
                        jr Loop
Return:                 di
                        ret
pend

PrintRst16Error         proc
                        ei
Loop:                   ld a, (hl)
                        ld b, a
                        and %1 0000000
                        ld a, b
                        jp nz, LastChar
                        inc hl
                        rst 16
                        jr Loop
Return:                 di
                        ret
LastChar                and %0 1111111
                        rst 16
                        jr Return
pend

PrintHelp               proc
                        ld hl, Msg
                        call PrintRst16
                        jp Return.ToBasic
Msg:                    db "NXTP", CR
                        db "Set date/time from internet", CR, CR
                        db "nxtp", CR
                        db "Show help", CR, CR
                        db "nxtp SERVER PORT [OPTIONS [...]]", CR
                        db "Lookup and set current date/time", CR, CR
                        db "SERVER", CR
                        db "Hostname or IP of time server", CR
                        db "List of public servers at:", CR
                        db "https://tinyurl.com/nxtpsrv", CR, CR
                        db "PORT", CR
                        db "Network port of time server", CR, CR
                        db "OPTIONS", CR
                        db "  -z=TIMEZONECODE", CR
                        db "  Your current timezone code", CR
                        db "  If omitted, uses UK time", CR
                        db "  List of timezone codes at:", CR
                        db "  https://tinyurl.com/tznxtp", CR, CR
                        db "NXTP v1.", BuildNoValue, " ", BuildDateValue, CR
                        db Copyright, " 2019 Robin Verhagen-Guest", CR
                        db 0
pend

PrintBufferProc         proc
                        ld de, MsgBuffer
                        ldir
                        xor a
                        ld (de), a
                        inc de
                        ld hl, MsgBuffer
                        call PrintRst16
                        ret
pend

PrintBufferLen          proc
                        ld a, (hl)
                        ei
                        rst 16
                        di
                        inc hl
                        dec bc
                        ld a, b
                        or c
                        jr nz, PrintBufferLen
                        ret
pend

