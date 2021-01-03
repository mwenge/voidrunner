;
; **** ZP FIELDS **** 
;
f9D = $9D
;
; **** ZP ABSOLUTE ADRESSES **** 
;
a02 = $02
a03 = $03
a04 = $04
a05 = $05
a06 = $06
a07 = $07
a08 = $08
a09 = $09
a0A = $0A
a10 = $10
a40 = $40
a41 = $41
a42 = $42
a43 = $43
a44 = $44
a46 = $46
a48 = $48
a49 = $49
aFA = $FA
aFE = $FE
aFF = $FF
;
; **** ZP POINTERS **** 
;
p00 = $00
p06 = $06
p09 = $09
p11 = $11
p22 = $22
p31 = $31
p40 = $40
p42 = $42
p43 = $43
;
; **** FIELDS **** 
;
f0340 = $0340
f0360 = $0360
f0800 = $0800
f0828 = $0828
f0900 = $0900
f0924 = $0924
f094C = $094C
f09C4 = $09C4
f09EC = $09EC
f0A00 = $0A00
f0A64 = $0A64
f0A8C = $0A8C
f0B00 = $0B00
f0B2C = $0B2C
f0B54 = $0B54
f0B70 = $0B70
f0BC0 = $0BC0
f0BD3 = $0BD3
f0C28 = $0C28
f0D00 = $0D00
f0D24 = $0D24
f0D4C = $0D4C
f0DC4 = $0DC4
f0DEC = $0DEC
f0E00 = $0E00
f0E64 = $0E64
f0E8C = $0E8C
f0F00 = $0F00
f0F2C = $0F2C
f0F54 = $0F54
f0F70 = $0F70
f0F76 = $0F76
f0FC0 = $0FC0
f0FC7 = $0FC7
;
; **** ABSOLUTE ADRESSES **** 
;
a02BD = $02BD
a0314 = $0314
a0315 = $0315
a0FE1 = $0FE1
a0FE3 = $0FE3
a659D = $659D
a7049 = $7049
aE000 = $E000
aFC00 = $FC00
aFF07 = $FF07
aFF08 = $FF08
aFF09 = $FF09
aFF0A = $FF0A
aFF0B = $FF0B
aFF0E = $FF0E
aFF0F = $FF0F
aFF10 = $FF10
aFF11 = $FF11
aFF12 = $FF12
aFF13 = $FF13
aFF15 = $FF15
aFF16 = $FF16
aFF17 = $FF17
aFF19 = $FF19
;
; **** POINTERS **** 
;
p30 = $0030
p0100 = $0100
p0101 = $0101
p01FF = $01FF
p03A0 = $03A0
p080F = $080F
p0C00 = $0C00
p0CA0 = $0CA0
p0E58 = $0E58
pF8F0 = $F8F0
pFF00 = $FF00
;
; **** EXTERNAL JUMPS **** 
;
e4020 = $4020
e4030 = $4030

        * = $1001

        .BYTE $15,$10,$C3,$07,$9E,$34,$31,$31
        .BYTE $32,$20,$3A,$20,$00
        BRK #$00
j1010   JMP j2B0A

        ORA (p00,X)
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
s1028   LDY #$00
        LDA a17E2
        AND #$07
        TAY 
        LDA f1041,Y
        STA a103F
        LDA f1049,Y
        STA a1040
        JMP (a103F)

a103F   .BYTE $51
a1040   .BYTE $10
f1041   .BYTE $51,$08,$6A,$51,$BF,$51,$B3,$08
f1049   .BYTE $10,$12,$12,$10,$12,$10,$12,$12
        LDY #$00
        JSR s12CB
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
        JSR s1177
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
        JSR s1170
        AND #$07
        CLC 
        ADC #$04
        TAX 
        STX a11E5
        LDA f119D,X
        STA a101A
        LDA f11AD,X
        STA a119B
        JSR s1170
        AND #$07
        CLC 
        ADC #$04
        TAX 
        STX a11E6
        LDA f119D,X
        STA a101B
        LDA f11AD,X
        STA a119C
        JSR s1170
        AND #$07
        CLC 
        ADC #$01
        STA a1020
        STA a1021
        JSR s1170
        AND #$07
        CLC 
        ADC #$01
        STA a1022
        STA a1023
b116F   RTS 

s1170   .BYTE $AD
        PHP 
        CPX #$EE
        ADC (p11),Y
        RTS 

s1177   LDA a1015
        LDX a1021
        BEQ b1185
        JSR s11BD
        JMP j1188

b1185   STA a1199
j1188   LDA a1016
        LDX a1023
        BEQ b1193
        JMP j11D0

b1193   STA a119A
        JMP j11E7

a1199   .BYTE $03
a119A   .BYTE $0B
a119B   .BYTE $03
a119C   .BYTE $04
f119D   .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $02,$03,$04,$05,$06,$07,$08,$09
f11AD   .BYTE $08,$07,$06,$05,$04,$03,$02,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
s11BD   LDA a1015
        CLC 
        ROR 
        STA aFA
        LDA a1017
        CLC 
        ROR 
        CLC 
        ADC aFA
        STA a1199
        RTS 

j11D0   LDA a1016
        CLC 
        ROR 
        STA aFA
        LDA a1018
        CLC 
        ROR 
        CLC 
        ADC aFA
        STA a119A
        JMP j11E7

a11E6   =*+$01
a11E5   ORA a04
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
        JSR s1318
        PLA 
        TAY 
        RTS 

a11FD   BRK #$00
f11FF   BRK #$08
        BPL b121B
        JSR s3028
        SEC 
a1207   .BYTE $02
s1208   DEC a1207
        BEQ b120E
        RTS 

b120E   LDA #$02
        STA a1207
        JSR s12CB
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
        JSR s129F
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
s126A   JSR s12CB
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
        JSR s129F
        LDX a11FD
        DEX 
        BPL b126F
        RTS 

a129E   .BYTE $00
s129F   LDA a129E
        BEQ b12AA
        TXA 
        PHA 
        TYA 
        TAX 
        PLA 
        TAY 
b12AA   JSR s1318
        LDA #$00
        STA aFF15
        RTS 

        LDA #$01
        STA a129E
        JSR s126A
        DEC a129E
        RTS 

        LDA #$01
        STA a129E
        JSR s1208
        DEC a129E
        RTS 

s12CB   LDX #$7F
        LDA a12D7
b12D0   STA f3C78,X
        DEX 
        BPL b12D0
        RTS 

a12D7   .BYTE $FF
f12D8   .BYTE $00,$02,$04,$06,$20,$22,$24,$26
        .BYTE $40,$42,$44,$46,$60,$62,$64,$66
f12E8   .BYTE $00,$00,$00,$00,$08,$08,$08,$08
        .BYTE $10,$10,$10,$10,$18,$18,$18,$18
f12F8   .BYTE $40,$10,$04,$01,$40,$10,$04,$01
        .BYTE $40,$10,$04,$01,$40,$10,$04,$01
f1308   .BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
        .BYTE $3F,$CF,$F3,$FC,$3F,$CF,$F3,$FC
s1318   LDA a12D7
        BNE b1337
        LDA f12D8,Y
        CLC 
        ADC f12E8,X
        TAY 
        LDA f3C78,Y
        ORA f12F8,X
        STA f3C78,Y
        LDX a2CFE
        BNE b1336
        STA f3C79,Y
b1336   RTS 

b1337   LDA f12D8,Y
        CLC 
        ADC f12E8,X
        TAY 
        LDA f3C78,Y
        AND f1308,X
        STA f3C78,Y
        STA f3C79,Y
        RTS 

s134C   LDA #>p0C00
        STA aFF
        LDA #<p0C00
        STA aFE
        LDX #$00
b1356   LDA aFE
        STA f0340,X
        LDA aFF
        STA f0360,X
        LDA aFE
        CLC 
        ADC #$28
        STA aFE
        LDA aFF
        ADC #$00
        STA aFF
        INX 
        CPX #$19
        BNE b1356
        RTS 

s1373   LDX a03
        LDY a02
        LDA f0340,X
        STA a06
        LDA f0360,X
        STA a07
        LDA (p06),Y
        RTS 

j1384   LDX a03
        LDY a02
        LDA f0340,X
        STA a06
        LDA f0360,X
        STA a07
        LDA a04
        STA (p06),Y
        LDA a07
        SEC 
        SBC #$04
        STA a07
        LDA a05
        STA (p06),Y
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

s14CB   LDX #$00
b14CD   LDA f13A2,X
        BMI b14D9
        TXA 
        PHA 
        JSR s14E1
        PLA 
        TAX 
b14D9   INX 
        CPX #$20
        BNE b14CD
        RTS 

a14DF   .BYTE $00
a14E0   .BYTE $00
s14E1   LDY f13E2,X
        LDA f14F3,Y
        STA a14DF
        LDA f1503,Y
        STA a14E0
        JMP (a14DF)

f14F3   .BYTE $E3,$81,$14,$B0,$C8,$1A,$5B,$D5
        .BYTE $10,$81,$81,$81,$81,$D5,$7A,$7A
f1503   .BYTE $17,$19,$1B,$1B,$1C,$1D,$1E,$1E
        .BYTE $20,$19,$19,$19,$19,$1E,$21,$21
a1513   .BYTE $00
b1514   DEC a15CD
        BEQ b1529
b1519   RTS 

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
        LDA f15D3,Y
        CLC 
        ADC #$15
        STA a40
        LDA f15F1,Y
        ADC #$00
        STA a41
        LDY a15CE
j1548   LDA (p40),Y
        CMP #$23
        BNE b155A
        INY 
        LDA (p40),Y
        STA a15D0
        INY 
        STY a15D1
        LDA (p40),Y
b155A   CMP #$24
        BNE b156F
        DEC a15D0
        BEQ b156B
        LDY a15D1
        LDA (p40),Y
        JMP b156F

b156B   INY 
        JMP j1548

b156F   CMP #$FD
        BEQ b15B8
        CMP #$FE
        BNE b1589
        INY 
        LDA (p40),Y
        STA a15CD
        BNE b1584
        LDA #$01
        STA a15CF
b1584   INY 
        STY a15CE
        RTS 

b1589   AND #$80
        BEQ b1595
        LDA (p40),Y
        AND #$7F
        STA a1513
        INY 
b1595   LDA (p40),Y
        STA a15CB
        INY 
        LDA (p40),Y
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
        STA a1F29
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
f15D3   .BYTE $0F,$47,$7F,$B4,$DD,$FF,$6D,$A9
        .BYTE $DB,$0E,$2F,$52,$74,$A6,$D9,$10
        .BYTE $3C,$64,$97,$C4,$E9,$1C,$4F,$76
        .BYTE $BE,$F1,$24,$4B,$80,$A3
f15F1   .BYTE $16,$16,$16,$16,$16,$16,$26,$26
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
s17C2   DEC a17BF
        BNE b17CF
        JSR s14CB
        LDA #$30
        STA a17BF
b17CF   DEC a17C1
        BNE b17E1
        LDA #$FF
        STA a17C1
        LDA a1F29
        BNE b17E1
        JSR s151A
b17E1   RTS 

a17E2   .BYTE $00
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
        JSR s1804
        JMP j185B

s1804   LDA f13A2,X
        PHA 
        STA a02
        LDA f13C2,X
        PHA 
        STA a03
        LDA f1442,X
        CLC 
        ADC a02
        STA a02
        LDA f1442,X
        CLC 
        ADC a03
        STA a03
        LDA #$01
        STA a36A2
        JSR s18AD
        PLA 
        PHA 
        SEC 
        SBC f1442,X
        STA a03
        JSR s18AD
        PLA 
        STA a03
        PLA 
        PHA 
        SEC 
        SBC f1442,X
        STA a02
        LDA a03
        PHA 
        SEC 
        SBC f1442,X
        STA a03
        JSR s18AD
        PLA 
        CLC 
        ADC f1442,X
        STA a03
        PLA 
        SEC 
        SBC f1442,X
        STA a02
        JMP s18AD

j185B   DEC f1442,X
        BMI b18CE
