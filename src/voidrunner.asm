;
; **** ZP FIELDS **** 
;
RAM_EAL = $9D
;
; **** ZP ABSOLUTE ADRESSES **** 
;
zp02 = $02
zp03 = $03
charToPlot = $04
colourToPlot = $05
currScreenPtrLo = $06
currScreenPtrHi = $07
zp08 = $08
zp09 = $09
zp0A = $0A
RAM_SUBFLG = $10
RAM_DATPTR_LO = $40
RAM_DATPTR_HI = $41
RAM_INPPTR_LO = $42
RAM_INPPTR_HI = $43
a44 = $44
a46 = $46
RAM_OPPTR = $48
RAM_FORPNT = $49
;
; **** ZP POINTERS **** 
;
RAM_PDIR = $00
RAM_STREND = $31
;
; **** FIELDS **** 
;
SCREEN_PTR_LO = $0340
SCREEN_PTR_HI = $0360
; **** ABSOLUTE ADRESSES **** 
;
aE000 = $E000
aE008 = $E008
GRAPHICS_CHIP = $FF07
KEYBOARD_LATCH = $FF08
RASTER_INTERRUPT_STATUS = $FF09
INTERRUPT_ENABLE_REGISTER = $FF0A
RASTER_COMPARE_REGISTER = $FF0B
;
; **** POINTERS **** 
;
p30 = $0030
p0100 = $0100
p0101 = $0101
p01FF = $01FF
p03A0 = $03A0
pF8F0 = $F8F0
pFF00 = $FF00
CharacterSet = $3C00
;
; **** EXTERNAL JUMPS **** 
;
e4020 = $4020
;
; **** PREDEFINED LABELS **** 
;
RAM_DORES = $000F
INTERRUPT_ROUTINE = $0314
COLOR_RAM = $0800
SCREEN_RAM = $0C00

        * = $1001

;------------------------------------------------------------------
; SYS 4112 (Branch execution to JumpToInitialize)
;------------------------------------------------------------------
        .BYTE $15,$10,$C3,$07,$9E,$34,$31,$31
        .BYTE $32,$20,$3A,$20,$00
        BRK #$00

JumpToInitialize
        JMP LaunchGame

        ORA (RAM_PDIR,X) ;PDIR    7501 on-chip data-direction register
a1015   .BYTE $03
a1016   .BYTE $01
a1017   .BYTE $04
a1018   .BYTE $16
a1019   .BYTE $01
a101A   .BYTE $01
a101B   .BYTE $01
a101C   .BYTE $01
a101D   .BYTE $00
a101E   .BYTE $FF
a101F   .BYTE $B4
a1020   .BYTE $01
a1021   .BYTE $01
a1022   .BYTE $04
a1023   .BYTE $05,$01,$01
a1026   .BYTE $B0
a1027   .BYTE $24

;------------------------------------------------------------------
; AdvanceBackgroundAnimation
; Perform the next in a set sequence of subroutines, listed below.
; I suspect this is an animation routine.
;------------------------------------------------------------------
AdvanceBackgroundAnimation
        LDY #$00
        LDA a17E2
        AND #$07
        TAY 
        ; Use the value of Y (0-7) to pick the subroutine to run.
        LDA AnimStateMapLo,Y
        STA a103F
        LDA AnimStateMapHi,Y
        STA a1040
        JMP (a103F) ; $1051 at first pass.

a103F   .BYTE $51
a1040   .BYTE $10

; This is the set of subroutines to cycle through:
; ResetAnimationState ($1051)
; AnimationState1 ($1208)
; AnimationState2 ($126A)
; ResetAnimationState ($1051)
; AnimationState3 ($12BF)
; ResetAnimationState ($1051)
; AnimationState4 ($12B3)
; AnimationState1 ($1208)
AnimStateMapLo   .BYTE $51,$08,$6A,$51,$BF,$51,$B3,$08
AnimStateMapHi   .BYTE $10,$12,$12,$10,$12,$10,$12,$12

;------------------------------------------------------------------
;ResetAnimationState
;------------------------------------------------------------------
ResetAnimationState
        LDY #$00
        JSR ResetDynamicCharset
        DEC a1019
        BNE b106B
        LDA a101A
        STA a1019
        LDA a119B
        CLC 
        ADC a101E
        STA a101E
b106B   DEC a101C
        BNE b1080
        LDA a101B
        STA a101C
        LDA a101F
        CLC 
        ADC a119C
        STA a101F
b1080   DEC a1020
        BNE b108E
        LDA a1021
        STA a1020
        INC a1026
b108E   DEC a1022
        BNE b109C
        LDA a1023
        STA a1022
        INC a1027
b109C   LDA a101E
        PHA 
        LDA a101F
        PHA 
        LDA a1026
        PHA 
        LDA a1027
        PHA 
b10AC   LDA a101E
        AND #$3F
        TAX 
        LDA f2C9E,X
        STA a1015
        LDA a101F
        AND #$3F
        TAX 
        LDA f2C9E,X
        STA a1016
        LDA a1026
        AND #$3F
        TAX 
        LDA f2C9E,X
        STA a1017
        LDA a1027
        AND #$3F
        TAX 
        LDA f2C9E,X
        STA a1018
        JSR ManipulateCharset
        LDA a1027
        CLC 
        ADC #$08
        STA a1027
        LDA a1026
        CLC 
        ADC #$08
        STA a1026
        LDA a101F
        CLC 
        ADC #$08
        STA a101F
        LDA a101E
        CLC 
        ADC #$08
        STA a101E
        INY 
        INY 
        CPY #$10
        BNE b10AC
        PLA 
        STA a1027
        PLA 
        STA a1026
        PLA 
        STA a101F
        PLA 
        STA a101E
        LDA a101D
        BEQ b116F
        LDA #$00
        STA a101D
        JSR GetRandomValue
        AND #$07
        CLC 
        ADC #$04
        TAX 
        STX a11E5
        LDA f119D,X
        STA a101A
        LDA f11AD,X
        STA a119B
        JSR GetRandomValue
        AND #$07
        CLC 
        ADC #$04
        TAX 
        STX a11E6
        LDA f119D,X
        STA a101B
        LDA f11AD,X
        STA a119C
        JSR GetRandomValue
        AND #$07
        CLC 
        ADC #$01
        STA a1020
        STA a1021
        JSR GetRandomValue
        AND #$07
        CLC 
        ADC #$01
        STA a1022
        STA a1023
b116F   RTS 

a1171   =*+$01
;------------------------------------------------------
; GetRandomValue
;------------------------------------------------------
GetRandomValue
        LDA aE008
        INC a1171
        RTS 

;------------------------------------------------------
; ManipulateCharset
;------------------------------------------------------
ManipulateCharset
        LDA a1015
        LDX a1021
        BEQ b1185
        JSR ManipulateCharsetImpl
        JMP j1188

b1185   STA a1199
j1188   LDA a1016
        LDX a1023
        BEQ b1193
        JMP j11D0

b1193   STA a119A
        JMP j11E7

zpFA = $FA
a1199   .BYTE $03
a119A   .BYTE $0B
a119B   .BYTE $03
a119C   .BYTE $04
f119D   .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $02,$03,$04,$05,$06,$07,$08,$09
f11AD   .BYTE $08,$07,$06,$05,$04,$03,$02,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
;------------------------------------------------------
; ManipulateCharsetImpl
;------------------------------------------------------
ManipulateCharsetImpl
        LDA a1015
        CLC 
        ROR 
        STA zpFA 
        LDA a1017
        CLC 
        ROR 
        CLC 
        ADC zpFA 
        STA a1199
        RTS 

j11D0   LDA a1016
        CLC 
        ROR 
        STA zpFA 
        LDA a1018
        CLC 
        ROR 
        CLC 
        ADC zpFA 
        STA a119A
        JMP j11E7

a11E5   .BYTE $05
a11E6   .BYTE $04
j11E7   TYA 
        PHA 
        LDA a1199
        CLC 
        ROR 
        PHA 
        LDA a119A
        CLC 
        ROR 
        TAY 
        PLA 
        TAX 
        JSR UpdateDynamicCharset
        PLA 
        TAY 
        RTS 

a11FD   .BYTE $00,$00
f11FF   .BYTE $00,$08,$10,$18,$20,$28,$30,$38
a1207   .BYTE $02

;------------------------------------------------------
; AnimationState1
;------------------------------------------------------
AnimationState1   DEC a1207
        BEQ b120E
        RTS 

b120E   LDA #$02
        STA a1207
        JSR ResetDynamicCharset
        LDX #$07
b1218   INC f11FF,X
b121B   LDA f11FF,X
        AND #$3F
        STA f11FF,X
        TAY 
        LDA f2C9E,Y
        CLC 
        ROR 
        TAY 
        STX a11FD
        TXA 
        ASL 
        TAX 
        JSR AnimationState2Impl
        LDX a11FD
        DEX 
        BPL b1218
        RTS 

f123A   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f124A   .BYTE $01,$02,$03,$04,$05,$06,$07,$08
        .BYTE $08,$07,$06,$05,$04,$03,$02,$01
f125A   .BYTE $01,$02,$03,$04,$05,$06,$07,$08
        .BYTE $08,$07,$06,$05,$04,$03,$02,$01
;------------------------------------------------------
; AnimationState2
;------------------------------------------------------
AnimationState2
       JSR ResetDynamicCharset
        LDX #$0F
b126F   DEC f124A,X
        BNE b1285
        LDA f125A,X
        STA f124A,X
        INC f123A,X
        LDA f123A,X
        AND #$0F
        STA f123A,X
b1285   TXA 
        TAY 
        LDA f123A,X
        STX a11FD
        CPY #$08
        BMI b1293
        EOR #$0F
b1293   TAX 
        JSR AnimationState2Impl
        LDX a11FD
        DEX 
        BPL b126F
        RTS 

a129E   .BYTE $00
;------------------------------------------------------
; AnimationState2Impl
;------------------------------------------------------
AnimationState2Impl
        LDA a129E
        BEQ b12AA
        TXA 
        PHA 
        TYA 
        TAX 
        PLA 
        TAY 
b12AA   JSR UpdateDynamicCharset
        LDA #$00
        STA $FF15    ;Background color register
        RTS 

;------------------------------------------------------
; AnimationState4
;------------------------------------------------------
AnimationState4
        LDA #$01
        STA a129E
        JSR AnimationState2
        DEC a129E
        RTS 

;------------------------------------------------------
; AnimationState3
;------------------------------------------------------
AnimationState3
        LDA #$01
        STA a129E
        JSR AnimationState1
        DEC a129E
        RTS 

;------------------------------------------------------------------
; ResetDynamicCharset
;------------------------------------------------------------------
ResetDynamicCharset
        LDX #$7F ; 127 bytes, i.e. 16 characters
        LDA a12D7 ;$FF
b12D0   STA startOfDynamicCharset,X
        DEX 
        BPL b12D0
        RTS 

;------------------------------------------------------------------
; UpdateDynamicCharset
;------------------------------------------------------------------
a12D7   .BYTE $FF
f12D8   .BYTE $00,$02,$04,$06,$20,$22,$24,$26
        .BYTE $40,$42,$44,$46,$60,$62,$64,$66
f12E8   .BYTE $00,$00,$00,$00,$08,$08,$08,$08
        .BYTE $10,$10,$10,$10,$18,$18,$18,$18
f12F8   .BYTE $40,$10,$04,$01,$40,$10,$04,$01
        .BYTE $40,$10,$04,$01,$40,$10,$04,$01
f1308   .BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
        .BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
UpdateDynamicCharset
        LDA a12D7
        BNE b1337
        LDA f12D8,Y
        CLC 
        ADC f12E8,X
        TAY 
        LDA startOfDynamicCharset,Y
        ORA f12F8,X
        STA startOfDynamicCharset,Y
        LDX a2CFE
        BNE b1336
        STA startOfDynamicCharset+$01,Y
b1336   RTS 

b1337   LDA f12D8,Y
        CLC 
        ADC f12E8,X
        TAY 
        LDA startOfDynamicCharset,Y
        AND f1308,X
        STA startOfDynamicCharset,Y
        STA startOfDynamicCharset+$01,Y
        RTS 

screenRAMLo = $FE
screenRAMHi = $FF
;------------------------------------------------------------------
; PointScreenArrayToFirstColumn
; Update the SCREEN_PTR_LO/SCREEN_PTR_HI arrays to point to the 
; first column in each row (25 rows of 40 columns).
;------------------------------------------------------------------
PointScreenArrayToFirstColumn
        LDA #>SCREEN_RAM
        STA screenRAMHi
        LDA #<SCREEN_RAM
        STA screenRAMLo

        ; Start at zero
        LDX #$00
        ; Set the first byte to be the start of the screen RAM (1st col)
b1356   LDA screenRAMLo
        STA SCREEN_PTR_LO,X
        LDA screenRAMHi
        STA SCREEN_PTR_HI,X

        ; Increment by 40 bytes to the start of the second row.
        LDA screenRAMLo
        CLC 
        ADC #$28 ; Skip 40 columns
        STA screenRAMLo

        ; Add any carry to the high byte.
        LDA screenRAMHi
        ADC #$00
        STA screenRAMHi

        INX 
        CPX #$19 ; Keep going until 25 rows are done.
        BNE b1356
        RTS 

;------------------------------------------------------------------
; Screen_GetPointer
;------------------------------------------------------------------
Screen_GetPointer
        LDX zp03
        LDY zp02
        LDA SCREEN_PTR_LO,X
        STA currScreenPtrLo
        LDA SCREEN_PTR_HI,X
        STA currScreenPtrHi
        LDA (currScreenPtrLo),Y
        RTS 

;------------------------------------------------------------------
; DrawCharacterOnScreen
;------------------------------------------------------------------
DrawCharacterOnScreen
        LDX zp03
        LDY zp02
        LDA SCREEN_PTR_LO,X
        STA currScreenPtrLo
        LDA SCREEN_PTR_HI,X
        STA currScreenPtrHi
        LDA charToPlot
        STA (currScreenPtrLo),Y
        LDA currScreenPtrHi
        SEC 
        SBC #$04
        STA currScreenPtrHi
        LDA colourToPlot
        STA (currScreenPtrLo),Y
        RTS 

f13A2   .BYTE $FF
f13A3   .BYTE $FF
f13A4   .BYTE $FF
f13A5   .BYTE $FF
f13A6   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF
f13C2   .BYTE $00
f13C3   .BYTE $00
f13C4   .BYTE $00
f13C5   .BYTE $00
f13C6   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00
f13E2   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f1402   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f1422   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f1442   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f1462   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f1482   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
a14A2   .BYTE $00
a14A3   .BYTE $00

;------------------------------------------------------
; s14A4
;------------------------------------------------------
s14A4   LDX a14A3
        LDA a14A2
        CMP #$20
        BEQ b14C3
        LDA #$20
        STA a46
b14B2   LDA f13A2,X
        BMI b14C6
        INX 
        TXA 
        AND #$1F
        TAX 
        STX a14A3
        DEC a46
        BNE b14B2
b14C3   LDX #$FF
        RTS 

b14C6   INC a14A2
        TXA 
        RTS 

;------------------------------------------------------------------
;RunSequenceFromf13A2
;------------------------------------------------------------------
RunSequenceFromf13A2
        LDX #$00
b14CD   LDA f13A2,X
        BMI b14D9
        TXA 
        PHA 
        JSR CallSelectedRoutine
        PLA 
        TAX 
b14D9   INX 
        CPX #$20 ; Run all 32 routines
        BNE b14CD
        RTS 


;------------------------------------------------------------------
;CallSelectedRoutine
;------------------------------------------------------------------
SelectedRoutineLo   .BYTE $00
SelectedRoutineHi   .BYTE $00
CallSelectedRoutine
        ; Uses the value at index in f13E2 to pick a routine to call.
        ; The valid routines are listed below.
        LDY f13E2,X
        LDA SelRoutLo,Y
        STA SelectedRoutineLo
        LDA SelRoutHi,Y
        STA SelectedRoutineHi
        JMP (SelectedRoutineLo)

;s17E3  $17E3
;s1981  $1981
;s1B14  $1B14
;s1BB0  $1BB0
;s1CC8  $1CC8
;s1D1A  $1D1A
;s1E5B  $1E5B
;s1ED5  $1ED5
;s2010  $2010
;s1981  $1981
;s1981  $1981
;s1981  $1981
;s1981  $1981
;s1ED5  $1ED5
;s217A  $217A
;s217A  $217A