j1860   LDA #$00
        STA a36A2
        LDA #$71
        STA a05
        LDA f13A2,X
        SEC 
        SBC f1442,X
        STA a02
        LDA f13C2,X
        CLC 
        ADC f1442,X
        STA a03
        LDA #$6F
        STA a04
        JSR s18AD
        LDA f13A2,X
        CLC 
        ADC f1442,X
        STA a02
        DEC a04
        JSR s18AD
        LDA f13C2,X
        SEC 
        SBC f1442,X
        STA a03
        INC a04
        JSR s18AD
        LDA f13A2,X
        SEC 
        SBC f1442,X
        STA a02
        DEC a04
        JMP s18AD

b18AC   RTS 

s18AD   LDA a02
        STX a18DE
        BMI b18AC
        CMP #$28
        BPL b18AC
        LDA a03
        BMI b18AC
        CMP #$18
        BPL b18AC
        JSR s1373
        AND #$80
        BNE b18CA
        JSR s33E1
b18CA   LDX a18DE
        RTS 

b18CE   JMP j18DF

        .BYTE $FF,$FF,$FF,$FF,$FF,$FF
a18D8   =*+$01
s18D7   LDA aE000
        INC a18D8
        RTS 

a18DE   .BYTE $00
j18DF   LDA f1402,X
        TAY 
s18E3   TYA 
        STA f13E2,X
        LDA f190C,Y
        STA a14DF
        LDA f191C,Y
        STA a14E0
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
        JSR s33E1
        PLA 
        TAX 
        JMP (a14DF)

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
        JSR s1AFF
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
        STA a05
        LDA #$EC
        STA a04
        LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
        JMP j1384

s19AC   STY a19C1
        LDY #$1F
b19B1   LDA a02
b19B3   CMP f13A2,Y
        BEQ b19C2
        DEY 
        BPL b19B3
        LDY a19C1
j19BE   LDA #$00
        RTS 

b19C2   =*+$01
a19C1   BRK #$A5
        .BYTE $03,$D9 ;SLO ($D9,X)
        .BYTE $C2,$13 ;NOP #$13
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
        JSR s18E3
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
a1A2B   =*+$01
a1A2C   =*+$02
a1A2A   .BYTE $FF,$00,$00 ;ISC $0000,X
s1A2D   LDY a1A2A
        BMI b1A11
        LDA a1F29
        BNE b1A11
        LDA f1A46,Y
        STA a1A2B
        LDA f1A4B,Y
        STA a1A2C
        JMP (a1A2B)

f1A46   BVC b19EA
        .BYTE $CF,$04,$24 ;DCP $2404
f1A4B   .BYTE $1A    ;NOP 
        .BYTE $1A    ;NOP 
        AND (p22,X)
        .BYTE $22    ;JAM 
        LDA aFF11
        AND #$1F
        ORA #$6F
        STA aFF11
        LDA a1A22
        BEQ b1A69
        LDA a1A23
        JSR s1A80
        DEC a1A22
        RTS 

b1A69   LDA a1A24
        BEQ b1A92
        LDA a1A25
        JSR s1A80
        DEC a1A24
        LDA aFF11
        AND #$3F
        STA aFF11
        RTS 

s1A80   PHA 
        ROL 
        ROL 
        ROL 
        AND #$03
        STA aFF10
        PLA 
        ROL 
        ROL 
        AND #$FC
        STA aFF0F
        RTS 

b1A92   LDA aFF11
        AND #$1F
        ORA #$0F
        STA aFF11
        LDA #$FF
        STA a1A2A
        RTS 

        LDA a1A22
        BEQ b1ABA
        LDA aFF11
        AND #$1F
        ORA #$4F
        STA aFF11
        INC a1A22
        LDA a1A22
        JMP s1A80

b1ABA   LDA aFF11
        AND #$1F
        ORA #$2F
        STA aFF11
        LDA a1A23
        JSR s1A80
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

s1AFF   LDA #<pF8F0
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
        STA a02
        LDA f13C2,X
        STA a03
        TXA 
        PHA 
        JSR s33E1
        PLA 
        TAX 
        LDA #$ED
        STA a04
        INC f1442,X
        LDA f1442,X
        AND #$0F
        TAY 
        LDA f1971,Y
        ORA f1422,X
        STA a05
        LDA f1482,X
        AND #$07
j1B4E   TAY 
        LDA a02
        CLC 
        ADC f3872,Y
        STA a02
        LDA a03
        CLC 
        ADC f387A,Y
        STA a03
        BMI b1B6D
        CMP #$18
        BPL b1B6D
        LDA a02
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
        JSR s1373
        CMP #$EC
        BNE b1B8F
        PLA 
        TAX 
        LDY f1482,X
        JMP b1B6D

b1B8F   AND #$F0
        CMP #$E0
        BNE b1BA0
        LDA (p06),Y
        AND #$08
        BNE b1BA0
        LDA #$01
        STA a1F29
b1BA0   JSR j1384
        PLA 
        TAX 
        LDA a02
        STA f13A2,X
        LDA a03
        STA f13C2,X
b1BAF   RTS 

        DEC f1402,X
        BNE b1BAF
        LDA f1442,X
        BNE b1BD3
        LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        JSR s33D0
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

a1BF7   =*+$01
a1BF8   =*+$02
a1BF6   .BYTE $FF,$FF,$FF ;ISC $FFFF,X
s1BF9   LDA (p40),Y
        CMP #$76
        BNE b1C06
        INY 
        LDA #$FF
        STA a1BF6
        RTS 

b1C06   LDA (p40),Y
        BPL b1C11
        JSR s18D7
        AND #$1F
        ADC #$04
b1C11   CMP #$44
        BNE b1C18
        LDA a3558
b1C18   STA a1BF6
        INY 
        LDA (p40),Y
        BPL b1C27
        JSR s18D7
        AND #$0F
        ADC #$04
b1C27   CMP #$44
        BNE b1C2E
        LDA a355C
b1C2E   STA a1BF7
        INY 
        LDA (p40),Y
        BPL b1C3B
        JSR s18D7
        AND #$07
b1C3B   STA a1BF8
        INY 
        RTS 

s1C40   LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
        LDA #$01
        STA a36A2
        TXA 
        PHA 
        JSR s33E1
        PLA 
        TAX 
        LDA #$00
        STA a36A2
        RTS 

a1C5C   .BYTE $00
j1C5D   
        LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
        TXA 
        PHA 
        JSR s1373
        STA a1C5C
        CMP a1D0E
        BNE b1C77
        PLA 
        TAX 
        RTS 

b1C77   AND #$F0
        CMP #$E0
        BNE b1C90
        LDA (p06),Y
        AND #$08
        BNE b1C90
        LDA a04
        AND #$F0
        CMP #$D0
        BEQ b1C90
        LDA #$01
        STA a1F29
b1C90   JSR j1384
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
        STA a04
        LDA #$5C
        STA a05
        JMP j1C5D

b1D09   LDY #$03
        JMP s18E3

a1D0E   BRK #$A9
        BRK #$9D
        .BYTE $22    ;JAM 
        .BYTE $14,$A9 ;NOP $A9,X
        .BYTE $04,$9D ;NOP a9D
        .BYTE $02    ;JAM 
b1D19   =*+$01
        .BYTE $14,$60 ;NOP $60,X
        DEC f1402,X
        BNE b1D19
        LDA #$01
        STA f1402,X
        LDA #$EC
        STA a04
        JSR s18D7
        AND #$70
        ORA #$02
        STA a05
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
        CMP a3558
        BNE b1D84
        LDA #$F4
        STA f1462,X
        LDA #$01
        STA f1482,X
        LDA #$01
        STA f1422,X
        LDA f13C2,X
        CMP a355C
        BMI b1D7E
        LDA #$00
        STA f1442,X
        RTS 

b1D7E   LDA #$04
        STA f1442,X
b1D83   RTS 

b1D84   LDA f13C2,X
        CMP a355C
        BNE b1D83
        LDA #$F5
        STA f1462,X
        LDA #$01
        STA f1482,X
        LDA #$01
        STA f1422,X
        LDA f13A2,X
        CMP a3558
        BMI b1DA9
        LDA #$06
        STA f1442,X
        RTS 

b1DA9   LDA #$02
        STA f1442,X
        RTS 

b1DB0   =*+$01
a1DAF   BRK #$C9
        .BYTE $02    ;JAM 
        BEQ b1E0A
        LDA f1462,X
        STA a04
        LDA f1482,X
        STA a1DAF
        TAY 
        LDA f1971,Y
        ORA #$0A
        STA a05
        LDY f1442,X
        LDA f13A2,X
        STA a02
        LDA f13C2,X
        STA a03
j1DD4   LDA a02
        CLC 
        ADC f3872,Y
        STA a02
        LDA a03
        CLC 
        ADC f387A,Y
        STA a03
        TXA 
        PHA 
        TYA 
        PHA 
        JSR s33D0
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
        JMP s18E3

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
        STA a05
        LDA #$EC
        STA a04
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

a1EAC   =*+$01
s1EAB   LDA aFC00
        INC a1EAC
        RTS 

        LDA #$04
        STA f1402,X
        LDA f13C2,X
        CMP a355C
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
        STA a05
        LDA f1422,X
        STA a04
        JMP j1C5D

b1F06   LDY #$03
        JMP s18E3

s1F0B   JSR s2AFA
        LDX #$09
b1F10   LDA f0FC7,X
        STA f34D2,X
        DEX 
        BPL b1F10
        LDY #$03
        LDX #$00
b1F1D   JSR s1F2A
        DEY 
        BPL b1F1D
        LDA #$02
        STA a1F29
        RTS 

s1F2A   =*+$01
a1F29   BRK #$B9
        CLI 
        AND f9D,X
        LDX #$13
        STA f13A3,X
        STA f13A4,X
        SEC 
        SBC #$02
        STA f13A5,X
        CLC 
        ADC #$04
        STA f13A6,X
        LDA a355C,Y
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
        LDX #$03
b1F7A   LDA a355C,X
        ASL 
        STA f1F97,X
        DEX 
        BPL b1F7A
        LDX #$03
b1F86   LDY f1F97,X
        LDA f2C65,Y
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
b1FBB   INC f0FC7,X
        LDA f0FC7,X
        CMP #$3A
        BNE b1FCD
        LDA #$30
        STA f0FC7,X
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
        STA a04
        LDA f13A2,X
        ASL 
        ASL 
        ASL 
        ASL 
        AND #$70
        ORA f1442,X
        STA a05
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
        JMP s18E3

a2086   .BYTE $00
a2087   .BYTE $00
f2088   .BYTE $02,$08,$07,$0C,$0D,$04,$0D,$0E
a2090   .BYTE $60
a2091   .BYTE $2D
a2092   .BYTE $2D
a2093   .BYTE $00
a2094   .BYTE $FF
a2095   .BYTE $FF
s2096   DEC a2090
        BEQ b209C
        RTS 

b209C   LDA #$C0
        STA a2090
        LDA a2094
        CMP #$FF
        BEQ b20AE
        LDX a2086
        STA f2C65,X
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
        LDA f2C65,X
        STA a2094
        LDA f2088,Y
        STA f2C65,X
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
        STA f2C65,X
        TXA 
        CLC 
        ROR 
        LDX #$00
b2115   CMP a355C,X
        BEQ b2120
        DEX 
        BPL b2115
        JMP j2134

b2120   LDA #$01
        STA a1F29
        LDX a2087
        LDA a2095
        STA f2C65,X
        LDA #$00
        STA a2093
        RTS 

j2134   DEC a2093
        BEQ b213A
        RTS 

b213A   LDX a2087
        LDA a2095
        STA f2C65,X
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
b21AB   STA a04
        LDA f1462,X
        STA a05
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
        JMP s18E3

        LDA aFF11
        AND #$1F
        ORA #$2F
        STA aFF11
        LDA a1A22
        SEC 
        SBC #$04
        STA a1A22
        CMP #$60
        BEQ b21E9
        JMP s1A80

b21E9   LDA aFF11
        AND #$1F
        ORA #$0F
        STA aFF11
        LDA #$FF
        STA a1A2A
        RTS 

        LDA #$A0
        STA a1A22
        LDA #$02
        STA a1A2A
        RTS 

        LDA aFF11
        AND #$1F
        ORA #$20
        STA aFF11
        LDA #$D0
        JSR s1A80
        DEC a1A22
        BEQ b21E9
        RTS 

        LDA #$04
        STA a1A22
        LDA #$03
        STA a1A2A
        RTS 

        LDA aFF11
        AND #$1F
        ORA #$20
        STA aFF11
        LDA #$02
        JSR s1A80
        DEC a1A22
        BEQ b21E9
        RTS 

        LDA #$08
        STA a1A22
        LDA #$04
        STA a1A2A
        RTS 