SelRoutLo
        .BYTE $E3,$81,$14,$B0,$C8,$1A,$5B,$D5
        .BYTE $10,$81,$81,$81,$81,$D5,$7A,$7A
SelRoutHi
        .BYTE $17,$19,$1B,$1B,$1C,$1D,$1E,$1E
        .BYTE $20,$19,$19,$19,$19,$1E,$21,$21
a1513   .BYTE $00

b1514   DEC a15CD
        BEQ b1529
b1519   RTS 

;------------------------------------------------------
; s151A
;------------------------------------------------------
s151A   LDA a15CF
        BEQ b1514
        LDA a14A2
        BNE b1519
        LDA #$00
        STA a15CF
b1529   LDA #$01
        STA a15CD
        LDY a17E2
        LDA #$01
        STA a1513
        LDA BgrndAnimationData1,Y
        CLC 
        ADC #$15
        STA RAM_DATPTR_LO
        LDA BgrndAnimationData2,Y
        ADC #$00
        STA RAM_DATPTR_HI 
        LDY a15CE
j1548   LDA (RAM_DATPTR_LO),Y
        CMP #$23
        BNE b155A
        INY 
        LDA (RAM_DATPTR_LO),Y
        STA a15D0
        INY 
        STY a15D1
        LDA (RAM_DATPTR_LO),Y
b155A   CMP #$24
        BNE b156F
        DEC a15D0
        BEQ b156B
        LDY a15D1
        LDA (RAM_DATPTR_LO),Y
        JMP b156F

b156B   INY 
        JMP j1548

b156F   CMP #$FD
        BEQ b15B8
        CMP #$FE
        BNE b1589
        INY 
        LDA (RAM_DATPTR_LO),Y
        STA a15CD
        BNE b1584
        LDA #$01
        STA a15CF
b1584   INY 
        STY a15CE
        RTS 

b1589   AND #$80
        BEQ b1595
        LDA (RAM_DATPTR_LO),Y
        AND #$7F
        STA a1513
        INY 
b1595   LDA (RAM_DATPTR_LO),Y
        STA a15CB
        INY 
        LDA (RAM_DATPTR_LO),Y
        STA a15D2
        INY 
        JSR s1BF9
        STY a15CE
b15A7   LDA a1513
        PHA 
        JSR s1741
        PLA 
        STA a1513
        DEC a15CB
        BNE b15A7
b15B7   RTS 

b15B8   LDA a15CC
        BNE b15B7
        LDA #$01
        STA a15CC
        STA playerIsAlive
        LDA #$00
        STA a15CE
        RTS 

a15CB   .BYTE $00
a15CC   .BYTE $00
a15CD   .BYTE $01
a15CE   .BYTE $00
a15CF   .BYTE $00
a15D0   .BYTE $00
a15D1   .BYTE $00
a15D2   .BYTE $00
BgrndAnimationData1   .BYTE $0F,$47,$7F,$B4,$DD,$FF,$6D,$A9
        .BYTE $DB,$0E,$2F,$52,$74,$A6,$D9,$10
        .BYTE $3C,$64,$97,$C4,$E9,$1C,$4F,$76
        .BYTE $BE,$F1,$24,$4B,$80,$A3
BgrndAnimationData2   .BYTE $16,$16,$16,$16,$16,$16,$26,$26
        .BYTE $26,$27,$27,$27,$27,$27,$27,$28
        .BYTE $28,$28,$28,$28,$28,$29,$29,$29
        .BYTE $29,$29,$2A,$2A,$2A,$2A,$2F,$59
        .BYTE $41,$4B,$2F,$14,$13,$15,$16,$0B
        .BYTE $0C,$0B,$0C,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$23,$06,$8C,$01,$08
        .BYTE $FF,$00,$FF,$03,$0D,$FF,$00,$06
        .BYTE $FE,$32,$24,$23,$06,$8F,$01,$02
        .BYTE $FF,$00,$04,$01,$0E,$FF,$00,$FF
        .BYTE $FE,$20,$24,$FE,$00,$FD,$4C,$4C
        .BYTE $41,$4D,$41,$14,$13,$15,$16,$0C
        .BYTE $0B,$0C,$0B,$00,$00,$00,$00,$04
        .BYTE $04,$04,$04,$23,$06,$8C,$01,$08
        .BYTE $FF,$17,$FF,$03,$0D,$FF,$17,$02
        .BYTE $FE,$32,$24,$23,$06,$8F,$01,$02
        .BYTE $FF,$17,$00,$01,$0E,$FF,$17,$FF
        .BYTE $FE,$20,$24,$FE,$00,$FD,$47,$4F
        .BYTE $41,$54,$20,$13,$12,$14,$13,$0B
        .BYTE $0C,$0C,$0D,$00,$00,$00,$00,$00
        .BYTE $06,$02,$04,$23,$04,$82,$01,$02
        .BYTE $FF,$00,$06,$82,$01,$02,$FF,$17
        .BYTE $00,$82,$01,$02,$00,$FF,$02,$82
        .BYTE $01,$02,$27,$FF,$06,$FE,$00,$24
        .BYTE $FE,$00,$FD,$53,$48,$45,$45,$50
        .BYTE $14,$13,$15,$16,$0B,$0B,$0B,$0B
        .BYTE $00,$00,$0C,$0C,$00,$00,$00,$00
        .BYTE $23,$04,$86,$02,$02,$FF,$00,$FF
        .BYTE $FE,$00,$24,$9F,$01,$02,$FF,$00
        .BYTE $FF,$FE,$00,$FD,$43,$41,$4D,$45
        .BYTE $4C,$14,$13,$15,$16,$0B,$0B,$0B
        .BYTE $0B,$00,$00,$00,$00,$07,$07,$01
        .BYTE $01,$23,$20,$01,$0E,$FF,$00,$FF
        .BYTE $FE,$0A,$24,$FE,$00,$FD,$42,$45
        .BYTE $41,$53,$54,$13,$14,$13,$14,$0B
        .BYTE $0B,$0B,$0B,$00,$00,$00,$00,$00
        .BYTE $00,$04,$04,$23,$02,$88,$01,$06
        .BYTE $14,$0C,$FF,$FE,$80,$24,$23,$04
        .BYTE $01,$05,$76,$24,$23,$04,$01,$04
        .BYTE $44,$00,$04,$01,$04,$44,$17,$00
        .BYTE $01,$04,$00,$44,$02,$01,$04,$27
        .BYTE $44,$06,$FE,$30,$24,$FE,$00,$FD
;------------------------------------------------------
; s1741
;------------------------------------------------------
s1741   LDA #$01
        STA a17C0
b1746   JSR s14A4
        CPX #$FF
        BEQ b17BE
        LDA a15D2
        STA f1402,X
        LDA #$04
        STA f1422,X
        LDA #$0F
        STA f1442,X
        LDA #$00
        STA f13E2,X
        LDA a17C0
        STA f1462,X
        CMP #$01
        BEQ b1781
        LDA a1BF6
        STA f13A2,X
        LDA a1BF7
        STA f13C2,X
        LDA a1BF8
        STA f1482,X
        JMP j17B6

b1781   LDA a1BF6
        BPL b17A4
        JSR s18D7
        AND #$1F
        CLC 
        ADC #$04
        STA a1BF6
        JSR s18D7
        AND #$0F
        CLC 
        ADC #$04
        STA a1BF7
        JSR s18D7
        AND #$07
        STA a1BF8
b17A4   LDA a1BF6
        STA f13A2,X
        LDA a1BF7
        STA f13C2,X
        LDA a1BF8
        STA f1482,X
j17B6   INC a17C0
        DEC a1513
        BNE b1746
b17BE   RTS 

a17BF   .BYTE $30
a17C0   .BYTE $09
a17C1   .BYTE $01

;------------------------------------------------------------------
; UpdateBackgroundAnimationData
;------------------------------------------------------------------
UpdateBackgroundAnimationData
        DEC a17BF
        BNE b17CF
        JSR RunSequenceFromf13A2
        LDA #$30
        STA a17BF
b17CF   DEC a17C1
        BNE b17E1
        LDA #$FF
        STA a17C1
        LDA playerIsAlive
        BNE b17E1
        JSR s151A
b17E1   RTS 

a17E2   .BYTE $00

;------------------------------------------------------
; s17E3
;------------------------------------------------------
s17E3
        DEC f1422,X
        BEQ b17E9
        RTS 

b17E9   LDA f1462,X
        BEQ b17F9
        LDA #$06
        STA f1422,X
        DEC f1462,X
        BEQ b17F9
        RTS 

b17F9   LDA #$06
        STA f1422,X
RAM_BMLUM   =*+$02
        JSR s1804
        JMP j185B

;------------------------------------------------------
; s1804
;------------------------------------------------------
s1804   LDA f13A2,X
        PHA 
        STA zp02 
        LDA f13C2,X
        PHA 
        STA zp03 
        LDA f1442,X
        CLC 
        ADC zp02 
        STA zp02 
        LDA f1442,X
        CLC 
        ADC zp03 
        STA zp03 
        LDA #$01
        STA a36A2
        JSR s18AD
        PLA 
        PHA 
        SEC 
        SBC f1442,X
        STA zp03 
        JSR s18AD
        PLA 
        STA zp03 
        PLA 
        PHA 
        SEC 
        SBC f1442,X
        STA zp02 
        LDA zp03 
        PHA 
        SEC 
        SBC f1442,X
        STA zp03 
        JSR s18AD
        PLA 
        CLC 
        ADC f1442,X
        STA zp03 
        PLA 
        SEC 
        SBC f1442,X
        STA zp02 
        JMP s18AD

j185B   DEC f1442,X
        BMI b18CE
j1860   LDA #$00
        STA a36A2
        LDA #$71
        STA colourToPlot 
        LDA f13A2,X
        SEC 
        SBC f1442,X
        STA zp02 
        LDA f13C2,X
        CLC 
        ADC f1442,X
        STA zp03 
        LDA #$6F
        STA charToPlot
        JSR s18AD
        LDA f13A2,X
        CLC 
        ADC f1442,X
        STA zp02 
        DEC charToPlot
        JSR s18AD
        LDA f13C2,X
        SEC 
        SBC f1442,X
        STA zp03 
        INC charToPlot
        JSR s18AD
        LDA f13A2,X
        SEC 
        SBC f1442,X
        STA zp02 
        DEC charToPlot
        JMP s18AD

b18AC   RTS 

;------------------------------------------------------
; s18AD
;------------------------------------------------------
s18AD   LDA zp02
        STX a18DE
        BMI b18AC
        CMP #$28
        BPL b18AC
        LDA zp03
        BMI b18AC
        CMP #$18
        BPL b18AC
        JSR Screen_GetPointer
        AND #$80
        BNE b18CA
        JSR DrawCharacter2
b18CA   LDX a18DE
        RTS 

b18CE   JMP j18DF

        .BYTE $FF,$FF,$FF ;ISC $FFFF,X
        .BYTE $FF,$FF,$FF ;ISC $FFFF,X
a18D8   =*+$01
;------------------------------------------------------
; s18D7
;------------------------------------------------------
s18D7   LDA aE000
        INC a18D8
        RTS 

a18DE   .BYTE $00
j18DF   LDA f1402,X
        TAY 
;------------------------------------------------------
; SelectStepInAnimation1
;------------------------------------------------------
SelectStepInAnimation1
        TYA 
        STA f13E2,X
        LDA f190C,Y
        STA SelectedRoutineLo
        LDA f191C,Y
        STA SelectedRoutineHi
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        LDA f13A2,X
        STA zp02
        LDA f13C2,X
        STA zp03
        JSR DrawCharacter2
        PLA 
        TAX 
        JMP (SelectedRoutineLo)

f190C   .BYTE $00,$3C,$4C,$60,$9B,$0F,$27,$B2
        .BYTE $D4,$3C,$3C,$3C,$3C,$B2,$55,$44
f191C   .BYTE $00,$19,$19,$19,$1C,$1D,$1E,$1E
        .BYTE $1F,$19,$19,$19,$19,$1E,$21,$21
f192C   .BYTE $00,$81,$73,$00,$61,$65,$85,$81
        .BYTE $91,$91,$91,$91,$00,$61,$51,$51
        LDA #$03
        STA f1462,X
        LDA #$00
        STA f1422,X
        LDA #$05
        STA f1442,X
        RTS 

        LDA f13A2,X
        CLC 
        ADC f13C2,X
        AND #$07
        ORA #$08
        STA f1422,X
        LDA #$03
        STA f1462,X
        RTS 

        LDA #$00
        STA f1442,X
        STA f1462,X
        LDA #$03
        STA f1402,X
        JSR DrawDataToScreen
        RTS 

f1971   BRK #$00
        BPL b1985
        JSR e4020
        BVS b19EA
        RTI 

        JSR a1020
        BPL b1980
b1980   BRK #$DE
        .BYTE $62    ;JAM 
        .BYTE $14,$D0 ;NOP $D0,X
b1985   NOP 
        LDA #$03
        STA f1462,X
        INC f1422,X
        LDA f1422,X
        AND #$0F
        TAY 
        LDA f1971,Y
        ORA #$0E
        STA colourToPlot 
        LDA #$EC
        STA charToPlot
        LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
        JMP DrawCharacterOnScreen

;------------------------------------------------------
; s19AC
;------------------------------------------------------
s19AC   STY a19C1
        LDY #$1F
b19B1   LDA zp02 
b19B3   CMP f13A2,Y
        BEQ b19C2
        DEY 
        BPL b19B3
        LDY a19C1
j19BE   LDA #$00
        RTS 

a19C1   .BYTE $00
b19C2   LDA zp03 
        CMP f13C2,Y
        BEQ b19D2
        DEY 
        BPL b19B1
        LDY a19C1
        JMP j19BE

b19D2   STX a19FE
        TYA 
        TAX 
        LDA f13E2,Y
        TAY 
        LDA f2273,Y
        BEQ b19E3
        JSR s2261
b19E3   JSR s1F9F
        LDA f1A00,Y
b19EA   =*+$01
        BEQ b19F5
        STY a19FF
        TAY 
        JSR SelectStepInAnimation1
        LDY a19FF
b19F5   LDX a19FE
        LDA f1A12,Y
        BMI b1A11
        RTS 

a19FE   .BYTE $00
a19FF   .BYTE $00
f1A00   .BYTE $00,$03,$03,$00,$01,$00,$07,$03
        .BYTE $09,$0A,$0B,$0C,$03,$00,$05,$05
        RTS 

b1A11   RTS 

f1A12   .BYTE $00,$05,$FF,$00,$06,$03,$04,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
a1A22   .BYTE $00
a1A23   .BYTE $00
a1A24   .BYTE $00
a1A25   .BYTE $00,$00,$00,$00,$00
a1A2A   .BYTE $FF
a1A2B   .BYTE $00
a1A2C   .BYTE $00
;------------------------------------------------------
; PlaySounds2
;------------------------------------------------------
PlaySounds2
        LDY a1A2A
        BMI b1A11
        LDA playerIsAlive
        BNE b1A11
        LDA f1A46,Y
        STA a1A2B
        LDA f1A4B,Y
        STA a1A2C
        JMP (a1A2B)

f1A46   .BYTE $50,$A2,$CF,$04,$24
f1A4B   .BYTE $1A,$1A,$21,$22,$22
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$6F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA a1A22
        BEQ b1A69
        LDA a1A23
        JSR PlaySounds3
        DEC a1A22
        RTS 

b1A69   LDA a1A24
        BEQ b1A92
        LDA a1A25
        JSR PlaySounds3
        DEC a1A24
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$3F
        STA $FF11    ;Bits 0-3 : Volume control
        RTS 

;------------------------------------------------------
; PlaySounds3
;------------------------------------------------------
PlaySounds3   PHA 
        ROL 
        ROL 
        ROL 
        AND #$03
        STA $FF10    ;Voice #2 frequency, bits 8 & 9
        PLA 
        ROL 
        ROL 
        AND #$FC
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        RTS 

b1A92   LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$0F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$FF
        STA a1A2A
        RTS 

        LDA a1A22
        BEQ b1ABA
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$4F
        STA $FF11    ;Bits 0-3 : Volume control
        INC a1A22
        LDA a1A22
        JMP PlaySounds3

b1ABA   LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$2F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA a1A23
        JSR PlaySounds3
        LDA a1A23
        SEC 
        SBC #$10
        STA a1A23
        CMP #$68
        BNE b1AE4
        LDA #$F8
        STA a1A23
        DEC a1A24
        BNE b1AE4
        JMP b1A92

b1AE4   RTS 

j1AE5   LDA #$90
        STA a1A23
        LDA #$E0
        STA a1A25
        LDA #$03
        STA a1A22
        LDA #$05
        STA a1A24
        LDA #$00
        STA a1A2A
        RTS 

;------------------------------------------------------
; DrawDataToScreen
;------------------------------------------------------
DrawDataToScreen
        LDA #<pF8F0
        STA a1A22
        LDA #>pF8F0
        STA a1A23
        LDA #$03
        STA a1A24
        LDA #$01
        STA a1A2A
b1B13   RTS 

        DEC f1462,X
        BNE b1B13
        LDA #$03
        STA f1462,X
        LDA #$01
        STA a36A2
        LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
        TXA 
        PHA 
        JSR DrawCharacter2
        PLA 
        TAX 
        LDA #$ED
        STA charToPlot
        INC f1442,X
        LDA f1442,X
        AND #$0F
        TAY 
        LDA f1971,Y
        ORA f1422,X
        STA colourToPlot 
        LDA f1482,X
        AND #$07
j1B4E   TAY 
        LDA zp02 
        CLC 
        ADC f3872,Y
        STA zp02 
        LDA zp03 
        CLC 
        ADC f387A,Y
        STA zp03 
        BMI b1B6D
        CMP #$18
        BPL b1B6D
        LDA zp02 
        BMI b1B6D
        CMP #$28
        BMI b1B79
b1B6D   TYA 
        CLC 
        ADC #$05
        AND #$07
        STA f1482,X
        JMP j1B4E

b1B79   TXA 
        PHA 
        LDA #$00
        STA a36A2
        JSR Screen_GetPointer
        CMP #$EC
        BNE b1B8F
        PLA 
        TAX 
        LDY f1482,X
        JMP b1B6D

b1B8F   AND #$F0
        CMP #$E0
        BNE b1BA0
        LDA (currScreenPtrLo),Y
        AND #$08
        BNE b1BA0
        LDA #$01
        STA playerIsAlive
b1BA0   JSR DrawCharacterOnScreen
        PLA 
        TAX 
        LDA zp02 
        STA f13A2,X
        LDA zp03 
        STA f13C2,X
b1BAF   RTS 

        DEC f1402,X
        BNE b1BAF
        LDA f1442,X
        BNE b1BD3
        LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        JSR ModifyAndDrawCharacterOnScreen
        PLA 
        TAX 
        DEC a36A2
b1BD3   LDA #$03
        STA f1402,X
        JSR s1804
        INC f1442,X
        LDA f1442,X
        CMP #$10
        BEQ b1BE8
        JMP j1860

b1BE8   LDA #$FF
        STA f13A2,X
        LDA #$00
        STA f13E2,X
        DEC a14A2
        RTS 

a1BF6   .BYTE $FF
a1BF7   .BYTE $FF
a1BF8   .BYTE $FF
;------------------------------------------------------
; s1BF9
;------------------------------------------------------
s1BF9   LDA (RAM_DATPTR_LO),Y
        CMP #$76
        BNE b1C06
        INY 
RAM_BMCOLR LDA #$FF
        STA a1BF6
        RTS 

b1C06   LDA (RAM_DATPTR_LO),Y
        BPL b1C11
        JSR s18D7
        AND #$1F
        ADC #$04
b1C11   CMP #$44
        BNE b1C18
        LDA ShipData1
b1C18   STA a1BF6
        INY 
        LDA (RAM_DATPTR_LO),Y
        BPL b1C27
        JSR s18D7
        AND #$0F
        ADC #$04
b1C27   CMP #$44
        BNE b1C2E
        LDA ShipData2
b1C2E   STA a1BF7
        INY 
        LDA (RAM_DATPTR_LO),Y
        BPL b1C3B
        JSR s18D7
        AND #$07
b1C3B   STA a1BF8
        INY 
        RTS 

;------------------------------------------------------
; s1C40
;------------------------------------------------------
s1C40   LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        JSR DrawCharacter2
        PLA 
        TAX 
        LDA #$00
        STA a36A2
        RTS 

a1C5C   .BYTE $00

;------------------------------------------------------------------
; j1C5D
;------------------------------------------------------------------
j1C5D   LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
        TXA 
        PHA 
        JSR Screen_GetPointer
        STA a1C5C
        CMP a1D0E
        BNE b1C77
        PLA 
        TAX 
        RTS 

b1C77   AND #$F0
        CMP #$E0
        BNE b1C90
        LDA (currScreenPtrLo),Y
        AND #$08
        BNE b1C90
        LDA charToPlot
        AND #$F0
        CMP #$D0
        BEQ b1C90
        LDA #$01
        STA playerIsAlive
b1C90   JSR DrawCharacterOnScreen
        PLA 
        TAX 
        LDA #$00
        STA a1C5C
        RTS 

        LDA #$02
        STA f1402,X
        LDA #$F0
        STA f1422,X
        LDA f1482,X
        CMP #$02
        BNE b1CB3
        LDA #$F2
        STA f1422,X
        BNE b1CC7
b1CB3   CMP #$04
        BNE b1CBE
        LDA #$F1
        STA f1422,X
        BNE b1CC7
b1CBE   CMP #$06
        BNE b1CC7
        LDA #$F3
        STA f1422,X
b1CC7   RTS 

        DEC f1402,X
        BNE b1CC7
        LDA #$02
        STA f1402,X
        JSR s1C40
        LDY f1482,X
        LDA f13A2,X
        CLC 
        ADC f3872,Y
        STA f13A2,X
        BEQ b1D09
        CMP #$27
        BPL b1D09
        LDA f13C2,X
        CLC 
        ADC f387A,Y
        STA f13C2,X
        BEQ b1D09
        CMP #$17
        BPL b1D09
        LDA #$00
        STA a1D0E
        LDA f1422,X
        STA charToPlot
        LDA #$5C
        STA colourToPlot 
        JMP j1C5D

b1D09   LDY #$03
        JMP SelectStepInAnimation1

a1D0E   .BYTE $00
        LDA #$00
        STA f1422,X
        LDA #$04
        STA f1402,X
b1D19   RTS 

        DEC f1402,X
        BNE b1D19
        LDA #$01
        STA f1402,X
        LDA #$EC
        STA charToPlot
        JSR s18D7
        AND #$70
        ORA #$02
        STA colourToPlot 
        LDA #$00
        STA a1D0E
        JSR j1C5D
        LDA f1422,X
        BNE b1DB0
        DEC f1442,X
        BNE b1D59
        LDA #$EC
        STA f1462,X
        JSR s18D7
        AND #$07
        STA f1442,X
        LDA #$01
        STA f1482,X
        STA f1422,X
        RTS 

b1D59   LDA f13A2,X
        CMP ShipData1
        BNE b1D84
        LDA #$F4
        STA f1462,X
        LDA #$01
        STA f1482,X
        LDA #$01
        STA f1422,X
        LDA f13C2,X
        CMP ShipData2
        BMI b1D7E
        LDA #$00
        STA f1442,X
        RTS 

b1D7E   LDA #$04
        STA f1442,X
b1D83   RTS 

b1D84   LDA f13C2,X
        CMP ShipData2
        BNE b1D83
        LDA #$F5
        STA f1462,X
        LDA #$01
        STA f1482,X
        LDA #$01
        STA f1422,X
        LDA f13A2,X
        CMP ShipData1
        BMI b1DA9
        LDA #$06
        STA f1442,X
        RTS 

b1DA9   LDA #$02
        STA f1442,X
        RTS 

a1DAF   .BYTE $00
b1DB0   CMP #$02
        BEQ b1E0A
        LDA f1462,X
        STA charToPlot
        LDA f1482,X
        STA a1DAF
        TAY 
        LDA f1971,Y
        ORA #$0A
        STA colourToPlot 
        LDY f1442,X
        LDA f13A2,X
        STA zp02 
        LDA f13C2,X
        STA zp03 
j1DD4   LDA zp02 
        CLC 
        ADC f3872,Y
        STA zp02 
        LDA zp03 
        CLC 
        ADC f387A,Y
        STA zp03 
        TXA 
        PHA 
        TYA 
        PHA 
        JSR ModifyAndDrawCharacterOnScreen
        PLA 
        TAY 
        PLA 
        TAX 
        LDA a1DAF
        CMP #$01
        BEQ b1DFC
        DEC a1DAF
        JMP j1DD4

b1DFC   INC f1482,X
        LDA f1482,X
        CMP #$10
        BNE b1E09
        INC f1422,X
b1E09   RTS 

b1E0A   LDA #$01
        STA a36A2
        LDA #$0F
        STA f1482,X
        STA a1DAF
        LDY f1442,X
        JSR j1DD4
        LDA #$00
        STA f1422,X
        LDY #$01
        JMP SelectStepInAnimation1

        LDA #$03
        STA f1402,X
        LDA f1482,X
        ASL 
        ASL 
        STA a1EAC
        JSR s1EAB
        AND #$3F
        STA f1422,X
        JSR s1EAB
        AND #$03
        STA f1442,X
        INC f1442,X
        JSR s1EAB
        AND #$3F
        STA f1462,X
        JSR s1EAB
        AND #$03
        STA f1482,X
        INC f1482,X
b1E5A   RTS 

        DEC f1402,X
        BNE b1E5A
        LDA #$03
        STA f1402,X
        JSR s1C40
        LDA f1422,X
        CLC 
        ADC f1442,X
        AND #$3F
        STA f1422,X
        ASL 
        AND #$70
        ORA #$0C
        STA colourToPlot 
        LDA #$EC
        STA charToPlot
        LDY f1422,X
        LDA f2C9E,Y
        CLC 
        ADC #$04
        STA f13A2,X
        LDA f1462,X
        CLC 
        ADC f1482,X
        AND #$3F
        STA f1462,X
        TAY 
        LDA f2C9E,Y
        CLC 
        ROR 
        CLC 
        ADC #$04
        STA f13C2,X
        LDA #$00
        STA a1D0E
        JMP j1C5D

;------------------------------------------------------
; s1EAB
;------------------------------------------------------
s1EAB   .BYTE $AD
a1EAC   BRK #$FC
        INC a1EAC
        RTS 

        LDA #$04
        STA f1402,X
        LDA f13C2,X
        CMP ShipData2
        BMI b1ECA
        LDA #$F0
        STA f1422,X
        LDA #$00
        STA f1482,X
        RTS 

b1ECA   LDA #$F1
        STA f1422,X
        LDA #$04
        STA f1482,X
b1ED4   RTS 

        DEC f1402,X
        BNE b1ED4
        LDA #$02
        STA f1402,X
        JSR s1C40
        LDY f1482,X
        LDA f13C2,X
        CLC 
        ADC f387A,Y
        STA f13C2,X
        BEQ b1F06
        CMP #$17
        BEQ b1F06
        LDA #$00
        STA a1D0E
        LDA #$7F
        STA colourToPlot 
        LDA f1422,X
        STA charToPlot
        JMP j1C5D

b1F06   LDY #$03
        JMP SelectStepInAnimation1

;------------------------------------------------------
; s1F0B
;------------------------------------------------------
s1F0B   JSR Initializef13A2
        LDX #$09
b1F10   LDA SCREEN_RAM + $03C7,X
        STA CurrentScore,X
        DEX 
        BPL b1F10

        LDY #$03
        LDX #$00
b1F1D   JSR s1F2A
        DEY 
        BPL b1F1D
        LDA #$02
        STA playerIsAlive
        RTS 

playerIsAlive   .BYTE $00

;------------------------------------------------------
; s1F2A
;------------------------------------------------------
s1F2A   LDA ShipData1,Y
        STA f13A2,X
        STA f13A3,X
        STA f13A4,X
        SEC 
        SBC #$02
        STA f13A5,X
        CLC 
        ADC #$04
        STA f13A6,X
        LDA ShipData2,Y
        STA f13C2,X
        STA f13C5,X
        STA f13C6,X
        SEC 
        SBC #$02
        STA f13C3,X
        CLC 
        ADC #$04
        STA f13C4,X
        TYA 
        PHA 
        LDY #$04
b1F5E   LDA #$03
        STA f13E2,X
        LDA #$00
        STA f1442,X
        LDA #$02
        STA f1402,X
        INX 
        DEY 
        BPL b1F5E
        LDA #$14
        STA a14A2
        TXA 
        PHA 

        LDX #$03 ; Four ships.
b1F7A   LDA ShipData2,X
        ASL 
        STA f1F97,X
        DEX 
        BPL b1F7A

        LDX #$03 ; Four ships.
b1F86   LDY f1F97,X
        LDA colorSequence,Y
        STA f1F9B,X
        DEX 
        BPL b1F86

        PLA 
        TAX 
        PLA 
        TAY 
        RTS 

f1F97   .BYTE $00,$00,$00,$00
f1F9B   .BYTE $00,$00,$00,$00
;------------------------------------------------------
; s1F9F
;------------------------------------------------------
s1F9F   TXA 
        PHA 
        TYA 
        PHA 
        LDA f192C,Y
        BNE b1FAD
b1FA8   PLA 
        TAY 
        PLA 
        TAX 
        RTS 

b1FAD   PHA 
        AND #$0F
        TAY 
        PLA 
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        TAX 
b1FB9   TXA 
        PHA 

b1FBB   INC SCREEN_RAM + $03C7,X
        LDA SCREEN_RAM + $03C7,X
        CMP #$3A
        BNE b1FCD
        LDA #$30
        STA SCREEN_RAM + $03C7,X
        DEX 
        BPL b1FBB

b1FCD   PLA 
        TAX 
        DEY 
        BNE b1FB9
        BEQ b1FA8
        LDA f1482,X
        STA a1EAC
        JSR s1EAB
        AND #$01
        BNE b1FE5
        LDA #$02
        BNE b1FE7
b1FE5   LDA #$06
b1FE7   STA f1482,X
        LDA #$ED
        STA f1422,X
b1FEF   JSR s1EAB
        AND #$0F
        BEQ b1FEF
        STA f1442,X
        LDA f13C2,X
        BNE b2005
        LDA #$01
        STA f1462,X
        BNE b200A
b2005   LDA #$FF
        STA f1462,X
b200A   LDA #$06
        STA f1402,X
b200F   RTS 

        DEC f1402,X
        BNE b200F
        LDA #$03
        STA f1402,X
        JSR s1C40
        LDA f13A2,X
        LDY f1482,X
        CLC 
        ADC f3872,Y
        STA f13A2,X
        BEQ b2053
        BMI b2053
        CMP #$28
        BPL b2053
j2032   LDA f1422,X
        STA charToPlot
        LDA f13A2,X
        ASL 
        ASL 
        ASL 
        ASL 
        AND #$70
        ORA f1442,X
        STA colourToPlot 
        LDA #$EC
        STA a1D0E
        JSR j1C5D
        LDA a1C5C
        BNE b2053
        RTS 

b2053   LDA f1482,X
        AND #$04
        BNE b205E
        LDA #$06
        BNE b2060
b205E   LDA #$02
b2060   STA f1482,X
        TAY 
        LDA f13A2,X
        CLC 
        ADC f3872,Y
        STA f13A2,X
        LDA f13C2,X
        CLC 
        ADC f1462,X
        BEQ b2081
        CMP #$18
        BEQ b2081
        STA f13C2,X
        JMP j2032

b2081   LDY #$02
        JMP SelectStepInAnimation1

a2086   .BYTE $00
a2087   .BYTE $00
f2088   .BYTE $02,$08,$07,$0C,$0D,$04,$0D,$0E
a2090   .BYTE $60
a2091   .BYTE $2D
a2092   .BYTE $2D
a2093   .BYTE $00
a2094   .BYTE $FF
a2095   .BYTE $FF
;------------------------------------------------------
; DoSomeMoreAnimation
;------------------------------------------------------
DoSomeMoreAnimation
        DEC a2090
        BEQ b209C
        RTS 

b209C   LDA #$C0
        STA a2090
        LDA a2094
        CMP #$FF
        BEQ b20AE
        LDX a2086
        STA colorSequence,X
b20AE   LDA a2086
        CLC 
        ADC #$01
        CMP #$30
        BNE b20BA
        LDA #$00