a2244   .BYTE $00
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
p2283   .TEXT "OKALA INCARNADINE             "
p22A1   .TEXT "0000500000GAF THE HORSE IN TEARS        "
        .TEXT "0000400000TARQUIN BISCUIT BARREL        "
        .TEXT "0000300000ATAHUALPA INCA                "
        .TEXT "0000200000NUMBER SIX                    "
        .TEXT "0000100000"
a234B   .BYTE $00
a234C   .BYTE $FF
j234D   JSR s2BDC
        JSR s351B
        LDA #$02
        STA a3196
        LDA #$00
        STA a12D7
        STA a2579
        LDA #$0F
        STA a234C
        LDA #$00
        JSR s2D01
        LDX #$27
b236C   LDA f2428,X
        CMP #$20
        BEQ b237B
        STA f0C28,X
        LDA #$77
        STA f0828,X
b237B   DEX 
        BPL b236C
        LDA #<p2283
        STA a40
        LDA #>p2283
        STA a41
        LDA #$05
        STA a42
        LDA #>p0CA0
        STA a44
        LDA #<p0CA0
        STA a43
b2392   LDY #$27
b2394   LDA (p40),Y
        CMP #$20
        BEQ b23B6
        STA (p43),Y
        LDA a44
        PHA 
        SEC 
        SBC #$04
        STA a44
        LDA a42
        ASL 
        ASL 
        ASL 
        ASL 
        CLC 
        ADC #$20
        AND #$F0
        ORA #$04
        STA (p43),Y
        PLA 
        STA a44
b23B6   DEY 
        BPL b2394
        LDA a40
        CLC 
        ADC #$28
        STA a40
        LDA a41
        ADC #$00
        STA a41
        LDA a43
        CLC 
        ADC #$50
        STA a43
        LDA a44
        ADC #$00
        STA a44
        DEC a42
        BNE b2392
        LDY a234B
        BNE b23DE
        LDY #$01
b23DE   LDA f241A,Y
        TAY 
        LDX #$07
b23E4   LDA f2420,X
        STA f2C65,Y
        INY 
        DEX 
        BPL b23E4
        LDA a234B
        BNE b2450
        JSR s2646
        LDA #$30
        STA a40
        LDX #$20
b23FC   LDY #$00
        LDA a2F81
        AND #$40
        BEQ b240F
b2405   DEY 
        BNE b2405
        DEX 
        BNE b23FC
        DEC a40
        BNE b23FC
b240F   LDX #$F8
        TXS 
        LDA #$00
        STA a234B
        JMP j1010

f241A   .BYTE $00,$05,$09,$0D,$11,$15
f2420   .BYTE $06,$26
        LSR a06
        ASL a46
        ROL a06
f2428   .TEXT "VOIDRUNNER FIVE BEST GAMES AND SCORERS /"
b2450   LDA #>p0E58
        STA a41
        LDA #<p0E58
        STA a40
        LDA #$71
        STA a43
b245C   LDY #$27
b245E   LDA f2496,Y
        CMP #$20
        BEQ b2476
        STA (p40),Y
        LDA a41
        PHA 
        SEC 
        SBC #$04
        STA a41
        LDA a43
        STA (p40),Y
        PLA 
        STA a41
b2476   DEY 
        BPL b245E
        LDA a40
        CLC 
        ADC #$28
        STA a40
        LDA a41
        ADC #$00
        STA a41
        LDA a43
        SEC 
        SBC #$10
        STA a43
        AND #$F0
        CMP #$F0
        BNE b245C
        JMP j24BE

f2496   .TEXT "EGO TRIP TIME  /   /   ENTER YOUR HANDLE"
j24BE   LDA #$0C
        STA a41
        LDA #$08
        STA a43
        LDA #$A0
        STA a40
        STA a42
        LDX #$00
        LDY a234B
j24D1   DEY 
        BEQ b24F0
        TXA 
        CLC 
        ADC #$27
        TAX 
        LDA a40
        CLC 
        ADC #$50
        STA a40
        STA a42
        LDA a41
        ADC #$00
        STA a41
        SEC 
        SBC #$04
        STA a43
        JMP j24D1

b24F0   LDY #$00
b24F2   JSR s24FE
        INY 
        INX 
        CPY #$1C
        BNE b24F2
        JMP b240F

s24FE   LDA (p42),Y
        PHA 
        LDA #$77
        STA (p42),Y
j2505   LDA (p40),Y
        AND #$E0
        BNE b250F
        LDA #$20
        STA (p40),Y
b250F   LDA a2F81
        AND #$04
        BNE b2522
        LDA (p40),Y
        SEC 
        SBC #$01
        JSR s255D
        STA (p40),Y
        BNE b2533
b2522   LDA a2F81
        AND #$08
        BNE b2546
        LDA (p40),Y
        CLC 
        ADC #$01
        JSR s255D
        STA (p40),Y
b2533   LDA #<p30
        STA a48
b2537   LDA #>p30
        STA a49
b253B   DEC a49
        BNE b253B
        DEC a48
        BNE b2537
        JMP j2505

b2546   LDA a2F81
        AND #$40
        BNE j2505
b254D   LDA a2F81
        AND #$4F
        CMP #$4F
        BNE b254D
        PLA 
        LDA (p40),Y
        STA p2283,X
        RTS 

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
s257A   LDA a234C
        CMP #$FF
        BNE b2587
        LDA #$0F
        STA aFF11
b2586   RTS 

b2587   LDA a234C
        ORA #$30
        STA aFF11
        LDY a2579
        LDA f2C9E,Y
        ASL 
        ASL 
        STA a2ED6
        JSR s2F2A
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

s25B3   LDA #<p22A1
        STA a40
        LDA #>p22A1
        STA a41
        LDA #<f34D2
        STA a42
        LDA #>f34D2
        STA a43
        LDX #$00
        LDA #$05
        STA a44
b25C9   LDY #$00
b25CB   LDA (p40),Y
        CMP (p42),Y
        BEQ b25D5
        BPL b25DA
        BMI b25F3
b25D5   INY 
        CPY #$0A
        BNE b25CB
b25DA   LDA #$28
        CLC 
        ADC a40
        STA a40
        LDA a41
        ADC #$00
        STA a41
        TXA 
        CLC 
        ADC #$28
        TAX 
        DEC a44
        BNE b25C9
        JMP j2638

b25F3   LDA a44
        CMP #$01
        BNE b260D
        LDA #$05
        STA a234B
        LDY #$00
b2600   LDA (p42),Y
        STA p22A1,X
        INY 
        INX 
        CPY #$0A
        BNE b2600
        BEQ j2638
b260D   LDY #$C7
b260F   LDA f225B,Y
        STA p2283,Y
        DEY 
        TXA 
        CLC 
        ADC #$28
        STA a2645
        TYA 
        CMP a2645
        BNE b260F
        LDY #$00
b2625   LDA (p42),Y
        STA p22A1,X
        INY 
        INX 
        CPY #$0A
        BNE b2625
        LDA #$06
        SEC 
        SBC a44
        STA a234B
j2638   LDA #<p0101
        STA a2BF1
        LDA #>p0101
        STA a2BF2
        JMP j3B62

a2645   .BYTE $00
s2646   LDX #$10
b2648   LDA f2D81,X
        STA f0F2C,X
        CLC 
        ADC #$20
        STA f0F54,X
        LDA #$5C
        STA f0B2C,X
        STA f0B54,X
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
s2AFA   LDX #$1F
        LDA #$FF
b2AFE   STA f13A2,X
        DEX 
        BPL b2AFE
        LDA #$00
        STA a14A2
        RTS 

j2B0A   LDA #$00
        STA aFF15
        STA aFF19
        STA a3196
        STA a15CE
        STA a17E2
        STA a2CFE
        STA a36A2
        JSR s2AFA
        JSR s134C
        LDA #$FF
        STA a234C
        LDA #<pFF00
        STA a2BF1
        LDA #>pFF00
        STA a2BF2
        LDA #$0C
        STA a2BF3
        SEI 
        LDA #$20
        STA a30F8
        LDA #<p2BF4
        STA a0314    ;IRQ
        LDA #>p2BF4
        STA a0315    ;IRQ
        LDA aFF12
        AND #$FB
        STA aFF12
        LDA aFF13
        AND #$03
        ORA #$3C
        STA aFF13
        LDA #$02
        STA aFF0A
        STA aFF09
        LDA #$40
        STA aFF0B
        LDA #$00
        STA a2BF0
        CLI 
        JSR s2BDC
b2B73   LDA a2F81
        AND #$40
        BEQ b2B73
        JSR s2CFF
        JSR s2E0A
        JSR s2E73
        JSR s2D0A
b2B86   JSR s3AD9
        DEC a2BF1
        BNE b2B9B
        DEC a2BF2
        BNE b2B9B
        DEC a2BF3
        BNE b2B9B
        JMP j234D

b2B9B   LDA a2F81
        AND #$40
        BNE b2B86
        JSR s2D51
        JMP j2F98

s2BA8   LDA #>p080F
        STA a05
s2BAC   LDA #<p080F
        STA a04
        LDA #$04
        STA a08
        STA a09
        LDA a03
        PHA 
        LDA a02
        PHA 
b2BBC   JSR j1384
        INC a02
        INC a04
        DEC a08
        BNE b2BBC
        PLA 
        PHA 
        STA a02
        LDA #$04
        STA a08
        INC a03
        DEC a09
        BNE b2BBC
        PLA 
        STA a02
        PLA 
        STA a03
        RTS 

s2BDC   LDA #$20
s2BDE   LDX #$00
b2BE0   STA p0C00,X
        STA f0D00,X
        STA f0E00,X
        STA f0F00,X
        DEX 
        BNE b2BE0
        RTS 

a2BF0   .BYTE $FF
a2BF1   .BYTE $12
a2BF2   .BYTE $3A
a2BF3   .BYTE $0C
p2BF4   LDA aFF09
        AND #$02
        BNE b2C01
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI 

b2C01   LDX a2BF0
        LDA f2C65,X
        STA aFF15
        CPX #$32
        BEQ b2C25
        LDA aFF0B
        CLC 
        ADC #$04
        STA aFF0B
j2C17   LDA #$02
        STA aFF09
        INC a2BF0
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI 

b2C25   LDX #$FF
        STX a2BF0
        LDA #$02
        STA aFF0B
        LDA #$00
        JSR s354D
        STA aFF15
        LDA a3196
        BEQ b2C4E
        LDX a3196
        LDA a3196,X
        STA a31CD
        LDA f3198,X
        STA a31CE
        JMP (a31CD)

b2C4E   JSR s1028
        JSR s2DE4
        JSR s2E43
        JSR s2ED9
        JSR s2F82
        LDA #$00
        STA aFF15
        JMP j2C17

f2C65   .BYTE $73,$04,$14,$24,$34,$44,$54,$64
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
s2CFF   LDA #$00
s2D01   LDX #$32
b2D03   STA f2C65,X
        DEX 
        BPL b2D03
        RTS 

s2D0A   LDA aFF07
        AND #$EF
        ORA #$10
        STA aFF07
        LDX #$10
b2D16   LDA f2D81,X
        STA f0DC4,X
        STA f0D24,X
        STA f0E64,X
        CLC 
        ADC #$20
        STA f0DEC,X
        STA f0D4C,X
        STA f0E8C,X
        LDA #$0A
        STA f09C4,X
        STA f09EC,X
        STA f0A64,X
        STA f0A8C,X
        STA f0924,X
        STA f094C,X
        DEX 
        BPL b2D16
        LDA #$01
        STA a2DE2
        LDA #$2E
        STA aFF17
        BNE b2D67
s2D51   LDX #$09
b2D53   LDA f34D2,X
        STA f2DD8,X
        LDA #$30
        STA f34D2,X
        DEX 
        BPL b2D53
        LDA #$35
        STA a34EE
        RTS 