b20BA   STA a2086
        TAX 
        AND #$07
        TAY 
        LDA colorSequence,X
        STA a2094
        LDA f2088,Y
        STA colorSequence,X
        LDA a2093
        BEQ b20D4
        BNE b20F5
b20D4   DEC a2091
        BNE b20F5
        LDA a2092
        STA a2091
        LDA a2094
        STA a2095
        LDA a2086
        STA a2087
        LDA #$07
        STA a2093
        LDA #$04
        JSR s2261
b20F5   LDA a2093
        BNE b20FB
        RTS 

b20FB   AND #$07
        TAY 
        LDX a2087
        LDA a2093
        ASL 
        ASL 
        ASL 
        ASL 
        AND #$70
        ORA f2088,Y
        STA colorSequence,X
        TXA 
        CLC 
        ROR 
        LDX #$00
b2115   CMP ShipData2,X
        BEQ b2120
        DEX 
        BPL b2115
        JMP j2134

b2120   LDA #$01
        STA playerIsAlive
        LDX a2087
        LDA a2095
        STA colorSequence,X
        LDA #$00
        STA a2093
        RTS 

j2134   DEC a2093
        BEQ b213A
        RTS 

b213A   LDX a2087
        LDA a2095
        STA colorSequence,X
        RTS 

        LDA #$DD
        STA f1422,X
        LDA #$DE
        STA f1442,X
        LDA #$71
        STA f1462,X
        BNE b2164
        LDA #$DB
        STA f1422,X
        LDA #$DC
        STA f1442,X
        LDA #$67
        STA f1462,X
b2164   LDA #$02
        STA f1402,X
        LDA f1482,X
        AND #$01
        BNE b2174
        LDA #$06
        BNE b2176
b2174   LDA #$02
b2176   STA f1482,X
b2179   RTS 

        DEC f1402,X
        BNE b2179
        LDA #$02
        STA f1402,X
        JSR s1C40
        LDY f1482,X
        LDA f13A2,X
        CLC 
        ADC f3872,Y
        STA f13A2,X
        BEQ b21B5
        BMI b21B5
        CMP #$28
        BPL b21B5
b219C   LDA f1482,X
        CMP #$02
        BNE b21A8
        LDA f1422,X
        BNE b21AB
b21A8   LDA f1442,X
b21AB   STA charToPlot
        LDA f1462,X
        STA colourToPlot 
        JMP j1C5D

b21B5   LDA f1482,X
        EOR #$04
        STA f1482,X
        LDA f13C2,X
        CLC 
        ADC #$01
        STA f13C2,X
        CMP #$18
        BNE b219C
        LDY #$07
        JMP SelectStepInAnimation1

        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$2F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA a1A22
        SEC 
        SBC #$04
        STA a1A22
        CMP #$60
        BEQ b21E9
        JMP PlaySounds3

b21E9   LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$0F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$FF
        STA a1A2A
        RTS 

        LDA #$A0
        STA a1A22
        LDA #$02
        STA a1A2A
        RTS 

        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$20
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$D0
        JSR PlaySounds3
        DEC a1A22
        BEQ b21E9
        RTS 

        LDA #$04
        STA a1A22
        LDA #$03
        STA a1A2A
        RTS 

        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$1F
        ORA #$20
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$02
        JSR PlaySounds3
        DEC a1A22
        BEQ b21E9
        RTS 

        LDA #$08
        STA a1A22
        LDA #$04
        STA a1A2A
        RTS 

a2244   .BYTE $00
;------------------------------------------------------
; s2245
;------------------------------------------------------
s2245   TAY 
        LDA f2257,Y
        STA a2255
        LDA f225C,Y
        STA a2256
        JMP (a2255)

a2255   .BYTE $00
a2256   .BYTE $00
f2257   .BYTE $00,$00,$F9,$19
f225B   .BYTE $39
f225C   .BYTE $00,$00,$21,$22,$22
;------------------------------------------------------
; s2261
;------------------------------------------------------
s2261   STA a2244
        TXA 
        PHA 
        TYA 
        PHA 
        LDA a2244
        JSR s2245
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

f2273   .BYTE $00,$00,$02,$00,$02,$03,$02,$03
        .BYTE $02,$03,$03,$03,$03,$03,$02,$02
TopScoreText   .TEXT "OKALA INCARNADINE             "
RestOfTopFiveText
        .TEXT "0000500000GAF THE HORSE IN TEARS        "
        .TEXT "0000400000TARQUIN BISCUIT BARREL        "
        .TEXT "0000300000ATAHUALPA INCA                "
        .TEXT "0000200000NUMBER SIX                    "
        .TEXT "0000100000"
LivesLeft   .BYTE $00
a234C   .BYTE $FF

;------------------------------------------------------------------
; Display the high score screen.
;------------------------------------------------------------------
DisplayHiScoreScreen
        JSR ClearScreen
        JSR RunAnAnimationOnScreen
        LDA #$02
        STA a3196
        LDA #$00
        STA a12D7
        STA a2579
        LDA #$0F
        STA a234C
        LDA #$00
        JSR FillColorSequenceData

        ; Print title for high score screen
        LDX #$27
b236C   LDA HiScoreTitle,X
        CMP #$20 ; No need to print spaces
        BEQ b237B
        STA SCREEN_RAM + $0028,X ; Middle of screen
        LDA #$77 ; Add color to text
        STA COLOR_RAM + $0028,X
b237B   DEX 
        BPL b236C

        LDA #<TopScoreText
        STA RAM_DATPTR_LO
        LDA #>TopScoreText
        STA RAM_DATPTR_HI 
        LDA #$05
        STA RAM_INPPTR_LO
        LDA #>SCREEN_RAM + $00A0
        STA a44
        LDA #<SCREEN_RAM + $00A0
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
b2392   LDY #$27
b2394   LDA (RAM_DATPTR_LO),Y
        CMP #$20
        BEQ b23B6
        STA (RAM_INPPTR_HI),Y ;INPPTR  Vector: INPUT routine
        LDA a44
        PHA 
        SEC 
        SBC #$04
        STA a44
        LDA RAM_INPPTR_LO
        ASL 
        ASL 
        ASL 
        ASL 
        CLC 
        ADC #$20
        AND #$F0
        ORA #$04
        STA (RAM_INPPTR_HI),Y ;INPPTR  Vector: INPUT routine
        PLA 
        STA a44
b23B6   DEY 
        BPL b2394

        LDA RAM_DATPTR_LO
        CLC 
        ADC #$28
        STA RAM_DATPTR_LO
        LDA RAM_DATPTR_HI 
        ADC #$00
        STA RAM_DATPTR_HI 
        LDA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        CLC 
        ADC #$50
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        LDA a44
        ADC #$00
        STA a44
        DEC RAM_INPPTR_LO
        BNE b2392
        LDY LivesLeft
        BNE b23DE
        LDY #$01
b23DE   LDA f241A,Y
        TAY 
        LDX #$07
b23E4   LDA f2420,X
        STA colorSequence,Y
        INY 
        DEX 
        BPL b23E4
        LDA LivesLeft
        BNE b2450
        JSR DrawSomethingToBottomOfScreen
        LDA #$30
        STA RAM_DATPTR_LO

        ; Wait a little, unless the player presses fire.
        LDX #$20
b23FC   LDY #$00
        LDA currentJoystick1Reading
        AND #$40
        BEQ b240F
b2405   DEY 
        BNE b2405
        DEX 
        BNE b23FC
        DEC RAM_DATPTR_LO
        BNE b23FC

b240F   LDX #$F8
        TXS 
        LDA #$00
        STA LivesLeft
        JMP JumpToInitialize

f241A   .BYTE $00,$05,$09,$0D,$11,$15
f2420   .BYTE $06,$26,$46,$06,$06,$46,$26,$06

HiScoreTitle
       .TEXT "VOIDRUNNER FIVE BEST GAMES AND SCORERS /"

b2450   LDA #>SCREEN_RAM + $0258
        STA RAM_DATPTR_HI 
        LDA #<SCREEN_RAM + $0258
        STA RAM_DATPTR_LO
        LDA #$71
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine

        ; Print the text in HighScorePrompt to screen
b245C   LDY #$27 ; The text is 39 chars long
b245E   LDA HighScorePrompt,Y
        CMP #$20 ; No need to print a space
        BEQ b2476
        STA (RAM_DATPTR_LO),Y
        LDA RAM_DATPTR_HI 
        PHA 
        SEC 
        SBC #$04
        STA RAM_DATPTR_HI 
        LDA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        STA (RAM_DATPTR_LO),Y
        PLA 
        STA RAM_DATPTR_HI 
b2476   DEY 
        BPL b245E

        LDA RAM_DATPTR_LO
        CLC 
        ADC #$28
        STA RAM_DATPTR_LO
        LDA RAM_DATPTR_HI 
        ADC #$00
        STA RAM_DATPTR_HI 
        LDA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        SEC 
        SBC #$10
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        AND #$F0
        CMP #$F0
        BNE b245C
        JMP j24BE

HighScorePrompt   .TEXT "EGO TRIP TIME  /   /   ENTER YOUR HANDLE"
j24BE   LDA #$0C
        STA RAM_DATPTR_HI 
        LDA #$08
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        LDA #$A0
        STA RAM_DATPTR_LO
        STA RAM_INPPTR_LO
        LDX #$00
        LDY LivesLeft
j24D1   DEY 
        BEQ b24F0
        TXA 
        CLC 
        ADC #$27
        TAX 
        LDA RAM_DATPTR_LO
        CLC 
        ADC #$50
        STA RAM_DATPTR_LO
        STA RAM_INPPTR_LO
        LDA RAM_DATPTR_HI 
        ADC #$00
        STA RAM_DATPTR_HI 
        SEC 
        SBC #$04
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine
        JMP j24D1

b24F0   LDY #$00
b24F2   JSR CheckUserInputHiScoreMenu
        INY 
        INX 
        CPY #$1C
        BNE b24F2
        JMP b240F

;------------------------------------------------------
; CheckUserInputHiScoreMenu
;------------------------------------------------------
CheckUserInputHiScoreMenu
        LDA (RAM_INPPTR_LO),Y
        PHA 
        LDA #$77
        STA (RAM_INPPTR_LO),Y
j2505   LDA (RAM_DATPTR_LO),Y
        AND #$E0
        BNE b250F
        LDA #$20
        STA (RAM_DATPTR_LO),Y
b250F   LDA currentJoystick1Reading
        AND #$04 ; Left
        BNE b2522
        LDA (RAM_DATPTR_LO),Y
        SEC 
        SBC #$01
        JSR s255D
        STA (RAM_DATPTR_LO),Y
        BNE b2533
b2522   LDA currentJoystick1Reading
        AND #$08 ; Right
        BNE b2546
        LDA (RAM_DATPTR_LO),Y
        CLC 
        ADC #$01
        JSR s255D
        STA (RAM_DATPTR_LO),Y
b2533   LDA #<p30
        STA RAM_OPPTR ;OPPTR   
b2537   LDA #>p30
        STA RAM_FORPNT ;FORPNT  Pointer: Index variable for FOR/NEXT
b253B   DEC RAM_FORPNT ;FORPNT  Pointer: Index variable for FOR/NEXT
        BNE b253B
        DEC RAM_OPPTR ;OPPTR   
        BNE b2537
        JMP j2505

b2546   LDA currentJoystick1Reading
        AND #$40 ; Fire
        BNE j2505
b254D   LDA currentJoystick1Reading
        AND #$4F ;Fire, Left, Right, Up or Down
        CMP #$4F
        BNE b254D
        PLA 
        LDA (RAM_DATPTR_LO),Y
        STA TopScoreText,X
        RTS 

;------------------------------------------------------
; s255D
;------------------------------------------------------
s255D   CMP #$21
        BNE b2564
        LDA #$41
        RTS 

b2564   CMP #$1F
        BNE b256B
        LDA #$5A
b256A   RTS 

b256B   CMP #$5B
        BNE b2572
        LDA #$20
        RTS 

b2572   CMP #$40
        BNE b256A
        LDA #$20
        RTS 

a2579   .BYTE $00
;------------------------------------------------------
; PlayASound
;------------------------------------------------------
PlayASound   
        LDA a234C
        CMP #$FF
        BNE b2587
        LDA #$0F
        STA $FF11    ;Bits 0-3 : Volume control
b2586   RTS 

b2587   LDA a234C
        ORA #$30
        STA $FF11    ;Bits 0-3 : Volume control
        LDY a2579
        LDA f2C9E,Y
        ASL 
        ASL 
        STA a2ED6
        JSR PlaySoundImpl
        LDA a2579
        CLC 
        ADC #$04
        STA a2579
        CMP #$40
        BNE b2586
        LDA #$00
        STA a2579
        DEC a234C
        RTS 

;------------------------------------------------------
; PrepareGameOverSequence
;------------------------------------------------------
PrepareGameOverSequence
        LDA #<RestOfTopFiveText
        STA RAM_DATPTR_LO
        LDA #>RestOfTopFiveText
        STA RAM_DATPTR_HI 
        LDA #<CurrentScore
        STA RAM_INPPTR_LO
        LDA #>CurrentScore
        STA RAM_INPPTR_HI ;INPPTR  Vector: INPUT routine

        LDX #$00
        LDA #$05
        STA a44
b25C9   LDY #$00
b25CB   LDA (RAM_DATPTR_LO),Y
        CMP (RAM_INPPTR_LO),Y
        BEQ b25D5
        BPL b25DA
        BMI b25F3
b25D5   INY 
        CPY #$0A
        BNE b25CB
b25DA   LDA #$28
        CLC 
        ADC RAM_DATPTR_LO
        STA RAM_DATPTR_LO
        LDA RAM_DATPTR_HI 
        ADC #$00
        STA RAM_DATPTR_HI 
        TXA 
        CLC 
        ADC #$28
        TAX 
        DEC a44
        BNE b25C9
        JMP JmpGameOver

b25F3   LDA a44
        CMP #$01
        BNE b260D
        LDA #$05
        STA LivesLeft
        LDY #$00
b2600   LDA (RAM_INPPTR_LO),Y
        STA RestOfTopFiveText,X
        INY 
        INX 
        CPY #$0A
        BNE b2600
        BEQ JmpGameOver

b260D   LDY #$C7
b260F   LDA f225B,Y
        STA TopScoreText,Y
        DEY 
        TXA 
        CLC 
        ADC #$28
        STA a2645
        TYA 
        CMP a2645
        BNE b260F

        LDY #$00
b2625   LDA (RAM_INPPTR_LO),Y
        STA RestOfTopFiveText,X
        INY 
        INX 
        CPY #$0A
        BNE b2625

        ; Reset LivesLeft
        LDA #$06
        SEC 
        SBC a44
        STA LivesLeft

JmpGameOver
        LDA #<p0101
        STA a2BF1
        LDA #>p0101
        STA a2BF2
        JMP PlayGameOverSequence

a2645   .BYTE $00

;------------------------------------------------------------------
; Draw something to the bottom of the screen not sure what it is
;------------------------------------------------------------------
DrawSomethingToBottomOfScreen
        LDX #$10 ;
b2648   LDA TitleScreenText,X
        STA SCREEN_RAM + $032C,X
        CLC 
        ADC #$20
        STA SCREEN_RAM + $0354,X
        LDA #$5C ; Light Blue
        STA COLOR_RAM + $032C,X
        STA COLOR_RAM + $0354,X
        DEX 
        BPL b2648

        LDX #$07