b2D67   LDX #$27
b2D69   LDA f2D92,X
        STA f0C28,X
        LDA f2DBA,X
        STA f0F70,X
        LDA #$76
        STA f0828,X
        STA f0B70,X
        DEX 
        BPL b2D69
        RTS 

f2D81   .BYTE $01,$02,$03,$04,$05,$06,$07,$08
        .BYTE $09,$0A,$0B,$0C,$0B,$0C,$0D,$0E
        .BYTE $07
f2D92   .TEXT "VOIDRUNNER    CREATED BY   "
b2DAD   .TEXT "/ / YAK / /  "
f2DBA   .TEXT "LEVEL /YAK/    LAST SCORE WAS "
f2DD8   .TEXT "0000000000"
a2DE2   .BYTE $52
a2DE3   .BYTE $04
s2DE4   DEC a2DE3
        BEQ b2DEA
        RTS 

b2DEA   LDA #$06
        STA a2DE3
        LDA a2DE2
        CLC 
        ADC #$10
        AND #$60
        ORA #$12
        STA a2DE2
        STA aFF16
        JMP j2E2B

f2E02   BRK #$10
        JSR e4030
        BVC b2E69
s2E0A   =*+$01
        BVS b2DAD
b2E0C   =*+$01
        BRK #$BD
        .BYTE $02    ;JAM 
        ROL a659D
        BIT a02BD
        ROL a7049
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
b2E2D   LDA f2C65,X
        JSR s2E60
        STA f2C65,X
        LDA f2C8D,X
        JSR s2E60
        STA f2C8D,X
        DEX 
        BPL b2E2D
        RTS 

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

s2E60   CLC 
        ADC #$10
        PHA 
        AND #$80
        BNE b2E6A
        PLA 
b2E69   RTS 

b2E6A   PLA 
        AND #$0F
        CLC 
        ADC #$01
        AND #$0F
        RTS 

s2E73   LDA #$00
        STA a02
        LDA #$FF
        STA a12D7
        LDA #$04
        STA a03
b2E80   LDA a02
        PHA 
        JSR s2BA8
        LDA a02
        CLC 
        ADC #$04
        STA a02
        JSR s2BA8
        LDA a02
        CLC 
        ADC #$1C
        STA a02
        JSR s2BA8
        LDA a02
        CLC 
        ADC #$04
        STA a02
        JSR s2BA8
        PLA 
        STA a02
        LDA a03
        CLC 
        ADC #$04
        STA a03
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
s2ED9   LDA a2ED3
        BEQ b2F17
        DEC a2ED3
        BNE b2F15
        JSR s1170
        STA a2ED6
        STA a2ED7
        LDA #$08
        STA a2ED5
        LDA #$0F
        STA a2F16
        JSR s1170
        AND #$7F
        STA a2ED8
        INC a2ED8
        JSR s1170
        AND #$01
        BNE b2F10
        LDA a2ED8
        EOR #$FF
        STA a2ED8
b2F10   LDA #$01
        STA a101D
b2F15   RTS 

a2F16   .BYTE $00
b2F17   LDA aFF11
        AND #$F0
        ORA a2F16
        ORA #$30
        STA aFF11
        JSR s2F2A
        JMP j2F53

s2F2A   LDA a2ED6
        PHA 
        CLC 
        ROL 
        ROL 
        ROL 
        AND #$03
        STA aFF10
        STA a10
        LDA aFF12
        AND #$FC
        ORA a10
        STA aFF12
        PLA 
        CLC 
        ROL 
        ROL 
        AND #$FC
        STA aFF0E
        CLC 
        ADC #$06
        STA aFF0F
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
        LDA aFF11
        AND #$C0
        STA aFF11
        JSR s1170
        STA a2ED3
b2F80   RTS 

a2F81   .BYTE $7F
s2F82   SEI 
        LDX #$FA
b2F85   STX aFF08
        LDA aFF08
        STX aFF08
        CMP aFF08
        BNE b2F85
        CLI 
        STA a2F81
        RTS 

j2F98   LDA aFF11
        LDY #$01
        STY a33CF
        AND #$CF
        STA aFF11
        JSR s3A70
        LDA #$FF
        STA a2094
        STA a12D7
        LDA #$00
        JSR s2BDE
b2FB5   STA f0800,X
        STA f0900,X
        STA f0A00,X
        STA f0B00,X
        DEX 
        BNE b2FB5
        LDA a2094
        CMP #$FF
        BEQ b2FD1
        LDY a2086
        STA f2C65,Y
b2FD1   LDA #$FF
        STA a2094
        LDA #$00
        STA a2086
        LDA #$01
        STA a3196
        LDA #$00
        JSR s2D01
        LDX #$04
b2FE7   LDA #$01
        STA a3099
        LDA f309A,X
        STA a3098
        LDA f309F,X
        JSR s30AF
        LDA #$09
        STA a3099
        LDA f309A,X
        STA a3098
        LDA f30A4,X
        JSR s30AF
        LDA #$11
        STA a3099
        LDA f309A,X
        STA a3098
        LDA f30A9,X
        JSR s30AF
        DEX 
        BPL b2FE7
        LDA #>p01FF
        STA a311A
        LDA #<p01FF
        STA a3119
s3028   =*+$01
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
        JSR s2BDC
        JMP j32B5

a3097   .BYTE $00
a3098   .BYTE $00
a3099   .BYTE $00
f309A   .BYTE $00,$08,$10,$18,$20
f309F   .TEXT "ENTER"
f30A4   .TEXT "/YAK/"
f30A9   .TEXT "LEVEL"
a30AE   .TEXT $00
s30AF   STX a30AE
        JSR s30FA
        LDA a3098
        STA a02
        LDA a3099
        STA a03
        LDY #$00
b30C1   LDA (p09),Y
        PHA 
        LDA #$08
        STA a08
b30C8   PLA 
        ROL 
        PHA 
        BCC b30E0
        LDA a30F8
        STA a04
        LDA a30F9
        STA a05
        STY a30F7
        JSR j1384
        LDY a30F7
b30E0   INC a02
        DEC a08
        BNE b30C8
        PLA 
        INC a03
        LDA a3098
        STA a02
        INY 
        CPY #$08
        BNE b30C1
        LDX a30AE
        RTS 

a30F7   .BYTE $00
a30F8   .BYTE $20
a30F9   .BYTE $00
s30FA   LDY #<p3C00
        STY a09
        LDY #>p3C00
        STY a0A
        TAY 
        BEQ b3115
b3105   LDA a09
        CLC 
        ADC #$08
        STA a09
        LDA a0A
        ADC #$00
        STA a0A
        DEY 
        BNE b3105
b3115   RTS 

a3116   .BYTE $32
a3117   .BYTE $00
a3118   .BYTE $00
a3119   .BYTE $01
a311A   .BYTE $01
s311B   LDA a3097
        BNE b3121
        RTS 

b3121   CMP #$01
        BEQ b3128
        JMP j31D1

b3128   LDA aFF11
        ORA #$3F
        STA aFF11
        LDA a3117
        CMP a3116
        BEQ b317E
        LDA #$00
        LDX a3117
        STA f2C65,X
        TXA 
        CLC 
        ADC a311A
        TAX 
        STX a3117
        LDY a31CF
        LDA f2EB3,Y
        STA f2C65,X
        CPX a3116
        BEQ b3162
        LDA a3117
        ASL 
        ASL 
        STA a2ED6
        JMP s2F2A

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
        STA f2C65,X
        LDA #$00
        STA a3097
        LDA aFF11
        AND #$C0
        STA aFF11
        RTS 

a3195   .BYTE $27
a3196   .BYTE $00,$9B
f3198   .BYTE $A1
        AND (p31),Y
        JSR s311B
        JMP j2C17

        LDA #$00
        STA aFF15
        JSR s2F82
        JSR s1028
        LDA #$00
        STA aFF15
        LDA a234C
        BMI b31BC
        JSR s257A
        JMP j31CA

b31BC   JSR s36D7
        LDA a33CF
        BNE j31CA
        JSR s3988
        JSR s1A2D
j31CA   JMP j2C17

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
        LDA aFF11
        ORA #$3F
        STA aFF11
        INC a31CF
        LDX a31CF
        CPX #$06
        BEQ b3221
        LDA f322B,X
        STA aFF0E
        STA aFF0F
        INC aFF0F
        LDA aFF10
        AND #$FC
        ORA f3230,X
        STA aFF10
        LDA aFF12
        AND #$FC
        ORA f3230,X
        STA aFF12
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

b323D   LDA aFF0E
        CLC 
        ADC #$82
        STA aFF0E
        CLC 
        ADC #$04
        STA aFF0F
        DEC a31CF
        BNE f322B
        LDA #$0C
        STA a31CF
        LDA aFF11
        AND #$0F
        SEC 
        SBC #$01
        BNE b327E
        LDA aFF11
        ORA #$3F
        STA aFF11
        LDA #$04
        STA a2ED6
        LDA #$00
        STA a3097
        JSR s2F2A
        LDA aFF0F
        ADC #$05
        STA aFF0F
        RTS 

b327E   STA a30AE
        LDA aFF11
        AND #$C0
        ORA #$30
        ORA a30AE
        STA aFF11
        LDX #$32
b3290   LDA f2C65,X
        BEQ b32B1
        AND #$0F
        STA a30AE
        LDA f2C65,X
        AND #$F0
        BEQ b32A6
        SEC 
        SBC #$10
        BNE b32AB
b32A6   LDA #$00
        STA a30AE
b32AB   ORA a30AE
        STA f2C65,X
b32B1   DEX 
        BPL b3290
        RTS 

j32B5   LDA a17E2
        AND #$07
        TAY 
        LDA f3429,Y
        STA a33CE
        LDA f3431,Y
        STA aFF16
        LDA #$71
        STA aFF17
        LDA #$07
        STA a3398
        LDA #$00
        JSR s2D01
        LDA #$10
        STA a31CF
        LDA #$04
        STA a3097
b32E0   LDA a3097
        BNE b32E0
        JSR s3461
        LDA #$02
        STA a3196
        JSR s351B
        LDA #$05
        STA a02
        LDX #$00
        LDY #$00
b32F8   DEX 
        BNE b32F8
        DEY 
        BNE b32F8
        DEC a02
        BNE b32F8
        STX a12D7
        INC a2CFE
j3308   LDA #$00
        STA a33CF
        JSR s3564
b3310   JSR s373D
        JSR s3897
        JSR s17C2
        JSR s2096
        LDA a1F29
        BEQ b3310
        LDX #$09
b3323   LDA f0FC7,X
        STA f34D2,X
        STA f2DD8,X
        DEX 
        BNE b3323
        JSR s1F0B
        JSR s39DE
b3335   JSR s17C2
        JSR s3A2A
        LDA a3987
        BNE b3335
        JSR s351B
        LDA #$00
        STA a1F29
        JSR s2AFA
        LDX #$03
b334D   LDA f1F9B,X
        LDY f1F97,X
        STA f2C65,Y
        DEX 
        BPL b334D
        LDA a15CC
        BNE b3374
        DEC a34EE
        LDA a34EE
        CMP #$2F
        BNE b336E
        JSR s25B3
        JMP j3B62

b336E   STA a0FE3
        JMP j3308

b3374   LDA #$00
        STA a15CC
        INC a17E2
        LDA a17E2
        CMP #$1E
        BNE b3388
        LDA #$00
        STA a17E2
b3388   INC a34EE
        LDA a34EE
        CMP #$3A
        BNE b3395
        DEC a34EE
b3395   JMP j2F98

a3398   .BYTE $00
j3399   INC aFF0E
        INC aFF0F
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
        STA f2C65,X
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
s33D0   LDA a02
        BPL b33D5
b33D4   RTS 

b33D5   CMP #$28
        BPL b33D4
        LDA a03
        BMI b33D4
        CMP #$18
        BPL b33D4
s33E1   LDA a03
        CMP #$18
        BNE b33E8
        RTS 

b33E8   LDA a36A2
        BNE b33F0
        JMP j1384

b33F0   LDA a03
        AND #$03
        TAY 
        LDA a04
        PHA 
        LDA f3411,Y
        STA a04
        LDA a02
        AND #$03
        CLC 
        ADC a04
        STA a04
        LDA #$08
        STA a05
        JSR j1384
        PLA 
        STA a04
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
s3461   LDX #$13
        LDY #$00