b2661   LDA f2E02,X
        ORA #$0D
        STA f2C8F,X
        DEX 
        BPL b2661
        RTS 

        .TEXT "MOVE;", $13, $14, $15, $16
        .BYTE $0C,$0C,$0C,$0C,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$23,$14,$01,$01
        .BYTE $44,$44,$00,$FE,$02,$24,$FE,$00
        .BYTE $88,$01,$02,$44,$00,$04,$88,$01
        .BYTE $02,$44,$17,$00,$88,$01,$02,$00
        .BYTE $44,$02,$88,$01,$02
        .BYTE $27,$44,$06,$FE,$00,$FD,$20,$45
        .BYTE $57,$45,$20,$12,$14,$16,$18,$0A
        .BYTE $0B,$0C,$0D,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$23,$07,$82,$01,$02
        .BYTE $FF,$00,$04,$24,$FE,$00,$23,$05
        .BYTE $86,$01,$08,$00,$FF,$02,$86,$01
        .BYTE $02,$27,$FF,$FF,$FE,$00,$24,$FD
        .BYTE $46,$4C,$4F,$59,$44,$13,$14,$13
        .BYTE $14,$0B,$0B,$0C,$0C,$00,$00,$03
        .BYTE $03,$04,$04,$00,$00,$23,$08,$82
        .BYTE $01,$02,$14,$0B,$FF,$82,$01,$02
        .BYTE $14,$0C,$FF,$82,$01,$02,$14,$0B
        .BYTE $FF,$82,$01,$02,$14,$0C,$FF,$FE
        .BYTE $28,$24,$FD,$5A,$49,$50,$50,$59
        .BYTE $13,$14,$15,$16,$0C,$0C,$0C,$0C
        .BYTE $0F,$0F,$0F,$0F,$00,$00,$00,$00
        .BYTE $23,$04,$9F,$01,$02,$FF,$00,$FF
        .BYTE $FE,$00,$24,$FD,$2F,$2F,$2F,$2F
        .BYTE $2F,$12,$14,$16,$18,$0D,$0E,$0E
        .BYTE $0D,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$23,$1E,$85,$01,$02,$FF,$17
        .BYTE $00,$FE,$14,$24,$FE,$00,$FD,$46
        .BYTE $41,$55,$4E,$41,$13,$14,$15,$16
        .BYTE $10,$0F,$0E,$0D,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$23,$1E,$01,$0D
        .BYTE $FF,$00,$04,$FE,$05,$24,$FE,$00
        .BYTE $FD,$36,$38,$30,$30,$30,$13,$14
        .BYTE $15,$16,$0A,$0E,$0E,$0A,$00,$00
        .BYTE $00,$00,$04,$00,$00,$04,$84,$03
        .BYTE $02,$FF,$00,$FF,$23,$1E,$01,$04
        .BYTE $00,$44,$02,$01,$04,$27,$44,$06
        .BYTE $01,$04,$44,$17,$02,$FE,$14,$24
        .BYTE $FE,$00,$FD,$47,$49,$4C,$42,$59
        .BYTE $14,$15,$14,$15,$0C,$0C,$0D,$0D
        .BYTE $00,$00,$00,$00,$07,$01,$05,$03
        .BYTE $23,$06,$88,$01,$02,$00,$00,$03
        .BYTE $88,$01,$02,$00,$17,$01,$88,$01
        .BYTE $02,$27,$17,$07,$88,$01,$02,$27
        .BYTE $00,$05,$FE,$00,$24,$FD,$48,$41
        .BYTE $49,$52,$59,$13,$14,$15,$16,$0C
        .BYTE $0C,$0C,$0C,$00,$00,$00,$00,$04
        .BYTE $04,$04,$04,$23,$30,$01,$0E,$FF
        .BYTE $00,$FF,$01,$0F,$FF,$00,$FF,$83
        .BYTE $01,$0D,$44,$17,$00,$FE,$0A,$24
        .BYTE $23,$30,$01,$05,$44,$44,$00,$FE
        .BYTE $0A,$24,$FE,$00,$FD,$20,$47,$4E
        .BYTE $55,$20,$13,$14,$15,$16,$0C,$0C
        .BYTE $0C,$0C,$03,$00,$00,$03,$00,$00
        .BYTE $00,$00,$23,$0C,$83,$01,$02,$FF
        .BYTE $00,$05,$FE,$03,$24,$23,$05,$82
        .BYTE $01,$02,$44,$44,$00,$FE,$02,$24
        .BYTE $FD,$48,$4F,$52,$53,$45,$13,$13
        .BYTE $13,$13,$0B,$0C,$0C,$0C,$00,$00
        .BYTE $00,$00,$00,$02,$04,$06,$23,$30
        .BYTE $84,$01,$02,$44,$44,$02,$01,$04
        .BYTE $FF,$00,$04,$FE,$05,$24,$FE,$00
        .BYTE $FD,$5A,$49,$47,$47,$59,$13,$14
        .BYTE $15,$16,$0C,$0B,$0B,$0C,$00,$00
        .BYTE $00,$00,$04,$00,$00,$04,$23,$0A
        .BYTE $01,$04,$00,$44,$02,$01,$04,$27
        .BYTE $44,$06,$86,$01,$08,$FF,$00,$FF
        .BYTE $86,$01,$08,$FF,$17,$FF,$FE,$14
        .BYTE $24,$FE,$00,$FF,$20,$54,$45,$41
        .BYTE $20,$0A,$0A,$0A,$0A,$0C,$0B,$0D
        .BYTE $0E,$00,$00,$00,$00,$02,$02,$02
        .BYTE $02,$23,$14,$01,$05,$14,$FF,$00
        .BYTE $01,$05,$1E,$FF,$00,$88,$01,$02
        .BYTE $27,$FF,$FF,$FE,$07,$24,$FE,$00
        .BYTE $FD,$52,$41,$49,$4E,$20,$14,$13
        .BYTE $15,$16,$0C,$0C,$0C,$0C,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$23,$50
        .BYTE $01,$0D,$44,$00,$04,$01,$04,$FF
        .BYTE $00,$04,$24,$FE,$00,$FD,$45,$56
        .BYTE $49,$4C,$3B,$13,$14,$13,$14,$0B
        .BYTE $0B,$0C,$0C,$00,$00,$00,$00,$00
        .BYTE $00,$05,$03,$23,$04,$88,$01,$06
        .BYTE $14,$0C,$00,$01,$05,$44,$44,$00
        .BYTE $FE,$00,$24,$23,$12,$88,$01,$02
        .BYTE $44,$17,$00,$FE,$06,$24,$FE,$00
        .BYTE $FD,$57,$45,$49,$52,$44,$14,$14
        .BYTE $14,$14,$0C,$0C,$0C,$0C,$00,$FC
        .BYTE $0F,$F3,$00,$02,$04,$06,$23,$04
        .BYTE $82,$01,$02,$FF,$00,$FF,$82,$01
        .BYTE $02,$FF,$17,$FF,$82,$01,$02,$00
        .BYTE $FF,$FF,$82,$01,$02,$27,$FF,$FF
        .BYTE $FE,$00,$24,$FD,$53,$50,$4C,$49
        .BYTE $54,$13,$14,$13,$14,$0B,$0B,$0C
        .BYTE $0C,$00,$00,$00,$00,$06,$02,$06
        .BYTE $02,$23,$40,$01,$02,$00,$FF,$06
        .BYTE $01,$02,$27,$FF,$02,$FE,$02,$24
        .BYTE $FE,$00,$FD,$42,$4F,$4E,$55,$53
        .BYTE $13,$14,$13,$14,$0B,$0B,$0C,$0C
        .BYTE $00,$00,$00,$00,$00,$00,$04,$04
        .BYTE $23,$30,$01,$0D,$44,$00,$04,$01
        .BYTE $0D,$44,$17,$00,$01,$0E,$00,$44
        .BYTE $02,$01,$0F,$27,$44,$06,$24,$FE
        .BYTE $00,$23,$30,$01,$04,$00,$44,$02
        .BYTE $01,$04,$27,$44,$06,$01,$04,$44
        .BYTE $00,$04,$01,$04,$44,$17,$00,$24
        .BYTE $FE,$00,$FD,$41,$54,$41,$52,$49
        .BYTE $12,$14,$12,$14,$0A,$0A,$0C,$0C
        .BYTE $00,$00,$00,$00,$00,$02,$06,$04
        .BYTE $23,$07,$88,$01,$02,$FF,$00,$03
        .BYTE $88,$01,$02,$FF,$17,$07,$88,$01
        .BYTE $02,$00,$FF,$01,$88,$01,$02,$27
        .BYTE $FF,$05,$FE,$00,$24,$FD,$50,$49
        .BYTE $58,$45,$4C,$14,$14,$14,$14,$0C
        .BYTE $0B,$0D,$0E,$00,$00,$00,$00,$00
        .BYTE $00,$01,$07,$23,$10,$86,$01,$08
        .BYTE $00,$FF,$02,$86,$01,$08,$00,$FF
        .BYTE $02,$01,$08,$27,$FF,$06,$01,$08
        .BYTE $27,$FF,$06,$FE,$0A,$24,$FE,$00
        .BYTE $FD,$46,$55,$52,$52,$59,$13,$14
        .BYTE $15,$16,$0C,$0C,$0C,$0C,$00,$00
        .BYTE $0C,$0C,$00,$00,$04,$04,$23,$07
        .BYTE $90,$01,$02,$FF,$00,$FF,$90,$01
        .BYTE $02,$FF,$17,$FF,$FE,$00,$24,$FD
        .BYTE $35,$32,$30,$53,$54,$14,$13,$15
        .BYTE $14,$0B,$0C,$0C,$0D,$00,$00,$00
        .BYTE $00,$00,$06,$02,$04,$23,$10,$88
        .BYTE $01,$02,$FF,$00,$04,$88,$01,$02
        .BYTE $FF,$17,$00,$88,$01,$02,$00,$FF
        .BYTE $02,$88,$01,$02,$27,$FF,$06,$FE
        .BYTE $14,$24,$FE,$00,$FD,$44,$49,$46
        .BYTE $46,$59,$12,$14,$12,$14,$0A,$0A
        .BYTE $0C,$0C,$00,$0C,$03,$0F,$07,$01
        .BYTE $05,$03,$23,$10,$9F,$01,$02,$14
        .BYTE $0C,$00,$FE,$14,$24,$FE,$00,$FD
        .BYTE $56,$4F,$49,$44,$3B,$13,$12,$14
        .BYTE $15,$0C,$0C,$0C,$0C,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$23,$30,$01
        .BYTE $05,$44,$44,$00,$83,$01,$06,$14
        .BYTE $0C,$00,$FE,$05,$24,$FE,$00,$23
        .BYTE $30,$01,$05,$44,$44,$00,$24,$23
        .BYTE $30,$01,$07,$44,$00,$04,$24,$23
        .BYTE $06,$84,$08,$02,$FF,$00,$FF,$FE
        .BYTE $28,$24,$23,$FF,$01,$02,$44,$44
        .BYTE $FF,$FE,$04,$24,$23,$40,$01,$07
        .BYTE $44,$00,$04,$24,$FE,$00,$FD

;------------------------------------------------------------------
; Initializef13A2
;------------------------------------------------------------------
Initializef13A2   LDX #$1F
        LDA #$FF
b2AFE   STA f13A2,X
        DEX 
        BPL b2AFE
        LDA #$00
        STA a14A2
        RTS 

;------------------------------------------------------------------
; LaunchGame
;------------------------------------------------------------------
LaunchGame
        ; Set background to black.
        LDA #$00
        STA $FF15    ;Background color register
        STA $FF19    ;Color register #4

        ; Initialize some variables
        STA a3196
        STA a15CE
        STA a17E2
        STA a2CFE
        STA a36A2
        JSR Initializef13A2
        JSR PointScreenArrayToFirstColumn
        LDA #$FF
        STA a234C
        LDA #<pFF00
        STA a2BF1
        LDA #>pFF00
        STA a2BF2
        LDA #$0C
        STA a2BF3

        SEI   ; Stop interrupts while setting the interrupts registers

        LDA #$20
        STA a30F8

        ; When an interrupt happens INTERRUPT_ROUTINE is checked for a
        ; user routine to perform. Set it to RoutineToPerformAtInterrupt.
        LDA #<RoutineToPerformAtInterrupt
        STA INTERRUPT_ROUTINE
        LDA #>RoutineToPerformAtInterrupt
        STA INTERRUPT_ROUTINE + $01

        ; Clear bit 2 of $FF12 so that custom character sets are enabled.
        ; The order of bits is: 7 6 5 4 3 2 1 0
        LDA $FF12
        AND #$FB
        STA $FF12

        ; Load the custom character set from CharacterSet (see charset.asm).
        ; Do this by storing the address of the custom character
        ; set ($3C00) at $FF13.
        LDA $FF13    ;Bit 0 :    Clock status
        AND #$03
        ORA #$3C
        STA $FF13    ;Bit 0 :    Clock status

        ; Enable raster interrupts by setting bit 1 of $FF0A to 1.
        LDA #$02
        STA INTERRUPT_ENABLE_REGISTER
        STA RASTER_INTERRUPT_STATUS

        ; Set the position on the screen at which the raster interrupt occurs.
        LDA #$40
        STA RASTER_COMPARE_REGISTER
        LDA #$00
        STA interruptCount

        CLI  ; Start the interrupts going again.

        JSR ClearScreen

        ; Wait for the user to release the fire button.
Init_WaitForFire
        LDA currentJoystick1Reading
        AND #$40 ; Fire
        BEQ Init_WaitForFire

        JSR ResetColorSequenceData
        JSR InitializeColorSequenceData
        JSR WriteStuffToScreen
        JSR WriteTitleScreenText

b2B86   JSR UpdateBackgroundAnimation
        DEC a2BF1
        BNE Title_HandleFire
        DEC a2BF2
        BNE Title_HandleFire
        DEC a2BF3
        BNE Title_HandleFire
        ; After a while switch to the high score screen.
        JMP DisplayHiScoreScreen

        ; Keep looping until the user presses fire to start a game.
        ; currentJoystick1Reading gets updated by RoutineToPerformAtInterrupt
        ; at every raster/timer interrupt.
Title_HandleFire
        LDA currentJoystick1Reading
        AND #$40 ; Fire
        BNE b2B86

        ; THe player has pressed fire, start the game.
        JSR InitializeScoresAndLives
        JMP LoadEnterLevelScreen

;------------------------------------------------------
; s2BA8
;------------------------------------------------------
s2BA8   LDA #>COLOR_RAM + $000F
        STA colourToPlot 

;------------------------------------------------------
; s2BAC
;------------------------------------------------------
s2BAC   LDA #<COLOR_RAM + $000F
        STA charToPlot
        LDA #$04
        STA zp08 
        STA zp09 
        LDA zp03 
        PHA 
        LDA zp02 
        PHA 
b2BBC   JSR DrawCharacterOnScreen
        INC zp02 
        INC charToPlot
        DEC zp08 
        BNE b2BBC
        PLA 
        PHA 
        STA zp02 
        LDA #$04
        STA zp08 
        INC zp03 
        DEC zp09 
        BNE b2BBC
        PLA 
        STA zp02 
        PLA 
        STA zp03
        RTS 

;------------------------------------------------------------------
; ClearScreen
;------------------------------------------------------------------
ClearScreen
        LDA #$20 ; Space
FillScreen ; Fill Screen with whatever is in A register
        LDX #$00
b2BE0   STA SCREEN_RAM,X ;TEDSCN  TED character pointers
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $0200,X
        STA SCREEN_RAM + $0300,X
        DEX 
        BNE b2BE0
        RTS 

interruptCount   .BYTE $FF
a2BF1   .BYTE $12
a2BF2   .BYTE $3A
a2BF3   .BYTE $0C

;------------------------------------------------------------------
; RoutineToPerformAtInterrupt
;------------------------------------------------------------------
RoutineToPerformAtInterrupt
        LDA RASTER_INTERRUPT_STATUS
        AND #$02
        BNE ProcessRasterInterrupt
        ; It's not a raster interrupt, so bail.
        ; Restore the stack when returning from an interrupt
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI ; Retuurn from the Interrupt

ProcessRasterInterrupt
        LDX interruptCount

        ; Change the background color from the current byte
        ; in the color sequence.
        LDA colorSequence,X
        STA $FF15    ;Background color register

        ; The sequence is 50 bytes long. Reset it if necessary.
        CPX #$32
        BEQ ResetInterruptCount

        LDA RASTER_COMPARE_REGISTER
        CLC 
        ADC #$04
        STA RASTER_COMPARE_REGISTER

FinishProcessing_RI
        ; Reset raster interrupt
        LDA #$02
        STA RASTER_INTERRUPT_STATUS
        INC interruptCount
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI 

ResetInterruptCount
        LDX #$FF
        STX interruptCount
        LDA #$02
        STA RASTER_COMPARE_REGISTER

        ; Set the background to black
        LDA #$00
        JSR WasteAFewCycles
        STA $FF15    ;Background color register

        ; Depending on the value in a3196 this will branch execution
        ; to JustPlayASound1($319B) or CheckInputAndPlaySound($31A1)
        LDA a3196 ; Can be $00, $01 or $02
        BEQ b2C4E
        LDX a3196 ; Can be $01 or $02
        LDA a3196,X
        STA a31CD
        LDA f3198,X
        STA a31CE
        JMP (a31CD) ; can be JustPlayASound1 or CheckInputAndPlaySound

b2C4E   JSR AdvanceBackgroundAnimation
        JSR UpdateCurrentColorAndColorSequence
        JSR s2E43
        JSR PlaySomeSounds
        JSR CheckJoystick1
        LDA #$00
        STA $FF15    ;Background color register
        JMP FinishProcessing_RI

colorSequence
        .BYTE $73,$04,$14,$24,$34,$44,$54,$64
f2C6D   .BYTE $4D
f2C6E   .BYTE $36,$4D,$5D,$6D,$7D,$7E,$7D,$7E
        .BYTE $6E
f2C77   .BYTE $5E,$4E,$06,$16,$26,$36
f2C7D   .BYTE $36
f2C7E   .BYTE $26,$16,$06,$4E,$5E,$6E,$7E,$7D
        .BYTE $7E,$7D,$6D,$5D,$4D,$36
a2C8C   .BYTE $4D
f2C8D   .BYTE $64,$54
f2C8F   .BYTE $44,$34,$24,$14,$04,$73,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00

f2C9E   .BYTE $10,$11,$13,$14,$16,$17,$18,$1A
        .BYTE $1B,$1C,$1D,$1E,$1E,$1F,$1F,$1F
        .BYTE $1F,$1F,$1F,$1F,$1E,$1E,$1D,$1C
        .BYTE $1B,$1A,$18,$17,$16,$14,$13,$11
        .BYTE $10,$0E,$0C,$0B,$09,$08,$07,$05
        .BYTE $04,$03,$02,$01,$01,$00,$00,$00
        .BYTE $00,$00,$00,$00,$01,$01,$02,$03
        .BYTE $04,$05,$07,$08,$09,$0B,$0C,$0E
        .BYTE $04,$04,$04,$04,$04,$04,$04,$04
        .BYTE $05,$05,$05,$05,$05,$05,$05,$05
        .BYTE $00,$02,$04,$06,$08,$0A,$0C,$0E
        .BYTE $20,$22,$24,$26,$28,$2A,$2C,$2E
a2CFE   .BYTE $00

;------------------------------------------------------------------
; ResetColorSequenceData
; Reset the color sequence data to zeros.
;------------------------------------------------------------------
ResetColorSequenceData
        LDA #$00
FillColorSequenceData
        LDX #$32
b2D03   STA colorSequence,X
        DEX 
        BPL b2D03
        RTS 

;------------------------------------------------------------------
; WriteTitleScreenText
;------------------------------------------------------------------
WriteTitleScreenText   
        ; Turn on multi-color mode on the graphics chip ($FF07)
        LDA GRAPHICS_CHIP
        AND #$EF
        ORA #$10
        STA GRAPHICS_CHIP

        LDX #$10
b2D16   LDA TitleScreenText,X
        STA SCREEN_RAM + $01C4,X
        STA SCREEN_RAM + $0124,X
        STA SCREEN_RAM + $0264,X
        CLC 
        ADC #$20
        STA SCREEN_RAM + $01EC,X
        STA SCREEN_RAM + $014C,X
        STA SCREEN_RAM + $028C,X

        LDA #$0A
        STA COLOR_RAM + $01C4,X
        STA COLOR_RAM + $01EC,X
        STA COLOR_RAM + $0264,X
        STA COLOR_RAM + $028C,X
        STA COLOR_RAM + $0124,X
        STA COLOR_RAM + $014C,X
        DEX 
        BPL b2D16
        LDA #$01
        STA CurrentColor1

        LDA #$2E
        STA $FF17    ;Color register #2
        BNE b2D67 ; Always jump?

;------------------------------------------------------------------
; InitializeScoresAndLives
;------------------------------------------------------------------
InitializeScoresAndLives
        LDX #$09
b2D53   LDA CurrentScore,X
        STA LastScore,X
        LDA #$30
        STA CurrentScore,X
        DEX 
        BPL b2D53
        LDA #$35
        STA LivesLeftText
        RTS 

;------------------------------------------------------------------
; WriteTitleScreenText continnued.
;------------------------------------------------------------------
b2D67   LDX #$27
b2D69   LDA TitleTop,X
        STA SCREEN_RAM + $0028,X
        LDA TitleBottom,X
        STA SCREEN_RAM + $0370,X
        LDA #$76
        STA COLOR_RAM + $0028,X
        STA COLOR_RAM + $0370,X
        DEX 
        BPL b2D69
        RTS 

TitleScreenText
        .BYTE $01,$02,$03,$04,$05,$06,$07,$08 ; Padding before the title text
        .BYTE $09,$0A,$0B,$0C,$0B,$0C,$0D,$0E
        .BYTE $07
TitleTop .TEXT "VOIDRUNNER    CREATED BY   / / YAK / /  "
TitleBottom   .TEXT "LEVEL /YAK/    LAST SCORE WAS "
LastScore   .TEXT "0000000000"

;------------------------------------------------------
; UpdateCurrentColorAndColorSequence
;------------------------------------------------------
CurrentColor1   .BYTE $52
CurClr1Counter   .BYTE $04

UpdateCurrentColorAndColorSequence
        DEC CurClr1Counter
        BEQ b2DEA
        RTS 

b2DEA   LDA #$06
        STA CurClr1Counter
        LDA CurrentColor1
        CLC 
        ADC #$10
        AND #$60
        ORA #$12
        STA CurrentColor1
        STA $FF16    ;Color register #1
        JMP j2E2B

f2E02   .BYTE $00,$10,$20,$30,$40,$50,$60,$70

;------------------------------------------------------------------
; InitializeColorSequenceData
;------------------------------------------------------------------
InitializeColorSequenceData
        LDX #$00
b2E0C   LDA f2E02,X
        STA colorSequence,X
        LDA f2E02,X
        EOR #$70
        STA f2C8D,X
        INX 
        CPX #$08
        BNE b2E0C

        LDX #$1F
b2E21   LDA f2EB3,X
        STA f2C6D,X
        DEX 
        BPL b2E21
        RTS 

j2E2B   LDX #$07
b2E2D   LDA colorSequence,X
        JSR ManipulateClrSeqValue
        STA colorSequence,X
        LDA f2C8D,X
        JSR ManipulateClrSeqValue
        STA f2C8D,X
        DEX 
        BPL b2E2D
        RTS 

;------------------------------------------------------
; s2E43
;------------------------------------------------------
s2E43   LDX #$0E
        LDY #$00
        LDA f2C6E,X
        PHA 
b2E4B   LDA f2C6D,X
        STA f2C6E,X
        STA f2C7D,Y
        INY 
        DEX 
        BPL b2E4B
        PLA 
        STA f2C6D
        STA a2C8C
        RTS 

;------------------------------------------------------
; ManipulateClrSeqValue
;------------------------------------------------------
ManipulateClrSeqValue
        CLC 
        ADC #$10
        PHA 
        AND #$80
        BNE b2E6A
        PLA 
        RTS 

b2E6A   PLA 
        AND #$0F
        CLC 
        ADC #$01
        AND #$0F
        RTS 

;------------------------------------------------------------------
; WriteStuffToScreen
;------------------------------------------------------------------
WriteStuffToScreen
        LDA #$00
        STA zp02 
        LDA #$FF
        STA a12D7
        LDA #$04
        STA zp03 
b2E80   LDA zp02 
        PHA 
        JSR s2BA8
        LDA zp02 
        CLC 
        ADC #$04
        STA zp02 
        JSR s2BA8
        LDA zp02 
        CLC 
        ADC #$1C
        STA zp02 
        JSR s2BA8
        LDA zp02 
        CLC 
        ADC #$04
        STA zp02 
        JSR s2BA8
        PLA 
        STA zp02 
        LDA zp03 
        CLC 
        ADC #$04
        STA zp03 
        CMP #$14
        BNE b2E80
        RTS 

f2EB3   .BYTE $06,$16,$26,$36,$4D,$36,$4D,$5D
        .BYTE $6D,$7D,$7E,$7D,$7E,$6E,$5E,$4E
        .BYTE $4E,$5E,$6E,$7E,$7D,$7E,$7D,$6D
        .BYTE $5D,$4D,$36,$4D,$36,$26,$16,$06
a2ED3   .BYTE $A4,$20
a2ED5   .BYTE $08
a2ED6   .BYTE $20
a2ED7   .BYTE $20
a2ED8   .BYTE $DA
;------------------------------------------------------
; PlaySomeSounds
;------------------------------------------------------
PlaySomeSounds
        LDA a2ED3
        BEQ b2F17
        DEC a2ED3
        BNE b2F15
        JSR GetRandomValue
        STA a2ED6
        STA a2ED7
        LDA #$08
        STA a2ED5
        LDA #$0F
        STA a2F16
        JSR GetRandomValue
        AND #$7F
        STA a2ED8
        INC a2ED8
        JSR GetRandomValue
        AND #$01
        BNE b2F10
        LDA a2ED8
        EOR #$FF
        STA a2ED8
b2F10   LDA #$01
        STA a101D
b2F15   RTS 

a2F16   .BYTE $00
b2F17   LDA $FF11    ;Bits 0-3 : Volume control
        AND #$F0
        ORA a2F16
        ORA #$30
        STA $FF11    ;Bits 0-3 : Volume control
        JSR PlaySoundImpl
        JMP j2F53

;------------------------------------------------------
; PlaySoundImpl
;------------------------------------------------------
PlaySoundImpl   LDA a2ED6
        PHA 
        CLC 
        ROL 
        ROL 
        ROL 
        AND #$03
        STA $FF10    ;Voice #2 frequency, bits 8 & 9
        STA RAM_SUBFLG ;SUBFLG  Flag: subscript ref / user function coll
        LDA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        AND #$FC
        ORA RAM_SUBFLG ;SUBFLG  Flag: subscript ref / user function coll
        STA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        PLA 
        CLC 
        ROL 
        ROL 
        AND #$FC
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        CLC 
        ADC #$06
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        RTS 

j2F53   LDA a2ED6
        CLC 
        ADC a2ED8
        STA a2ED6
        DEC a2ED5
        BNE b2F80
        LDA a2ED7
        STA a2ED6
        LDA #$08
        STA a2ED5
        DEC a2F16
        BNE b2F80
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$C0
        STA $FF11    ;Bits 0-3 : Volume control
        JSR GetRandomValue
        STA a2ED3
b2F80   RTS 

currentJoystick1Reading   .BYTE $7F

;------------------------------------------------------------------
; Check for joystick input
;------------------------------------------------------------------
CheckJoystick1
        SEI 
        LDX #$FA
        ; Get a consistent read from the joystick. This means
        ; getting the same reading twice in a row.
b2F85   STX KEYBOARD_LATCH
        LDA KEYBOARD_LATCH
        STX KEYBOARD_LATCH
        CMP KEYBOARD_LATCH
        BNE b2F85
        CLI 
        STA currentJoystick1Reading
        RTS 

;------------------------------------------------------------------
; LoadEnterLevelScreen
;------------------------------------------------------------------
LoadEnterLevelScreen
        LDA $FF11    ;Bits 0-3 : Volume control
        LDY #$01
        STY a33CF
        AND #$CF
        STA $FF11    ;Bits 0-3 : Volume control
        JSR s3A70
        LDA #$FF
        STA a2094
        STA a12D7
        LDA #$00
        JSR FillScreen

        ; Initialize the color ram
b2FB5   STA COLOR_RAM,X ;TEDATR  TED attribute bytes
        STA COLOR_RAM + $0100,X
        STA COLOR_RAM + $0200,X
        STA COLOR_RAM + $0300,X
        DEX 
        BNE b2FB5

        LDA a2094
        CMP #$FF
        BEQ b2FD1
        LDY a2086
        STA colorSequence,Y
b2FD1   LDA #$FF
        STA a2094
        LDA #$00
        STA a2086
        LDA #$01
        STA a3196
        LDA #$00
        JSR FillColorSequenceData

        ; Draw the new level screen, e.g. 'ENTER /YAK/ LEVEL'
        LDX #$04
b2FE7   LDA #$01
        STA a3099
        LDA f309A,X
        STA a3098
        LDA txtENTER,X
        JSR DrawLargeCharacter

        LDA #$09
        STA a3099
        LDA f309A,X
        STA a3098
        LDA txtLevelName,X
        JSR DrawLargeCharacter

        LDA #$11
        STA a3099
        LDA f309A,X
        STA a3098
        LDA txtLEVEL,X
        JSR DrawLargeCharacter

        DEX 
        BPL b2FE7

        LDA #>p01FF
        STA a311A
        LDA #<p01FF
        STA a3119
        
        LDA #$00
        STA a3117
        STA a3118
        STA a31CF
        LDA #$11
        STA a3116

        LDA #$01
        STA a3097
b303C   LDA a3097
        BNE b303C

        LDA #$32
        STA a3117
        STA a3118
        LDA #$FF
        STA a311A
        LDA #$22
        STA a3116
        LDA #$00
        STA a31CF
        LDA #$01
        STA a3119

        STA a3097
b3060   LDA a3097
        BNE b3060

        LDX #$07
        LDY #$00
b3069   LDA f2E02,X
        ORA #$08
        STA f2C77,Y
        STA f2C7E,X
        INY 
        DEX 
        BPL b3069

        LDA #$77
        STA f2C7D
        LDA #<p0100
        STA a31CF
        LDA #>p0100
        STA a31D0

        LDA #$02
        STA a3097
b308C   LDA a3097
        BNE b308C
        JSR ClearScreen
        JMP MainGameLoop

a3097   .BYTE $00
a3098   .BYTE $00
a3099   .BYTE $00
f309A   .BYTE $00,$08,$10,$18,$20
txtENTER   .TEXT "ENTER"
txtLevelName   .TEXT "/YAK/"
txtLEVEL   .TEXT "LEVEL"
tmpAorX   .TEXT $00

;------------------------------------------------------------------
; DrawLargeCharacter
; Draw a large character on the screen. Used by the Game Over and
; 'ENTER XXXX LEVEL' sequences.
;------------------------------------------------------------------
DrawLargeCharacter
        STX tmpAorX
        JSR s30FA
        LDA a3098
        STA zp02
        LDA a3099
        STA zp03
        LDY #$00
b30C1   LDA (zp09),Y
        PHA 
        LDA #$08
        STA zp08
b30C8   PLA 
        ROL 
        PHA 
        BCC b30E0
        LDA a30F8
        STA charToPlot
        LDA a30F9
        STA colourToPlot
        STY a30F7
        JSR DrawCharacterOnScreen
        LDY a30F7
b30E0   INC zp02
        DEC zp08
        BNE b30C8
        PLA 
        INC zp03
        LDA a3098
        STA zp02
        INY 
        CPY #$08
        BNE b30C1
        LDX tmpAorX
        RTS 

a30F7   .BYTE $00
a30F8   .BYTE $20
a30F9   .BYTE $00
;------------------------------------------------------
; s30FA
;------------------------------------------------------
s30FA   LDY #<CharacterSet
        STY zp09 ;TRMPOS  Screen column from last TAB
        LDY #>CharacterSet
        STY zp0A ;VERCK   Flag: 0 = load 1 - verify
        TAY 
        BEQ b3115
b3105   LDA zp09 ;TRMPOS  Screen column from last TAB
        CLC 
        ADC #$08
        STA zp09 ;TRMPOS  Screen column from last TAB
        LDA zp0A ;VERCK   Flag: 0 = load 1 - verify
        ADC #$00
        STA zp0A ;VERCK   Flag: 0 = load 1 - verify
        DEY 
        BNE b3105
b3115   RTS 

a3116   .BYTE $32
a3117   .BYTE $00
a3118   .BYTE $00
a3119   .BYTE $01
a311A   .BYTE $01
;------------------------------------------------------
; PlayASound2
;------------------------------------------------------
PlayASound2   LDA a3097
        BNE b3121
        RTS 

b3121   CMP #$01
        BEQ b3128
        JMP j31D1

b3128   LDA $FF11    ;Bits 0-3 : Volume control
        ORA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA a3117
        CMP a3116
        BEQ b317E
        LDA #$00
        LDX a3117
        STA colorSequence,X
        TXA 
        CLC 
        ADC a311A
        TAX 
        STX a3117
        LDY a31CF
        LDA f2EB3,Y
        STA colorSequence,X
        CPX a3116
        BEQ b3162
        LDA a3117
        ASL 
        ASL 
        STA a2ED6
        JMP PlaySoundImpl