b3465   LDA f3415,X
        STA f3439,Y
        STA f344D,X
        INY 
        DEX 
        BPL b3465
        LDA #$00
        STA a04
b3476   LDA #$00
        STA a31CF
        TAX 
b347C   LDA #$71
        STA a05
        LDA f3439,X
        STA a03
        STX a02
j3487   JSR s33D0
        LDX a02
        LDA a05
        AND #$F0
        SEC 
        SBC #$10
        CMP #$F0
        BEQ b34A0
        ORA #$01
        STA a05
        DEC a03
        JMP j3487

b34A0   INC f3439,X
        LDA f3439,X
        CMP #$20
        BNE b34BE
        DEC f3439,X
        INC a31CF
        LDA f34CB,X
        STA f0FC0,X
        LDA f34F3,X
        ORA #$70
        STA f0BC0,X
b34BE   INX 
        CPX #$28
        BNE b347C
        LDA a31CF
        CMP #$28
        BNE b3476
        RTS 

f34CB   .TEXT "SCORE: "
f34D2   .TEXT "0000000000  LEVEL: "
f34E5   .TEXT "/YAK/  `:"
a34EE   .TEXT "0 YAK"
f34F3   .BYTE $07,$07,$07,$07,$07,$07,$00,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$00,$00,$04,$04,$04,$04,$04
        .BYTE $01,$00,$01,$01,$01,$01,$01,$00
        .BYTE $00,$05,$01,$07,$00,$03,$03,$03
s351B   LDA #$00
        STA a02
        STA a03
        LDA #$09
        STA a05
b3525   JSR s2BAC
        LDA a02
        CLC 
        ADC #$04
        STA a02
        CMP #$28
        BNE b3525
        LDA #$00
        STA a02
        LDA a03
        CLC 
        ADC #$04
        STA a03
        CMP #$18
        BNE b3525
        LDA #<pF8F0
        STA aFF0E
        LDA #>pF8F0
        STA aFF0F
        RTS 

s354D   NOP 
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

a3558   .BYTE $13,$14,$15,$16
a355C   .BYTE $0C,$0C,$0C,$0C
f3560   .BYTE $07,$00,$00,$01
s3564   LDA #$20
        STA a31CF
b3569   LDX #$03
        LDA a31CF
        CLC 
        ROR 
        STA a30AE
        LDA aFF11
        AND #$03
        ORA a30AE
        ORA #$40
        STA aFF11
        LDA aFF0E
        SEC 
        SBC #$04
        STA aFF0E
        STA aFF0F
        DEC aFF0F
b358F   LDA f3560,X
        BMI b35A8
        LDA a3558,X
        STA a02
        LDA #$00
        STA a04
        STA a36A2
        LDA a355C,X
        STA a03
        JSR s361F
b35A8   DEX 
        BPL b358F
        LDA #$05
        DEC a31CF
        BPL b3569
        INC a31CF
        INC a36A2
        LDX #$03
b35BA   LDA f3560
        BMI b35CC
        LDA a3558,X
        STA a02
        LDA a355C,X
        STA a03
        JSR s361F
b35CC   DEX 
        BPL b35BA
        LDA #$00
        STA a36A2
        JSR s36A5
        LDA #$3F
        STA aFF11
j35DC   LDA #$E0
        STA a2ED6
b35E1   JSR s2F2A
        LDX #$00
b35E6   DEX 
        BNE b35E6
        DEC a2ED6
        LDA a2ED6
        CMP #$80
        BNE b35E1
        LDA aFF11
        SEC 
        SBC #$04
        STA aFF11
        AND #$0F
        CMP #$0F
        BEQ b3605
        JMP j35DC

b3605   LDA #$00
        STA aFF11
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

s361F   LDY #$07
        STX a30AE
        LDA a02
        STA a36A3
        LDA a03
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
        STA a05
        LDA a36A4
        STA a03
        TYA 
        CLC 
        ADC a31CF
        CLC 
        ADC a36A3
        STA a02
        JSR s33D0
        LDY a30F7
        LDA a36A3
        SEC 
        SBC a31CF
        SEC 
        SBC a30F7
        STA a02
        JSR s33D0
        LDA a36A3
        STA a02
        LDA a30F7
        CLC 
        ADC a36A4
        CLC 
        ADC a31CF
        STA a03
        JSR s33D0
        LDA a36A4
        SEC 
        SBC a30F7
        SEC 
        SBC a31CF
        STA a03
        JSR s33D0
        LDY a30F7
        DEY 
        BMI b369E
        CPY #$06
        BNE b362E
        DEC a36A2
        JMP b362E

b369E   LDX a30AE
        RTS 

a36A2   .BYTE $00
a36A3   .BYTE $00
a36A4   .BYTE $00
s36A5   LDX #$03
b36A7   LDA f3560,X
        BMI b36D3
        LDA a3558,X
        STA a02
        LDA #$42
        STA a05
        CPX #$00
        BNE b36BD
        LDA #$75
        STA a05
b36BD   LDA #$E0
        CLC 
        ADC f3560,X
        STA a04
        LDA a355C,X
        STA a03
        STX a30AE
        JSR s33D0
        LDX a30AE
b36D3   DEX 
        BPL b36A7
        RTS 

s36D7   DEC a36DD
        BEQ b36DE
b36DC   RTS 

a36DD   .BYTE $06
b36DE   LDA #$06
        STA a36DD
        LDX #$04
b36E5   LDA f0BC0,X
        CLC 
        ADC #$10
        STA f0BC0,X
        LDA f0BD3,X
        CLC 
        ADC #$10
        STA f0BD3,X
        DEX 
        BPL b36E5
        LDA a234C
        BMI b370E
        INC a0FE1
        LDA a0FE1
        CMP #$68
        BNE b36DC
        LDA #$60
        STA a0FE1
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
s373D   DEC a373B
        BNE b370E
        LDA #$60
        STA a373B
        DEC a373C
        BNE b370E
        LDA #$01
        STA a373C
        LDA a2F81
        EOR #$FF
        AND #$0F
        TAY 
        PHA 
        LDX #$03
b375C   PLA 
        PHA 
        TAY 
        LDA f3560,X
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
        STA a30AE
        TYA 
        EOR a30AE
        TAY 
b377F   TYA 
        AND #$0C
        BEQ b3791
        LDA f372F,X
        AND #$0C
        STA a30AE
        TYA 
        EOR a30AE
        TAY 
b3791   LDA f372F,X
        AND #$F0
        BEQ b37AE
        TYA 
        STA a30AE
        ASL 
        ASL 
        AND #$0C
        STA a30F7
        LDA a30AE
        ROR 
        ROR 
        AND #$03
        ORA a30F7
        TAY 
b37AE   LDA a3558,X
        CLC 
        ADC f370F,Y
        STA f3733,X
        LDA a355C,X
        CLC 
        ADC f371F,Y
        STA f3737,X
b37C2   DEX 
        BPL b375C
        PLA 
        LDA f3733
        CMP a3558
        BNE b37DA
        LDA f3737
        CMP a355C
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
        LDX #$03
b37EE   LDA a3558,X
        STA a02
        LDA a355C,X
        STA a03
        LDA #$01
        STA a36A2
        JSR s3832
        DEX 
        BPL b37EE
j3803   LDA #$00
        STA a36A2
        LDX #$03
b380A   LDA f3733,X
        STA a02
        STA a3558,X
        LDA f3737,X
        STA a03
        STA a355C,X
        LDA f382E,X
        STA a05
        LDA #$E0
        CLC 
        ADC f3560,X
        STA a04
        JSR s3832
        DEX 
        BPL b380A
b382D   RTS 

f382E   .BYTE $75,$42,$42,$42
s3832   LDA a02
        STX a30AE
        BMI b382D
        CMP #$28
        BPL b382D
        LDA a03
        BMI b382D
        CMP #$18
        BPL b382D
        JSR s1373
        AND #$80
        BEQ b386B
        LDA (p06),Y
        AND #$F0
        CMP #$D0
        BNE b385A
        JSR s3ABC
        JMP b386B

b385A   CMP #$E0
        BNE b3866
        LDA (p06),Y
        AND #$0C
        CMP #$0C
        BNE b386B
b3866   LDA #$01
        STA a1F29
b386B   JSR s33E1
        LDX a30AE
        RTS 

f3872   .BYTE $00,$01,$01,$01,$00,$FF,$FF,$FF
f387A   .BYTE $FF,$FF,$00,$01,$01,$01,$00,$FF
f3882   .BYTE $68,$6A,$69,$6B,$68,$6A,$69,$6B
f388A   .BYTE $FF,$FF,$FF,$FF
f388E   .BYTE $FF,$FF,$FF,$FF
f3892   .BYTE $00,$00,$00,$00
a3896   .BYTE $C0
s3897   DEC a3896
        BEQ b389D
        RTS 

b389D   LDX #$03
b389F   LDA f388A,X
        BPL b38B0
        JSR s38B6
j38A7   DEX 
        BPL b389F
        LDA #$20
        STA a3896
b38AF   RTS 

b38B0   JSR s38DF
        JMP j38A7

s38B6   LDA a2F81
        AND #$40
        BNE b38AF
        LDA a3558,X
        STA f388A,X
        LDA a355C,X
        STA f388E,X
        LDA #$20
        STA f3892,X
        LDA #<p03A0
        STA a3986
        LDA #>p03A0
        STA a3987
        LDA f3560,X
        STA f39DA,X
        RTS 

s38DF   LDA f388A,X
        STA a02
        LDA f388E,X
        STA a03
        LDA #$01
        STA a36A2
        JSR s3968
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
        STA a05
        LDA f3882,Y
        STA a04
        LDA f388A,X
        STA a02
        LDA f388E,X
        STA a03
        STX a30AE
        JSR s1373
        LDX a30AE
        AND #$80
        BEQ b3961
        LDA (p06),Y
        JSR s19AC
        BEQ b3960
        BMI b3921
        CLC 
        ADC f39DA,X
        AND #$07
        STA f39DA,X
        JMP j1AE5

b3960   RTS 

b3961   JSR s33E1
        LDX a30AE
b3967   RTS 

s3968   STX a30AE
        JSR s1373
        AND #$80
        BEQ b397F
        LDA (p06),Y
        LDX a30AE
        JSR s19AC
        BEQ b3967
        BMI b3921
        RTS 

b397F   JSR s33D0
        LDX a30AE
b3985   RTS 

a3986   .BYTE $00
a3987   .BYTE $00
s3988   LDA a1F29
        BNE b3985
        LDA a3987
        BNE b399B
        LDA aFF11
        AND #$EF
        STA aFF11
b399A   RTS 

b399B   LDA a3986
        ROL 
        ROL 
        ROL 
        AND #$03
        STA a39D9
        LDA aFF12
        AND #$FC
        ORA a39D9
        STA aFF12
        LDA a3986
        ASL 
        ASL 
        AND #$FC
        STA aFF0E
        LDA aFF11
        ORA #$1F
        STA aFF11
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
s39DE   LDA #$C0
        STA a33CF
        STA a2ED6
        LDA #$3F
        STA aFF11
        LDA #$10
        STA a3987
b39F0   JSR s2F2A
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
        STA aFF11
        CMP #$30
        BNE b39F0
        LDA #$F0
        STA a2ED6
        LDA #$0F
        STA a3987
b3A29   RTS 

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
        LDX #$03
b3A40   LDY f1F97,X
        STA f2C65,Y
        DEX 
        BPL b3A40
        JSR s2F2A
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
        STA aFF11
        RTS 

a3A6F   .BYTE $00
s3A70   LDY a17E2
        LDX #$04
        LDA f15D3,Y
        STA a40
        LDA f15F1,Y
        STA a41
        LDY #$00
b3A81   LDA (p40),Y
        STA f30A4,Y
        STA f34E5,Y
        INY 
        DEX 
        BPL b3A81
        LDX #$00
b3A8F   LDA (p40),Y
        STA a3558,X
        TYA 
        PHA 
        CLC 
        ADC #$04
        TAY 
        LDA (p40),Y
        STA a355C,X
        TYA 
        CLC 
        ADC #$04
        TAY 
        LDA (p40),Y
        STA f372F,X
        TYA 
        CLC 
        ADC #$04
        TAY 
        LDA (p40),Y
        STA f3560,X
        PLA 
        TAY 
        INY 
        INX 
        CPX #$04
        BNE b3A8F
        RTS 

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
        JSR s18E3
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
s3AD9   LDA a3AD8
        BEQ b3AED
        DEC a3AD8
        LDA a2F81
        AND #$08
        BNE b3AD7
        LDA #$00
        STA a3AD8
b3AED   LDA a2F81
        AND #$08
        BNE b3AD7
        LDA #$F0
        STA a3AD8
        INC a17E2
        LDA a17E2
        AND #$0F
        STA a17E2
        LDX a17E2
        LDA f15D3,X
        STA a40
        LDA f15F1,X
        STA a41
        LDY #$04
b3B13   LDA (p40),Y
        STA f0F76,Y
        DEY 
        BPL b3B13
b3B1B   LDA a2F81
        AND #$08
        BEQ b3B1B
        LDA #$0C
        STA a2BF3
        RTS 

a3B28   .BYTE $00
a3B29   .BYTE $00
s3B2A   LDX #$08
b3B2C   LDA f3B4A,X
        CLC 
        ADC a3B28
        STA a3098
        LDA f3B52,X
        CLC 
        ADC a3B29
        STA a3099
        LDA f3B5A,X
        JSR s30AF
        DEX 
        BPL b3B2C
        RTS 

f3B4A   .BYTE $00,$08,$10,$18,$00,$08,$10,$18
f3B52   .BYTE $00,$00,$00,$00,$08,$08,$08,$08
f3B5A   .TEXT "GAMEOVER"
j3B62   LDA #$00
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
        JSR s351B
b3B81   JSR s3B2A
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
        STA aFF11
j3B9E   LDA #$20
        STA a3BDB
b3BA3   JSR s18D7
        STA a2ED6
        JSR s2F2A
        LDX #$10
b3BAE   LDY #$C0
b3BB0   DEY 
        BNE b3BB0
        DEX 
        BNE b3BAE
        DEC a3BDB
        BNE b3BA3
        DEC aFF11
        LDA aFF11
        AND #$0F
        BEQ b3BC8
        JMP j3B9E

b3BC8   LDX #$F8
        TXS 
        LDA #$00
        STA aFF11
        LDA a234B
        BNE b3BD8
        JMP j1010

b3BD8   JMP j234D

a3BDB   .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF
p3C00   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $54,$76,$76,$74,$74,$74,$74,$74
        .BYTE $00,$AA,$AA,$00,$00,$54,$74,$74
        .BYTE $00,$AA,$AA,$00,$00,$15,$7F,$77
        .BYTE $00,$AA,$AA,$00,$00,$05,$47,$47
        .BYTE $00,$AA,$AA,$00,$00,$41,$47,$47
        .BYTE $54,$76,$76,$74,$74,$74,$F4,$74
        .BYTE $00,$AA,$AA,$00,$00,$55,$77,$7D
        .BYTE $00,$AA,$AA,$00,$00,$51,$D1,$51
        .BYTE $00,$AA,$AA,$00,$00,$51,$D1,$D1
        .BYTE $00,$AA,$AA,$00,$00,$50,$D0,$D0
        .BYTE $00,$AA,$AA,$00,$00,$50,$74,$7D
        .BYTE $54,$76,$76,$74,$74,$74,$74,$74
        .BYTE $00,$AA,$AA,$00,$00,$15,$7F,$75
        .BYTE $00,$AA,$AA,$00,$00,$50,$F4,$74