b3162   LDA a3116
        CLC 
        ADC a3119
        STA a3116
        LDA a3118
        STA a3117
        INC a31CF
        LDA a31CF
        AND #$0F
        STA a31CF
        RTS 

b317E   LDX a3116
        LDA a3195
        STA colorSequence,X
        LDA #$00
        STA a3097
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$C0
        STA $FF11    ;Bits 0-3 : Volume control
        RTS 

a3195   .BYTE $27
a3196   .BYTE $00,$9B
f3198   .BYTE $A1,$31,$31

;------------------------------------------------------
; JustPlayASound1
;------------------------------------------------------
JustPlayASound1
        JSR PlayASound2
        JMP FinishProcessing_RI

;------------------------------------------------------
; CheckInputAndPlaySound
;------------------------------------------------------
CheckInputAndPlaySound
        LDA #$00
        STA $FF15    ;Background color register
        JSR CheckJoystick1
        JSR AdvanceBackgroundAnimation
        LDA #$00
        STA $FF15    ;Background color register
        LDA a234C
        BMI b31BC
        JSR PlayASound
        JMP j31CA

b31BC   JSR ColorPulseLevelAndScoreText
        LDA a33CF
        BNE j31CA
        JSR PlayBackgroundSounds
        JSR PlaySounds2
j31CA   JMP FinishProcessing_RI

a31CD   .BYTE $00
a31CE   .BYTE $00
a31CF   .BYTE $00
a31D0   .BYTE $01
j31D1   CMP #$02
        BEQ b31D8
        JMP j3236

b31D8   LDA f2C7D
        CLC 
        ADC #$10
        STA f2C7D
        DEC a31D0
        BEQ b31E7
        RTS 

b31E7   LDA #$18
        STA a31D0
        LDA $FF11    ;Bits 0-3 : Volume control
        ORA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
        INC a31CF
        LDX a31CF
        CPX #$06
        BEQ b3221
        LDA f322B,X
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        INC $FF0F    ;Voice #2 frequency, bits 0-7
        LDA $FF10    ;Voice #2 frequency, bits 8 & 9
        AND #$FC
        ORA f3230,X
        STA $FF10    ;Voice #2 frequency, bits 8 & 9
        LDA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        AND #$FC
        ORA f3230,X
        STA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        RTS 

b3221   LDA #$03
        STA a3097
        LDA #$0C
        STA a31CF
f322B   RTS 

        .BYTE $42,$56,$2A,$A9
f3230   .BYTE $C5,$03,$03,$03
        BRK #$01
j3236   CMP #$03
        BEQ b323D
        JMP j3399

b323D   LDA $FF0E    ;Voice #1 frequency, bits 0-7
        CLC 
        ADC #$82
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        CLC 
        ADC #$04
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        DEC a31CF
        BNE f322B
        LDA #$0C
        STA a31CF
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$0F
        SEC 
        SBC #$01
        BNE b327E

        LDA $FF11    ;Bits 0-3 : Volume control
        ORA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$04
        STA a2ED6
        LDA #$00
        STA a3097
        JSR PlaySoundImpl
        LDA $FF0F    ;Voice #2 frequency, bits 0-7
        ADC #$05
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        RTS 

b327E   STA tmpAorX
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$C0
        ORA #$30
        ORA tmpAorX
        STA $FF11    ;Bits 0-3 : Volume control
        LDX #$32
b3290   LDA colorSequence,X
        BEQ b32B1
        AND #$0F
        STA tmpAorX
        LDA colorSequence,X
        AND #$F0
        BEQ b32A6
        SEC 
        SBC #$10
        BNE b32AB
b32A6   LDA #$00
        STA tmpAorX
b32AB   ORA tmpAorX
        STA colorSequence,X
b32B1   DEX 
        BPL b3290
        RTS 

;------------------------------------------------------------------
; MainGameLoop
;------------------------------------------------------------------
MainGameLoop
        LDA a17E2
        AND #$07
        TAY 
        LDA f3429,Y
        STA a33CE
        LDA f3431,Y
        STA $FF16    ;Color register #1
        LDA #$71
        STA $FF17    ;Color register #2
        LDA #$07
        STA a3398
        LDA #$00
        JSR FillColorSequenceData
        LDA #$10
        STA a31CF

        LDA #$04
        STA a3097
b32E0   LDA a3097
        BNE b32E0

        JSR DrawNewLevelCascadeAnimation
        LDA #$02
        STA a3196
        JSR RunAnAnimationOnScreen

        LDA #$05
        STA zp02
        LDX #$00
        LDY #$00
b32F8   DEX 
        BNE b32F8
        DEY 
        BNE b32F8
        DEC zp02
        BNE b32F8

        STX a12D7
        INC a2CFE
RestartLevel
        LDA #$00
        STA a33CF
        JSR PlayNewShipAnimation

       ; Main loop?
b3310   JSR HandleInputAndMoveShips
        JSR HandleFirePressed
        JSR UpdateBackgroundAnimationData
        JSR DoSomeMoreAnimation
        LDA playerIsAlive
        BEQ b3310

        ; Update last score with current score
        LDX #$09
b3323   LDA SCREEN_RAM + $03C7,X
        STA CurrentScore,X
        STA LastScore,X
        DEX 
        BNE b3323

        JSR s1F0B
        JSR PlaySound4
b3335   JSR UpdateBackgroundAnimationData
        JSR s3A2A
        LDA a3987
        BNE b3335

        JSR RunAnAnimationOnScreen
        LDA #$00
        STA playerIsAlive
        JSR Initializef13A2

        LDX #$03
b334D   LDA f1F9B,X ; 4 ships.
        LDY f1F97,X
        STA colorSequence,Y
        DEX 
        BPL b334D

        LDA a15CC
        BNE b3374

        ; Player got killed
        DEC LivesLeftText
        LDA LivesLeftText
        CMP #$2F ; $30 is zero (in PETSCII) so $2F means the last life
                 ; has been lost
        BNE b336E

        ; Game Over!
        JSR PrepareGameOverSequence
        JMP PlayGameOverSequence

b336E   STA SCREEN_RAM + $03E3 ; Update lives left displayed on screen
        JMP RestartLevel

b3374   LDA #$00
        STA a15CC
        INC a17E2
        LDA a17E2
        CMP #$1E
        BNE b3388
        LDA #$00
        STA a17E2

b3388   INC LivesLeftText
        LDA LivesLeftText
        CMP #$3A
        BNE b3395
        DEC LivesLeftText
b3395   JMP LoadEnterLevelScreen

a3398   .BYTE $00
j3399   INC $FF0E    ;Voice #1 frequency, bits 0-7
        INC $FF0F    ;Voice #2 frequency, bits 0-7
        DEC a31CF
        BEQ b33A5
b33A4   RTS 

b33A5   LDA #$08
        STA a31CF
        LDX a3398
        TXA 
        EOR #$07
        ASL 
        ASL 
        ASL 
        ASL 
        ORA a33CE
        STA colorSequence,X
        PHA 
        TXA 
        EOR #$07
        TAX 
        PLA 
        STA f2C8D,X
        DEC a3398
        BPL b33A4
        LDA #$00
        STA a3097
        RTS 

a33CE   .BYTE $00
a33CF   .BYTE $00
;------------------------------------------------------------------
; ModifyAndDrawCharacterOnScreen
;------------------------------------------------------------------
ModifyAndDrawCharacterOnScreen
        LDA zp02
        BPL b33D5
b33D4   RTS 

b33D5   CMP #$28
        BPL b33D4
        LDA zp03
        BMI b33D4
        CMP #$18
        BPL b33D4
;------------------------------------------------------
; DrawCharacter2
;------------------------------------------------------
DrawCharacter2   LDA zp03
        CMP #$18
        BNE b33E8
        RTS 

b33E8   LDA a36A2
        BNE b33F0
        JMP DrawCharacterOnScreen

b33F0   LDA zp03
        AND #$03
        TAY 
        LDA charToPlot
        PHA 
        LDA f3411,Y
        STA charToPlot
        LDA zp02
        AND #$03
        CLC 
        ADC charToPlot
        STA charToPlot
        LDA #$08
        STA colourToPlot
        JSR DrawCharacterOnScreen
        PLA 
        STA charToPlot
        RTS 

f3411   .BYTE $0F,$13,$17,$1B
f3415   .BYTE $00,$FF,$FE,$FD,$FC,$FA,$F8,$F6
        .BYTE $F4,$F2,$EE,$EA,$E6,$E2,$DE,$D6
        .BYTE $CE,$C6,$BE,$B6
f3429   .BYTE $05,$04,$02,$06,$03,$0B,$08,$0E
f3431   .BYTE $46,$47,$42,$48,$44,$57,$3E,$77
f3439   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00
f344D   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00

;------------------------------------------------------------------
; DrawNewLevelCascadeAnimation
;------------------------------------------------------------------
DrawNewLevelCascadeAnimation
        LDX #$13
        LDY #$00
b3465   LDA f3415,X
        STA f3439,Y
        STA f344D,X
        INY 
        DEX 
        BPL b3465
        LDA #$00
        STA charToPlot
b3476   LDA #$00
        STA a31CF
        TAX 
b347C   LDA #$71
        STA colourToPlot 
        LDA f3439,X
        STA zp03 
        STX zp02 
j3487   JSR ModifyAndDrawCharacterOnScreen
        LDX zp02 
        LDA colourToPlot 
        AND #$F0
        SEC 
        SBC #$10
        CMP #$F0
        BEQ b34A0
        ORA #$01
        STA colourToPlot 
        DEC zp03 
        JMP j3487

b34A0   INC f3439,X
        LDA f3439,X
        CMP #$20
        BNE b34BE
        DEC f3439,X
        INC a31CF
        LDA ScoreLabelText,X
        STA SCREEN_RAM + $03C0,X
        LDA f34F3,X
        ORA #$70
        STA COLOR_RAM + $03C0,X
b34BE   INX 
        CPX #$28
        BNE b347C
        LDA a31CF
        CMP #$28
        BNE b3476
        RTS 

ScoreLabelText   .TEXT "SCORE: "
CurrentScore   .TEXT "0000000000  LEVEL: "
CurrentLevelText   .TEXT "/YAK/  `:"
LivesLeftText   .TEXT "0 YAK"
f34F3   .BYTE $07,$07,$07,$07,$07,$07,$00,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$00,$00,$04,$04,$04,$04,$04
        .BYTE $01,$00,$01,$01,$01,$01,$01,$00
        .BYTE $00,$05,$01,$07,$00,$03,$03,$03

;------------------------------------------------------------------
;RunAnAnimationOnScreen
;------------------------------------------------------------------
RunAnAnimationOnScreen   LDA #$00
        STA zp02 
        STA zp03 
        LDA #$09
        STA colourToPlot 
b3525   JSR s2BAC
        LDA zp02 
        CLC 
        ADC #$04
        STA zp02 
        CMP #$28
        BNE b3525
        LDA #$00
        STA zp02 
        LDA zp03 
        CLC 
        ADC #$04
        STA zp03 
        CMP #$18
        BNE b3525
        LDA #$F0
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        LDA #$F8
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        RTS 

;------------------------------------------------------------------
;WasteAFewCycles
;------------------------------------------------------------------
WasteAFewCycles
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        RTS 

ShipData1   .BYTE $13,$14,$15,$16
ShipData2   .BYTE $0C,$0C,$0C,$0C
ShipData3   .BYTE $07,$00,$00,$01

;------------------------------------------------------
; PlayNewShipAnimation
;------------------------------------------------------
PlayNewShipAnimation
        LDA #$20
        STA a31CF

b3569   LDX #$03 ; Four ships.
        LDA a31CF
        CLC 
        ROR 
        STA tmpAorX
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$03
        ORA tmpAorX
        ORA #$40
        STA $FF11    ;Bits 0-3 : Volume control
        LDA $FF0E    ;Voice #1 frequency, bits 0-7
        SEC 
        SBC #$04
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        STA $FF0F    ;Voice #2 frequency, bits 0-7
        DEC $FF0F    ;Voice #2 frequency, bits 0-7
b358F   LDA ShipData3,X
        BMI b35A8
        LDA ShipData1,X
        STA zp02 
        LDA #$00
        STA charToPlot
        STA a36A2
        LDA ShipData2,X
        STA zp03 
        JSR DrawShipMaterialization
b35A8   DEX 
        BPL b358F

        LDA #$05
        DEC a31CF
        BPL b3569

        INC a31CF
        INC a36A2
        LDX #$03 ; Four ships.
b35BA   LDA ShipData3
        BMI b35CC
        LDA ShipData1,X
        STA zp02 
        LDA ShipData2,X
        STA zp03 
        JSR DrawShipMaterialization
b35CC   DEX 
        BPL b35BA

        LDA #$00
        STA a36A2
        JSR DrawInitialShips
        LDA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
j35DC   LDA #$E0
        STA a2ED6
b35E1   JSR PlaySoundImpl
        LDX #$00
b35E6   DEX 
        BNE b35E6
        DEC a2ED6
        LDA a2ED6
        CMP #$80
        BNE b35E1
        LDA $FF11    ;Bits 0-3 : Volume control
        SEC 
        SBC #$04
        STA $FF11    ;Bits 0-3 : Volume control
        AND #$0F
        CMP #$0F
        BEQ b3605
        JMP j35DC

b3605   LDA #$00
        STA $FF11    ;Bits 0-3 : Volume control
        RTS 

a360B   .BYTE $00
        STA a360B
b360F   LDX #$10
b3611   LDY #$50
b3613   DEY 
        BNE b3613
        DEX 
        BNE b3611
        DEC a360B
        BNE b360F
        RTS 

;------------------------------------------------------
; DrawShipMaterialization
;------------------------------------------------------
DrawShipMaterialization   LDY #$07
        STX tmpAorX
        LDA zp02 
        STA a36A3
        LDA zp03 
        STA a36A4
b362E   TYA 
        STA a30F7
        CMP #$07
        BNE b3639
        INC a36A2
b3639   EOR #$07
        ASL 
        ASL 
        ASL 
        ASL 
        ORA #$06
        STA colourToPlot 
        LDA a36A4
        STA zp03 
        TYA 
        CLC 
        ADC a31CF
        CLC 
        ADC a36A3
        STA zp02 
        JSR ModifyAndDrawCharacterOnScreen
        LDY a30F7
        LDA a36A3
        SEC 
        SBC a31CF
        SEC 
        SBC a30F7
        STA zp02 
        JSR ModifyAndDrawCharacterOnScreen
        LDA a36A3
        STA zp02 
        LDA a30F7
        CLC 
        ADC a36A4
        CLC 
        ADC a31CF
        STA zp03 
        JSR ModifyAndDrawCharacterOnScreen
        LDA a36A4
        SEC 
        SBC a30F7
        SEC 
        SBC a31CF
        STA zp03 
        JSR ModifyAndDrawCharacterOnScreen
        LDY a30F7
        DEY 
        BMI b369E
        CPY #$06
        BNE b362E
        DEC a36A2
        JMP b362E

b369E   LDX tmpAorX
        RTS 

a36A2   .BYTE $00
a36A3   .BYTE $00
a36A4   .BYTE $00

;------------------------------------------------------
; DrawInitialShips
;------------------------------------------------------
DrawInitialShips
        LDX #$03 ; Four ships!
b36A7   LDA ShipData3,X
        BMI b36D3
        LDA ShipData1,X
        STA zp02 
        LDA #$42
        STA colourToPlot 
        CPX #$00
        BNE b36BD
        LDA #$75
        STA colourToPlot 
b36BD   LDA #$E0
        CLC 
        ADC ShipData3,X
        STA charToPlot
        LDA ShipData2,X
        STA zp03 
        STX tmpAorX
        JSR ModifyAndDrawCharacterOnScreen
        LDX tmpAorX
b36D3   DEX 
        BPL b36A7
        RTS 

;------------------------------------------------------
; ColorPulseLevelAndScoreText
;------------------------------------------------------
ColorPulseLevelAndScoreText
        DEC a36DD
        BEQ b36DE
b36DC   RTS 

a36DD   .BYTE $06
b36DE   LDA #$06
        STA a36DD
        LDX #$04
b36E5   LDA COLOR_RAM + $03C0,X
        CLC 
        ADC #$10
        STA COLOR_RAM + $03C0,X
        LDA COLOR_RAM + $03D3,X
        CLC 
        ADC #$10
        STA COLOR_RAM + $03D3,X
        DEX 
        BPL b36E5
        LDA a234C
        BMI b370E

        ; This rotates the ship icon next to the 'lives left'. $60
        ; is the ship icon and values up to $68 animate it rotating
        ; 360 degress.
        INC SCREEN_RAM + $03E1
        LDA SCREEN_RAM + $03E1
        CMP #$68
        BNE b36DC
        LDA #$60
        STA SCREEN_RAM + $03E1
b370E   RTS 

f370F   .BYTE $00,$00,$00,$00,$FF,$FF,$FF,$00
        .BYTE $01,$01,$01,$00,$00,$00,$00,$00
f371F   .BYTE $00,$FF,$01,$00,$00,$FF,$01,$00
        .BYTE $00,$FF,$01,$00,$00,$00,$00,$00
f372F   .BYTE $00,$00,$00,$00
f3733   .BYTE $00,$00,$00,$00
f3737   .BYTE $00,$00,$00,$00
a373B   .BYTE $30
a373C   .BYTE $01

;------------------------------------------------------
; HandleInputAndMoveShips
;------------------------------------------------------
HandleInputAndMoveShips
        DEC a373B
        BNE b370E
        LDA #$60
        STA a373B
        DEC a373C
        BNE b370E
        LDA #$01
        STA a373C

        LDA currentJoystick1Reading
        EOR #$FF
        AND #$0F
        TAY 
        PHA 

        LDX #$03 ; Four ships to move.
b375C   PLA 
        PHA 
        TAY 
        LDA ShipData3,X
        BMI b37C2
        LDA f372F,X
        BEQ b37AE
        AND #$0F
        BEQ b3791
        TYA 
        AND #$03
        BEQ b377F
        LDA f372F,X
        AND #$03
        STA tmpAorX
        TYA 
        EOR tmpAorX
        TAY 
b377F   TYA 
        AND #$0C
        BEQ b3791
        LDA f372F,X
        AND #$0C
        STA tmpAorX
        TYA 
        EOR tmpAorX
        TAY 
b3791   LDA f372F,X
        AND #$F0
        BEQ b37AE
        TYA 
        STA tmpAorX
        ASL 
        ASL 
        AND #$0C
        STA a30F7
        LDA tmpAorX
        ROR 
        ROR 
        AND #$03
        ORA a30F7
        TAY 
b37AE   LDA ShipData1,X
        CLC 
        ADC f370F,Y
        STA f3733,X
        LDA ShipData2,X
        CLC 
        ADC f371F,Y
        STA f3737,X
b37C2   DEX 
        BPL b375C

        PLA 
        LDA f3733
        CMP ShipData1
        BNE b37DA
        LDA f3737
        CMP ShipData2
        BNE b37DA
        JMP j3803

b37D9   RTS 

b37DA   LDA f3733
        BMI b37D9
        CMP #$28
        BPL b37D9
        LDA f3737
        BMI b37D9
        CMP #$18
        BPL b37D9

        LDX #$03 ; Four ships to draw.
b37EE   LDA ShipData1,X
        STA zp02 
        LDA ShipData2,X
        STA zp03 
        LDA #$01
        STA a36A2
        JSR PrepareAndDrawCharacter2
        DEX 
        BPL b37EE

j3803   LDA #$00
        STA a36A2

        LDX #$03 ; Four ships to move.
b380A   LDA f3733,X
        STA zp02 
        STA ShipData1,X
        LDA f3737,X
        STA zp03 
        STA ShipData2,X
        LDA f382E,X
        STA colourToPlot 
        LDA #$E0
        CLC 
        ADC ShipData3,X
        STA charToPlot
        JSR PrepareAndDrawCharacter2
        DEX 
        BPL b380A

b382D   RTS 

f382E   .BYTE $75,$42,$42,$42

;------------------------------------------------------
; PrepareAndDrawCharacter2
;------------------------------------------------------
PrepareAndDrawCharacter2
        LDA zp02 
        STX tmpAorX
        BMI b382D
        CMP #$28
        BPL b382D
        LDA zp03 
        BMI b382D
        CMP #$18
        BPL b382D
        JSR Screen_GetPointer
        AND #$80
        BEQ b386B
        LDA (currScreenPtrLo),Y
        AND #$F0
        CMP #$D0
        BNE b385A
        JSR s3ABC
        JMP b386B

b385A   CMP #$E0
        BNE b3866
        LDA (currScreenPtrLo),Y
        AND #$0C
        CMP #$0C
        BNE b386B
b3866   LDA #$01
        STA playerIsAlive
b386B   JSR DrawCharacter2
        LDX tmpAorX
        RTS 

f3872   .BYTE $00,$01,$01,$01,$00,$FF,$FF,$FF
f387A   .BYTE $FF,$FF,$00,$01,$01,$01,$00,$FF
f3882   .BYTE $68,$6A,$69,$6B,$68,$6A,$69,$6B
f388A   .BYTE $FF,$FF,$FF,$FF
f388E   .BYTE $FF,$FF,$FF,$FF
f3892   .BYTE $00,$00,$00,$00
a3896   .BYTE $C0
;------------------------------------------------------------------
; HandleFirePressed
;------------------------------------------------------------------
HandleFirePressed
        DEC a3896
        BEQ b389D
        RTS 

b389D   LDX #$03 ; Four ships to fire.
b389F   LDA f388A,X
        BPL b38B0
        JSR PrepareFireDataIfFirePressed
j38A7   DEX 
        BPL b389F

        LDA #$20
        STA a3896
b38AF   RTS 

b38B0   JSR DrawFireAnimation
        JMP j38A7

;------------------------------------------------------------------
; PrepareFireDataIfFirePressed   
;------------------------------------------------------------------
PrepareFireDataIfFirePressed   
        ; Check if fire waas pressed. The fire button sets bit 6 (i.e. $40)
        ; to zero. So 'AND'ing with $40 and getting the Z bit flipped to 0
        ; means that fire was not pressed. Getting the Z bit flipped to 1
        ; means that it was pressed.
        LDA currentJoystick1Reading
        AND #$40 ; Fire
        BNE b38AF
        ; Fire was pressed. 
        LDA ShipData1,X
        STA f388A,X
        LDA ShipData2,X
        STA f388E,X
        LDA #$20
        STA f3892,X
        LDA #<p03A0
        STA a3986
        LDA #>p03A0
        STA a3987
        LDA ShipData3,X
        STA f39DA,X
        RTS 

;------------------------------------------------------------------
; DrawFireAnimation
;------------------------------------------------------------------
DrawFireAnimation
        LDA f388A,X
        STA zp02 
        LDA f388E,X
        STA zp03 
        LDA #$01
        STA a36A2
        JSR DrawStepInFireAnimation
        LDY f39DA,X
        LDA f388A,X
        CLC 
        ADC f3872,Y
        STA f388A,X
        BMI b3921
        CMP #$28
        BPL b3921
        LDA f388E,X
        CLC 
        ADC f387A,Y
        STA f388E,X
        BMI b3921
        CMP #$18
        BPL b3921
        LDA #$00
        STA a36A2
        DEC f3892,X
        LDA f3892,X
        BNE b3927
b3921   LDA #$FF
        STA f388A,X
        RTS 

b3927   ASL 
        ASL 
        AND #$70
        ORA #$07
        STA colourToPlot
        LDA f3882,Y
        STA charToPlot
        LDA f388A,X
        STA zp02
        LDA f388E,X
        STA zp03
        STX tmpAorX
        JSR Screen_GetPointer
        LDX tmpAorX
        AND #$80
        BEQ b3961
        LDA (currScreenPtrLo),Y
        JSR s19AC
        BEQ b3960
        BMI b3921
        CLC 
        ADC f39DA,X
        AND #$07
        STA f39DA,X
        JMP j1AE5

b3960   RTS 

b3961   JSR DrawCharacter2
        LDX tmpAorX
b3967   RTS 

DrawStepInFireAnimation
        STX tmpAorX
        JSR Screen_GetPointer
        AND #$80
        BEQ b397F
        LDA (currScreenPtrLo),Y
        LDX tmpAorX
        JSR s19AC
        BEQ b3967
        BMI b3921
        RTS 

b397F   JSR ModifyAndDrawCharacterOnScreen
        LDX tmpAorX
b3985   RTS 

a3986   .BYTE $00
a3987   .BYTE $00
;------------------------------------------------------
; PlayBackgroundSounds
;------------------------------------------------------
PlayBackgroundSounds
        LDA playerIsAlive
        BNE b3985 ; Stop playing if player is dead.
        LDA a3987
        BNE b399B
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$EF
        STA $FF11    ;Bits 0-3 : Volume control
b399A   RTS 

b399B   LDA a3986
        ROL 
        ROL 
        ROL 
        AND #$03
        STA a39D9
        LDA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        AND #$FC
        ORA a39D9
        STA $FF12    ;Bit 0-1 : Voice #1 frequency, bits 8 & 9
        LDA a3986
        ASL 
        ASL 
        AND #$FC
        STA $FF0E    ;Voice #1 frequency, bits 0-7
        LDA $FF11    ;Bits 0-3 : Volume control
        ORA #$1F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA a3986
        SEC 
        SBC #$08
        STA a3986
        CMP #$40
        BNE b399A
        LDA #$A0
        STA a3986
        DEC a3987
        RTS 

a39D9   .BYTE $00
f39DA   .BYTE $00,$00,$00,$00
;------------------------------------------------------
; PlaySound4
;------------------------------------------------------
PlaySound4
        LDA #$C0
        STA a33CF
        STA a2ED6
        LDA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
        LDA #$10
        STA a3987
b39F0   JSR PlaySoundImpl
        LDX #$C0
b39F5   LDY #$0A
b39F7   DEY 
        BNE b39F7
        DEX 
        BNE b39F5
        LDA a2ED6
        SEC 
        SBC #$18
        STA a2ED6
        BNE b39F0
        LDA #$C0
        STA a2ED6
        LDA a3987
        SEC 
        SBC #$04
        STA a3987
        ORA #$30
        STA $FF11    ;Bits 0-3 : Volume control
        CMP #$30
        BNE b39F0
        LDA #$F0
        STA a2ED6
        LDA #$0F
        STA a3987
b3A29   RTS 

;------------------------------------------------------
; s3A2A
;------------------------------------------------------
s3A2A   DEC a3A6F
        BNE b3A29
        LDA #$1A
        STA a3A6F
        LDA a3987
        ASL 
        ASL 
        ASL 
        AND #$70
        ORA #$06

        LDX #$03 ; Four ships.
b3A40   LDY f1F97,X
        STA colorSequence,Y
        DEX 
        BPL b3A40

        JSR PlaySoundImpl
        LDA a2ED6
        CLC 
        ADC #$02
        STA a2ED6
        CMP #$F8
        BNE b3A29
        LDA #$F0
        STA a2ED6
        DEC a3987
        BPL b3A66
        INC a3987
b3A66   LDA a3987
        ORA #$30
        STA $FF11    ;Bits 0-3 : Volume control
        RTS 

a3A6F   .BYTE $00

;------------------------------------------------------
; s3A70
;------------------------------------------------------
s3A70   LDY a17E2
        LDX #$04
        LDA BgrndAnimationData1,Y
        STA RAM_DATPTR_LO
        LDA BgrndAnimationData2,Y
        STA RAM_DATPTR_HI 
        LDY #$00

b3A81   LDA (RAM_DATPTR_LO),Y
        STA txtLevelName,Y
        STA CurrentLevelText,Y
        INY 
        DEX 
        BPL b3A81

        LDX #$00
b3A8F   LDA (RAM_DATPTR_LO),Y
        STA ShipData1,X
        TYA 
        PHA 
        CLC 
        ADC #$04
        TAY 
        LDA (RAM_DATPTR_LO),Y
        STA ShipData2,X
        TYA 
        CLC 
        ADC #$04
        TAY 
        LDA (RAM_DATPTR_LO),Y
        STA f372F,X
        TYA 
        CLC 
        ADC #$04
        TAY 
        LDA (RAM_DATPTR_LO),Y
        STA ShipData3,X
        PLA 
        TAY 
        INY 
        INX 
        CPX #$04
        BNE b3A8F
        RTS 

;------------------------------------------------------
; s3ABC
;------------------------------------------------------
s3ABC   TXA 
        PHA 
        TYA 
        PHA 
        LDX #$1F
b3AC2   LDY #$03
        TXA 
        PHA 
        LDA f13A2,X
        BMI b3ACE
        JSR SelectStepInAnimation1
b3ACE   PLA 
        TAX 
        DEX 
        BPL b3AC2
        PLA 
        TAY 
        PLA 
        TAX 
b3AD7   RTS 

a3AD8   .BYTE $00

;------------------------------------------------------------------
; UpdateBackgroundAnimation
; If the player presses 'right' on the joystick, update the background
; animation.
;------------------------------------------------------------------
UpdateBackgroundAnimation
        LDA a3AD8
        BEQ b3AED
        DEC a3AD8
        LDA currentJoystick1Reading
        AND #$08 ; right
        BNE b3AD7
        LDA #$00
        STA a3AD8
b3AED   LDA currentJoystick1Reading
        AND #$08 ; right
        BNE b3AD7
        LDA #$F0
        STA a3AD8
        INC a17E2
        LDA a17E2
        AND #$0F
        STA a17E2
        LDX a17E2
        LDA BgrndAnimationData1,X
        STA RAM_DATPTR_LO
        LDA BgrndAnimationData2,X
        STA RAM_DATPTR_HI 
        LDY #$04
b3B13   LDA (RAM_DATPTR_LO),Y
        STA SCREEN_RAM + $0376,Y
        DEY 
        BPL b3B13
b3B1B   LDA currentJoystick1Reading
        AND #$08 ; right
        BEQ b3B1B
        LDA #$0C
        STA a2BF3
        RTS 

a3B28   .BYTE $00
a3B29   .BYTE $00
;------------------------------------------------------------------
; RunGameOverAnimation
;------------------------------------------------------------------
RunGameOverAnimation
        LDX #$08
b3B2C   LDA f3B4A,X
        CLC 
        ADC a3B28
        STA a3098
        LDA f3B52,X
        CLC 
        ADC a3B29
        STA a3099
        LDA f3B5A,X
        JSR DrawLargeCharacter
        DEX 
        BPL b3B2C
        RTS 

f3B4A   .BYTE $00,$08,$10,$18,$00,$08,$10,$18
f3B52   .BYTE $00,$00,$00,$00,$08,$08,$08,$08
f3B5A   .TEXT "GAMEOVER"

;------------------------------------------------------------------
; PlayGameOverSequence
;------------------------------------------------------------------
PlayGameOverSequence
        LDA #$00
        STA a30F8
        STA a3B28
        STA a3B29
        LDA a33CE
        AND #$07
        BNE b3B76
        LDA #$01
b3B76   STA a30F9
        LDA #$FF
        STA a12D7
        JSR RunAnAnimationOnScreen
        
b3B81   JSR RunGameOverAnimation
        INC a3B28
        INC a3B29
        LDA a30F9
        CLC 
        ADC #$10
        STA a30F9
        AND #$F0
        CMP #$80
        BNE b3B81
        LDA #$3F
        STA $FF11    ;Bits 0-3 : Volume control
j3B9E   LDA #$20
        STA a3BDB
b3BA3   JSR s18D7
        STA a2ED6
        JSR PlaySoundImpl
        LDX #$10
b3BAE   LDY #$C0
b3BB0   DEY 
        BNE b3BB0
        DEX 
        BNE b3BAE
        DEC a3BDB
        BNE b3BA3
        DEC $FF11    ;Bits 0-3 : Volume control
        LDA $FF11    ;Bits 0-3 : Volume control
        AND #$0F
        BEQ b3BC8
        JMP j3B9E

b3BC8   LDX #$F8
        TXS 
        LDA #$00
        STA $FF11    ;Bits 0-3 : Volume control
        LDA LivesLeft
        BNE b3BD8
        JMP JumpToInitialize

b3BD8   JMP DisplayHiScoreScreen

a3BDB   .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF

.include "charset.asm"

        .BYTE $F0
        .BYTE $F0,$F0,$F0,$0F
        .BYTE $0F,$0F