f3C78   .BYTE $FF
f3C79   .BYTE $FF,$FF,$FF,$FC,$FC,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FC,$FC,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$CF,$CF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FC,$FC,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
        .BYTE $00,$00,$7E,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00

        .BYTE $74,$74,$75,$77,$7F,$7D,$74,$50   ;.BYTE $74,$74,$75,$77,$7F,$7D,$74,$50
                                                ; CHARACTER $00
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110101    *** * *
                                                ; 01110111    *** ***
                                                ; 01111111    *******
                                                ; 01111101    ***** *
                                                ; 01110100    *** *  
                                                ; 01010000    * *    

        .BYTE $74,$74,$F4,$D0,$40,$00,$00,$00   ;.BYTE $74,$74,$F4,$D0,$40,$00,$00,$00
                                                ; CHARACTER $01
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 11110100   **** *  
                                                ; 11010000   ** *    
                                                ; 01000000    *      
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $77,$77,$77,$77,$77,$77,$7F,$15   ;.BYTE $77,$77,$77,$77,$77,$77,$7F,$15
                                                ; CHARACTER $02
                                                ; 01110111    *** ***
                                                ; 01110111    *** ***
                                                ; 01110111    *** ***
                                                ; 01110111    *** ***
                                                ; 01110111    *** ***
                                                ; 01110111    *** ***
                                                ; 01111111    *******
                                                ; 00010101      * * *

        .BYTE $47,$47,$47,$47,$47,$47,$47,$05   ;.BYTE $47,$47,$47,$47,$47,$47,$47,$05
                                                ; CHARACTER $03
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 00000101        * *

        .BYTE $47,$47,$47,$47,$47,$47,$47,$41   ;.BYTE $47,$47,$47,$47,$47,$47,$47,$41
                                                ; CHARACTER $04
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000111    *   ***
                                                ; 01000001    *     *

        .BYTE $74,$74,$74,$74,$74,$74,$F4,$54   ;.BYTE $74,$74,$74,$74,$74,$74,$F4,$54
                                                ; CHARACTER $05
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 11110100   **** *  
                                                ; 01010100    * * *  

        .BYTE $74,$74,$74,$74,$74,$74,$74,$54   ;.BYTE $74,$74,$74,$74,$74,$74,$74,$54
                                                ; CHARACTER $06
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01010100    * * *  

        .BYTE $01,$01,$01,$01,$01,$01,$01,$00   ;.BYTE $01,$01,$01,$01,$01,$01,$01,$00
                                                ; CHARACTER $07
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000001          *
                                                ; 00000000           

        .BYTE $D1,$D1,$D1,$D1,$D1,$D5,$FF,$55   ;.BYTE $D1,$D1,$D1,$D1,$D1,$D5,$FF,$55
                                                ; CHARACTER $08
                                                ; 11010001   ** *   *
                                                ; 11010001   ** *   *
                                                ; 11010001   ** *   *
                                                ; 11010001   ** *   *
                                                ; 11010001   ** *   *
                                                ; 11010101   ** * * *
                                                ; 11111111   ********
                                                ; 01010101    * * * *

        .BYTE $D0,$D0,$D0,$D0,$D0,$D0,$D0,$40   ;.BYTE $D0,$D0,$D0,$D0,$D0,$D0,$D0,$40
                                                ; CHARACTER $09
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 11010000   ** *    
                                                ; 01000000    *      

        .BYTE $7F,$77,$75,$74,$74,$74,$74,$54   ;.BYTE $7F,$77,$75,$74,$74,$74,$74,$54
                                                ; CHARACTER $0a
                                                ; 01111111    *******
                                                ; 01110111    *** ***
                                                ; 01110101    *** * *
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01010100    * * *  

        .BYTE $74,$F4,$F4,$74,$74,$74,$74,$54   ;.BYTE $74,$F4,$F4,$74,$74,$74,$74,$54
                                                ; CHARACTER $0b
                                                ; 01110100    *** *  
                                                ; 11110100   **** *  
                                                ; 11110100   **** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01010100    * * *  

        .BYTE $75,$7F,$75,$74,$74,$75,$7F,$15   ;.BYTE $75,$7F,$75,$74,$74,$75,$7F,$15
                                                ; CHARACTER $0c
                                                ; 01110101    *** * *
                                                ; 01111111    *******
                                                ; 01110101    *** * *
                                                ; 01110100    *** *  
                                                ; 01110100    *** *  
                                                ; 01110101    *** * *
                                                ; 01111111    *******
                                                ; 00010101      * * *

        .BYTE $74,$F4,$50,$00,$00,$54,$F4,$54   ;.BYTE $74,$F4,$50,$00,$00,$54,$F4,$54
                                                ; CHARACTER $0d
                                                ; 01110100    *** *  
                                                ; 11110100   **** *  
                                                ; 01010000    * *    
                                                ; 00000000           
                                                ; 00000000           
                                                ; 01010100    * * *  
                                                ; 11110100   **** *  
                                                ; 01010100    * * *  

        .BYTE $42,$99,$7E,$5A,$7E,$3C,$24,$18   ;.BYTE $42,$99,$7E,$5A,$7E,$3C,$24,$18
                                                ; CHARACTER $0e
                                                ; 01000010    *    * 
                                                ; 10011001   *  **  *
                                                ; 01111110    ****** 
                                                ; 01011010    * ** * 
                                                ; 01111110    ****** 
                                                ; 00111100     ****  
                                                ; 00100100     *  *  
                                                ; 00011000      **   

        .BYTE $7C,$06,$CE,$DE,$F6,$E6,$7C,$00   ;.BYTE $7C,$06,$CE,$DE,$F6,$E6,$7C,$00
                                                ; CHARACTER $0f
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11001110   **  *** 
                                                ; 11011110   ** **** 
                                                ; 11110110   **** ** 
                                                ; 11100110   ***  ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $38,$18,$18,$18,$18,$18,$3C,$00   ;.BYTE $38,$18,$18,$18,$18,$18,$3C,$00
                                                ; CHARACTER $10
                                                ; 00111000     ***   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00111100     ****  
                                                ; 00000000           

        .BYTE $FC,$06,$06,$FC,$C0,$C6,$FE,$00   ;.BYTE $FC,$06,$06,$FC,$C0,$C6,$FE,$00
                                                ; CHARACTER $11
                                                ; 11111100   ******  
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 11111100   ******  
                                                ; 11000000   **      
                                                ; 11000110   **   ** 
                                                ; 11111110   ******* 
                                                ; 00000000           

        .BYTE $FC,$06,$06,$3C,$06,$C6,$FC,$00   ;.BYTE $FC,$06,$06,$3C,$06,$C6,$FC,$00
                                                ; CHARACTER $12
                                                ; 11111100   ******  
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00111100     ****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 00000000           

        .BYTE $C0,$00,$D8,$FE,$18,$18,$18,$00   ;.BYTE $C0,$00,$D8,$FE,$18,$18,$18,$00
                                                ; CHARACTER $13
                                                ; 11000000   **      
                                                ; 00000000           
                                                ; 11011000   ** **   
                                                ; 11111110   ******* 
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00000000           

        .BYTE $FE,$06,$C0,$FC,$06,$C6,$FC,$00   ;.BYTE $FE,$06,$C0,$FC,$06,$C6,$FC,$00
                                                ; CHARACTER $14
                                                ; 11111110   ******* 
                                                ; 00000110        ** 
                                                ; 11000000   **      
                                                ; 11111100   ******  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 00000000           

        .BYTE $7E,$06,$C0,$FC,$C6,$C6,$7C,$00   ;.BYTE $7E,$06,$C0,$FC,$C6,$C6,$7C,$00
                                                ; CHARACTER $15
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000000   **      
                                                ; 11111100   ******  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $FE,$06,$06,$06,$06,$06,$06,$06   ;.BYTE $FE,$06,$06,$06,$06,$06,$06,$06
                                                ; CHARACTER $16
                                                ; 11111110   ******* 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 

        .BYTE $7C,$06,$C6,$7C,$C6,$C6,$7C,$00   ;.BYTE $7C,$06,$C6,$7C,$C6,$C6,$7C,$00
                                                ; CHARACTER $17
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $7C,$06,$C6,$7E,$06,$C6,$FC,$00   ;.BYTE $7C,$06,$C6,$7E,$06,$C6,$FC,$00
                                                ; CHARACTER $18
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 00000000           

        .BYTE $00,$00,$18,$00,$00,$18,$00,$00   ;.BYTE $00,$00,$18,$00,$00,$18,$00,$00
                                                ; CHARACTER $19
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $18,$18,$18,$18,$00,$18,$18,$00   ;.BYTE $18,$18,$18,$18,$00,$18,$18,$00
                                                ; CHARACTER $1a
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00000000           

        .BYTE $0E,$18,$30,$60,$30,$18,$0E,$00   ;.BYTE $0E,$18,$30,$60,$30,$18,$0E,$00
                                                ; CHARACTER $1b
                                                ; 00001110       *** 
                                                ; 00011000      **   
                                                ; 00110000     **    
                                                ; 01100000    **     
                                                ; 00110000     **    
                                                ; 00011000      **   
                                                ; 00001110       *** 
                                                ; 00000000           

        .BYTE $00,$00,$7E,$00,$7E,$00,$00,$00   ;.BYTE $00,$00,$7E,$00,$7E,$00,$00,$00
                                                ; CHARACTER $1c
                                                ; 00000000           
                                                ; 00000000           
                                                ; 01111110    ****** 
                                                ; 00000000           
                                                ; 01111110    ****** 
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $70,$18,$0C,$06,$0C,$18,$70,$00   ;.BYTE $70,$18,$0C,$06,$0C,$18,$70,$00
                                                ; CHARACTER $1d
                                                ; 01110000    ***    
                                                ; 00011000      **   
                                                ; 00001100       **  
                                                ; 00000110        ** 
                                                ; 00001100       **  
                                                ; 00011000      **   
                                                ; 01110000    ***    
                                                ; 00000000           

        .BYTE $3C,$66,$06,$0C,$18,$00,$18,$00   ;.BYTE $3C,$66,$06,$0C,$18,$00,$18,$00
                                                ; CHARACTER $1e
                                                ; 00111100     ****  
                                                ; 01100110    **  ** 
                                                ; 00000110        ** 
                                                ; 00001100       **  
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00000000           

        .BYTE $00,$00,$00,$00,$00,$00,$00,$00   ;.BYTE $00,$00,$00,$00,$00,$00,$00,$00
                                                ; CHARACTER $1f
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $F0,$18,$CC,$FE,$C6,$C6,$C6,$C0   ;.BYTE $F0,$18,$CC,$FE,$C6,$C6,$C6,$C0
                                                ; CHARACTER $20
                                                ; 11110000   ****    
                                                ; 00011000      **   
                                                ; 11001100   **  **  
                                                ; 11111110   ******* 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000000   **      

        .BYTE $F8,$0C,$C6,$FC,$C6,$CC,$F8,$00   ;.BYTE $F8,$0C,$C6,$FC,$C6,$CC,$F8,$00
                                                ; CHARACTER $21
                                                ; 11111000   *****   
                                                ; 00001100       **  
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 11000110   **   ** 
                                                ; 11001100   **  **  
                                                ; 11111000   *****   
                                                ; 00000000           

        .BYTE $3C,$0C,$C0,$C0,$C0,$6C,$3C,$00   ;.BYTE $3C,$0C,$C0,$C0,$C0,$6C,$3C,$00
                                                ; CHARACTER $22
                                                ; 00111100     ****  
                                                ; 00001100       **  
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 01101100    ** **  
                                                ; 00111100     ****  
                                                ; 00000000           

        .BYTE $E0,$30,$D8,$CC,$C6,$C6,$FE,$00   ;.BYTE $E0,$30,$D8,$CC,$C6,$C6,$FE,$00
                                                ; CHARACTER $23
                                                ; 11100000   ***     
                                                ; 00110000     **    
                                                ; 11011000   ** **   
                                                ; 11001100   **  **  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11111110   ******* 
                                                ; 00000000           

        .BYTE $FE,$00,$C0,$F0,$C0,$C0,$FE,$00   ;.BYTE $FE,$00,$C0,$F0,$C0,$C0,$FE,$00
                                                ; CHARACTER $24
                                                ; 11111110   ******* 
                                                ; 00000000           
                                                ; 11000000   **      
                                                ; 11110000   ****    
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11111110   ******* 
                                                ; 00000000           

        .BYTE $FE,$00,$C0,$F0,$C0,$C0,$C0,$C0   ;.BYTE $FE,$00,$C0,$F0,$C0,$C0,$C0,$C0
                                                ; CHARACTER $25
                                                ; 11111110   ******* 
                                                ; 00000000           
                                                ; 11000000   **      
                                                ; 11110000   ****    
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      

        .BYTE $7E,$06,$C0,$CE,$C6,$C6,$7E,$00   ;.BYTE $7E,$06,$C0,$CE,$C6,$C6,$7E,$00
                                                ; CHARACTER $26
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000000   **      
                                                ; 11001110   **  *** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111110    ****** 
                                                ; 00000000           

        .BYTE $C6,$06,$C6,$FE,$C6,$C6,$C6,$C0   ;.BYTE $C6,$06,$C6,$FE,$C6,$C6,$C6,$C0
                                                ; CHARACTER $27
                                                ; 11000110   **   ** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111110   ******* 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000000   **      

        .BYTE $18,$00,$18,$18,$18,$18,$18,$00   ;.BYTE $18,$00,$18,$18,$18,$18,$18,$00
                                                ; CHARACTER $28
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00000000           

        .BYTE $18,$00,$18,$18,$18,$18,$18,$70   ;.BYTE $18,$00,$18,$18,$18,$18,$18,$70
                                                ; CHARACTER $29
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 01110000    ***    

        .BYTE $C6,$06,$CC,$F8,$CC,$C6,$C6,$C0   ;.BYTE $C6,$06,$CC,$F8,$CC,$C6,$C6,$C0
                                                ; CHARACTER $2a
                                                ; 11000110   **   ** 
                                                ; 00000110        ** 
                                                ; 11001100   **  **  
                                                ; 11111000   *****   
                                                ; 11001100   **  **  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000000   **      

        .BYTE $C0,$00,$C0,$C0,$C0,$C6,$FE,$00   ;.BYTE $C0,$00,$C0,$C0,$C0,$C6,$FE,$00
                                                ; CHARACTER $2b
                                                ; 11000000   **      
                                                ; 00000000           
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000110   **   ** 
                                                ; 11111110   ******* 
                                                ; 00000000           

        .BYTE $C6,$2E,$FE,$FE,$D6,$C6,$C6,$C0   ;.BYTE $C6,$2E,$FE,$FE,$D6,$C6,$C6,$C0
                                                ; CHARACTER $2c
                                                ; 11000110   **   ** 
                                                ; 00101110     * *** 
                                                ; 11111110   ******* 
                                                ; 11111110   ******* 
                                                ; 11010110   ** * ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000000   **      

        .BYTE $C2,$06,$CE,$DE,$FE,$F6,$E6,$C0   ;.BYTE $C2,$06,$CE,$DE,$FE,$F6,$E6,$C0
                                                ; CHARACTER $2d
                                                ; 11000010   **    * 
                                                ; 00000110        ** 
                                                ; 11001110   **  *** 
                                                ; 11011110   ** **** 
                                                ; 11111110   ******* 
                                                ; 11110110   **** ** 
                                                ; 11100110   ***  ** 
                                                ; 11000000   **      

        .BYTE $7C,$06,$C6,$C6,$C6,$C6,$7C,$00   ;.BYTE $7C,$06,$C6,$C6,$C6,$C6,$7C,$00
                                                ; CHARACTER $2e
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $FC,$06,$C6,$FC,$C0,$C0,$C0,$C0   ;.BYTE $FC,$06,$C6,$FC,$C0,$C0,$C0,$C0
                                                ; CHARACTER $2f
                                                ; 11111100   ******  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      

        .BYTE $7C,$06,$C6,$C6,$CE,$CE,$7E,$03   ;.BYTE $7C,$06,$C6,$C6,$CE,$CE,$7E,$03
                                                ; CHARACTER $30
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11001110   **  *** 
                                                ; 11001110   **  *** 
                                                ; 01111110    ****** 
                                                ; 00000011         **

        .BYTE $FC,$06,$C6,$FC,$CC,$C6,$C6,$C0   ;.BYTE $FC,$06,$C6,$FC,$CC,$C6,$C6,$C0
                                                ; CHARACTER $31
                                                ; 11111100   ******  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 11001100   **  **  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000000   **      

        .BYTE $7E,$06,$C0,$7C,$06,$C6,$FC,$00   ;.BYTE $7E,$06,$C0,$7C,$06,$C6,$FC,$00
                                                ; CHARACTER $32
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000000   **      
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 00000000           

        .BYTE $FE,$00,$C0,$C0,$C0,$C0,$7E,$00   ;.BYTE $FE,$00,$C0,$C0,$C0,$C0,$7E,$00
                                                ; CHARACTER $33
                                                ; 11111110   ******* 
                                                ; 00000000           
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 11000000   **      
                                                ; 01111110    ****** 
                                                ; 00000000           

        .BYTE $CE,$06,$C6,$C6,$C6,$E6,$7C,$00   ;.BYTE $CE,$06,$C6,$C6,$C6,$E6,$7C,$00
                                                ; CHARACTER $34
                                                ; 11001110   **  *** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11100110   ***  ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $CE,$06,$C6,$C6,$CC,$D8,$F0,$C0   ;.BYTE $CE,$06,$C6,$C6,$CC,$D8,$F0,$C0
                                                ; CHARACTER $35
                                                ; 11001110   **  *** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 11001100   **  **  
                                                ; 11011000   ** **   
                                                ; 11110000   ****    
                                                ; 11000000   **      

        .BYTE $C6,$06,$C6,$D6,$FE,$FE,$EE,$C6   ;.BYTE $C6,$06,$C6,$D6,$FE,$FE,$EE,$C6
                                                ; CHARACTER $36
                                                ; 11000110   **   ** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11010110   ** * ** 
                                                ; 11111110   ******* 
                                                ; 11111110   ******* 
                                                ; 11101110   *** *** 
                                                ; 11000110   **   ** 

        .BYTE $C6,$44,$10,$38,$10,$44,$C6,$00   ;.BYTE $C6,$44,$10,$38,$10,$44,$C6,$00
                                                ; CHARACTER $37
                                                ; 11000110   **   ** 
                                                ; 01000100    *   *  
                                                ; 00010000      *    
                                                ; 00111000     ***   
                                                ; 00010000      *    
                                                ; 01000100    *   *  
                                                ; 11000110   **   ** 
                                                ; 00000000           

        .BYTE $C6,$06,$C6,$7E,$06,$06,$06,$06   ;.BYTE $C6,$06,$C6,$7E,$06,$06,$06,$06
                                                ; CHARACTER $38
                                                ; 11000110   **   ** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 

        .BYTE $FE,$06,$CC,$18,$36,$66,$FE,$00   ;.BYTE $FE,$06,$CC,$18,$36,$66,$FE,$00
                                                ; CHARACTER $39
                                                ; 11111110   ******* 
                                                ; 00000110        ** 
                                                ; 11001100   **  **  
                                                ; 00011000      **   
                                                ; 00110110     ** ** 
                                                ; 01100110    **  ** 
                                                ; 11111110   ******* 
                                                ; 00000000           

        .BYTE $22,$73,$72,$FA,$FC,$C8,$88,$CC   ;.BYTE $22,$73,$72,$FA,$FC,$C8,$88,$CC
                                                ; CHARACTER $3a
                                                ; 00100010     *   * 
                                                ; 01110011    ***  **
                                                ; 01110010    ***  * 
                                                ; 11111010   ***** * 
                                                ; 11111100   ******  
                                                ; 11001000   **  *   
                                                ; 10001000   *   *   
                                                ; 11001100   **  **  

        .BYTE $44,$CE,$4E,$5F,$3F,$13,$11,$33   ;.BYTE $44,$CE,$4E,$5F,$3F,$13,$11,$33
                                                ; CHARACTER $3b
                                                ; 01000100    *   *  
                                                ; 11001110   **  *** 
                                                ; 01001110    *  *** 
                                                ; 01011111    * *****
                                                ; 00111111     ******
                                                ; 00010011      *  **
                                                ; 00010001      *   *
                                                ; 00110011     **  **

        .BYTE $38,$44,$07,$FE,$7C,$44,$C4,$84   ;.BYTE $38,$44,$07,$FE,$7C,$44,$C4,$84
                                                ; CHARACTER $3c
                                                ; 00111000     ***   
                                                ; 01000100    *   *  
                                                ; 00000111        ***
                                                ; 11111110   ******* 
                                                ; 01111100    *****  
                                                ; 01000100    *   *  
                                                ; 11000100   **   *  
                                                ; 10000100   *    *  

        .BYTE $1C,$22,$E0,$7F,$3E,$22,$23,$21   ;.BYTE $1C,$22,$E0,$7F,$3E,$22,$23,$21
                                                ; CHARACTER $3d
                                                ; 00011100      ***  
                                                ; 00100010     *   * 
                                                ; 11100000   ***     
                                                ; 01111111    *******
                                                ; 00111110     ***** 
                                                ; 00100010     *   * 
                                                ; 00100011     *   **
                                                ; 00100001     *    *

        .BYTE $5A,$DB,$18,$E7,$E7,$18,$DB,$5A   ;.BYTE $5A,$DB,$18,$E7,$E7,$18,$DB,$5A
                                                ; CHARACTER $3e
                                                ; 01011010    * ** * 
                                                ; 11011011   ** ** **
                                                ; 00011000      **   
                                                ; 11100111   ***  ***
                                                ; 11100111   ***  ***
                                                ; 00011000      **   
                                                ; 11011011   ** ** **
                                                ; 01011010    * ** * 

        .BYTE $18,$18,$3C,$3C,$7E,$7E,$E7,$C3   ;.BYTE $18,$18,$3C,$3C,$7E,$7E,$E7,$C3
                                                ; CHARACTER $3f
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 01111110    ****** 
                                                ; 01111110    ****** 
                                                ; 11100111   ***  ***
                                                ; 11000011   **    **

        .BYTE $03,$0F,$3E,$FE,$0E,$06,$04,$04   ;.BYTE $03,$0F,$3E,$FE,$0E,$06,$04,$04
                                                ; CHARACTER $40
                                                ; 00000011         **
                                                ; 00001111       ****
                                                ; 00111110     ***** 
                                                ; 11111110   ******* 
                                                ; 00001110       *** 
                                                ; 00000110        ** 
                                                ; 00000100        *  
                                                ; 00000100        *  

        .BYTE $C0,$F0,$7C,$3F,$3F,$7C,$F0,$C0   ;.BYTE $C0,$F0,$7C,$3F,$3F,$7C,$F0,$C0
                                                ; CHARACTER $41
                                                ; 11000000   **      
                                                ; 11110000   ****    
                                                ; 01111100    *****  
                                                ; 00111111     ******
                                                ; 00111111     ******
                                                ; 01111100    *****  
                                                ; 11110000   ****    
                                                ; 11000000   **      

        .BYTE $08,$08,$0C,$0C,$1E,$FE,$3F,$03   ;.BYTE $08,$08,$0C,$0C,$1E,$FE,$3F,$03
                                                ; CHARACTER $42
                                                ; 00001000       *   
                                                ; 00001000       *   
                                                ; 00001100       **  
                                                ; 00001100       **  
                                                ; 00011110      **** 
                                                ; 11111110   ******* 
                                                ; 00111111     ******
                                                ; 00000011         **

        .BYTE $C3,$E7,$7E,$7E,$3C,$3C,$18,$18   ;.BYTE $C3,$E7,$7E,$7E,$3C,$3C,$18,$18
                                                ; CHARACTER $43
                                                ; 11000011   **    **
                                                ; 11100111   ***  ***
                                                ; 01111110    ****** 
                                                ; 01111110    ****** 
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00011000      **   
                                                ; 00011000      **   

        .BYTE $20,$20,$60,$70,$7F,$7C,$F0,$C0   ;.BYTE $20,$20,$60,$70,$7F,$7C,$F0,$C0
                                                ; CHARACTER $44
                                                ; 00100000     *     
                                                ; 00100000     *     
                                                ; 01100000    **     
                                                ; 01110000    ***    
                                                ; 01111111    *******
                                                ; 01111100    *****  
                                                ; 11110000   ****    
                                                ; 11000000   **      

        .BYTE $03,$0F,$3E,$FC,$FC,$3E,$0F,$03   ;.BYTE $03,$0F,$3E,$FC,$FC,$3E,$0F,$03
                                                ; CHARACTER $45
                                                ; 00000011         **
                                                ; 00001111       ****
                                                ; 00111110     ***** 
                                                ; 11111100   ******  
                                                ; 11111100   ******  
                                                ; 00111110     ***** 
                                                ; 00001111       ****
                                                ; 00000011         **

        .BYTE $C0,$FC,$7F,$78,$30,$30,$10,$10   ;.BYTE $C0,$FC,$7F,$78,$30,$30,$10,$10
                                                ; CHARACTER $46
                                                ; 11000000   **      
                                                ; 11111100   ******  
                                                ; 01111111    *******
                                                ; 01111000    ****   
                                                ; 00110000     **    
                                                ; 00110000     **    
                                                ; 00010000      *    
                                                ; 00010000      *    

        .BYTE $18,$18,$18,$3C,$3C,$18,$18,$18   ;.BYTE $18,$18,$18,$3C,$3C,$18,$18,$18
                                                ; CHARACTER $47
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   

        .BYTE $00,$00,$18,$FF,$FF,$18,$00,$00   ;.BYTE $00,$00,$18,$FF,$FF,$18,$00,$00
                                                ; CHARACTER $48
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00011000      **   
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 00011000      **   
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $03,$06,$0C,$3C,$3C,$30,$60,$C0   ;.BYTE $03,$06,$0C,$3C,$3C,$30,$60,$C0
                                                ; CHARACTER $49
                                                ; 00000011         **
                                                ; 00000110        ** 
                                                ; 00001100       **  
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00110000     **    
                                                ; 01100000    **     
                                                ; 11000000   **      

        .BYTE $80,$C0,$78,$38,$1C,$1E,$03,$01   ;.BYTE $80,$C0,$78,$38,$1C,$1E,$03,$01
                                                ; CHARACTER $4a
                                                ; 10000000   *       
                                                ; 11000000   **      
                                                ; 01111000    ****   
                                                ; 00111000     ***   
                                                ; 00011100      ***  
                                                ; 00011110      **** 
                                                ; 00000011         **
                                                ; 00000001          *

        .BYTE $00,$28,$BC,$FF,$FF,$3C,$00,$00   ;.BYTE $00,$28,$BC,$FF,$FF,$3C,$00,$00
                                                ; CHARACTER $4b
                                                ; 00000000           
                                                ; 00101000     * *   
                                                ; 10111100   * ****  
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 00111100     ****  
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $55,$24,$BC,$FF,$FF,$3C,$14,$55   ;.BYTE $55,$24,$BC,$FF,$FF,$3C,$14,$55
                                                ; CHARACTER $4c
                                                ; 01010101    * * * *
                                                ; 00100100     *  *  
                                                ; 10111100   * ****  
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 00111100     ****  
                                                ; 00010100      * *  
                                                ; 01010101    * * * *

        .BYTE $10,$20,$44,$88,$11,$22,$04,$08   ;.BYTE $10,$20,$44,$88,$11,$22,$04,$08
                                                ; CHARACTER $4d
                                                ; 00010000      *    
                                                ; 00100000     *     
                                                ; 01000100    *   *  
                                                ; 10001000   *   *   
                                                ; 00010001      *   *
                                                ; 00100010     *   * 
                                                ; 00000100        *  
                                                ; 00001000       *   

        .BYTE $08,$04,$22,$11,$88,$44,$20,$10   ;.BYTE $08,$04,$22,$11,$88,$44,$20,$10
                                                ; CHARACTER $4e
                                                ; 00001000       *   
                                                ; 00000100        *  
                                                ; 00100010     *   * 
                                                ; 00010001      *   *
                                                ; 10001000   *   *   
                                                ; 01000100    *   *  
                                                ; 00100000     *     
                                                ; 00010000      *    

        .BYTE $1C,$3C,$3C,$3C,$7F,$FF,$FF,$C3   ;.BYTE $1C,$3C,$3C,$3C,$7F,$FF,$FF,$C3
                                                ; CHARACTER $4f
                                                ; 00011100      ***  
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 01111111    *******
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 11000011   **    **

        .BYTE $C3,$FF,$FF,$7F,$3C,$3C,$3C,$1C   ;.BYTE $C3,$FF,$FF,$7F,$3C,$3C,$3C,$1C
                                                ; CHARACTER $50
                                                ; 11000011   **    **
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 01111111    *******
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00111100     ****  
                                                ; 00011100      ***  

        .BYTE $00,$40,$D0,$3D,$3F,$F0,$C0,$00   ;.BYTE $00,$40,$D0,$3D,$3F,$F0,$C0,$00
                                                ; CHARACTER $51
                                                ; 00000000           
                                                ; 01000000    *      
                                                ; 11010000   ** *    
                                                ; 00111101     **** *
                                                ; 00111111     ******
                                                ; 11110000   ****    
                                                ; 11000000   **      
                                                ; 00000000           

        .BYTE $00,$01,$07,$7C,$FC,$0F,$03,$00   ;.BYTE $00,$01,$07,$7C,$FC,$0F,$03,$00
                                                ; CHARACTER $52
                                                ; 00000000           
                                                ; 00000001          *
                                                ; 00000111        ***
                                                ; 01111100    *****  
                                                ; 11111100   ******  
                                                ; 00001111       ****
                                                ; 00000011         **
                                                ; 00000000           

        .BYTE $3C,$0C,$30,$3C,$0C,$30,$3C,$0C   ;.BYTE $3C,$0C,$30,$3C,$0C,$30,$3C,$0C
                                                ; CHARACTER $53
                                                ; 00111100     ****  
                                                ; 00001100       **  
                                                ; 00110000     **    
                                                ; 00111100     ****  
                                                ; 00001100       **  
                                                ; 00110000     **    
                                                ; 00111100     ****  
                                                ; 00001100       **  

        .BYTE $00,$00,$CF,$FC,$00,$00,$00,$00   ;.BYTE $00,$00,$CF,$FC,$00,$00,$00,$00
                                                ; CHARACTER $54
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11001111   **  ****
                                                ; 11111100   ******  
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $7E,$06,$C0,$FC,$C6,$C6,$7C,$00   ;.BYTE $7E,$06,$C0,$FC,$C6,$C6,$7C,$00
                                                ; CHARACTER $55
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000000   **      
                                                ; 11111100   ******  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $FE,$06,$06,$06,$06,$06,$06,$06   ;.BYTE $FE,$06,$06,$06,$06,$06,$06,$06
                                                ; CHARACTER $56
                                                ; 11111110   ******* 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 
                                                ; 00000110        ** 

        .BYTE $7C,$06,$C6,$7C,$C6,$C6,$7C,$00   ;.BYTE $7C,$06,$C6,$7C,$C6,$C6,$7C,$00
                                                ; CHARACTER $57
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 11000110   **   ** 
                                                ; 11000110   **   ** 
                                                ; 01111100    *****  
                                                ; 00000000           

        .BYTE $7C,$06,$C6,$7E,$06,$C6,$FC,$00   ;.BYTE $7C,$06,$C6,$7E,$06,$C6,$FC,$00
                                                ; CHARACTER $58
                                                ; 01111100    *****  
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 01111110    ****** 
                                                ; 00000110        ** 
                                                ; 11000110   **   ** 
                                                ; 11111100   ******  
                                                ; 00000000           

        .BYTE $03,$03,$03,$03,$03,$03,$FF,$FF   ;.BYTE $03,$03,$03,$03,$03,$03,$FF,$FF
                                                ; CHARACTER $59
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 11111111   ********
                                                ; 11111111   ********

        .BYTE $00,$00,$00,$00,$F0,$F0,$F0,$F0   ;.BYTE $00,$00,$00,$00,$F0,$F0,$F0,$F0
                                                ; CHARACTER $5a
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    

        .BYTE $0F,$0F,$0F,$0F,$00,$00,$00,$00   ;.BYTE $0F,$0F,$0F,$0F,$00,$00,$00,$00
                                                ; CHARACTER $5b
                                                ; 00001111       ****
                                                ; 00001111       ****
                                                ; 00001111       ****
                                                ; 00001111       ****
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $18,$18,$18,$F8,$F8,$00,$00,$00   ;.BYTE $18,$18,$18,$F8,$F8,$00,$00,$00
                                                ; CHARACTER $5c
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 00011000      **   
                                                ; 11111000   *****   
                                                ; 11111000   *****   
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           

        .BYTE $F0,$F0,$F0,$F0,$00,$00,$00,$00   ;.BYTE $F0,$F0,$F0,$F0,$00,$00,$00,$00
                                                ; CHARACTER $5d
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           


        .BYTE $F0,$F0,$F0,$F0,$0F,$0F,$0F
