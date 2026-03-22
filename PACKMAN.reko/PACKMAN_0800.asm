;;; Segment 0800 (0800:0000)
0800:0000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...

;; fn0800_0100: 0800:0100
fn0800_0100 proc
	mov	dx,cs
	mov	cs:[019Dh],dx
	mov	bp,[0002h]
	mov	bx,[002Ch]
	mov	ds,dx
	mov	[6FF2h],es
	mov	[6FF4h],bx
	mov	[6FF0h],bp
	mov	dx,ds
	sub	bp,dx
	mov	di,[0A0BEh]
	cmp	di,100h
	jnc	0132h

l0800_012B:
	mov	di,100h
	mov	[0A0BEh],di

l0800_0132:
	add	di,0A3C8h
	add	di,[0A0BCh]
	mov	cl,4h
	shr	di,cl
	inc	di
	cmp	bp,di
	cmp	word ptr [0A0BEh],0h
	jz	014Fh

l0800_0148:
	cmp	word ptr [0A0BCh],0h
	jnz	015Ah

l0800_014F:
	mov	di,1000h
	cmp	bp,di
	ja	015Ah

l0800_0156:
	mov	di,bp
	jmp	015Ah

l0800_015A:
	mov	bx,di
	add	bx,dx
	mov	[6FE8h],bx
	mov	[6FECh],bx
	mov	ax,[6FF2h]
	sub	bx,ax
	mov	es,ax
	shl	di,cl
	cli
	mov	ss,dx
	mov	sp,di
	sti
	xor	ax,ax
	mov	es,cs:[019Dh]
	mov	di,0A0C6h
	mov	cx,0A3C8h
	sub	cx,di

l0800_0184:
	rep stosb

l0800_0186:
	call	01CEh
	push	ax
	call	68BCh

;; fn0800_018D: 0800:018D
;;   Called from:
;;     0800:018A (in fn0800_0100)
;;     0800:68E5 (in fn0800_68BC)
fn0800_018D proc
	mov	ds,cs:[019Dh]
	mov	bp,sp
	jmp	far 0F000h:0E05Bh
0800:0199                            CD 21 EB F0 00 00             .!....

;; fn0800_019F: 0800:019F
;;   Called from:
;;     0800:01D6 (in fn0800_01CE)
fn0800_019F proc
	mov	word ptr [0A104h],1h
	mov	word ptr [0A102h],0h
	push	ds
	mov	ax,6FF8h
	push	ax
	push	ds
	mov	ax,0A102h
	push	ax
	push	ds
	mov	ax,0A104h
	push	ax
	push	cs
	call	3632h
	add	sp,0Ch
	mov	word ptr [0A0C6h],0Fh
	mov	word ptr [0A0C8h],0Dh
	ret

;; fn0800_01CE: 0800:01CE
;;   Called from:
;;     0800:0186 (in fn0800_0100)
fn0800_01CE proc
	mov	ax,1460h
	push	ax
	call	6DBCh
	pop	cx
	call	019Fh
	call	0BDCh
	push	cs
	call	3B02h
	xor	ax,ax
	ret
0800:01E3          55 8B EC B8 38 00 50 B8 CA A0 50 8B 46    U...8.P...P.F
0800:01F0 04 BA 38 00 F7 E2 05 1E 8C 50 E8 FA 69 8B E5 FF ..8......P..i...
0800:0200 76 0A 1E B8 C6 A0 50 FF 76 08 FF 76 06 0E E8 B4 v.....P.v..v....
0800:0210 3F 8B E5 5D C3                                  ?..].          

;; fn0800_0215: 0800:0215
;;   Called from:
;;     0800:062C (in fn0800_05E9)
;;     0800:0785 (in fn0800_06F3)
;;     0800:0798 (in fn0800_06F3)
;;     0800:07AA (in fn0800_06F3)
;;     0800:07EE (in fn0800_06F3)
;;     0800:0C9C (in fn0800_0BDC)
;;     0800:0CAE (in fn0800_0BDC)
;;     0800:0CC0 (in fn0800_0BDC)
fn0800_0215 proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+6h]
	push	cs
	call	4A0Bh
	pop	cx
	mov	ax,1h
	push	ax
	mov	ax,0C8h
	push	ax
	mov	ax,140h
	push	ax
	mov	ax,0BCh
	push	ax
	xor	ax,ax
	push	ax
	push	cs
	call	3BBEh
	mov	sp,bp
	mov	ax,1h
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	push	cs
	call	42F6h
	mov	sp,bp
	mov	ax,2h
	push	ax
	xor	ax,ax
	push	ax
	push	cs
	call	42B5h
	mov	sp,bp
	push	ds
	push	word ptr [bp+8h]
	mov	ax,0BCh
	push	ax
	push	word ptr [bp+4h]
	push	cs
	call	4BD9h
	mov	sp,bp
	pop	bp
	ret

;; fn0800_0267: 0800:0267
;;   Called from:
;;     0800:112A (in fn0800_111E)
fn0800_0267 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	xor	di,di
	jmp	02CDh

l0800_0270:
	xor	si,si
	jmp	02C7h

l0800_0274:
	mov	ax,38h
	push	ax
	mov	ax,0A0CAh
	push	ax
	mov	ax,[bp+4h]
	mov	dx,1E0h
	mul	dx
	mov	bx,ax
	mov	ax,di
	mov	dx,28h
	mul	dx
	add	bx,ax
	mov	ax,si
	shl	ax,1h
	add	bx,ax
	mov	ax,[bx+6FFCh]
	mov	dx,38h
	mul	dx
	add	ax,8C1Eh
	push	ax
	call	6BF7h
	add	sp,6h
	xor	ax,ax
	push	ax
	push	ds
	mov	ax,0A0C6h
	push	ax
	mov	ax,di
	mov	dx,0Eh
	mul	dx
	push	ax
	mov	ax,si
	mov	cl,4h
	shl	ax,cl
	push	ax
	push	cs
	call	41C5h
	add	sp,0Ah
	inc	si

l0800_02C7:
	cmp	si,14h
	jl	0274h

l0800_02CC:
	inc	di

l0800_02CD:
	cmp	di,0Ch
	jl	0270h

l0800_02D2:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_02D6: 0800:02D6
;;   Called from:
;;     0800:0D0C (in fn0800_0BDC)
fn0800_02D6 proc
	push	si
	jmp	02E9h

l0800_02D9:
	mov	bx,[9276h]
	mov	si,[bx+2h]
	push	bx
	call	6D6Dh
	pop	cx
	mov	[9276h],si

l0800_02E9:
	cmp	word ptr [9276h],0h
	jnz	02D9h

l0800_02F0:
	mov	word ptr [9278h],0h
	pop	si
	ret

;; fn0800_02F8: 0800:02F8
;;   Called from:
;;     0800:0C2F (in fn0800_0BDC)
;;     0800:0C3B (in fn0800_0BDC)
;;     0800:0C47 (in fn0800_0BDC)
;;     0800:0C53 (in fn0800_0BDC)
;;     0800:0C5F (in fn0800_0BDC)
fn0800_02F8 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	or	si,si
	jz	030Ch

l0800_0303:
	mov	ax,[bp+6h]
	mov	[si],ax
	mov	ax,si
	jmp	0358h

l0800_030C:
	cmp	word ptr [9278h],0h
	jnz	0327h

l0800_0313:
	mov	ax,4h
	push	ax
	call	69F0h
	pop	cx
	mov	[9276h],ax
	mov	[9278h],ax
	or	ax,ax
	jnz	0348h

l0800_0325:
	jmp	033Ah

l0800_0327:
	mov	ax,4h
	push	ax
	call	69F0h
	pop	cx
	mov	bx,[9278h]
	mov	[bx+2h],ax
	or	ax,ax
	jnz	033Eh

l0800_033A:
	xor	ax,ax
	jmp	0358h

l0800_033E:
	mov	bx,[9278h]
	mov	ax,[bx+2h]
	mov	[9278h],ax

l0800_0348:
	mov	bx,[9278h]
	mov	word ptr [bx+2h],0h
	mov	ax,[bp+6h]
	mov	[bx],ax
	mov	ax,bx

l0800_0358:
	pop	si
	pop	bp
	ret
0800:035B                                  55 8B EC 56 57            U..VW
0800:0360 8B 7E 04 0B FF 74 4E 3B 3E 76 92 75 16 8B 1E 76 .~...tN;>v.u...v
0800:0370 92 8B 47 02 A3 76 92 0B C0 75 35 C7 06 78 92 00 ..G..v...u5..x..
0800:0380 00 EB 2D 8B 36 76 92 EB 03 8B 74 02 8B 44 02 3B ..-.6v....t..D.;
0800:0390 C7 74 06 3B 36 78 92 75 F0 3B 36 78 92 74 16 A1 .t.;6x.u.;6x.t..
0800:03A0 78 92 3B C7 75 04 89 36 78 92 8B 45 02 89 44 02 x.;.u..6x..E..D.
0800:03B0 57 E8 B9 69 59 33 C0 5F 5E 5D C3                W..iY3._^].    

;; fn0800_03BB: 0800:03BB
;;   Called from:
;;     0800:0CCE (in fn0800_0BDC)
fn0800_03BB proc
	push	si
	mov	si,[9276h]
	jmp	03C7h

l0800_03C2:
	call	word ptr [si]
	mov	si,[si+2h]

l0800_03C7:
	or	si,si
	jnz	03C2h

l0800_03CB:
	pop	si
	ret

;; fn0800_03CD: 0800:03CD
;;   Called from:
;;     0800:0447 (in fn0800_042B)
;;     0800:0464 (in fn0800_044C)
fn0800_03CD proc
	push	bp
	mov	bp,sp
	sub	sp,10h
	mov	al,[bp+4h]
	mov	[bp-0Fh],al
	lea	ax,[bp-10h]
	push	ax
	lea	ax,[bp-10h]
	push	ax
	mov	ax,16h
	push	ax
	call	6DDAh
	add	sp,6h
	mov	ax,[bp-10h]
	mov	sp,bp
	pop	bp
	ret

;; fn0800_03F2: 0800:03F2
;;   Called from:
;;     0800:0425 (in fn0800_0419)
;;     0800:089C (in fn0800_06F3)
;;     0800:0BCA (in fn0800_0B33)
fn0800_03F2 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+4h]
	jmp	040Eh

l0800_03FC:
	mov	di,3Ch
	jmp	0407h

l0800_0401:
	add	si,14h
	sub	si,14h

l0800_0407:
	mov	ax,di
	dec	di
	or	ax,ax
	jnz	0401h

l0800_040E:
	mov	ax,si
	dec	si
	or	ax,ax
	jnz	03FCh

l0800_0415:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_0419: 0800:0419
;;   Called from:
;;     0800:1144 (in fn0800_111E)
fn0800_0419 proc
	push	bp
	mov	bp,sp
	mov	ax,[bp+4h]
	mov	dx,3E8h
	mul	dx
	push	ax
	call	03F2h
	pop	cx
	pop	bp
	ret

;; fn0800_042B: 0800:042B
;;   Called from:
;;     0800:08A3 (in fn0800_06F3)
fn0800_042B proc
	cmp	word ptr [927Eh],0h
	jz	043Dh

l0800_0432:
	cmp	word ptr [0A112h],0h
	jz	043Dh

l0800_0439:
	mov	al,20h
	jmp	044Bh

l0800_043D:
	call	0474h
	or	ax,ax
	jz	042Bh

l0800_0444:
	xor	ax,ax
	push	ax
	call	03CDh
	pop	cx

l0800_044B:
	ret

;; fn0800_044C: 0800:044C
;;   Called from:
;;     0800:0B2B (in fn0800_0ADF)
;;     0800:0B9F (in fn0800_0B33)
fn0800_044C proc
	cmp	word ptr [927Eh],0h
	jz	045Ah

l0800_0453:
	cmp	word ptr [0A112h],0h
	jnz	046Ch

l0800_045A:
	call	0474h
	or	ax,ax
	jz	0471h

l0800_0461:
	xor	ax,ax
	push	ax
	call	03CDh
	pop	cx
	cmp	al,20h
	jnz	0471h

l0800_046C:
	mov	ax,1h
	jmp	0473h

l0800_0471:
	xor	ax,ax

l0800_0473:
	ret

;; fn0800_0474: 0800:0474
;;   Called from:
;;     0800:043D (in fn0800_042B)
;;     0800:045A (in fn0800_044C)
fn0800_0474 proc
	xor	bx,bx
	mov	es,bx
	mov	bx,41Ah
	mov	ax,es:[bx]
	xor	bx,bx
	mov	es,bx
	mov	bx,41Ch
	cmp	ax,es:[bx]
	jnz	048Eh

l0800_048A:
	xor	ax,ax
	jmp	0491h

l0800_048E:
	mov	ax,1h

l0800_0491:
	ret

;; fn0800_0492: 0800:0492
;;   Called from:
;;     0800:06FA (in fn0800_06F3)
;;     0800:0B28 (in fn0800_0ADF)
;;     0800:0B5B (in fn0800_0B33)
;;     0800:0C0D (in fn0800_0BDC)
fn0800_0492 proc
	xor	bx,bx
	mov	es,bx
	mov	bx,41Ch
	mov	ax,es:[bx]
	xor	bx,bx
	mov	es,bx
	mov	bx,41Ah
	mov	es:[bx],ax
	mov	word ptr [0A112h],0h
	ret
0800:04AD                                        55 8B EC              U..
0800:04B0 56 8B 76 04 EB 04 80 04 0D 46 80 3C 00 75 F7 5E V.v......F.<.u.^
0800:04C0 5D C3 55 8B EC 56 8B 76 04 EB 04 80 2C 0D 46 80 ].U..V.v....,.F.
0800:04D0 3C 00 75 F7 5E 5D C3 56 57 33 F6 EB 0D 8B DE D1 <.u.^].VW3......
0800:04E0 E3 FF B7 04 97 E8 DA FF 59 46 83 FE 08 7C EE B8 ........YF...|..
0800:04F0 3F 00 50 B8 FF FF 50 33 C0 50 50 0E E8 95 3C 83 ?.P...P3.PP...<.
0800:0500 C4 08 50 E8 EA 64 59 8B F8 1E 57 B8 3F 00 50 FF ..P..dY...W.?.P.
0800:0510 36 04 97 E8 C4 66 59 D1 E0 D1 E0 05 9F 00 50 33 6....fY.......P3
0800:0520 C0 50 FF 36 04 97 E8 B1 66 59 D1 E0 D1 E0 BA A0 .P.6....fY......
0800:0530 00 2B D0 52 0E E8 DD 47 83 C4 0C B8 03 00 50 B8 .+.R...G......P.
0800:0540 01 00 50 0E E8 73 39 59 59 B8 3F 00 50 FF 36 04 ..P..s9YY.?.P.6.
0800:0550 97 E8 86 66 59 D1 E0 D1 E0 05 9F 00 50 33 C0 50 ...fY.......P3.P
0800:0560 FF 36 04 97 E8 73 66 59 D1 E0 D1 E0 BA A0 00 2B .6...sfY.......+
0800:0570 D0 52 0E E8 6D 43 83 C4 08 33 F6 EB 20 8B DE D1 .R..mC...3.. ...
0800:0580 E3 FF B7 04 97 B8 01 00 50 B8 02 00 50 8B C6 D1 ........P...P...
0800:0590 E0 D1 E0 D1 E0 50 E8 9C 00 83 C4 08 46 83 FE 08 .....P......F...
0800:05A0 7C DB 33 F6 EB 0D 8B DE D1 E3 FF B7 04 97 E8 FC |.3.............
0800:05B0 FE 59 46 83 FE 08 7C EE E8 D7 FE 33 C0 50 E8 0C .YF...|....3.P..
0800:05C0 FE 59 33 C0 50 1E 57 50 FF 36 04 97 E8 0B 66 59 .Y3.P.WP.6....fY
0800:05D0 D1 E0 D1 E0 BA A0 00 2B D0 52 0E E8 E7 3B 83 C4 .......+.R...;..
0800:05E0 0A 57 E8 88 67 59 5F 5E C3                      .W..gY_^.      

;; fn0800_05E9: 0800:05E9
;;   Called from:
;;     0800:07DC (in fn0800_06F3)
;;     0800:0C79 (in fn0800_0BDC)
;;     0800:0C8B (in fn0800_0BDC)
;;     0800:0CE4 (in fn0800_0BDC)
;;     0800:113A (in fn0800_111E)
fn0800_05E9 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	xor	ax,ax
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	3EBAh
	pop	cx
	pop	cx
	mov	ax,0Ah
	push	ax
	mov	ax,0A106h
	push	ax
	push	word ptr [bp+8h]
	call	6B55h
	add	sp,6h
	mov	ax,0C7h
	push	ax
	mov	ax,si
	add	ax,1Fh
	push	ax
	mov	ax,0BCh
	push	ax
	push	si
	push	cs
	call	48E3h
	add	sp,8h
	mov	ax,0A106h
	push	ax
	push	word ptr [bp+6h]
	push	si
	call	0215h
	add	sp,6h
	pop	si
	pop	bp
	ret

;; fn0800_0635: 0800:0635
;;   Called from:
;;     0800:072C (in fn0800_06F3)
;;     0800:0742 (in fn0800_06F3)
;;     0800:0767 (in fn0800_06F3)
;;     0800:0B0F (in fn0800_0ADF)
;;     0800:0B22 (in fn0800_0ADF)
;;     0800:0B8C (in fn0800_0B33)
fn0800_0635 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	push	word ptr [bp+6h]
	push	cs
	call	4A0Bh
	pop	cx
	push	word ptr [bp+8h]
	xor	ax,ax
	push	ax
	push	ax
	push	cs
	call	42F6h
	add	sp,6h
	mov	ax,2h
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	42B5h
	pop	cx
	pop	cx
	mov	ax,1h
	push	ax
	mov	ax,si
	add	ax,7h
	push	ax
	mov	ax,140h
	push	ax
	push	si
	xor	ax,ax
	push	ax
	push	cs
	call	3BBEh
	add	sp,0Ah
	push	ds
	push	word ptr [bp+0Ah]
	push	si
	mov	ax,0A0h
	push	ax
	push	cs
	call	4BD9h
	add	sp,8h
	pop	si
	pop	bp
	ret
0800:068C                                     56 83 3E 14             V.>.
0800:0690 A1 00 74 21 33 F6 EB 15 8B DE D1 E3 FF B7 14 97 ..t!3...........
0800:06A0 E8 08 69 59 B8 06 00 50 E8 47 FD 59 46 83 FE 05 ..iY...P.G.YF...
0800:06B0 7C E6 E8 22 69 5E C3 56 BE 58 02 EB 10 56 E8 EA |.."i^.V.X...V..
0800:06C0 68 59 B8 05 00 50 E8 29 FD 59 83 EE 04 81 FE 90 hY...P.).Y......
0800:06D0 01 7F EA BE 58 02 EB 10 56 E8 CF 68 59 B8 05 00 ....X...V..hY...
0800:06E0 50 E8 0E FD 59 83 EE 04 81 FE 90 01 7F EA E8 E6 P...Y...........
0800:06F0 68 5E C3                                        h^.            

;; fn0800_06F3: 0800:06F3
;;   Called from:
;;     0800:0C04 (in fn0800_0BDC)
fn0800_06F3 proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	si
	call	0492h
	xor	ax,ax
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	3EBAh
	pop	cx
	pop	cx
	mov	ax,0C7h
	push	ax
	mov	ax,13Fh
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	push	cs
	call	48E3h
	add	sp,8h
	mov	ax,985Bh
	push	ax
	mov	ax,4h
	push	ax
	mov	ax,3h
	push	ax
	xor	ax,ax
	push	ax
	call	0635h
	add	sp,8h
	mov	ax,9997h
	push	ax
	mov	ax,1h
	push	ax
	mov	ax,2h
	push	ax
	mov	ax,28h
	push	ax
	call	0635h
	add	sp,8h
	xor	si,si
	jmp	076Eh

l0800_074C:
	mov	bx,si
	shl	bx,1h
	push	word ptr [bx+971Eh]
	mov	ax,1h
	push	ax
	mov	ax,3h
	push	ax
	mov	ax,si
	mov	dx,0Ah
	mul	dx
	add	ax,46h
	push	ax
	call	0635h
	add	sp,8h
	inc	si

l0800_076E:
	cmp	si,0Bh
	jl	074Ch

l0800_0773:
	cmp	word ptr [927Eh],0h
	jnz	078Dh

l0800_077A:
	mov	ax,9734h
	push	ax
	mov	ax,2h
	push	ax
	xor	ax,ax
	push	ax
	call	0215h
	add	sp,6h
	jmp	079Eh

l0800_078D:
	mov	ax,973Fh
	push	ax
	mov	ax,2h
	push	ax
	xor	ax,ax
	push	ax
	call	0215h
	add	sp,6h

l0800_079E:
	mov	ax,99A8h
	push	ax
	mov	ax,1h
	push	ax
	mov	ax,5Ch
	push	ax
	call	0215h
	add	sp,6h
	jmp	07CCh

l0800_07B2:
	cmp	byte ptr [bp-1h],30h
	jc	07F7h

l0800_07B8:
	cmp	byte ptr [bp-1h],39h
	ja	07F7h

l0800_07BE:
	mov	al,[bp-1h]
	mov	ah,0h
	mov	dx,39h
	sub	dx,ax
	mov	[927Ch],dx

l0800_07CC:
	mov	ax,9h
	sub	ax,[927Ch]
	push	ax
	mov	ax,2h
	push	ax
	mov	ax,0DCh
	push	ax
	call	05E9h
	add	sp,6h
	mov	ax,99B9h
	push	ax
	mov	ax,1h
	push	ax
	mov	ax,0E4h
	push	ax
	call	0215h
	add	sp,6h
	jmp	08A3h

l0800_07F7:
	mov	al,[bp-1h]
	mov	ah,0h
	mov	cx,5h
	mov	bx,812h

l0800_0802:
	cmp	ax,cs:[bx]
	jz	080Eh

l0800_0807:
	inc	bx
	inc	bx
	loop	0802h

l0800_080B:
	jmp	0890h

l0800_080E:
	jmp	word ptr cs:[bx+0Ah]
0800:0812       1B 00 44 00 4B 00 64 00 6B 00 26 08 61 08   ..D.K.d.k.&.a.
0800:0820 35 08 61 08 35 08 E8 ED 01 0E E8 D5 32 B8 01 00 5.a.5.......2...
0800:0830 50 E8 88 60 59 B8 C7 00 50 B8 4F 00 50 B8 BC 00 P..`Y...P.O.P...
0800:0840 50 33 C0 50 0E E8 9B 40 83 C4 08 B8 34 97 50 B8 P3.P...@....4.P.
0800:0850 02 00 50 33 C0 50 E8 BC F9 83 C4 06 E8 B7 01 EB ..P3.P..........
0800:0860 42 B8 C7 00 50 B8 4F 00 50 B8 BC 00 50 33 C0 50 B...P.O.P...P3.P
0800:0870 0E E8 6F 40 83 C4 08 B8 3F 97 50 B8 02 00 50 33 ..o@....?.P...P3
0800:0880 C0 50 E8 90 F9 83 C4 06 E8 8B 01 E8 63 01 EB 13 .P..........c...

l0800_0890:
	mov	ax,258h
	push	ax
	call	6FABh
	pop	cx
	mov	ax,46h
	push	ax
	call	03F2h
	pop	cx
	call	6FD7h

l0800_08A3:
	call	042Bh
	mov	[bp-1h],al
	cmp	al,20h
	jz	08B0h

l0800_08AD:
	jmp	07B2h

l0800_08B0:
	xor	ax,ax
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	3EBAh
	pop	cx
	pop	cx
	mov	ax,0C7h
	push	ax
	mov	ax,13Fh
	push	ax
	mov	ax,0BCh
	push	ax
	xor	ax,ax
	push	ax
	push	cs
	call	48E3h
	add	sp,8h
	pop	si
	mov	sp,bp
	pop	bp
	ret
0800:08D8                         50 53 51 52 06 1E 56 57         PSQR..VW
0800:08E0 55 2E 8E 1E 9D 01 8B EC 83 EC 02 9C FF 1E 1A A1 U...............
0800:08F0 FF 06 4A 97 A1 4A 97 A9 01 00 74 03 E9 74 00 B0 ..J..J....t..t..
0800:0900 03 BA 01 02 EE C7 06 12 A1 00 00 EC A8 10 75 06 ..............u.
0800:0910 C7 06 12 A1 01 00 33 FF 8B F7 EB 1A 8A 46 FF B4 ......3......F..
0800:0920 00 25 01 00 03 F0 8A 46 FF B4 00 BB 02 00 99 F7 .%.....F........
0800:0930 FB 25 01 00 03 F8 BA 01 02 EC 88 46 FF A8 03 75 .%.........F...u
0800:0940 DB 83 FE 05 7D 08 C7 06 7A 92 04 00 EB 25 83 FE ....}...z....%..
0800:0950 0A 7E 08 C7 06 7A 92 02 00 EB 18 83 FF 05 7D 08 .~...z........}.
0800:0960 C7 06 7A 92 01 00 EB 0B 83 FF 0A 7E 06 C7 06 7A ..z........~...z
0800:0970 92 03 00 8B E5 5D 5F 5E 1F 07 5A 59 5B 58 CF    .....]_^..ZY[X.

;; fn0800_097F: 0800:097F
;;   Called from:
;;     0800:0A09 (in fn0800_09F1)
;;     0800:0A22 (in fn0800_0A16)
fn0800_097F proc
	push	bp
	mov	bp,sp
	cli
	mov	ax,[bp+6h]
	mov	dx,[bp+4h]
	mov	bx,dx
	shl	bx,1h
	shl	bx,1h
	xor	cx,cx
	or	bx,0h
	or	cx,0h
	mov	es,cx
	mov	es:[bx],ax
	mov	ax,[bp+8h]
	mov	bx,dx
	shl	bx,1h
	shl	bx,1h
	inc	bx
	inc	bx
	xor	cx,cx
	or	bx,0h
	or	cx,0h
	mov	es,cx
	mov	es:[bx],ax
	sti
	pop	bp
	ret

;; fn0800_09BB: 0800:09BB
;;   Called from:
;;     0800:09F5 (in fn0800_09F1)
fn0800_09BB proc
	push	bp
	mov	bp,sp
	mov	ax,[bp+4h]
	shl	ax,1h
	shl	ax,1h
	xor	dx,dx
	or	ax,0h
	or	dx,0h
	mov	bx,ax
	mov	es,dx
	mov	ax,es:[bx]
	mov	dx,[bp+4h]
	mov	bx,dx
	shl	bx,1h
	shl	bx,1h
	inc	bx
	inc	bx
	xor	cx,cx
	or	bx,0h
	or	cx,0h
	mov	es,cx
	mov	dx,es:[bx]
	pop	bp
	ret

;; fn0800_09F1: 0800:09F1
;;   Called from:
;;     0800:0BF8 (in fn0800_0BDC)
fn0800_09F1 proc
	mov	ax,8h
	push	ax
	call	09BBh
	pop	cx
	mov	[0A11Ch],dx
	mov	[0A11Ah],ax
	push	cs
	mov	ax,8D8h
	push	ax
	mov	ax,8h
	push	ax
	call	097Fh
	add	sp,6h
	mov	word ptr [927Eh],1h
	ret

;; fn0800_0A16: 0800:0A16
;;   Called from:
;;     0800:0BFB (in fn0800_0BDC)
fn0800_0A16 proc
	push	word ptr [0A11Ch]
	push	word ptr [0A11Ah]
	mov	ax,8h
	push	ax
	call	097Fh
	add	sp,6h
	mov	word ptr [927Eh],0h
	ret
0800:0A2F                                              E8                .
0800:0A30 42 FA 0B C0 75 03 E9 A5 00 33 DB 8E C3 BB 17 04 B...u....3......
0800:0A40 26 8B 07 25 03 00 3D 03 00 75 08 C7 06 10 A1 01 &..%..=..u......
0800:0A50 00 EB 06 C7 06 10 A1 00 00 33 C0 50 E8 6E F9 59 .........3.P.n.Y
0800:0A60 B9 08 00 BB 75 0A 2E 3B 07 74 06 43 43 E2 F7 EB ....u..;.t.CC...
0800:0A70 6D 2E FF 67 10 1B 01 20 39 00 3B 00 3C 00 48 00 m..g... 9.;.<.H.
0800:0A80 4B 00 4D 00 50 C5 0A D4 0A B5 0A BD 0A 95 0A AD K.M.P...........
0800:0A90 0A 9D 0A A5 0A C7 06 7A 92 01 00 EB 41 C7 06 7A .......z....A..z
0800:0AA0 92 02 00 EB 39 C7 06 7A 92 03 00 EB 31 C7 06 7A ....9..z....1..z
0800:0AB0 92 04 00 EB 29 C7 06 14 A1 00 00 EB 21 C7 06 14 ....).......!...
0800:0AC0 A1 01 00 EB 19 E8 4E FF 0E E8 36 30 B8 01 00 50 ......N...60...P
0800:0AD0 E8 E9 5D 59 83 3E 10 A1 00 74 03 E8 F9 F9 C3    ..]Y.>...t.....

;; fn0800_0ADF: 0800:0ADF
;;   Called from:
;;     0800:0D1C (in fn0800_0BDC)
fn0800_0ADF proc
	xor	ax,ax
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	3EBAh
	pop	cx
	pop	cx
	mov	ax,0C7h
	push	ax
	mov	ax,13Fh
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	push	cs
	call	48E3h
	add	sp,8h
	mov	ax,99BBh
	push	ax
	mov	ax,4h
	push	ax
	mov	ax,3h
	push	ax
	mov	ax,50h
	push	ax
	call	0635h
	add	sp,8h
	mov	ax,99C5h
	push	ax
	mov	ax,1h
	push	ax
	push	ax
	mov	ax,78h
	push	ax
	call	0635h
	add	sp,8h
	call	0492h

l0800_0B2B:
	call	044Ch
	or	ax,ax
	jz	0B2Bh

l0800_0B32:
	ret

;; fn0800_0B33: 0800:0B33
;;   Called from:
;;     0800:0D16 (in fn0800_0BDC)
fn0800_0B33 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	push	di
	xor	ax,ax
	push	ax
	mov	ax,1h
	push	ax
	push	cs
	call	3EBAh
	pop	cx
	pop	cx
	mov	ax,0C7h
	push	ax
	mov	ax,13Fh
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	push	cs
	call	48E3h
	add	sp,8h
	call	0492h
	mov	word ptr [bp-2h],3h
	mov	di,258h
	xor	si,si
	mov	word ptr [bp-4h],64h

l0800_0B6D:
	inc	word ptr [bp-4h]
	mov	ax,[bp-4h]
	cmp	ax,64h
	jl	0B9Fh

l0800_0B78:
	mov	ax,99D4h
	push	ax
	mov	ax,4h
	push	ax
	mov	bx,si
	shl	bx,1h
	push	word ptr [bx+974Ch]
	mov	ax,3Ch
	push	ax
	call	0635h
	add	sp,8h
	inc	si
	mov	ax,si
	and	ax,7h
	mov	si,ax
	mov	word ptr [bp-4h],0h

l0800_0B9F:
	call	044Ch
	or	ax,ax
	jnz	0BD3h

l0800_0BA6:
	cmp	di,258h
	jl	0BB2h

l0800_0BAC:
	cmp	di,384h
	jle	0BBAh

l0800_0BB2:
	xor	ax,ax
	sub	ax,[bp-2h]
	mov	[bp-2h],ax

l0800_0BBA:
	cmp	word ptr [0A114h],0h
	jz	0BC6h

l0800_0BC1:
	push	di
	call	6FABh
	pop	cx

l0800_0BC6:
	mov	ax,3h
	push	ax
	call	03F2h
	pop	cx
	add	di,[bp-2h]
	jmp	0B6Dh

l0800_0BD3:
	call	6FD7h
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret

;; fn0800_0BDC: 0800:0BDC
;;   Called from:
;;     0800:01D9 (in fn0800_01CE)
fn0800_0BDC proc
	mov	ax,9280h
	xor	bx,bx
	mov	es,bx
	mov	bx,7Ch
	mov	es:[bx],ax
	mov	ax,9280h
	mov	dx,ds
	xor	bx,bx
	mov	es,bx
	mov	bx,7Eh
	mov	es:[bx],dx
	call	09F1h
	call	0A16h
	mov	word ptr [0A122h],0h

l0800_0C04:
	call	06F3h
	mov	word ptr [0A118h],0h
	call	0492h
	mov	word ptr [0A11Eh],23h
	mov	word ptr [0A114h],1h
	mov	ax,[0A11Eh]
	mov	bx,7h
	cwd
	idiv	bx
	mov	[0A11Eh],ax
	mov	ax,0A2Fh
	push	ax
	xor	ax,ax
	push	ax
	call	02F8h
	pop	cx
	pop	cx
	mov	ax,13EEh
	push	ax
	xor	ax,ax
	push	ax
	call	02F8h
	pop	cx
	pop	cx
	mov	ax,0F63h
	push	ax
	xor	ax,ax
	push	ax
	call	02F8h
	pop	cx
	pop	cx
	mov	ax,12B7h
	push	ax
	xor	ax,ax
	push	ax
	call	02F8h
	pop	cx
	pop	cx
	mov	ax,10F8h
	push	ax
	xor	ax,ax
	push	ax
	call	02F8h
	pop	cx
	pop	cx
	mov	word ptr [0A116h],0h
	jmp	0D00h

l0800_0C6D:
	push	word ptr [0A118h]
	mov	ax,3h
	push	ax
	mov	ax,2Dh
	push	ax
	call	05E9h
	add	sp,6h
	push	word ptr [0A122h]
	mov	ax,2h
	push	ax
	mov	ax,0BAh
	push	ax
	call	05E9h
	add	sp,6h
	mov	ax,99DDh
	push	ax
	mov	ax,3h
	push	ax
	xor	ax,ax
	push	ax
	call	0215h
	add	sp,6h
	mov	ax,99E3h
	push	ax
	mov	ax,2h
	push	ax
	mov	ax,82h
	push	ax
	call	0215h
	add	sp,6h
	mov	ax,99EBh
	push	ax
	mov	ax,3h
	push	ax
	mov	ax,0FAh
	push	ax
	call	0215h
	add	sp,6h
	call	111Eh
	call	6FD7h
	jmp	0CD1h

l0800_0CCE:
	call	03BBh

l0800_0CD1:
	cmp	word ptr [0A380h],0h
	jz	0CCEh

l0800_0CD8:
	push	word ptr [0A122h]
	mov	ax,2h
	push	ax
	mov	ax,0BAh
	push	ax
	call	05E9h
	add	sp,6h
	cmp	word ptr [0A11Eh],0h
	jl	0D0Ch

l0800_0CF1:
	cmp	word ptr [0A380h],2h
	jnz	0CFCh

l0800_0CF8:
	dec	word ptr [0A116h]

l0800_0CFC:
	inc	word ptr [0A116h]

l0800_0D00:
	mov	ax,[0A116h]
	cmp	ax,[6FFAh]
	jge	0D0Ch

l0800_0D09:
	jmp	0C6Dh

l0800_0D0C:
	call	02D6h
	cmp	word ptr [0A11Eh],0h
	jl	0D1Ch

l0800_0D16:
	call	0B33h
	jmp	0C04h

l0800_0D1C:
	call	0ADFh
	jmp	0C04h
0800:0D22       C3 55 8B EC 8B 5E 04 8B 07 BB 10 00 99 F7   .U...^........
0800:0D30 FB 0B D2 75 15 8B 5E 04 8B 47 02 BB 0E 00 99 F7 ...u..^..G......
0800:0D40 FB 0B D2 75 05 B8 01 00 EB 02 33 C0 5D C3 55 8B ...u......3.].U.
0800:0D50 EC 8B 5E 04 8B 07 8B 5E 06 2B 07 99 33 C2 2B C2 ..^....^.+..3.+.
0800:0D60 3D 10 00 7D 05 B8 01 00 EB 02 33 C0 5D C3 55 8B =..}......3.].U.
0800:0D70 EC 8B 5E 04 8B 47 02 8B 5E 06 2B 47 02 99 33 C2 ..^..G..^.+G..3.
0800:0D80 2B C2 3D 0E 00 7D 05 B8 01 00 EB 02 33 C0 5D C3 +.=..}......3.].
0800:0D90 55 8B EC 56 57 8B 7E 06 8B 76 04 57 56 E8 AE FF U..VW.~..v.WV...
0800:0DA0 59 59 0B C0 74 12 8B 44 02 3B 45 02 7E 05 B8 01 YY..t..D.;E.~...
0800:0DB0 00 EB 22 B8 03 00 EB 1D 57 56 E8 B1 FF 59 59 0B ..".....WV...YY.
0800:0DC0 C0 74 10 8B 04 3B 05 7E 05 B8 04 00 EB 07 B8 02 .t...;.~........
0800:0DD0 00 EB 02 33 C0 5F 5E 5D C3 55 8B EC 56 FF 76 06 ...3._^].U..V.v.
0800:0DE0 FF 76 04 E8 AA FF 59 59 8B F0 8B C6 0B C0 74 06 .v....YY......t.
0800:0DF0 8B 5E 04 89 77 0A 5E 5D C3 55 8B EC 83 EC 02 56 .^..w.^].U.....V
0800:0E00 57 8B 76 04 8B 44 0A 3D 01 00 74 07 3D 04 00 74 W.v..D.=..t.=..t
0800:0E10 1D EB 2A 8B 04 BB 10 00 99 F7 FB 8B F8 8B 44 02 ..*...........D.
0800:0E20 05 0D 00 BB 0E 00 99 F7 FB 89 46 FE EB 25 8B 04 ..........F..%..
0800:0E30 05 0F 00 BB 10 00 99 F7 FB 8B F8 EB 0A 8B 04 BB ................
0800:0E40 10 00 99 F7 FB 8B F8 8B 44 02 BB 0E 00 99 F7 FB ........D.......
0800:0E50 89 46 FE 33 C0 50 8B 46 FE BA 0E 00 F7 E2 50 8B .F.3.P.F......P.
0800:0E60 C7 B1 04 D3 E0 50 8B 46 FE BA 28 00 F7 E2 8B D8 .....P.F..(.....
0800:0E70 8B C7 D1 E0 03 D8 FF B7 9E A1 E8 66 F3 83 C4 08 ...........f....
0800:0E80 5F 5E 8B E5 5D C3 55 8B EC 56 8B 76 04 8B 44 0C _^..].U..V.v..D.
0800:0E90 FF 44 0C 3B 44 0E 7C 38 C7 44 0C 01 00 83 44 1A .D.;D.|8.D....D.
0800:0EA0 02 8B 44 1A 2B 44 18 BB 02 00 99 F7 FB 3B 44 1C ..D.+D.......;D.
0800:0EB0 7C 05 8B 44 18 EB 03 8B 44 1A 89 44 1A 33 C0 50 |..D....D..D.3.P
0800:0EC0 FF 74 02 FF 34 8B 5C 1A FF 37 E8 16 F3 83 C4 08 .t..4.\..7......
0800:0ED0 8B 44 0A 48 3D 03 00 76 03 E9 84 00 8B D8 D1 E3 .D.H=..v........
0800:0EE0 2E FF A7 E5 0E ED 0E 1B 0F 4A 0F 30 0F 8B 44 14 .........J.0..D.
0800:0EF0 FF 44 14 3B 44 16 7C 68 56 E8 FD FE 59 83 6C 02 .D.;D.|hV...Y.l.
0800:0F00 02 C7 44 14 01 00 33 C0 50 FF 74 02 FF 34 8B 5C ..D...3.P.t..4.\
0800:0F10 1A FF 37 E8 CD F2 83 C4 08 EB 45 8B 44 10 FF 44 ..7.......E.D..D
0800:0F20 10 3B 44 12 7C 3A 56 E8 CF FE 59 83 04 04 EB 13 .;D.|:V...Y.....
0800:0F30 8B 44 10 FF 44 10 3B 44 12 7C 25 56 E8 BA FE 59 .D..D.;D.|%V...Y
0800:0F40 83 2C 04 C7 44 10 01 00 EB BC 8B 44 14 FF 44 14 .,..D......D..D.
0800:0F50 3B 44 16 7C 0B 56 E8 A0 FE 59 83 44 02 02 EB A1 ;D.|.V...Y.D....
0800:0F60 5E 5D C3 56 57 BE 24 A1 33 FF EB 09 56 E8 16 FF ^].VW.$.3...V...
0800:0F70 59 47 83 C6 1E 3B 3E 20 A1 7C F1 5F 5E C3 55 8B YG...;> .|._^.U.
0800:0F80 EC 56 57 8B 76 04 56 E8 99 FD 59 0B C0 74 1E 8B .VW.v.V...Y..t..
0800:0F90 44 0A 3D 04 00 76 03 E9 D5 00 8B D8 D1 E3 2E FF D.=..v..........
0800:0FA0 A7 A3 0F AD 0F B2 0F E3 0F 14 10 42 10 33 C0 E9 ...........B.3..
0800:0FB0 C0 00 8B 44 02 BB 0E 00 99 F7 FB 8B F8 8B C7 0B ...D............
0800:0FC0 C0 75 03 E9 A9 00 4F 8B C7 BA 28 00 F7 E2 8B D8 .u....O...(.....
0800:0FD0 8B 04 B9 10 00 99 F7 F9 D1 E0 03 D8 8B 87 9E A1 ................
0800:0FE0 E9 8F 00 8B 04 BB 10 00 99 F7 FB 8B F8 8B C7 3D ...............=
0800:0FF0 13 00 75 03 E9 78 00 8B 44 02 BB 0E 00 99 F7 FB ..u..x..D.......
0800:1000 BA 28 00 F7 E2 8B D8 47 8B C7 D1 E0 03 D8 8B 87 .(.....G........
0800:1010 9E A1 EB 5E 8B 44 02 BB 0E 00 99 F7 FB 8B F8 8B ...^.D..........
0800:1020 C7 3D 0B 00 74 49 47 8B C7 BA 28 00 F7 E2 8B D8 .=..tIG...(.....
0800:1030 8B 04 B9 10 00 99 F7 F9 D1 E0 03 D8 8B 87 9E A1 ................
0800:1040 EB 30 8B 04 BB 10 00 99 F7 FB 8B F8 8B C7 0B C0 .0..............
0800:1050 74 1D 8B 44 02 BB 0E 00 99 F7 FB BA 28 00 F7 E2 t..D........(...
0800:1060 8B D8 4F 8B C7 D1 E0 03 D8 8B 87 9E A1 EB 03 B8 ..O.............
0800:1070 FF FF 5F 5E 5D C3 55 8B EC 56 FF 76 04 E8 FE FE .._^].U..V.v....
0800:1080 59 8B F0 0B F6 7C 05 83 FE 01 7E 05 B8 01 00 EB Y....|....~.....
0800:1090 02 33 C0 5E 5D C3 55 8B EC 56 8B 76 04 56 E8 82 .3.^].U..V.v.V..
0800:10A0 FC 59 0B C0 74 41 B8 24 A1 50 56 E8 2B FD 59 59 .Y..tA.$.PV.+.YY
0800:10B0 56 E8 C2 FF 59 0B C0 75 06 83 7C 0A 00 75 28 8B V...Y..u..|..u(.
0800:10C0 5C 06 8B 07 89 44 0A 83 44 06 02 8B 44 06 2B 44 \....D..D...D.+D
0800:10D0 04 BB 02 00 99 F7 FB 3B 44 08 7C 05 8B 44 04 EB .......;D.|..D..
0800:10E0 03 8B 44 06 89 44 06 56 E8 8B FF 59 0B C0 74 05 ..D..D.V...Y..t.
0800:10F0 C7 44 0A 00 00 5E 5D C3 56 57 BE 01 00 8B C6 BA .D...^].VW......
0800:1100 1E 00 F7 E2 8B F8 81 C7 24 A1 EB 09 57 E8 86 FF ........$...W...
0800:1110 59 46 83 C7 1E 3B 36 20 A1 7C F1 5F 5E C3       YF...;6 .|._^. 

;; fn0800_111E: 0800:111E
;;   Called from:
;;     0800:0CC6 (in fn0800_0BDC)
fn0800_111E proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	si
	push	di
	push	word ptr [0A116h]
	call	0267h
	pop	cx
	push	word ptr [0A11Eh]
	mov	ax,2h
	push	ax
	mov	ax,136h
	push	ax
	call	05E9h
	add	sp,6h
	mov	ax,2h
	push	ax
	call	0419h
	pop	cx
	xor	ax,ax
	mov	[0A19Ch],ax
	mov	[0A380h],ax
	mov	[927Ah],ax
	mov	ax,1E0h
	push	ax
	mov	ax,0A19Eh
	push	ax
	mov	ax,[0A116h]
	mov	dx,1E0h
	mul	dx
	add	ax,6FFCh
	push	ax
	call	6BF7h
	add	sp,6h
	xor	di,di
	mov	ax,di
	mov	[0A37Eh],ax
	mov	word ptr [bp-2h],0A19Eh
	jmp	118Ch

l0800_117B:
	mov	bx,[bp-2h]
	cmp	word ptr [bx],1h
	jnz	1187h

l0800_1183:
	inc	word ptr [0A37Eh]

l0800_1187:
	add	word ptr [bp-2h],2h
	inc	di

l0800_118C:
	cmp	di,0F0h
	jl	117Bh

l0800_1192:
	mov	ax,[0A116h]
	mov	dx,3h
	mul	dx
	cwd
	idiv	word ptr [6FFAh]
	inc	ax
	inc	ax
	mov	[0A120h],ax
	mov	di,1h
	mov	ax,di
	mov	dx,1Eh
	mul	dx
	mov	si,ax
	add	si,0A124h
	jmp	1239h

l0800_11B7:
	mov	word ptr [si],12Ch
	mov	word ptr [si+2h],54h
	mov	word ptr [si+0Ah],4h
	call	6F53h
	mov	bx,3h
	cwd
	idiv	bx
	mov	cl,5h
	shl	dx,cl
	add	dx,9680h
	mov	[si+6h],dx
	mov	[si+4h],dx
	mov	word ptr [si+8h],20h
	call	6F53h
	mov	bx,[927Ch]
	add	bx,4h
	cwd
	idiv	bx
	mov	ax,[927Ch]
	mov	bx,0Eh
	push	dx
	mul	bx
	pop	dx
	add	dx,ax
	add	dx,4h
	mov	[si+12h],dx
	mov	ax,[si+12h]
	shl	ax,1h
	mov	[si+0Eh],ax
	call	6F53h
	mov	bx,[927Ch]
	add	bx,4h
	cwd
	idiv	bx
	mov	ax,[927Ch]
	mov	bx,0Eh
	push	dx
	mul	bx
	pop	dx
	add	dx,ax
	inc	dx
	inc	dx
	mov	[si+16h],dx
	mov	ax,4h
	push	ax
	mov	ax,9700h
	push	ax
	push	si
	call	128Ch
	add	sp,6h
	inc	di
	add	si,1Eh

l0800_1239:
	cmp	di,[0A120h]
	jge	1242h

l0800_123F:
	jmp	11B7h

l0800_1242:
	mov	word ptr [0A124h],4h
	mov	word ptr [0A126h],54h
	mov	word ptr [0A12Eh],2h
	mov	ax,[927Ch]
	mov	dx,0Eh
	mul	dx
	add	ax,4h
	mov	[0A136h],ax
	shl	ax,1h
	mov	[0A132h],ax
	mov	ax,[927Ch]
	mov	dx,0Eh
	mul	dx
	inc	ax
	inc	ax
	mov	[0A13Ah],ax
	mov	ax,4h
	push	ax
	mov	ax,96E8h
	push	ax
	mov	ax,0A124h
	push	ax
	call	128Ch
	add	sp,6h
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret

;; fn0800_128C: 0800:128C
;;   Called from:
;;     0800:122F (in fn0800_111E)
;;     0800:1280 (in fn0800_111E)
fn0800_128C proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	mov	ax,[bp+6h]
	mov	[si+1Ah],ax
	mov	[si+18h],ax
	mov	ax,[bp+8h]
	mov	bx,2h
	cwd
	idiv	bx
	mov	[si+1Ch],ax
	mov	ax,1h
	mov	[si+14h],ax
	mov	[si+10h],ax
	mov	[si+0Ch],ax
	pop	si
	pop	bp
	ret
0800:12B7                      56 57 BE 24 A1 56 E8 63 FA        VW.$.V.c.
0800:12C0 59 0B C0 75 03 E9 23 01 8B 44 02 BB 0E 00 99 F7 Y..u..#..D......
0800:12D0 FB BA 28 00 F7 E2 8B F8 8B 04 BB 10 00 99 F7 FB ..(.............
0800:12E0 D1 E0 03 F8 81 C7 9E A1 83 3D 00 75 03 E9 7B 00 .........=.u..{.
0800:12F0 C7 05 00 00 E8 95 F3 FF 06 9C A1 A1 9C A1 3B 06 ..............;.
0800:1300 7E A3 7C 06 C7 06 80 A3 01 00 81 3E 18 A1 58 02 ~.|........>..X.
0800:1310 74 18 81 3E 18 A1 B0 04 74 10 81 3E 18 A1 D0 07 t..>....t..>....
0800:1320 74 08 81 3E 18 A1 28 0A 75 19 FF 06 1E A1 FF 36 t..>..(.u......6
0800:1330 1E A1 B8 02 00 50 B8 36 01 50 E8 AC F2 83 C4 06 .....P.6.P......
0800:1340 E8 74 F3 83 06 18 A1 02 A1 22 A1 3B 06 18 A1 7E .t.......".;...~
0800:1350 02 EB 03 A1 18 A1 A3 22 A1 FF 36 18 A1 B8 03 00 ......."..6.....
0800:1360 50 B8 2D 00 50 E8 81 F2 83 C4 06 8B 44 0A 3B 06 P.-.P.......D.;.
0800:1370 7A 92 74 66 A1 7A 92 89 44 0A 48 3D 03 00 77 55 z.tf.z..D.H=..wU
0800:1380 8B D8 D1 E3 2E FF A7 89 13 91 13 A2 13 B3 13 C4 ................
0800:1390 13 B8 04 00 50 B8 E0 96 50 56 E8 EF FE 83 C4 06 ....P...PV......
0800:13A0 EB 38 B8 04 00 50 B8 E8 96 50 56 E8 DE FE 83 C4 .8...P...PV.....
0800:13B0 06 EB 27 B8 04 00 50 B8 F0 96 50 56 E8 CD FE 83 ..'...P...PV....
0800:13C0 C4 06 EB 16 B8 04 00 50 B8 F8 96 50 56 E8 BC FE .......P...PV...
0800:13D0 83 C4 06 EB 05 C7 44 0A 00 00 56 E8 98 FC 59 0B ......D...V...Y.
0800:13E0 C0 74 08 33 C0 89 44 0A A3 7A 92 5F 5E C3 56 57 .t.3..D..z._^.VW
0800:13F0 BE 01 00 8B C6 BA 1E 00 F7 E2 8B F8 81 C7 24 A1 ..............$.
0800:1400 EB 52 B8 24 A1 50 57 E8 64 F9 59 59 0B C0 74 40 .R.$.PW.d.YY..t@
0800:1410 B8 24 A1 50 57 E8 36 F9 59 59 0B C0 74 32 FF 0E .$.PW.6.YY..t2..
0800:1420 1E A1 C7 06 80 A3 02 00 BE 08 02 EB 18 E8 23 5B ..............#[
0800:1430 99 F7 FE 81 C2 90 01 52 E8 70 5B 59 B8 0A 00 50 .......R.p[Y...P
0800:1440 E8 AF EF 59 4E 81 FE CC 01 7F E2 E8 89 5B EB 0A ...YN........[..
0800:1450 46 83 C7 1E 3B 36 20 A1 7C A8 5F 5E C3 00 00 00 F...;6 .|._^....
0800:1460 70 6B 08 08 42 47 49 20 44 65 76 69 63 65 20 44 pk..BGI Device D
0800:1470 72 69 76 65 72 20 28 43 47 41 29 20 32 2E 30 30 river (CGA) 2.00
0800:1480 20 2D 20 4D 61 72 20 32 31 20 31 39 38 38 0D 0A  - Mar 21 1988..
0800:1490 43 6F 70 79 72 69 67 68 74 20 28 63 29 20 31 39 Copyright (c) 19
0800:14A0 38 37 2C 31 39 38 38 20 42 6F 72 6C 61 6E 64 20 87,1988 Borland 
0800:14B0 49 6E 74 65 72 6E 61 74 69 6F 6E 61 6C 0D 0A 00 International...
0800:14C0 1A A0 00 00 00 CD 17 02 00 01 01 00 00 00 00 00 ................
0800:14D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:14E0 A0 00 00 00 CD 17 02 00 01 01 03 43 47 41 00 00 ...........CGA..
0800:14F0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:1500 1E 0E 1F FC 55 FF 94 16 00 5D 1F CB 43 42 00 00 ....U....]..CB..
0800:1510 C3 00 00 00 00 C3 73 02 D2 02 E9 02 15 00 53 03 ......s.......S.
0800:1520 5B 03 6F 03 10 00 10 00 E2 08 10 00 10 00 10 00 [.o.............
0800:1530 F6 00 22 01 27 03 27 01 91 04 53 04 17 04 41 01 ..".'.'...S...A.
0800:1540 10 00 D8 00 BC 10 D5 10 92 00 BD 00 D2 00 72 00 ..............r.
0800:1550 5F 01 15 00 15 00 15 00 15 00 15 00 15 00 15 00 _...............
0800:1560 15 00 15 00 15 00 15 00 15 00 15 00 15 00 15 00 ................
0800:1570 15 00 A3 BB 04 89 1E BD 04 89 0E BF 04 89 16 C1 ................
0800:1580 04 C3 98 00 AF 00 AF 00 AF 00 A0 00 B0 00 B1 00 ................
0800:1590 B6 00 0E 07 BB 82 00 C3 1E 0E 1F E8 89 02 1F CB ................
0800:15A0 2E 80 3E 7A 01 00 75 04 B8 02 00 CB B8 01 00 CB ..>z..u.........
0800:15B0 CB B4 05 CD 10 CB 24 01 2E A2 7E 01 CB E8 03 00 ......$...~.....
0800:15C0 E9 32 0E 8B F1 8B FA 26 03 0F 43 43 26 03 17 43 .2.....&..CC&..C
0800:15D0 43 C3 E8 EE FF E9 D5 0E 8B F0 8B FB B2 FF A0 7A C..............z
0800:15E0 03 3C 02 73 0A 32 D2 22 C0 74 04 8A 16 7D 01 8A .<.s.2.".t...}..
0800:15F0 F1 32 DB E9 35 11 8A FB 8A D8 22 E4 79 05 F6 C4 .2..5.....".y...
0800:1600 40 75 01 C3 80 E7 0F 75 08 80 3E 7A 01 00 74 01 @u.....u..>z..t.
0800:1610 C3 80 3E 80 01 00 75 03 80 CF 10 88 3E 7F 01 E9 ..>...u.....>...
0800:1620 30 04 26 8A 3F EB DD 3C FF 75 12 B9 08 00 BF 10 0.&.?..<.u......
0800:1630 0B 26 8A 07 88 05 47 43 E2 F7 B8 0C 0C E8 3E 02 .&....GC......>.
0800:1640 C3 8B C1 F7 26 85 01 8B D8 8B 0E 87 01 C3 10 00 ....&...........
0800:1650 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 3C ...............<
0800:1660 01 74 11 BB 01 00 B9 01 00 80 3E 7A 01 00 75 03 .t........>z..u.
0800:1670 B9 03 00 C3 0E 07 BB 4E 01 C3 00 00 00 00 00 00 .......N........
0800:1680 00 00 00 00 00 08 00 08 00 00 00 00 00 00 00 00 ................
0800:1690 00 00 00 00 00 00 00 00 00 00 00 3F 01 C7 00 3F ...........?...?
0800:16A0 01 C7 00 28 23 58 1B 8D 20 08 08 03 02 04 0E 90 ...(#X.. .......
0800:16B0 00 00 3F 01 C7 00 3F 01 C7 00 28 23 58 1B 8D 20 ..?...?...(#X.. 
0800:16C0 08 08 03 03 05 07 90 00 00 7F 02 C7 00 7F 02 C7 ................
0800:16D0 00 28 23 58 1B 47 10 08 08 01 07 90 00 00 7F 02 .(#X.G..........
0800:16E0 DF 01 7F 02 DF 01 28 23 58 1B 10 27 08 08 01 07 ......(#X..'....
0800:16F0 90 99 01 B0 01 C7 01 DC 01 06 00 12 33 32 30 20 ............320 
0800:1700 78 20 32 30 30 20 43 47 41 20 43 30 20 20 00 12 x 200 CGA C0  ..
0800:1710 33 32 30 20 78 20 32 30 30 20 43 47 41 20 43 31 320 x 200 CGA C1
0800:1720 20 20 00 12 33 32 30 20 78 20 32 30 30 20 43 47   ..320 x 200 CG
0800:1730 41 20 43 32 20 20 00 12 33 32 30 20 78 20 32 30 A C2  ..320 x 20
0800:1740 30 20 43 47 41 20 43 33 20 20 00 12 36 34 30 20 0 CGA C3  ..640 
0800:1750 78 20 32 30 30 20 43 47 41 20 20 20 20 20 00 12 x 200 CGA     ..
0800:1760 36 34 30 20 78 20 34 38 30 20 4D 43 47 41 20 20 640 x 480 MCGA  
0800:1770 20 20 00 3C 01 75 05 8B 0E F9 01 C3 0E 07 3C 02   .<.u........<.
0800:1780 75 0D B0 14 F6 E1 8A D8 32 FF 81 C3 FB 01 C3 8A u.......2.......
0800:1790 C5 32 E4 40 A3 F9 01 8A C1 32 DB 3C 04 73 06 3C .2.@.....2.<.s.<
0800:17A0 02 72 04 FE C3 2C 02 88 1E 80 01 8A C8 A2 7B 01 .r...,........{.
0800:17B0 C6 06 7A 01 FF 3C 02 73 05 C6 06 7A 01 00 8A D9 ..z..<.s...z....
0800:17C0 D0 E3 32 FF 8B 9F F1 01 89 1E 97 01 C6 06 7E 01 ..2...........~.
0800:17D0 00 C3 26 8A 07 24 0F 80 3E 80 01 00 75 02 0C 10 ..&..$..>...u...
0800:17E0 A2 7F 01 A0 7B 01 E9 20 02 A0 B2 04 3C 03 72 18 ....{.. ....<.r.
0800:17F0 3C 03 74 23 FF 36 BF 04 FF 36 C1 04 E8 E4 FF 8F <.t#.6...6......
0800:1800 06 C1 04 8F 06 BF 04 C3 33 C9 B6 18 B2 4F 32 FF ........3....O2.
0800:1810 32 C0 B4 06 CD 10 C3 B8 00 A0 8E C0 B9 00 4B FC 2.............K.
0800:1820 33 C0 8B F8 F3 AB C3 80 3E 7A 01 00 74 13 33 DB 3.......>z..t.3.
0800:1830 22 E4 74 02 FE C7 22 C0 74 02 FE C3 89 1E 7C 01 ".t...".t.....|.
0800:1840 C3 B3 03 3A E3 76 02 8A E3 3A C3 76 02 8A C3 A3 ...:.v...:.v....
0800:1850 7C 01 C3 A3 81 01 89 1E 83 01 C3 51 52 8B C8 8B |..........QR...
0800:1860 D3 87 06 81 01 87 1E 83 01 E8 03 00 5A 59 C3 8B ............ZY..
0800:1870 36 7C 01 8B 3E 85 04 E9 28 03 00 00 00 00 A3 7A 6|..>...(......z
0800:1880 03 8A 1E 7D 01 0E 07 FC 3C 02 72 55 2C 02 32 E4 ...}....<.rU,.2.
0800:1890 B1 03 D3 E0 BE C0 0A 03 F0 BF 07 04 80 3E 7A 01 .............>z.
0800:18A0 00 74 0C B9 04 00 F3 A5 C7 06 05 04 08 00 C3 C7 .t..............
0800:18B0 06 05 04 10 00 8A 3E 7D 01 B9 08 00 AC E8 0E 00 ......>}........
0800:18C0 86 D0 AA 8A C2 E8 06 00 8A C2 AA E2 EF C3 32 D2 ..............2.
0800:18D0 B3 04 D0 C2 D0 C2 D0 D0 73 02 0A D7 FE CB 75 F2 ........s.....u.
0800:18E0 C3 80 3E 7A 01 00 74 07 22 DB 74 03 BB 03 00 3C ..>z..t.".t....<
0800:18F0 01 74 02 33 DB 83 E3 03 8A 87 33 0A BF 07 04 B9 .t.3......3.....
0800:1900 10 00 F3 AA C3 08 00 00 00 00 00 00 00 00 00 00 ................
0800:1910 00 00 00 00 00 00 00 80 3E 8A 01 01 75 03 03 D9 ........>...u...
0800:1920 4B 26 8A 07 22 C0 74 2A 06 53 51 8B 1E 81 01 8B K&..".t*.SQ.....
0800:1930 0E 83 01 E8 2C 07 59 5B 07 8B 16 85 01 80 3E 8A ....,.Y[......>.
0800:1940 01 01 75 07 01 16 83 01 4B EB 05 01 16 81 01 43 ..u.....K......C
0800:1950 E2 CF C3 22 E4 78 2D A2 89 01 88 26 8A 01 81 E3 ...".x-....&....
0800:1960 F8 00 89 1E 85 01 81 E1 F8 00 89 0E 87 01 53 51 ..............SQ
0800:1970 A0 7C 01 D0 EB D0 EB D0 EB D0 E9 D0 E9 D0 E9 E8 .|..............
0800:1980 A8 06 59 5B C3 FF FF 01 00 FF FF CC CC 78 FC F8 ..Y[.........x..
0800:1990 F8 3C 04 74 0A 32 E4 D0 E0 8B D8 8B 9F 89 04 89 .<.t.2..........
0800:19A0 1E 85 04 89 0E 87 04 C3 00 00 00 00 00 00 00 00 ................
0800:19B0 00 B8 00 00 00 00 00 00 00 00 00 00 00 00 00 7F ................
0800:19C0 02 C7 00 3F 01 C7 00 28 00 00 B8 3D 05 3F 01 C7 ...?...(...=.?..
0800:19D0 00 28 00 00 B8 41 05 7F 02 C7 00 28 00 00 B8 67 .(...A.....(...g
0800:19E0 05 7F 02 DF 01 50 00 00 A0 6D 05 CF 02 5B 01 5A .....P...m...[.Z
0800:19F0 00 00 B0 9B 05 7F 02 8F 01 50 00 00 B8 73 05 CF .........P...s..
0800:1A00 02 5D 01 5A 00 00 B8 79 05 3C 07 72 02 B0 02 A2 .].Z...y.<.r....
0800:1A10 B2 04 B4 0A F6 E4 8B D8 81 C3 C3 04 8B 07 A3 B7 ................
0800:1A20 04 A3 BF 04 8B 47 02 A3 B9 04 A3 C1 04 8B 47 04 .....G........G.
0800:1A30 A3 B3 04 8B 47 06 A3 B0 04 FF 57 08 C3 32 C0 EB ....G.....W..2..
0800:1A40 02 B0 01 50 B8 04 00 CD 10 58 B7 01 8A D8 B4 0B ...P.....X......
0800:1A50 CD 10 80 3E B2 04 04 74 0D A0 7F 01 B4 0B 32 FF ...>...t......2.
0800:1A60 24 1F 8A D8 CD 10 C3 B8 06 00 CD 10 C3 B8 11 00 $...............
0800:1A70 CD 10 C3 B8 40 00 CD 10 C3 FC B8 30 00 CD 10 B8 ....@......0....
0800:1A80 00 B8 8E C0 33 C0 33 FF FC B9 00 40 F3 AB C3 35 ....3.3....@...5
0800:1A90 2D 2E 07 5B 02 57 57 02 03 00 00 B0 03 BA BF 03 -..[.WW.........
0800:1AA0 EE B0 02 BE 8F 05 33 DB B9 00 80 50 53 51 BA B8 ......3....PSQ..
0800:1AB0 03 EE 8C D8 8E C0 BA B4 03 B9 0C 00 32 E4 8A C4 ............2...
0800:1AC0 EE 42 AC EE FE C4 4A E2 F5 59 A1 B0 04 FC 8E C0 .B....J..Y......
0800:1AD0 33 FF 58 F3 AB BA B8 03 58 0C 08 EE BB 40 00 8E 3.X.....X....@..
0800:1AE0 C3 BB 65 00 26 88 07 C3 02 06 02 06 12 06 02 06 ..e.&...........
0800:1AF0 12 06 02 06 12 06 22 06 28 06 36 06 56 06 70 06 ......".(.6.V.p.
0800:1B00 90 06 34 01 A8 01 74 05 81 C3 00 20 C3 81 EB B0 ..4...t.... ....
0800:1B10 1F C3 34 01 A8 01 74 05 81 C3 B0 1F C3 81 EB 00 ..4...t.........
0800:1B20 20 C3 2E 03 1E B3 04 C3 2E 2B 1E B3 04 C3 00 B0  ........+......
0800:1B30 00 B2 00 B4 00 B6 51 8A C8 FE C1 80 E1 03 75 03 ......Q.......u.
0800:1B40 83 C3 5A 53 24 FC 0A C1 8A D9 D0 E3 32 FF 2E 8E ..ZS$.......2...
0800:1B50 87 2E 06 5B 59 C3 51 8A C8 FE C9 80 E1 03 80 F9 ...[Y.Q.........
0800:1B60 03 75 E0 83 EB 5A EB DB 00 B8 00 BA 00 BC 00 BE .u...Z..........
0800:1B70 51 8A C8 FE C1 80 E1 03 75 03 83 C3 50 53 24 FC Q.......u...PS$.
0800:1B80 0A C1 8A D9 D0 E3 32 FF 2E 8E 87 68 06 5B 59 C3 ......2....h.[Y.
0800:1B90 51 8A C8 FE C9 80 E1 03 80 F9 03 75 E0 83 EB 50 Q..........u...P
0800:1BA0 EB DB 3B 06 B7 04 77 12 3B 0E B7 04 77 0C 3B 1E ..;...w.;...w.;.
0800:1BB0 B9 04 77 06 3B 16 B9 04 76 01 C3 8B EC 83 EC 14 ..w.;...v.......
0800:1BC0 89 76 FE 89 3E B5 04 3B C1 72 03 91 87 DA 89 46 .v..>..;.r.....F
0800:1BD0 FC 89 5E FA C6 46 EC 00 3B DA 72 06 87 DA C6 46 ..^..F..;.r....F
0800:1BE0 EC 80 91 2B C1 89 46 F4 87 DA 2B DA 89 5E F2 E8 ...+..F...+..^..
0800:1BF0 2F 01 8B 46 F4 8B 5E F2 3B C3 72 18 89 46 F6 D1 /..F..^.;.r..F..
0800:1C00 E3 89 5E F2 2B D8 89 5E F8 2B D8 89 5E F4 E8 1B ..^.+..^.+..^...
0800:1C10 00 E9 87 00 89 5E F6 D1 E0 89 46 F4 2B C3 89 46 .....^....F.+..F
0800:1C20 F8 2B C3 89 46 F2 E8 03 00 E9 B2 00 8B 5E F0 8B .+..F........^..
0800:1C30 56 F8 8B 7E F4 8B 76 F2 8B 46 FA 24 03 80 3E 7B V..~..v..F.$..>{
0800:1C40 01 04 73 02 24 01 0A 46 EC 80 3E 7A 01 00 74 02 ..s.$..F..>z..t.
0800:1C50 0C 40 80 3E 7E 01 00 74 02 0C 20 8A 66 FE 8A 6E .@.>~..t.. .f..n
0800:1C60 EE 8B 6E F6 45 D1 06 B5 04 73 13 A8 20 74 05 26 ..n.E....s.. t.&
0800:1C70 30 27 EB 0A 26 8A 0F 22 CD 0A CC 26 88 0F 53 8A 0'..&.."...&..S.
0800:1C80 1E 7B 01 D0 E3 D0 E3 32 FF 81 C3 EA 05 22 C0 79 .{.....2.....".y
0800:1C90 02 43 43 8B 1F 89 1E E8 05 5B C3 4D 75 04 83 C4 .CC......[.Mu...
0800:1CA0 14 C3 F6 C6 80 75 08 03 D7 FF 16 E8 05 EB 02 03 .....u..........
0800:1CB0 D6 A8 40 75 04 D0 CC D0 CD D0 CC D0 CD F6 C5 80 ..@u............
0800:1CC0 75 01 43 D1 06 B5 04 73 13 A8 20 74 05 26 30 27 u.C....s.. t.&0'
0800:1CD0 EB 0A 26 8A 0F 22 CD 0A CC 26 88 0F EB BD 4D 75 ..&.."...&....Mu
0800:1CE0 04 83 C4 14 C3 F6 C6 80 75 16 03 D6 A8 40 75 04 ........u....@u.
0800:1CF0 D0 CC D0 CD D0 CC D0 CD F6 C5 80 75 01 43 EB 02 ...........u.C..
0800:1D00 03 D7 FF 16 E8 05 D1 06 B5 04 73 13 A8 20 74 05 ..........s.. t.
0800:1D10 26 30 27 EB 0A 26 8A 0F 22 CD 0A CC 26 88 0F EB &0'..&.."...&...
0800:1D20 BD 8B 4E FC 8B 56 FA A0 7B 01 3C 03 73 04 81 E2 ..N..V..{.<.s...
0800:1D30 FE 00 3C 04 72 04 D1 EA D1 EA A1 B3 04 F7 E2 8B ..<.r...........
0800:1D40 F0 8B D1 80 3E 7A 01 00 74 07 B9 03 07 B0 FE EB ....>z..t.......
0800:1D50 05 B9 02 03 B0 FC 22 EA D3 EA 03 F2 FE C5 8A 66 ......"........f
0800:1D60 FE 8A F0 A0 7A 01 D0 CC D0 CE 22 C0 75 04 D0 CC ....z.....".u...
0800:1D70 D0 CE FE CD 75 F0 A0 7B 01 88 66 FE 88 76 EE 8B ....u..{..f..v..
0800:1D80 DE 3C 03 73 0B F7 46 FA 01 00 74 04 81 C3 00 20 .<.s..F...t.... 
0800:1D90 89 5E F0 8E 06 B0 04 3C 04 72 14 8B 5E FA 83 E3 .^.....<.r..^...
0800:1DA0 03 D1 E3 8E 87 2E 06 3C 05 75 04 8E 87 68 06 C3 .......<.u...h..
0800:1DB0 00 00 00 D5 08 00 00 C1 08 C5 08 C9 08 D5 08 D1 ................
0800:1DC0 08 26 08 05 C3 26 30 05 C3 F6 D3 0A C3 26 20 05 .&...&0......& .
0800:1DD0 C3 F6 D0 EB 00 22 C3 F6 D3 26 22 1D 0A C3 26 88 ....."...&"...&.
0800:1DE0 05 C3 3B C1 72 01 91 3B DA 72 02 87 DA 8B F0 A2 ..;.r..;.r......
0800:1DF0 B6 08 8B FB B0 03 0E 07 83 E3 07 80 3E 7A 01 00 ............>z..
0800:1E00 75 02 D1 E3 81 C3 07 04 2B D7 42 89 16 B0 08 53 u.......+.B....S
0800:1E10 32 FF 8A D8 D0 E3 81 C3 B7 08 8B 1F 89 1E B3 08 2...............
0800:1E20 8B DE 8B C1 2B C3 A2 B5 08 D1 E8 D1 E8 80 3E 7A ....+.........>z
0800:1E30 01 00 74 02 D1 E8 40 5B 50 56 51 06 53 E8 F7 00 ..t...@[PVQ.S...
0800:1E40 88 1E B2 08 FC 5E 1F 8A C8 5B E8 C3 00 2E 80 3E .....^...[.....>
0800:1E50 7A 01 00 75 02 FE C3 2E 8A AF 2B 0A 5B E8 B0 00 z..u......+.[...
0800:1E60 2E 8A BF 23 0A 8A DD 5D 2E A0 B2 08 50 53 55 57 ...#...]....PSUW
0800:1E70 2E 80 3E 7A 01 00 74 05 AC 8A E0 EB 0B AD 2E F6 ..>z..t.........
0800:1E80 06 B6 08 04 75 02 86 E0 56 8B D0 E8 2F 00 5E B8 ....u...V.../.^.
0800:1E90 10 00 2E 80 3E 7A 01 00 74 03 B8 08 00 05 07 04 ....>z..t.......
0800:1EA0 3B F0 72 03 BE 07 04 5F 5D 5B 58 87 DF FF 16 E8 ;.r...._][X.....
0800:1EB0 05 87 DF 2E FF 0E B0 08 75 B2 0E 1F C3 53 8A C2 ........u....S..
0800:1EC0 4D 8A DF 23 ED 74 0F 2E FF 16 B3 08 B3 FF 47 86 M..#.t........G.
0800:1ED0 F2 8A C2 4D 75 F1 8A E6 B6 03 2E 80 3E 7A 01 00 ...Mu.......>z..
0800:1EE0 74 02 B6 07 2E 8A 16 B5 08 22 D6 2A F2 8A D1 2E t........".*....
0800:1EF0 80 3E 7A 01 00 75 02 D0 EA 3A F2 5A 7D 0A 2E FF .>z..u...:.Z}...
0800:1F00 16 B3 08 47 8A C4 B3 FF 22 DA 2E FF 16 B3 08 C3 ...G....".......
0800:1F10 83 E3 07 2E 80 3E 7A 01 00 75 05 80 E3 03 D0 E3 .....>z..u......
0800:1F20 8A C3 C3 FF 7F 3F 1F 0F 07 03 01 80 C0 E0 F0 F8 .....?..........
0800:1F30 FC FE FF 00 55 AA FF 32 C0 E8 42 FD 8B D7 57 A0 ....U..2..B...W.
0800:1F40 7B 01 3C 03 73 04 81 E2 FE 00 3C 04 72 04 D1 EA {.<.s.....<.r...
0800:1F50 D1 EA A1 B3 04 F7 E2 8B D8 8B D6 B9 02 03 B0 3F ...............?
0800:1F60 8A 26 7A 01 22 E4 74 05 B9 03 07 B0 7F 22 EA D3 .&z.".t......"..
0800:1F70 EA 03 DA 22 E4 75 02 D0 E5 8A CD D2 C8 86 C1 8B ...".u..........
0800:1F80 FB 8E 06 B0 04 5B 8A 26 7B 01 80 FC 03 73 0A 80 .....[.&{....s..
0800:1F90 E3 01 74 04 81 C7 00 20 C3 80 FC 04 72 14 83 E3 ..t.... ....r...
0800:1FA0 03 D0 E3 8E 87 2E 06 80 FC 05 75 04 8E 87 68 06 ..........u...h.
0800:1FB0 D0 EB C3 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:1FC0 FF FF 00 00 FF FF 00 00 01 02 04 08 10 20 40 80 ............. @.
0800:1FD0 E0 C1 83 07 0E 1C 38 70 F0 78 3C 1E 0F 87 C3 E1 ......8p.x<.....
0800:1FE0 A5 D2 69 B4 5A 2D 96 4B FF 88 88 88 FF 88 88 88 ..i.Z-.K........
0800:1FF0 81 42 24 18 18 24 42 81 CC 33 CC 33 CC 33 CC 33 .B$..$B..3.3.3.3
0800:2000 80 00 08 00 80 00 08 00 88 00 22 00 88 00 22 00 .........."...".
0800:2010 FF FF FF FF FF FF FF FF 00 00 00 00 00 00 00 00 ................
0800:2020 00 01 01 00 00 00 00 00 00 00 88 26 25 0B 8A E0 ...........&%...
0800:2030 80 E4 80 88 26 20 0B 24 03 22 DB 75 02 FE C3 88 ....& .$.".u....
0800:2040 1E 21 0B 22 C9 75 02 FE C1 88 0E 22 0B B0 08 F6 .!.".u....."....
0800:2050 E3 2D 02 00 A3 26 0B B0 08 F6 E1 2D 02 00 A3 28 .-...&.....-...(
0800:2060 0B C3 23 DB 78 FB 8B 3E BF 04 2B 3E 26 0B 3B DF ..#.x..>..+>&.;.
0800:2070 73 EF 23 C9 78 EB 8B 3E C1 04 2B 3E 28 0B 3B CF s.#.x..>..+>(.;.
0800:2080 73 DF 1E 53 51 E8 92 00 5F 5E 06 E8 24 01 07 2E s..SQ..._^..$...
0800:2090 C6 06 24 0B 08 2E 8A 2E 22 0B 50 53 26 8A 56 00 ..$.....".PS&.V.
0800:20A0 BF 08 00 2E 8A 0E 21 0B E8 18 00 D0 C2 4F 75 F3 ......!......Ou.
0800:20B0 5B E8 38 00 58 FE CD 75 E1 45 2E FE 0E 24 0B 75 [.8.X..u.E...$.u
0800:20C0 D4 1F C3 F6 C2 80 75 02 EB 08 8A 37 22 F4 0A F0 ......u....7"...
0800:20D0 88 37 D0 C8 D0 CC 2E 80 3E 7A 01 00 75 04 D0 C8 .7......>z..u...
0800:20E0 D0 CC 22 E4 78 01 43 FE C9 75 D8 C3 2E A0 23 0B ..".x.C..u....#.
0800:20F0 2E 80 3E 7B 01 04 73 0A 2E FF 16 E8 05 2E A2 23 ..>{..s........#
0800:2100 0B C3 06 2E FF 16 E8 05 2E A2 23 0B 8C C0 8E D8 ..........#.....
0800:2110 07 C3 00 00 00 00 00 00 00 00 3C 30 75 02 B0 4F ..........<0u..O
0800:2120 32 E4 8B E8 D1 E5 D1 E5 D1 E5 3C 41 72 04 3C 7B 2.........<Ar.<{
0800:2130 72 31 3C 80 72 22 B8 00 00 8E C0 BB 7C 00 81 ED r1<.r"......|...
0800:2140 00 04 26 8B 07 23 C0 74 0C 03 E8 26 8B 47 02 8E ..&..#.t...&.G..
0800:2150 C0 23 C0 75 14 BD 00 01 81 C5 6E FA B8 00 F0 8E .#.u......n.....
0800:2160 C0 EB 06 0E 07 81 C5 D9 0A 80 3E 25 0B 00 74 41 ..........>%..tA
0800:2170 26 8B 46 00 26 8B 5E 02 26 8B 4E 04 26 8B 56 06 &.F.&.^.&.N.&.V.
0800:2180 0E 07 BF 12 0C BD 08 00 D0 E8 D1 D6 D0 EC D1 D6 ................
0800:2190 D0 EB D1 D6 D0 EF D1 D6 D0 E9 D1 D6 D0 ED D1 D6 ................
0800:21A0 D0 EA D1 D6 D0 EE D1 D6 96 AA 96 4D 75 DA BD 12 ...........Mu...
0800:21B0 0C C3 E8 82 FD 88 1E 23 0B B0 FF 8A 1E 7C 01 81 .......#.....|..
0800:21C0 E3 03 00 80 3E 7A 01 00 74 06 22 DB 74 02 B3 03 ....>z..t.".t...
0800:21D0 8A 87 33 0A 8A E1 F6 D4 22 C4 06 1F 8A E1 8B DF ..3.....".......
0800:21E0 C3 38 6C C6 C6 FE C6 C6 00 FC C6 C6 FC C6 C6 FC .8l.............
0800:21F0 00 7C C6 C6 C0 C0 C6 7C 00 F8 CC C6 C6 C6 CC F8 .|.....|........
0800:2200 00 FE C0 C0 FC C0 C0 FE 00 FE C0 C0 FC C0 C0 C0 ................
0800:2210 00 7C C6 C0 CE C6 C6 7E 00 C6 C6 C6 FE C6 C6 C6 .|.....~........
0800:2220 00 78 30 30 30 30 30 78 00 1E 06 06 06 C6 C6 7C .x00000x.......|
0800:2230 00 C6 CC D8 F0 D8 CC C6 00 C0 C0 C0 C0 C0 C0 FE ................
0800:2240 00 C6 EE FE D6 C6 C6 C6 00 C6 E6 F6 DE CE C6 C6 ................
0800:2250 00 7C C6 C6 C6 C6 C6 7C 00 FC C6 C6 FC C0 C0 C0 .|.....|........
0800:2260 00 7C C6 C6 C6 C6 C6 7C 06 FC C6 C6 FC C6 C6 C6 .|.....|........
0800:2270 00 78 CC 60 30 18 CC 78 00 FC 30 30 30 30 30 30 .x.`0..x..000000
0800:2280 00 C6 C6 C6 C6 C6 C6 7C 00 C6 C6 C6 C6 C6 6C 38 .......|......l8
0800:2290 00 C6 C6 C6 D6 FE EE C6 00 C6 C6 6C 38 6C C6 C6 ...........l8l..
0800:22A0 00 C3 C3 66 3C 18 18 18 00 FE 0C 18 30 60 C0 FE ...f<.......0`..
0800:22B0 00 3C 30 30 30 30 30 3C 00 C0 60 30 18 0C 06 03 .<00000<..`0....
0800:22C0 00 3C 0C 0C 0C 0C 0C 3C 00 00 38 6C C6 00 00 00 .<.....<..8l....
0800:22D0 00 00 00 00 00 00 00 00 FF 30 30 18 00 00 00 00 .........00.....
0800:22E0 00 00 00 7C 06 7E C6 7E 00 C0 C0 FC C6 C6 E6 DC ...|.~.~........
0800:22F0 00 00 00 7C C6 C0 C0 7E 00 06 06 7E C6 C6 CE 76 ...|...~...~...v
0800:2300 00 00 00 7C C6 FE C0 7E 00 1E 30 7C 30 30 30 30 ...|...~..0|0000
0800:2310 00 00 00 7E C6 CE 76 06 7C C0 C0 FC C6 C6 C6 C6 ...~..v.|.......
0800:2320 00 18 00 38 18 18 18 3C 00 18 00 38 18 18 18 18 ...8...<...8....
0800:2330 F0 C0 C0 CC D8 F0 D8 CC 00 38 18 18 18 18 18 3C .........8.....<
0800:2340 00 00 00 CC FE D6 C6 C6 00 00 00 FC C6 C6 C6 C6 ................
0800:2350 00 00 00 7C C6 C6 C6 7C 00 00 00 FC C6 C6 E6 DC ...|...|........
0800:2360 C0 00 00 7E C6 C6 CE 76 06 00 00 6E 70 60 60 60 ...~...v...np```
0800:2370 00 00 00 7C C0 7C 06 FC 00 30 30 7C 30 30 30 1C ...|.|...00|000.
0800:2380 00 00 00 C6 C6 C6 C6 7E 00 00 00 C6 C6 C6 6C 38 .......~......l8
0800:2390 00 00 00 C6 C6 D6 FE 6C 00 00 00 C6 6C 38 6C C6 .......l....l8l.
0800:23A0 00 00 00 C6 C6 CE 76 06 7C 00 00 FC 18 30 60 FC ......v.|....0`.
0800:23B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
0800:23F0 00 00 00 00 00 2B CE 2B D7 42 89 16 F2 0E 51 06 .....+.+.B....Q.
0800:2400 53 E8 33 FB 88 1E F4 0E FC 06 1F 8B F7 5F 07 8A S.3.........._..
0800:2410 C8 5B 8B D3 E8 75 01 FE C3 D1 EA D1 EA 2E 80 3E .[...u.........>
0800:2420 7A 01 00 74 04 FE CB D1 EA 2E 8A 9F 2B 0A 2E A0 z..t........+...
0800:2430 F4 0E 50 52 56 E8 2B 00 5E 5A 58 87 DE 2E 80 3E ..PRV.+.^ZX....>
0800:2440 7B 01 04 72 0B 06 2E FF 16 E8 05 06 1F 07 EB 05 {..r............
0800:2450 2E FF 16 E8 05 87 DE 2E FF 0E F2 0E 75 D4 8B DF ............u...
0800:2460 0E 1F C3 AC 8A E0 AC 8A E8 D3 E0 23 D2 74 09 26 ...........#.t.&
0800:2470 88 25 47 8A E5 4A EB EE 22 E3 26 88 25 47 C3 00 .%G..J..".&.%G..
0800:2480 00 00 9C 0F 8C 0F 90 0F 94 0F A9 0F 26 30 05 C3 ............&0..
0800:2490 26 08 05 C3 F6 D3 0A C3 26 20 05 C3 22 C3 F6 D3 &.......& .."...
0800:24A0 26 22 1D 0A C3 26 88 05 C3 F6 D0 EB EF 2B D7 42 &"...&.......+.B
0800:24B0 89 16 F2 0E 53 32 FF 8A D8 D0 E3 81 C3 82 0F 8B ....S2..........
0800:24C0 1F 89 1E 7F 0F 8B DE 8B C1 2B C3 A2 81 0F D1 E8 .........+......
0800:24D0 D1 E8 80 3E 7A 01 00 74 02 D1 E8 40 5B 50 56 51 ...>z..t...@[PVQ
0800:24E0 06 53 E8 52 FA 88 1E F4 0E FC 5E 1F 8A C8 5B E8 .S.R......^...[.
0800:24F0 9A 00 2E 80 3E 7A 01 00 75 02 FE C3 2E 8A AF 2B ....>z..u......+
0800:2500 0A 5B E8 87 00 2E 8A BF 23 0A 8A DD 5A 2E A0 F4 .[......#...Z...
0800:2510 0E 50 53 52 57 E8 19 00 5F 5A 5B 58 87 DF 2E FF .PSRW..._Z[X....
0800:2520 16 E8 05 87 DF 2E FF 0E F2 0E 75 E5 8B DE 0E 1F ..........u.....
0800:2530 C3 53 AC 4A 32 E4 8A E8 8A DF D3 E8 23 D2 74 10 .S.J2.......#.t.
0800:2540 2E FF 16 7F 0F B3 FF 47 8A E5 AC 8A E8 4A EB EA .......G.....J..
0800:2550 B6 03 2E 80 3E 7A 01 00 74 02 B6 07 2E 8A 16 81 ....>z..t.......
0800:2560 0F 22 D6 2A F2 8A D1 2E 80 3E 7A 01 00 75 02 D0 .".*.....>z..u..
0800:2570 EA 3A F2 5A 7D 0E 2E FF 16 7F 0F 47 8A E5 32 C0 .:.Z}......G..2.
0800:2580 D3 E8 B3 FF 22 DA 2E FF 16 7F 0F C3 81 E3 07 00 ...."...........
0800:2590 2E 80 3E 7A 01 00 75 05 80 E3 03 D0 E3 8A C3 C3 ..>z..u.........
0800:25A0 F7 10 F7 10 7C 11 71 11 32 11 1B 11 6C 11 A0 11 ....|.q.2...l...
0800:25B0 A0 11 11 12 06 12 D1 11 BC 11 01 12 8B F0 8B FB ................
0800:25C0 8E 06 B0 04 8A 1E B2 04 32 FF D0 E3 FF 97 AE 10 ........2.......
0800:25D0 8A D0 32 F6 C3 81 E2 03 00 80 3E 7A 01 00 74 03 ..2.......>z..t.
0800:25E0 80 E2 01 8B F0 8B FB 8E 06 B0 04 8A 1E B2 04 32 ...............2
0800:25F0 FF D0 E3 FF A7 A0 10 E8 1C 01 8B C6 D1 E8 D1 E8 ................
0800:2600 03 F8 81 E6 03 00 D1 E6 D1 E6 03 F2 D1 E6 8B 84 ................
0800:2610 8D 17 26 22 05 0A C4 26 88 05 C3 8B DA 8B C7 81 ..&"...&........
0800:2620 E7 03 00 D1 E7 8E 85 68 06 D1 E8 D1 E8 BF 50 00 .......h......P.
0800:2630 EB 15 8B DA 8B C7 81 E7 03 00 D1 E7 8E 85 2E 06 ................
0800:2640 D1 E8 D1 E8 BF 5A 00 F7 E7 8B F8 8B C6 D1 E8 D1 .....Z..........
0800:2650 E8 D1 E8 03 F8 81 E6 07 00 D1 E6 03 F3 D1 E6 8B ................
0800:2660 84 AD 17 26 22 05 0A C4 26 88 05 C3 B8 5A 00 EB ...&"...&....Z..
0800:2670 03 B8 50 00 52 F7 E7 5A 8B F8 EB 03 E8 97 00 8B ..P.R..Z........
0800:2680 C6 D1 E8 D1 E8 D1 E8 03 F8 81 E6 07 00 D1 E6 03 ................
0800:2690 F2 D1 E6 8B 84 AD 17 26 22 05 0A C4 26 88 05 C3 .......&"...&...
0800:26A0 E8 73 00 8B C6 D1 E8 D1 E8 03 F8 8B CE 81 E1 03 .s..............
0800:26B0 00 41 D1 E1 26 8A 05 D2 C0 24 03 C3 8B C7 81 E7 .A..&....$......
0800:26C0 03 00 D1 E7 8E 85 68 06 D1 E8 D1 E8 BF 50 00 EB ......h......P..
0800:26D0 13 8B C7 81 E7 03 00 D1 E7 8E 85 2E 06 D1 E8 D1 ................
0800:26E0 E8 BF 5A 00 F7 E7 8B F8 8B C6 D1 E8 D1 E8 D1 E8 ..Z.............
0800:26F0 03 F8 8B CE 80 E1 07 FE C1 26 8A 05 D2 C0 24 01 .........&....$.
0800:2700 C3 B8 5A 00 EB 03 B8 50 00 52 F7 E7 5A 8B F8 EB ..Z....P.R..Z...
0800:2710 D7 E8 02 00 EB D2 52 8B C7 D1 E8 9C BF 50 00 F7 ......R......P..
0800:2720 E7 9D 73 03 05 00 20 8B F8 5A C3 0E 1F E8 A3 04 ..s... ..Z......
0800:2730 E8 20 04 80 FA FF 74 15 80 FA 04 72 02 B2 03 80 . ....t....r....
0800:2740 3E 7A 01 00 74 07 80 FA 02 72 02 B2 01 88 16 E2 >z..t....r......
0800:2750 0E 8A F8 89 1E E3 0E 89 26 CE 0E C6 06 EA 0E 00 ........&.......
0800:2760 8B EC 81 ED 80 00 8A DE 81 E3 03 00 8A B7 33 0A ..............3.
0800:2770 80 3E 7A 01 00 74 06 22 F6 74 02 B6 FF 52 B8 FF .>z..t.".t...R..
0800:2780 FF 4D 4D 89 46 00 A1 B9 04 2B C7 4D 4D 89 46 00 .MM.F....+.MM.F.
0800:2790 A3 D6 0E C7 06 DA 0E 00 00 A1 BF 04 A3 DE 0E 4D ...............M
0800:27A0 4D 89 76 00 C6 06 E6 0E 00 E8 C9 03 4D 4D 89 7E M.v.........MM.~
0800:27B0 00 F6 D1 5A E8 6C 03 E8 F4 02 26 8A 05 22 C1 8A ...Z.l....&.."..
0800:27C0 E6 22 E1 3A C4 74 1F 32 ED EB 25 5B 89 1E D6 0E .".:.t.2..%[....
0800:27D0 A1 D2 0E A3 DA 0E A1 D0 0E A3 DE 0E 8B 4E 00 45 .............N.E
0800:27E0 45 83 F9 FF 75 0A 8B 26 CE 0E A0 EA 0E D0 C8 C3 E...u..&........
0800:27F0 8B 7E 00 45 45 8B 76 00 45 45 8B 5E 00 45 45 E8 .~.EE.v.EE.^.EE.
0800:2800 23 04 53 8A C5 50 E8 24 01 E8 78 00 58 A8 02 74 #.S..P.$..x.X..t
0800:2810 06 A8 80 75 0E EB 19 80 3E E6 0E 00 75 0F E8 14 ...u....>...u...
0800:2820 00 73 05 E8 35 00 EB A3 E8 25 00 72 03 E8 2B 00 .s..5....%.r..+.
0800:2830 E8 3B 00 EB 96 A1 D6 0E 40 3B C3 75 1B A1 DA 0E .;......@;.u....
0800:2840 48 39 06 D2 0E 7E 11 A1 DE 0E 40 39 06 D0 0E C3 H9...~....@9....
0800:2850 A1 D6 0E 48 3B C3 74 E5 32 C0 C3 3B 1E CA 0E 73 ...H;.t.2..;...s
0800:2860 0C FF 16 C2 0E E8 46 02 B5 80 E8 34 01 C3 E8 98 ......F....4....
0800:2870 02 3B 1E C8 0E 74 0C FF 16 C0 0E E8 30 02 32 ED .;...t......0.2.
0800:2880 E8 1E 01 C3 26 8A 2D 3B 36 BB 04 74 19 4E D0 C1 ....&.-;6..t.N..
0800:2890 80 3E 7A 01 00 75 02 D0 C1 F6 C1 01 74 08 4F 86 .>z..u......t.O.
0800:28A0 16 E7 0E 26 8A 2D 8A C5 22 C1 8A E6 22 E1 3A C4 ...&.-.."...".:.
0800:28B0 74 38 8A C2 22 C1 8A E1 F6 D4 22 EC 0A E8 3B 36 t8.."....."...;6
0800:28C0 BB 04 74 26 4E D0 C1 80 3E 7A 01 00 75 02 D0 C1 ..t&N...>z..u...
0800:28D0 F6 C1 01 74 0B 26 88 2D 4F 86 16 E7 0E 26 8A 2D ...t.&.-O....&.-
0800:28E0 F6 C1 01 74 C1 E8 26 00 EB BC 26 88 2D 46 D0 C9 ...t..&...&.-F..
0800:28F0 80 3E 7A 01 00 75 02 D0 C9 F6 C1 80 74 08 47 86 .>z..u......t.G.
0800:2900 16 E7 0E 26 8A 2D 89 36 D2 0E E8 84 01 C3 A0 E5 ...&.-.6........
0800:2910 0E 26 8A 2D 3A E8 75 14 26 88 15 3B 36 C4 0E 7C .&.-:.u.&..;6..|
0800:2920 0B 2B 36 CC 0E 4F 86 16 E7 0E EB E5 C3 E8 61 01 .+6..O........a.
0800:2930 26 8A 2D 8A C5 22 C1 8A E6 22 E1 3A C4 74 38 8A &.-.."...".:.t8.
0800:2940 C2 22 C1 8A E1 F6 D4 22 EC 0A E8 3B 36 BF 04 7D ."....."...;6..}
0800:2950 26 46 D0 C9 80 3E 7A 01 00 75 02 D0 C9 F6 C1 80 &F...>z..u......
0800:2960 74 0B 26 88 2D 47 86 16 E7 0E 26 8A 2D F6 C1 80 t.&.-G....&.-...
0800:2970 74 C1 E8 0D 00 EB BC 26 88 2D 4E 89 36 D0 0E E9 t......&.-N.6...
0800:2980 87 01 A0 E5 0E 26 8A 2D 3A E8 75 14 26 88 15 3B .....&.-:.u.&..;
0800:2990 36 C6 0E 73 0B 03 36 CC 0E 47 86 16 E7 0E EB E5 6..s..6..G......
0800:29A0 C3 80 E5 80 EB 19 46 D0 C9 80 3E 7A 01 00 75 02 ......F...>z..u.
0800:29B0 D0 C9 F6 C1 80 74 08 86 16 E7 0E 47 E8 AB 00 26 .....t.....G...&
0800:29C0 8A 05 22 C1 8A E6 22 E1 3A C4 75 05 80 E5 FE EB .."...".:.u.....
0800:29D0 5E 80 3E E2 0E FF 75 08 8A E2 0A 26 E7 0E 74 0D ^.>...u....&..t.
0800:29E0 80 3E E3 0E 00 74 10 3A 16 E4 0E 75 0A 80 CD 02 .>...t.:...u....
0800:29F0 C6 06 E6 0E FF EB 17 F6 C1 80 74 0A E8 3F 00 75 ..........t..?.u
0800:2A00 05 80 E5 FE EB 29 8A E2 22 E1 3A E0 74 21 F6 C5 .....)..".:.t!..
0800:2A10 01 75 1C 80 CD 01 83 FD 0E 72 1D 4D 4D 89 5E 00 .u.......r.MM.^.
0800:2A20 4D 4D 89 76 00 4D 4D 89 7E 00 4D 4D 89 4E 00 3B MM.v.MM.~.MM.N.;
0800:2A30 36 D0 0E 73 08 E9 6E FF C6 06 EA 0E FF C3 26 3A 6..s..n.......&:
0800:2A40 15 75 26 A1 D0 0E 2B 06 CC 0E 26 3A 15 75 0F 3B .u&...+...&:.u.;
0800:2A50 F0 7F 0B 03 36 CC 0E 47 86 16 E7 0E EB EC 26 8A ....6..G......&.
0800:2A60 05 22 C1 8A E6 22 E1 3A E0 C3 F6 C5 01 74 21 A1 ."...".:.....t!.
0800:2A70 D0 0E 2B 06 CC 0E 51 8A 2E E5 0E 26 3A 2D 75 0F ..+...Q....&:-u.
0800:2A80 3B F0 73 0B 03 36 CC 0E 47 86 16 E7 0E EB EC 59 ;.s..6..G......Y
0800:2A90 C3 89 36 EB 0E 89 1E ED 0E 89 3E EF 0E 88 0E F1 ..6.......>.....
0800:2AA0 0E E8 0A 00 8A C2 8A 26 E7 0E A3 E8 0E C3 8B C3 .......&........
0800:2AB0 8A 1E E2 0E 80 FB FF 74 1C 81 E3 03 00 8A 97 33 .......t.......3
0800:2AC0 0A 8B D8 80 3E 7A 01 00 74 06 22 D2 74 02 B2 FF ....>z..t.".t...
0800:2AD0 88 16 E7 0E C3 50 52 F7 D8 03 06 B9 04 25 07 00 .....PR......%..
0800:2AE0 80 3E 7A 01 00 75 02 D1 E0 8B D8 5A 8B 87 07 04 .>z..u.....Z....
0800:2AF0 8A D0 80 3E 7A 01 00 74 02 8A E0 F7 C6 04 00 75 ...>z..t.......u
0800:2B00 02 86 E2 88 26 E7 0E 5B C3 8B 36 EB 0E 8B 1E ED ....&..[..6.....
0800:2B10 0E 8B 3E EF 0E 8A 0E F1 0E A1 E8 0E 88 26 E7 0E ..>..........&..
0800:2B20 8A D0 C3 26 8A 05 80 3E 7A 01 00 75 18 A2 E5 0E ...&...>z..u....
0800:2B30 32 C6 B4 03 84 C4 74 11 D0 E4 D0 E4 73 F6 C3 C6 2.....t.....s...
0800:2B40 06 E5 0E 00 C3 22 C0 74 F6 22 F6 75 F2 C6 06 E5 .....".t.".u....
0800:2B50 0E FF C3 80 FA FF 75 1C 53 51 50 BB 07 04 8B 0E ......u.SQP.....
0800:2B60 05 04 E3 0B 32 C0 0A 07 43 E2 FB 22 C0 75 02 32 ....2...C..".u.2
0800:2B70 D2 58 59 5B C3 E8 C1 F3 50 C7 06 CC 0E 04 00 80 .XY[....P.......
0800:2B80 3E 7A 01 00 74 06 C7 06 CC 0E 08 00 A1 BB 04 03 >z..t...........
0800:2B90 06 CC 0E A3 C4 0E A1 BF 04 2B 06 CC 0E 40 A3 C6 .........+...@..
0800:2BA0 0E A1 B9 04 2B 06 C1 04 A3 C8 0E A1 B9 04 2B 06 ....+.........+.
0800:2BB0 BD 04 A3 CA 0E 58 C3 F1 16 01 17 F1 16 01 17 F1 .....X..........
0800:2BC0 16 01 17 11 17 16 17 3D 17 53 17 65 17 7B 17 1B .......=.S.e.{..
0800:2BD0 17 20 17 50 53 8A 1E B2 04 D0 E3 D0 E3 32 FF 81 . .PS........2..
0800:2BE0 C3 B7 16 8B 07 A3 C0 0E 8B 47 02 A3 C2 0E 5B 58 .........G....[X
0800:2BF0 C3 4B F6 C3 01 75 05 81 C7 00 20 C3 81 EF B0 1F .K...u.... .....
0800:2C00 C3 43 F6 C3 01 75 05 81 C7 B0 1F C3 81 EF 00 20 .C...u......... 
0800:2C10 C3 4B 83 C7 50 C3 43 83 EF 50 C3 4B 83 C7 5A C3 .K..P.C..P.K..Z.
0800:2C20 43 83 EF 5A C3 A0 B2 04 3C 04 72 26 3C 06 73 22 C..Z....<.r&<.s"
0800:2C30 53 F6 D3 81 E3 03 00 3C 05 74 37 EB 0D 4B 53 F6 S......<.t7..KS.
0800:2C40 D3 81 E3 03 00 75 03 83 C7 5A D0 E3 2E 8E 87 2E .....u...Z......
0800:2C50 06 5B C3 43 53 F6 D3 81 E3 03 00 80 FB 03 75 EA .[.CS.........u.
0800:2C60 83 EF 5A EB E5 4B 53 F6 D3 81 E3 03 00 75 03 83 ..Z..KS......u..
0800:2C70 C7 50 D0 E3 2E 8E 87 68 06 5B C3 43 53 F6 D3 81 .P.....h.[.CS...
0800:2C80 E3 03 00 80 FB 03 75 EA 83 EF 50 EB E5 3F 00 3F ......u...P..?.?
0800:2C90 40 3F 80 3F C0 CF 00 CF 10 CF 20 CF 30 F3 00 F3 @?.?...... .0...
0800:2CA0 04 F3 08 F3 0C FC 00 FC 01 FC 02 FC 03 7F 00 7F ................
0800:2CB0 80 BF 00 BF 40 DF 00 DF 20 EF 00 EF 10 F7 00 F7 ....@... .......
0800:2CC0 08 FB 00 FB 04 FD 00 FD 02 FE 00 FE 01 55 8B EC .............U..
0800:2CD0 56 57 8B 7E 04 BE 62 9D C6 06 62 9D 00 4E 8B C7 VW.~..b...b..N..
0800:2CE0 BB 0A 00 33 D2 F7 F3 80 C2 30 88 14 8B C7 33 D2 ...3.....0....3.
0800:2CF0 F7 F3 8B F8 0B FF 75 E5 8B C6 5F 5E 5D C2 02 00 ......u..._^]...

;; fn0800_2D00: 0800:2D00
;;   Called from:
;;     0800:371F (in fn0800_3632)
fn0800_2D00 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	lds	si,[bp+4h]
	les	di,[bp+8h]

l0800_2D0C:
	lodsb
	stosb
	and	al,al
	jnz	2D0Ch

l0800_2D12:
	pop	ds
	mov	dx,[bp+0Ah]
	mov	ax,[bp+8h]
	pop	di
	pop	si
	pop	bp
	ret	8h

;; fn0800_2D1F: 0800:2D1F
;;   Called from:
;;     0800:3123 (in fn0800_30B4)
fn0800_2D1F proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	cld
	lds	si,[bp+0Ah]
	les	di,[bp+6h]
	mov	cx,[bp+4h]

l0800_2D2F:
	rep cmpsb

l0800_2D31:
	mov	al,[si-1h]
	sub	al,es:[di-1h]
	cbw
	pop	ds
	pop	di
	pop	si
	pop	bp
	ret	0Ah
0800:2D40 55 8B EC 56 C4 76 04 26 8A 04 0A C0 74 10 3C 61 U..V.v.&....t.<a
0800:2D50 72 09 3C 7A 7F 05 24 5F 26 88 04 46 EB E9 5E 5D r.<z..$_&..F..^]
0800:2D60 C2 04 00                                        ...            

;; fn0800_2D63: 0800:2D63
;;   Called from:
;;     0800:372E (in fn0800_3632)
fn0800_2D63 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	les	di,[bp+4h]
	mov	cx,0FFFFh
	xor	al,al
	cld

l0800_2D71:
	repne scasb

l0800_2D73:
	dec	di
	mov	ax,di
	mov	dx,es
	pop	di
	pop	si
	pop	bp
	ret	4h

;; fn0800_2D7E: 0800:2D7E
;;   Called from:
;;     0800:3402 (in fn0800_33E3)
;;     0800:342C (in fn0800_33E3)
;;     0800:3471 (in fn0800_3454)
;;     0800:43B3 (in fn0800_42F6)
fn0800_2D7E proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	les	di,[bp+0Ch]
	lds	si,[bp+8h]
	mov	ax,ds
	or	ax,si
	jz	2D97h

l0800_2D90:
	lodsb
	stosb
	and	al,al
	jnz	2D90h

l0800_2D96:
	dec	di

l0800_2D97:
	lds	si,[bp+4h]

l0800_2D9A:
	lodsb
	stosb
	and	al,al
	jnz	2D9Ah

l0800_2DA0:
	dec	di
	pop	ds
	mov	ax,di
	mov	dx,es
	pop	di
	pop	si
	pop	bp
	ret	0Ch

;; fn0800_2DAC: 0800:2DAC
;;   Called from:
;;     0800:2FF8 (in fn0800_2FEC)
;;     0800:3002 (in fn0800_2FEC)
fn0800_2DAC proc
	push	bp
	mov	bp,sp
	push	ds
	lds	dx,[bp+4h]
	mov	ah,9h
	nop
	nop
	pop	ds
	pop	bp
	ret	4h

;; fn0800_2DBC: 0800:2DBC
;;   Called from:
;;     0800:2DF8 (in fn0800_2DC5)
;;     0800:2E35 (in fn0800_2E0C)
;;     0800:34D3 (in fn0800_3454)
;;     0800:3506 (in fn0800_3454)
;;     0800:3537 (in fn0800_3454)
;;     0800:43F9 (in fn0800_42F6)
;;     0800:443D (in fn0800_42F6)
fn0800_2DBC proc
	mov	bx,[9D63h]
	mov	ah,3Eh
	nop
	nop
	ret

;; fn0800_2DC5: 0800:2DC5
;;   Called from:
;;     0800:3413 (in fn0800_33E3)
;;     0800:343D (in fn0800_33E3)
fn0800_2DC5 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	lds	dx,[bp+0Ah]
	mov	ax,3D00h
	nop
	nop
	pop	ds
	jnc	2DDBh

l0800_2DD6:
	mov	ax,0FFFDh
	jmp	2E06h

l0800_2DDB:
	mov	[9D63h],ax
	mov	bx,ax
	xor	cx,cx
	xor	dx,dx
	mov	ax,4202h
	nop
	nop
	jc	2DF8h

l0800_2DEB:
	and	ax,ax
	jz	2DF8h

l0800_2DEF:
	and	dx,dx
	jnz	2DF8h

l0800_2DF3:
	cmp	ax,7FFFh
	jbe	2E00h

l0800_2DF8:
	call	2DBCh
	mov	ax,[bp+4h]
	jmp	2E06h

l0800_2E00:
	les	di,[bp+6h]
	stosw
	xor	ax,ax

l0800_2E06:
	pop	di
	pop	si
	pop	bp
	ret	0Ah

;; fn0800_2E0C: 0800:2E0C
;;   Called from:
;;     0800:34ED (in fn0800_3454)
;;     0800:4422 (in fn0800_42F6)
fn0800_2E0C proc
	push	bp
	mov	bp,sp
	mov	bx,[9D63h]
	xor	cx,cx
	mov	dx,[bp+0Ah]
	mov	ax,4200h
	nop
	nop
	jc	2E35h

l0800_2E1F:
	push	ds
	mov	bx,[9D63h]
	mov	cx,[bp+8h]
	lds	dx,[bp+4h]
	mov	ah,3Fh
	nop
	nop
	pop	ds
	jc	2E35h

l0800_2E31:
	xor	ax,ax
	jmp	2E41h

l0800_2E35:
	call	2DBCh
	mov	word ptr [9C06h],0FFF4h
	mov	ax,1h

l0800_2E41:
	pop	bp
	ret	8h

;; fn0800_2E45: 0800:2E45
;;   Called from:
;;     0800:3839 (in fn0800_3632)
fn0800_2E45 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	si
	push	di
	push	ds
	lds	si,[bp+8h]
	les	di,[bp+4h]
	mov	cx,[bp+0Ch]
	cld

l0800_2E57:
	rep movsb

l0800_2E59:
	pop	ds
	pop	di
	pop	si
	pop	di
	pop	si
	pop	bp
	ret
0800:2E60 55 8B EC 83 EC 08 1E B8 00 08 8E D8 C7 46 FE 00 U............F..
0800:2E70 00 C7 46 FC 00 00 8B 46 06 2D EE FF 3D 12 00 76 ..F....F.-..=..v
0800:2E80 03 E9 FA 00 8B D8 D1 E3 2E FF A7 8D 2E 74 2F 6A .............t/j
0800:2E90 2F 60 2F 7E 2F 56 2F 44 2F 3A 2F 30 2F 26 2F 1C /`/~/V/D/:/0/&/.
0800:2EA0 2F 12 2F 07 2F FC 2E F1 2E DE 2E D4 2E C9 2E BE /././...........
0800:2EB0 2E B3 2E 8C 5E FA C7 46 F8 F9 9D E9 D8 00 8C 5E ....^..F.......^
0800:2EC0 FA C7 46 F8 02 9E E9 CD 00 8C 5E FA C7 46 F8 1F ..F.......^..F..
0800:2ED0 9E E9 C2 00 8C 5E FA C7 46 F8 3E 9E EB 08 8C 5E .....^..F.>....^
0800:2EE0 FA C7 46 F8 5D 9E 8C 5E FE C7 46 FC 01 9A E9 A5 ..F.]..^..F.....
0800:2EF0 00 8C 5E FA C7 46 F8 7A 9E E9 9A 00 8C 5E FA C7 ..^..F.z.....^..
0800:2F00 46 F8 9B 9E E9 8F 00 8C 5E FA C7 46 F8 B6 9E E9 F.......^..F....
0800:2F10 84 00 8C 5E FA C7 46 F8 D2 9E EB 30 8C 5E FA C7 ...^..F....0.^..
0800:2F20 46 F8 E8 9E EB 70 8C 5E FA C7 46 F8 07 9F EB 66 F....p.^..F....f
0800:2F30 8C 5E FA C7 46 F8 31 9F EB 5C 8C 5E FA C7 46 F8 .^..F.1..\.^..F.
0800:2F40 40 9F EB 52 8C 5E FA C7 46 F8 53 9F 8C 5E FE C7 @..R.^..F.S..^..
0800:2F50 46 FC F8 99 EB 40 8C 5E FA C7 46 F8 67 9F EB 36 F....@.^..F.g..6
0800:2F60 8C 5E FA C7 46 F8 7B 9F EB 2C 8C 5E FA C7 46 F8 .^..F.{..,.^..F.
0800:2F70 96 9F EB 22 8C 5E FA C7 46 F8 B0 9F EB 18 8C 5E ...".^..F......^
0800:2F80 FA C7 46 F8 CC 9F FF 76 06 E8 41 FD 8B D8 1E 07 ..F....v..A.....
0800:2F90 8C 46 FE 89 5E FC 8B 46 FC 0B 46 FE 74 25 1E B8 .F..^..F..F.t%..
0800:2FA0 65 9D 50 FF 76 FA FF 76 F8 FF 76 FE FF 76 FC E8 e.P.v..v..v..v..
0800:2FB0 CC FD 52 50 1E B8 DD 9F 50 E8 44 FD B8 65 9D 8C ..RP....P.D..e..
0800:2FC0 DA EB 0E 1E B8 65 9D 50 FF 76 FA FF 76 F8 E8 2F .....e.P.v..v../
0800:2FD0 FD 1F 8B E5 5D CB 56 1E B8 00 08 8E D8 8B 36 06 ....].V.......6.
0800:2FE0 9C C7 06 06 9C 00 00 8B C6 1F 5E CB             ..........^.   

;; fn0800_2FEC: 0800:2FEC
;;   Called from:
;;     0800:3557 (in fn0800_3542)
fn0800_2FEC proc
	cmp	word ptr [9C19h],0h
	jz	2FFDh

l0800_2FF3:
	push	ds
	mov	ax,9FDFh
	push	ax
	call	2DACh
	jmp	3005h

l0800_2FFD:
	push	ds
	mov	ax,0A006h
	push	ax
	call	2DACh

l0800_3005:
	mov	ax,0FFFFh
	push	ax
	call	far 0800h:6D94h
	pop	cx
	retf

;; fn0800_3010: 0800:3010
;;   Called from:
;;     0800:34C9 (in fn0800_3454)
;;     0800:37AB (in fn0800_3632)
;;     0800:43EF (in fn0800_42F6)
fn0800_3010 proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+8h]
	call	far 0800h:6DACh
	pop	cx
	mov	cx,ax
	or	cx,dx
	jz	3030h

l0800_3022:
	or	ax,ax
	jnz	3030h

l0800_3026:
	mov	bx,ds
	cmp	bx,dx
	jnz	3030h

l0800_302C:
	xor	cx,cx
	xor	dx,dx

l0800_3030:
	les	bx,[bp+4h]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx
	mov	ax,1h
	jcxz	3040h

l0800_303F:
	dec	ax

l0800_3040:
	pop	bp
	ret

;; fn0800_3042: 0800:3042
;;   Called from:
;;     0800:3200 (in fn0800_3172)
;;     0800:3518 (in fn0800_3454)
;;     0800:37CC (in fn0800_3632)
;;     0800:3B2C (in fn0800_3B02)
;;     0800:3B44 (in fn0800_3B02)
;;     0800:3B7B (in fn0800_3B02)
;;     0800:4376 (in fn0800_42F6)
;;     0800:4435 (in fn0800_42F6)
;;     0800:445C (in fn0800_42F6)
fn0800_3042 proc
	push	bp
	mov	bp,sp
	les	bx,[bp+4h]
	mov	ax,es:[bx]
	or	ax,es:[bx+2h]
	jz	3068h

l0800_3051:
	cmp	word ptr [bp+8h],0h
	jz	3068h

l0800_3057:
	push	word ptr [bp+8h]
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 0800h:6DA0h
	mov	sp,bp

l0800_3068:
	les	bx,[bp+4h]
	mov	word ptr es:[bx+2h],0h
	mov	word ptr es:[bx],0h
	pop	bp
	ret

;; fn0800_3078: 0800:3078
;;   Called from:
;;     0800:313D (in fn0800_30B4)
;;     0800:3225 (in fn0800_3172)
fn0800_3078 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+0Ah]
	les	bx,[bp+6h]
	add	si,es:[bx]
	mov	ax,si
	and	ax,0Fh
	sub	es:[bx],ax
	mov	dx,[bp+0Ch]
	mov	ax,si
	mov	cl,4h
	shr	ax,cl
	add	dx,ax
	and	si,0Fh
	jz	30ACh

l0800_309E:
	mov	cx,[bp+4h]
	push	ds
	mov	ds,dx
	mov	es,dx
	xor	di,di
	cld

l0800_30A9:
	rep movsb

l0800_30AB:
	pop	ds

l0800_30AC:
	xor	ax,ax
	pop	di
	pop	si
	pop	bp
	ret	0Ah

;; fn0800_30B4: 0800:30B4
;;   Called from:
;;     0800:34FC (in fn0800_3454)
;;     0800:6DC3 (in fn0800_6DBC)
fn0800_30B4 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	push	ds
	mov	ax,800h
	mov	ds,ax
	les	bx,[bp+6h]
	add	bx,80h
	mov	[bp-2h],es
	mov	[bp-4h],bx
	cmp	word ptr [9C19h],3h
	jnz	30D8h

l0800_30D5:
	jmp	3166h

l0800_30D8:
	mov	bx,[bp+6h]
	cmp	word ptr es:[bx],6B70h
	jz	30EBh

l0800_30E2:
	mov	ax,0FFFCh
	mov	[9C06h],ax
	jmp	316Ch

l0800_30EB:
	les	bx,[bp-4h]
	cmp	byte ptr es:[bx+6h],2h
	jc	30FCh

l0800_30F5:
	cmp	byte ptr es:[bx+8h],1h
	jbe	3104h

l0800_30FC:
	mov	ax,0FFEEh
	mov	[9C06h],ax
	jmp	316Ch

l0800_3104:
	xor	si,si
	jmp	3160h

l0800_3108:
	mov	dx,[bp-2h]
	mov	ax,[bp-4h]
	add	ax,0Bh
	push	dx
	push	ax
	push	ds
	mov	ax,si
	mov	dx,1Ah
	mul	dx
	add	ax,9C61h
	push	ax
	mov	ax,8h
	push	ax
	call	2D1Fh
	or	ax,ax
	jnz	315Fh

l0800_312A:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	les	bx,[bp-4h]
	push	word ptr es:[bx+4h]
	call	3078h
	push	dx
	push	ax
	mov	ax,si
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	pop	ax
	pop	dx
	mov	[bx+9C70h],dx
	mov	[bx+9C6Eh],ax
	mov	word ptr [9C06h],0h
	mov	ax,si
	jmp	316Ch

l0800_315F:
	inc	si

l0800_3160:
	cmp	si,[9C56h]
	jl	3108h

l0800_3166:
	mov	ax,0FFF5h
	mov	[9C06h],ax

l0800_316C:
	pop	ds
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn0800_3172: 0800:3172
;;   Called from:
;;     0800:4446 (in fn0800_42F6)
fn0800_3172 proc
	push	bp
	mov	bp,sp
	sub	sp,0Eh
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	les	bx,[bp+6h]
	cmp	word ptr es:[bx],4B50h
	jnz	31ACh

l0800_318A:
	les	di,[bp+6h]
	mov	cx,0FFFFh
	mov	al,1Ah
	cld

l0800_3193:
	repne scasb

l0800_3195:
	mov	[bp-0Eh],di
	mov	[bp-0Ch],es
	les	bx,[bp-0Eh]
	cmp	byte ptr es:[bx+8h],1h
	jc	31ACh

l0800_31A5:
	cmp	byte ptr es:[bx+0Ah],1h
	jbe	31B5h

l0800_31AC:
	mov	ax,0FFF3h
	mov	[9C06h],ax
	jmp	3251h

l0800_31B5:
	les	bx,[bp-0Eh]
	inc	bx
	inc	bx
	mov	[bp-8h],es
	mov	[bp-0Ah],bx
	mov	word ptr [bp-6h],9A6Dh
	mov	word ptr [bp-4h],0h
	jmp	3243h
0800:31CC                                     90                      .  

l0800_31CD:
	les	bx,[bp-0Ah]
	mov	dx,es:[bx+2h]
	mov	ax,es:[bx]
	mov	bx,[bp-6h]
	push	dx
	push	ax
	push	ds
	pop	es
	pop	ax
	pop	dx
	cmp	dx,es:[bx+2h]
	jnz	323Ch

l0800_31E6:
	cmp	ax,es:[bx]
	jnz	323Ch

l0800_31EB:
	mov	ax,[bp-4h]
	mov	dx,0Fh
	mul	dx
	add	ax,9A63h
	mov	[bp-2h],ax
	mov	bx,ax
	push	word ptr [bx+8h]
	push	ds
	push	ax
	call	3042h
	add	sp,6h
	mov	bx,[bp-2h]
	mov	word ptr [bx+2h],0h
	mov	word ptr [bx],0h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp-0Ch]
	push	word ptr [bp-0Eh]
	les	bx,[bp-0Eh]
	push	word ptr es:[bx+6h]
	call	3078h
	mov	bx,[bp-2h]
	mov	[bx+6h],dx
	mov	[bx+4h],ax
	mov	word ptr [bx+8h],0h
	mov	ax,[bp-4h]
	inc	ax
	jmp	3251h

l0800_323C:
	add	word ptr [bp-6h],0Fh
	inc	word ptr [bp-4h]

l0800_3243:
	cmp	word ptr [bp-4h],14h
	jnc	324Bh

l0800_3249:
	jmp	31CDh

l0800_324B:
	mov	ax,0FFF5h
	mov	[9C06h],ax

l0800_3251:
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
0800:3258                         55 8B EC 56 1E B8 00 08         U..V....
0800:3260 8E D8 8B 36 5F 9A 83 3E 19 9C 00 75 07 81 7E 06 ...6_..>...u..~.
0800:3270 00 01 73 08 C7 06 06 9C F5 FF EB 06 8B 46 06 A3 ..s..........F..
0800:3280 5F 9A 8B C6 1F 5E 5D CB 55 8B EC 1E B8 00 08 8E _....^].U.......
0800:3290 D8 C4 5E 08 26 C7 07 00 00 8B 46 06 40 3D 0B 00 ..^.&.....F.@=..
0800:32A0 77 72 8B D8 D1 E3 2E FF A7 AB 32 07 33 14 33 C3 wr........2.3.3.
0800:32B0 32 CD 32 FD 32 FD 32 E1 32 FD 32 F3 32 CD 32 D7 2.2.2.2.2.2.2.2.
0800:32C0 32 F3 32 C4 5E 0C 26 C7 07 04 00 EB 57 C4 5E 0C 2.2.^.&.....W.^.
0800:32D0 26 C7 07 05 00 EB 4D C4 5E 0C 26 C7 07 02 00 EB &.....M.^.&.....
0800:32E0 43 C4 5E 08 26 C7 07 03 00 C4 5E 0C 26 C7 07 03 C.^.&.....^.&...
0800:32F0 00 EB 31 C4 5E 0C 26 C7 07 00 00 EB 27 C4 5E 0C ..1.^.&.....'.^.
0800:3300 26 C7 07 01 00 EB 1D 9A A0 4A 00 08 C4 5E 0C 26 &........J...^.&
0800:3310 89 07 EB 10 C4 5E 08 26 C7 07 FF FF C4 5E 0C 26 .....^.&.....^.&
0800:3320 C7 07 FF FF 1F 5D CB 55 8B EC 1E B8 00 08 8E D8 .....].U........
0800:3330 FF 76 0C FF 76 0A FF 76 08 FF 76 06 9A CD 47 00 .v..v..v..v...G.
0800:3340 08 83 C4 08 C4 5E 06 26 83 3F 00 7D 09 B8 FE FF .....^.&.?.}....
0800:3350 26 89 07 A3 06 9C 1F 5D CB                      &......].      

;; fn0800_3359: 0800:3359
;;   Called from:
;;     0800:385A (in fn0800_3632)
;;     0800:3B60 (in fn0800_3B02)
fn0800_3359 proc
	mov	word ptr [9B95h],800h
	mov	word ptr [9B93h],2FECh
	mov	word ptr [9B91h],800h
	mov	word ptr [9B8Fh],2FECh
	mov	word ptr [9BECh],9BAAh
	mov	word ptr [9BF4h],0h
	mov	word ptr [9BF2h],0h
	mov	word ptr [9C0Ah],0h
	mov	word ptr [9C08h],0h
	mov	word ptr [9BF8h],0h
	mov	word ptr [9BF6h],0h
	mov	word ptr [9BFEh],0h
	mov	word ptr [9BFCh],0h
	mov	bx,[9BECh]
	mov	word ptr [bx+0Eh],0h
	mov	word ptr [bx+0Ch],0h
	mov	word ptr [bx+10h],0h
	mov	word ptr [bx+28h],0h
	mov	word ptr [bx+26h],0h
	mov	word ptr [bx+2Ah],0h
	mov	byte ptr [bx+16h],0h
	mov	ax,1h
	mov	[9C02h],ax
	mov	[9C00h],ax
	mov	word ptr [9C1Dh],0h
	mov	word ptr [9C19h],0h
	ret

;; fn0800_33E3: 0800:33E3
;;   Called from:
;;     0800:34B9 (in fn0800_3454)
;;     0800:43C9 (in fn0800_42F6)
fn0800_33E3 proc
	push	bp
	mov	bp,sp
	sub	sp,64h
	les	bx,[bp+6h]
	mov	word ptr es:[bx],0h
	push	ss
	lea	ax,[bp-64h]
	push	ax
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	2D7Eh
	push	ss
	lea	ax,[bp-64h]
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	call	2DC5h
	mov	[9C06h],ax
	or	ax,ax
	jz	3447h

l0800_341D:
	push	ss
	lea	ax,[bp-64h]
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	2D7Eh
	push	ss
	lea	ax,[bp-64h]
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	call	2DC5h
	mov	[9C06h],ax
	or	ax,ax
	jnz	344Bh

l0800_3447:
	xor	ax,ax
	jmp	344Eh

l0800_344B:
	mov	ax,1h

l0800_344E:
	mov	sp,bp
	pop	bp
	ret	0Eh

;; fn0800_3454: 0800:3454
;;   Called from:
;;     0800:3776 (in fn0800_3632)
fn0800_3454 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+8h]
	push	ds
	mov	ax,9A01h
	push	ax
	push	ds
	mov	ax,si
	mov	dx,1Ah
	mul	dx
	add	ax,9C58h
	push	ax
	push	ds
	mov	ax,0A043h
	push	ax
	call	2D7Eh
	mov	ax,si
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	mov	dx,[bx+9C70h]
	mov	ax,[bx+9C6Eh]
	mov	[9B95h],dx
	mov	[9B93h],ax
	or	dx,ax
	jz	34A5h

l0800_3490:
	mov	word ptr [9BF8h],0h
	mov	word ptr [9BF6h],0h
	mov	word ptr [9BFAh],0h
	jmp	353Ah

l0800_34A5:
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	push	ds
	mov	ax,9A01h
	push	ax
	push	ds
	mov	ax,9BFAh
	push	ax
	mov	ax,0FFFCh
	push	ax
	call	33E3h
	or	ax,ax
	jnz	351Eh

l0800_34C0:
	push	word ptr [9BFAh]
	push	ds
	mov	ax,9BF6h
	push	ax
	call	3010h
	add	sp,6h
	or	ax,ax
	jz	34DEh

l0800_34D3:
	call	2DBCh
	mov	word ptr [9C06h],0FFFBh
	jmp	351Eh

l0800_34DE:
	xor	ax,ax
	push	ax
	push	word ptr [9BFAh]
	push	word ptr [9BF8h]
	push	word ptr [9BF6h]
	call	2E0Ch
	or	ax,ax
	jnz	350Fh

l0800_34F4:
	push	word ptr [9BF8h]
	push	word ptr [9BF6h]
	push	cs
	call	30B4h
	pop	cx
	pop	cx
	cmp	ax,si
	jz	3522h

l0800_3506:
	call	2DBCh
	mov	word ptr [9C06h],0FFFCh

l0800_350F:
	push	word ptr [9BFAh]
	push	ds
	mov	ax,9BF6h
	push	ax
	call	3042h
	add	sp,6h

l0800_351E:
	xor	ax,ax
	jmp	353Dh

l0800_3522:
	mov	ax,si
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	les	bx,[bx+9C6Eh]
	mov	[9B95h],es
	mov	[9B93h],bx
	call	2DBCh

l0800_353A:
	mov	ax,1h

l0800_353D:
	pop	si
	pop	bp
	ret	6h

;; fn0800_3542: 0800:3542
;;   Called from:
;;     0800:3889 (in fn0800_3632)
fn0800_3542 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	cmp	word ptr [9C19h],0h
	jnz	355Bh

l0800_3557:
	push	cs
	call	2FECh

l0800_355B:
	mov	ax,1h
	push	ax
	mov	bx,[9BEAh]
	push	word ptr [bx+4h]
	push	word ptr [bx+2h]
	xor	ax,ax
	push	ax
	push	ax
	call	far 0800h:3BBEh
	add	sp,0Ah
	call	far 0800h:4A62h
	mov	[bp-2h],dx
	mov	[bp-4h],ax
	push	si
	push	di
	push	ds
	pop	es
	lds	si,[bp-4h]
	lea	di,[9C3Bh]
	mov	cx,11h
	cld

l0800_358F:
	rep movsb

l0800_3591:
	push	es
	pop	ds
	pop	di
	pop	si
	push	ds
	mov	ax,9C3Bh
	push	ax
	call	far 0800h:408Fh
	pop	cx
	pop	cx
	call	far 0800h:4A47h
	cmp	ax,1h
	jz	35B4h

l0800_35AB:
	xor	ax,ax
	push	ax
	call	far 0800h:403Bh
	pop	cx

l0800_35B4:
	mov	byte ptr [9C12h],0h
	call	far 0800h:4A2Ch
	push	ax
	call	far 0800h:4A0Bh
	pop	cx
	call	far 0800h:4A2Ch
	push	ax
	push	ds
	mov	ax,9DC9h
	push	ax
	call	far 0800h:3F0Bh
	add	sp,6h
	call	far 0800h:4A2Ch
	push	ax
	mov	ax,1h
	push	ax
	call	far 0800h:3EBAh
	pop	cx
	pop	cx
	mov	ax,1h
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	call	far 0800h:3E06h
	add	sp,6h
	mov	ax,1h
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	call	far 0800h:42F6h
	add	sp,6h
	mov	ax,2h
	push	ax
	xor	ax,ax
	push	ax
	call	far 0800h:42B5h
	pop	cx
	pop	cx
	xor	ax,ax
	push	ax
	call	far 0800h:46A1h
	pop	cx
	xor	ax,ax
	push	ax
	push	ax
	call	far 0800h:3CCFh
	pop	cx
	pop	cx
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn0800_3632: 0800:3632
;;   Called from:
;;     0800:01BA (in fn0800_019F)
fn0800_3632 proc
	push	bp
	mov	bp,sp
	sub	sp,8h
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	word ptr [bp-2h],0h
	mov	ax,0EFEh
	mov	es,ax
	mov	dx,es:[2A14h]
	mov	ax,0EFEh
	mov	es,ax
	mov	ax,es:[2A12h]
	add	ax,20h
	mov	cl,4h
	shr	ax,cl
	add	dx,ax
	xor	ax,ax
	mov	[9B91h],dx
	mov	[9B8Fh],ax
	les	bx,[bp+6h]
	cmp	es:[bx],ax
	jnz	36CCh

l0800_3672:
	jmp	36BAh

l0800_3674:
	mov	ax,[bp-2h]
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	mov	ax,[bx+9C6Ah]
	or	ax,[bx+9C6Ch]
	jz	36B7h

l0800_3688:
	mov	ax,[bp-2h]
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	call	dword ptr [bx+9C6Ah]
	mov	[bp-4h],ax
	or	ax,ax
	jl	36B7h

l0800_369D:
	mov	ax,[bp-2h]
	mov	[9BEEh],ax
	add	ax,80h
	les	bx,[bp+6h]
	mov	es:[bx],ax
	mov	ax,[bp-4h]
	les	bx,[bp+0Ah]
	mov	es:[bx],ax
	jmp	36CCh

l0800_36B7:
	inc	word ptr [bp-2h]

l0800_36BA:
	mov	ax,[bp-2h]
	cmp	ax,[9C56h]
	jge	36CCh

l0800_36C3:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx],0h
	jz	3674h

l0800_36CC:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	mov	ax,9BEEh
	push	ax
	call	far 0800h:4766h
	add	sp,0Ch
	les	bx,[bp+6h]
	cmp	word ptr es:[bx],0h
	jge	36FCh

l0800_36EE:
	mov	word ptr [9C06h],0FFFEh
	mov	word ptr es:[bx],0FFFEh
	jmp	385Ah

l0800_36FC:
	les	bx,[bp+0Ah]
	mov	ax,es:[bx]
	mov	[9BF0h],ax
	mov	ax,[bp+0Eh]
	or	ax,[bp+10h]
	jnz	3714h

l0800_370D:
	mov	byte ptr [9A0Eh],0h
	jmp	375Ah

l0800_3714:
	push	ds
	mov	ax,9A0Eh
	push	ax
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	call	2D00h
	cmp	byte ptr [9A0Eh],0h
	jz	375Ah

l0800_3729:
	push	ds
	mov	ax,9A0Eh
	push	ax
	call	2D63h
	mov	[bp-6h],dx
	mov	[bp-8h],ax
	les	bx,[bp-8h]
	dec	bx
	cmp	byte ptr es:[bx],3Ah
	jz	375Ah

l0800_3741:
	mov	bx,ax
	dec	bx
	cmp	byte ptr es:[bx],5Ch
	jz	375Ah

l0800_374A:
	mov	bx,ax
	mov	byte ptr es:[bx],5Ch
	inc	word ptr [bp-8h]
	mov	bx,[bp-8h]
	mov	byte ptr es:[bx],0h

l0800_375A:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx],80h
	jle	376Dh

l0800_3764:
	mov	ax,es:[bx]
	and	ax,7Fh
	mov	[9BEEh],ax

l0800_376D:
	push	word ptr [9BEEh]
	push	ds
	mov	ax,9A0Eh
	push	ax
	call	3454h
	or	ax,ax
	jnz	3789h

l0800_377D:
	mov	ax,[9C06h]
	les	bx,[bp+6h]
	mov	es:[bx],ax
	jmp	385Ah

l0800_3789:
	push	si
	push	di
	push	ds
	pop	es
	cld
	mov	di,9BAAh
	mov	ds,[9C0Eh]
	mov	cx,3Fh
	xor	al,al

l0800_379A:
	rep stosb

l0800_379C:
	mov	ax,es
	mov	ds,ax
	pop	di
	pop	si
	push	word ptr [9A5Fh]
	push	ds
	mov	ax,9BB6h
	push	ax
	call	3010h
	add	sp,6h
	or	ax,ax
	jz	37D5h

l0800_37B5:
	mov	word ptr [9C06h],0FFFBh
	les	bx,[bp+6h]
	mov	word ptr es:[bx],0FFFBh
	push	word ptr [9BFAh]
	push	ds
	mov	ax,9BF6h
	push	ax
	call	3042h
	add	sp,6h
	jmp	385Ah

l0800_37D5:
	mov	byte ptr [9BABh],0h
	mov	byte ptr [9BC0h],0h
	les	bx,[9BB6h]
	mov	[9BFEh],es
	mov	[9BFCh],bx
	mov	[9BD2h],es
	mov	[9BD0h],bx
	mov	ax,[9A5Fh]
	mov	[9BBAh],ax
	mov	[9BD4h],ax
	mov	[9BC6h],ds
	mov	word ptr [9BC4h],9C06h
	cmp	byte ptr [9BE9h],0h
	jz	381Bh

l0800_380D:
	push	ds
	mov	ax,9BAAh
	push	ax
	call	far 0800h:4573h
	pop	cx
	pop	cx
	jmp	3827h

l0800_381B:
	push	ds
	mov	ax,9BAAh
	push	ax
	call	far 0800h:456Eh
	pop	cx
	pop	cx

l0800_3827:
	mov	ax,13h
	push	ax
	mov	dx,[9C0Eh]
	mov	ax,[9C0Ch]
	push	dx
	push	ax
	push	ds
	mov	ax,9B97h
	push	ax
	call	2E45h
	add	sp,0Ah
	push	ds
	mov	ax,9BAAh
	push	ax
	call	far 0800h:480Ah
	pop	cx
	pop	cx
	cmp	byte ptr [9B97h],0h
	jz	385Fh

l0800_3852:
	mov	al,[9B97h]
	mov	ah,0h
	mov	[9C06h],ax

l0800_385A:
	call	3359h
	jmp	3893h

l0800_385F:
	mov	word ptr [9BECh],9BAAh
	mov	word ptr [9BEAh],9B97h
	call	far 0800h:4AA0h
	mov	[9C04h],ax
	mov	ax,[9BA5h]
	mov	[9C00h],ax
	mov	word ptr [9C02h],2710h
	mov	al,3h
	mov	[9BE9h],al
	mov	ah,0h
	mov	[9C19h],ax
	push	cs
	call	3542h
	mov	word ptr [9C06h],0h

l0800_3893:
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
0800:389A                               55 8B EC 83 EC 04           U.....
0800:38A0 56 1E B8 00 08 8E D8 FF 76 08 FF 76 06 E8 B3 F4 V.......v..v....
0800:38B0 48 89 56 FE 89 46 FC EB 0A C4 5E FC 26 C6 07 00 H.V..F....^.&...
0800:38C0 FF 4E FC C4 5E FC 26 80 3F 20 75 07 8B C3 3B 46 .N..^.&.? u...;F
0800:38D0 06 73 E6 FF 76 08 FF 76 06 E8 64 F4 33 F6 EB 3E .s..v..v..d.3..>
0800:38E0 FF 76 08 FF 76 06 1E 8B C6 BA 1A 00 F7 E2 05 58 .v..v..........X
0800:38F0 9C 50 B8 08 00 50 E8 26 F4 0B C0 75 20 8B 56 0C .P...P.&...u .V.
0800:3900 8B 46 0A 52 50 8B C6 BA 1A 00 F7 E2 8B D8 58 5A .F.RP.........XZ
0800:3910 89 97 6C 9C 89 87 6A 9C 8B C6 40 EB 65 46 3B 36 ..l...j...@.eF;6
0800:3920 56 9C 7C BC 83 3E 56 9C 0A 7C 08 B8 F5 FF A3 06 V.|..>V..|......
0800:3930 9C EB 4F 1E A1 56 9C BA 1A 00 F7 E2 05 58 9C 50 ..O..V.......X.P
0800:3940 FF 76 08 FF 76 06 E8 B7 F3 1E A1 56 9C BA 1A 00 .v..v......V....
0800:3950 F7 E2 05 61 9C 50 FF 76 08 FF 76 06 E8 A1 F3 8B ...a.P.v..v.....
0800:3960 56 0C 8B 46 0A 52 50 A1 56 9C BA 1A 00 F7 E2 8B V..F.RP.V.......
0800:3970 D8 58 5A 89 97 6C 9C 89 87 6A 9C A1 56 9C FF 06 .XZ..l...j..V...
0800:3980 56 9C 1F 5E 8B E5 5D CB 55 8B EC 83 EC 04 56 1E V..^..].U.....V.
0800:3990 B8 00 08 8E D8 FF 76 08 FF 76 06 E8 C5 F3 48 89 ......v..v....H.
0800:39A0 56 FE 89 46 FC EB 0A C4 5E FC 26 C6 07 00 FF 4E V..F....^.&....N
0800:39B0 FC C4 5E FC 26 80 3F 20 75 07 8B C3 3B 46 06 73 ..^.&.? u...;F.s
0800:39C0 E6 FF 76 08 FF 76 06 E8 76 F3 33 F6 EB 23 FF 76 ..v..v..v.3..#.v
0800:39D0 08 FF 76 06 1E 8B C6 BA 0F 00 F7 E2 05 6D 9A 50 ..v..........m.P
0800:39E0 B8 04 00 50 E8 38 F3 0B C0 75 05 8B C6 40 EB 3B ...P.8...u...@.;
0800:39F0 46 3B 36 61 9A 7C D7 83 3E 61 9A 14 7C 08 B8 F5 F;6a.|..>a..|...
0800:3A00 FF A3 06 9C EB 25 8B 5E 06 8B 57 02 8B 07 52 50 .....%.^..W...RP
0800:3A10 A1 61 9A BA 0F 00 F7 E2 8B D8 58 5A 89 97 6F 9A .a........XZ..o.
0800:3A20 89 87 6D 9A FF 06 61 9A A1 61 9A 1F 5E 8B E5 5D ..m...a..a..^..]
0800:3A30 CB 55 8B EC 56 1E B8 00 08 8E D8 8B 76 06 83 3E .U..V.......v..>
0800:3A40 19 9C 02 74 6E 3B 36 04 9C 7E 08 C7 06 06 9C F6 ...tn;6..~......
0800:3A50 FF EB 60 A1 F2 9B 0B 06 F4 9B 74 18 C4 1E F2 9B ..`.......t.....
0800:3A60 8C 06 91 9B 89 1E 8F 9B C7 06 F4 9B 00 00 C7 06 ................
0800:3A70 F2 9B 00 00 89 36 F0 9B 56 9A E3 45 00 08 59 B8 .....6..V..E..Y.
0800:3A80 02 00 50 8B 16 0E 9C A1 0C 9C 52 50 1E B8 97 9B ..P.......RP....
0800:3A90 50 E8 B1 F3 83 C4 0A C7 06 EA 9B 97 9B C7 06 EC P...............
0800:3AA0 9B AA 9B A1 A5 9B A3 00 9C C7 06 02 9C 10 27 0E ..............'.
0800:3AB0 E8 8F FA 1F 5E 5D CB 1E B8 00 08 8E D8 80 3E E9 ....^]........>.
0800:3AC0 9B 00 75 0B C7 06 06 9C FF FF B8 FF FF EB 03 A1 ..u.............
0800:3AD0 F0 9B 1F CB                                     ....           

;; fn0800_3AD4: 0800:3AD4
;;   Called from:
;;     0800:3B1F (in fn0800_3B02)
fn0800_3AD4 proc
	push	ds
	mov	ax,800h
	mov	ds,ax
	call	far 0800h:4619h
	mov	ax,[9BF2h]
	or	ax,[9BF4h]
	jnz	3B00h

l0800_3AE8:
	les	bx,[9B8Fh]
	mov	[9BF4h],es
	mov	[9BF2h],bx
	mov	word ptr [9B91h],800h
	mov	word ptr [9B8Fh],2FECh

l0800_3B00:
	pop	ds
	retf

;; fn0800_3B02: 0800:3B02
;;   Called from:
;;     0800:01DC (in fn0800_01CE)
fn0800_3B02 proc
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	cmp	byte ptr [9BE9h],0h
	jnz	3B1Ah

l0800_3B11:
	mov	word ptr [9C06h],0FFFFh
	jmp	3BA2h

l0800_3B1A:
	mov	byte ptr [9BE9h],0h
	push	cs
	call	3AD4h
	push	word ptr [9A5Fh]
	push	ds
	mov	ax,9BFCh
	push	ax
	call	3042h
	add	sp,6h
	mov	ax,[9BF6h]
	or	ax,[9BF8h]
	jz	3B60h

l0800_3B3B:
	push	word ptr [9BFAh]
	push	ds
	mov	ax,9BF6h
	push	ax
	call	3042h
	add	sp,6h
	mov	ax,[9BEEh]
	mov	dx,1Ah
	mul	dx
	mov	bx,ax
	mov	word ptr [bx+9C70h],0h
	mov	word ptr [bx+9C6Eh],0h

l0800_3B60:
	call	3359h
	xor	di,di
	mov	si,9A63h
	jmp	3B9Dh

l0800_3B6A:
	cmp	byte ptr [si+0Ah],0h
	jz	3B99h

l0800_3B70:
	cmp	word ptr [si+8h],0h
	jz	3B99h

l0800_3B76:
	push	word ptr [si+8h]
	push	ds
	push	si
	call	3042h
	add	sp,6h
	mov	word ptr [si+2h],0h
	mov	word ptr [si],0h
	mov	word ptr [si+6h],0h
	mov	word ptr [si+4h],0h
	mov	word ptr [si+8h],0h

l0800_3B99:
	inc	di
	add	si,0Fh

l0800_3B9D:
	cmp	di,14h
	jc	3B6Ah

l0800_3BA2:
	pop	ds
	pop	di
	pop	si
	retf
0800:3BA6                   1E B8 00 08 8E D8 9A 2F 48 00       ......./H.
0800:3BB0 08 33 C0 50 50 9A CF 3C 00 08 59 59 1F CB       .3.PP..<..YY.. 

;; fn0800_3BBE: 0800:3BBE
;;   Called from:
;;     0800:0233 (in fn0800_0215)
;;     0800:0672 (in fn0800_0635)
;;     0800:356D (in fn0800_3542)
fn0800_3BBE proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	di,[bp+8h]
	mov	si,[bp+6h]
	or	si,si
	jl	3BF9h

l0800_3BD3:
	or	di,di
	jl	3BF9h

l0800_3BD7:
	mov	bx,[9BEAh]
	mov	ax,[bx+2h]
	cmp	ax,[bp+0Ah]
	jc	3BF9h

l0800_3BE3:
	mov	ax,[bx+4h]
	cmp	ax,[bp+0Ch]
	jc	3BF9h

l0800_3BEB:
	mov	ax,[bp+0Ah]
	cmp	ax,si
	jl	3BF9h

l0800_3BF2:
	mov	ax,[bp+0Ch]
	cmp	ax,di
	jge	3C01h

l0800_3BF9:
	mov	word ptr [9C06h],0FFF5h
	jmp	3C37h

l0800_3C01:
	mov	[9C1Fh],si
	mov	[9C21h],di
	mov	ax,[bp+0Ah]
	mov	[9C23h],ax
	mov	ax,[bp+0Ch]
	mov	[9C25h],ax
	mov	ax,[bp+0Eh]
	mov	[9C27h],ax
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	di
	push	si
	call	far 0800h:45B7h
	add	sp,0Ah
	xor	ax,ax
	push	ax
	push	ax
	call	far 0800h:3CCFh
	pop	cx
	pop	cx

l0800_3C37:
	pop	ds
	pop	di
	pop	si
	pop	bp
	retf
0800:3C3C                                     55 8B EC 1E             U...
0800:3C40 B8 00 08 8E D8 C4 5E 06 06 53 BB 1F 9C 1E 53 B9 ......^..S....S.
0800:3C50 0A 00 9A 7A 6F 00 08 1F 5D CB 55 8B EC 83 EC 04 ...zo...].U.....
0800:3C60 1E B8 00 08 8E D8 8B 16 31 9C A1 2F 9C 89 56 FE ........1../..V.
0800:3C70 89 46 FC 33 C0 50 50 9A BA 3E 00 08 59 59 A1 25 .F.3.PP..>..YY.%
0800:3C80 9C 2B 06 21 9C 50 A1 23 9C 2B 06 1F 9C 50 33 C0 .+.!.P.#.+...P3.
0800:3C90 50 50 9A E3 48 00 08 83 C4 08 83 7E FC 0C 75 12 PP..H......~..u.
0800:3CA0 FF 76 FE 1E B8 33 9C 50 9A 0B 3F 00 08 83 C4 06 .v...3.P..?.....
0800:3CB0 EB 0D FF 76 FE FF 76 FC 9A BA 3E 00 08 59 59 33 ...v..v...>..YY3
0800:3CC0 C0 50 50 9A CF 3C 00 08 59 59 1F 8B E5 5D CB    .PP..<..YY...].

;; fn0800_3CCF: 0800:3CCF
;;   Called from:
;;     0800:3624 (in fn0800_3542)
;;     0800:3C30 (in fn0800_3BBE)
fn0800_3CCF proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,800h
	mov	ds,ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:4846h
	pop	cx
	pop	cx
	mov	ax,[bp+6h]
	mov	[9C15h],ax
	mov	ax,[bp+8h]
	mov	[9C17h],ax
	pop	ds
	pop	bp
	retf
0800:3CF4             55 8B EC 1E B8 00 08 8E D8 A1 17 9C     U...........
0800:3D00 03 46 08 50 A1 15 9C 03 46 06 50 0E E8 C0 FF 59 .F.P....F.P....Y
0800:3D10 59 1F 5D CB 1E B8 00 08 8E D8 A1 15 9C 1F CB 1E Y.].............
0800:3D20 B8 00 08 8E D8 A1 17 9C 1F CB 1E B8 00 08 8E D8 ................
0800:3D30 8B 1E EA 9B 8B 47 02 1F CB 1E B8 00 08 8E D8 8B .....G..........
0800:3D40 1E EA 9B 8B 47 04 1F CB 1E B8 00 08 8E D8 83 3E ....G..........>
0800:3D50 19 9C 03 74 06 33 D2 8B C2 EB 0D A1 EE 9B BA 1A ...t.3..........
0800:3D60 00 F7 E2 05 61 9C 8C DA 1F CB 55 8B EC 1E B8 00 ....a.....U.....
0800:3D70 08 8E D8 1E B8 D1 9D 50 FF 76 06 9A 7F 4A 00 08 .......P.v...J..
0800:3D80 59 52 50 E8 7A EF B8 D1 9D 8C DA 1F 5D CB 55 8B YRP.z.......].U.
0800:3D90 EC 1E B8 00 08 8E D8 FF 76 08 FF 76 06 9A 63 48 ........v..v..cH
0800:3DA0 00 08 59 59 FF 76 08 FF 76 06 0E E8 21 FF 59 59 ..YY.v..v...!.YY
0800:3DB0 1F 5D CB 55 8B EC 1E B8 00 08 8E D8 A1 17 9C 03 .].U............
0800:3DC0 46 08 50 A1 15 9C 03 46 06 50 9A 63 48 00 08 59 F.P....F.P.cH..Y
0800:3DD0 59 A1 17 9C 03 46 08 50 A1 15 9C 03 46 06 50 0E Y....F.P....F.P.
0800:3DE0 E8 EC FE 59 59 1F 5D CB 55 8B EC 1E B8 00 08 8E ...YY.].U.......
0800:3DF0 D8 C4 5E 06 06 53 BB 29 9C 1E 53 B9 06 00 9A 7A ..^..S.)..S....z
0800:3E00 6F 00 08 1F 5D CB                               o...].         

;; fn0800_3E06: 0800:3E06
;;   Called from:
;;     0800:35F1 (in fn0800_3542)
fn0800_3E06 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	di,[bp+0Ah]
	mov	si,[bp+6h]
	cmp	si,4h
	ja	3E21h

l0800_3E1C:
	cmp	di,3h
	jbe	3E29h

l0800_3E21:
	mov	word ptr [9C06h],0FFF5h
	jmp	3E42h

l0800_3E29:
	mov	[9C29h],si
	mov	ax,[bp+8h]
	mov	[9C2Bh],ax
	mov	[9C2Dh],di
	push	di
	push	ax
	push	si
	call	far 0800h:4B3Bh
	add	sp,6h

l0800_3E42:
	pop	ds
	pop	di
	pop	si
	pop	bp
	retf
0800:3E47                      55 8B EC 56 57 1E B8 00 08        U..VW....
0800:3E50 8E D8 8B 7E 08 8B 76 06 57 FF 76 0A 57 56 9A 80 ...~..v.W.v.WV..
0800:3E60 48 00 08 83 C4 08 FF 76 0C FF 76 0A 57 FF 76 0A H......v..v.W.v.
0800:3E70 9A 80 48 00 08 83 C4 08 FF 76 0C 56 FF 76 0C FF ..H......v.V.v..
0800:3E80 76 0A 9A 80 48 00 08 83 C4 08 57 56 FF 76 0C 56 v...H.....WV.v.V
0800:3E90 9A 80 48 00 08 83 C4 08 1F 5F 5E 5D CB 55 8B EC ..H......_^].U..
0800:3EA0 1E B8 00 08 8E D8 8B 16 31 9C A1 2F 9C C4 5E 06 ........1../..^.
0800:3EB0 26 89 57 02 26 89 07 1F 5D CB                   &.W.&...].     

;; fn0800_3EBA: 0800:3EBA
;;   Called from:
;;     0800:05F7 (in fn0800_05E9)
;;     0800:0704 (in fn0800_06F3)
;;     0800:08B7 (in fn0800_06F3)
;;     0800:0AE6 (in fn0800_0ADF)
;;     0800:0B42 (in fn0800_0B33)
;;     0800:35E2 (in fn0800_3542)
fn0800_3EBA proc
	push	bp
	mov	bp,sp
	push	si
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	si,[bp+6h]
	cmp	si,0Bh
	jbe	3ED4h

l0800_3ECC:
	mov	word ptr [9C06h],0FFF5h
	jmp	3EE7h

l0800_3ED4:
	mov	[9C2Fh],si
	mov	ax,[bp+8h]
	mov	[9C31h],ax
	push	ax
	push	si
	call	far 0800h:4BA9h
	pop	cx
	pop	cx

l0800_3EE7:
	pop	ds
	pop	si
	pop	bp
	retf
0800:3EEB                                  55 8B EC 56 57            U..VW
0800:3EF0 1E B8 00 08 8E D8 56 57 BE 33 9C C4 7E 06 B9 08 ......VW.3..~...
0800:3F00 00 FC F3 A4 5F 5E 1F 5F 5E 5D CB                ...._^._^].    

;; fn0800_3F0B: 0800:3F0B
;;   Called from:
;;     0800:35D0 (in fn0800_3542)
fn0800_3F0B proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	call	far 0800h:4A2Ch
	cmp	ax,[bp+0Ah]
	jnc	3F28h

l0800_3F20:
	mov	word ptr [9C06h],0FFF5h
	jmp	3F5Bh

l0800_3F28:
	mov	word ptr [9C2Fh],0Ch
	mov	ax,[bp+0Ah]
	mov	[9C31h],ax
	push	si
	push	di
	mov	ax,ds
	mov	es,ax
	lds	si,[bp+6h]
	mov	di,9C33h
	mov	cx,8h
	cld

l0800_3F44:
	rep movsb

l0800_3F46:
	mov	ds,ax
	pop	di
	pop	si
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:46C4h
	add	sp,6h

l0800_3F5B:
	pop	ds
	pop	di
	pop	si
	pop	bp
	retf
0800:3F60 55 8B EC A1 02 9C 99 52 50 8B 46 04 33 D2 52 50 U......RP.F.3.RP
0800:3F70 A1 00 9C 99 5B 59 9A C1 6B 00 08 52 50 9A 9F 6E ....[Y..k..RP..n
0800:3F80 00 08 5D C2 02 00 55 8B EC 1E B8 00 08 8E D8 FF ..]...U.........
0800:3F90 76 0E E8 CB FF 50 FF 76 0E FF 76 0C FF 76 0A FF v....P.v..v..v..
0800:3FA0 76 08 FF 76 06 9A 45 49 00 08 83 C4 0C 1F 5D CB v..v..EI......].
0800:3FB0 55 8B EC 1E B8 00 08 8E D8 FF 76 0A E8 A1 FF 50 U.........v....P
0800:3FC0 FF 76 0A B8 68 01 50 33 C0 50 FF 76 08 FF 76 06 .v..h.P3.P.v..v.
0800:3FD0 9A 45 49 00 08 83 C4 0C 1F 5D CB 55 8B EC 1E B8 .EI......].U....
0800:3FE0 00 08 8E D8 A1 00 9C C4 5E 06 26 89 07 A1 02 9C ........^.&.....
0800:3FF0 C4 5E 0A 26 89 07 1F 5D CB 55 8B EC 1E B8 00 08 .^.&...].U......
0800:4000 8E D8 8B 46 06 A3 00 9C 8B 46 08 A3 02 9C 1F 5D ...F.....F.....]
0800:4010 CB 55 8B EC 1E B8 00 08 8E D8 FF 76 0E E8 40 FF .U.........v..@.
0800:4020 50 FF 76 0E FF 76 0C FF 76 0A FF 76 08 FF 76 06 P.v..v..v..v..v.
0800:4030 9A B2 49 00 08 83 C4 0C 1F 5D CB                ..I......].    

;; fn0800_403B: 0800:403B
;;   Called from:
;;     0800:35AE (in fn0800_3542)
fn0800_403B proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,800h
	mov	ds,ax
	cmp	word ptr [bp+6h],0Fh
	ja	4072h

l0800_404A:
	mov	al,[bp+6h]
	mov	[9C12h],al
	cmp	word ptr [bp+6h],0h
	jnz	405Dh

l0800_4056:
	mov	byte ptr [9C3Ch],0h
	jmp	4067h

l0800_405D:
	mov	bx,[bp+6h]
	mov	al,[bx+9C3Ch]
	mov	[9C3Ch],al

l0800_4067:
	mov	al,[9C3Ch]
	cbw
	push	ax
	call	far 0800h:4ABCh
	pop	cx

l0800_4072:
	pop	ds
	pop	bp
	retf
0800:4075                1E B8 00 08 8E D8 A0 10 9C B4 00      ...........
0800:4080 1F CB 1E B8 00 08 8E D8 A0 12 9C B4 00 1F CB    ...............

;; fn0800_408F: 0800:408F
;;   Called from:
;;     0800:359A (in fn0800_3542)
fn0800_408F proc
	push	bp
	mov	bp,sp
	sub	sp,1Ah
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	les	bx,[bp+6h]
	mov	[bp-14h],es
	mov	[bp-16h],bx
	cmp	word ptr [9C19h],0h
	jnz	40B0h

l0800_40AD:
	jmp	412Ch
0800:40AF                                              90                .

l0800_40B0:
	les	bx,[bp-16h]
	cmp	byte ptr es:[bx],10h
	jbe	40BEh

l0800_40B9:
	mov	ax,10h
	jmp	40C6h

l0800_40BE:
	les	bx,[bp-16h]
	mov	al,es:[bx]
	mov	ah,0h

l0800_40C6:
	mov	[bp-18h],ax
	mov	word ptr [bp-1Ah],0h
	jmp	40F1h

l0800_40D0:
	les	bx,[bp-16h]
	add	bx,[bp-1Ah]
	cmp	byte ptr es:[bx+1h],0FFh
	jle	40EEh

l0800_40DD:
	mov	bx,[bp-16h]
	add	bx,[bp-1Ah]
	mov	al,es:[bx+1h]
	mov	bx,[bp-1Ah]
	mov	[bx+9C3Ch],al

l0800_40EE:
	inc	word ptr [bp-1Ah]

l0800_40F1:
	mov	ax,[bp-1Ah]
	cmp	ax,[bp-18h]
	jc	40D0h

l0800_40F9:
	les	bx,[bp-16h]
	cmp	byte ptr es:[bx+1h],0FFh
	jz	4108h

l0800_4103:
	mov	byte ptr [9C12h],0h

l0800_4108:
	push	si
	push	di
	push	ss
	pop	es
	mov	si,9C3Bh
	lea	di,[bp-12h]
	mov	cx,11h
	cld

l0800_4116:
	rep movsb

l0800_4118:
	pop	di
	pop	si
	mov	al,[9C1Bh]
	mov	[bp-1h],al
	push	ss
	lea	ax,[bp-12h]
	push	ax
	call	far 0800h:4B20h
	pop	cx
	pop	cx

l0800_412C:
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
0800:4133          55 8B EC 56 1E B8 00 08 8E D8 8B 76 06    U..V.......v.
0800:4140 83 3E 19 9C 00 74 2B A0 3B 9C B4 00 48 3B C6 72 .>...t+.;...H;.r
0800:4150 21 83 7E 08 00 7C 1B 8A 46 08 88 84 3C 9C 0B F6 !.~..|..F...<...
0800:4160 75 05 C6 06 12 9C 00 FF 76 08 56 9A 01 4B 00 08 u.......v.V..K..
0800:4170 59 59 1F 5E 5D CB 55 8B EC 1E B8 00 08 8E D8 C4 YY.^].U.........
0800:4180 5E 06 06 53 BB 3B 9C 1E 53 B9 11 00 9A 7A 6F 00 ^..S.;..S....zo.
0800:4190 08 1F 5D CB 55 8B EC 56 1E B8 00 08 8E D8 FF 76 ..].U..V.......v
0800:41A0 0C FF 76 0A FF 76 08 FF 76 06 9A 14 47 00 08 83 ..v..v..v...G...
0800:41B0 C4 08 8B F0 83 FE FF 75 06 C7 06 06 9C F5 FF 8B .......u........
0800:41C0 C6 1F 5E 5D CB                                  ..^].          

;; fn0800_41C5: 0800:41C5
;;   Called from:
;;     0800:02BF (in fn0800_0267)
fn0800_41C5 proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	les	bx,[bp+0Ah]
	mov	ax,es:[bx]
	mov	[bp-2h],ax
	mov	si,es:[bx+2h]
	mov	di,si
	mov	bx,[9BEAh]
	mov	si,[bx+4h]
	mov	ax,[bp+8h]
	add	ax,[9C21h]
	sub	si,ax
	cmp	si,di
	jbe	41F8h

l0800_41F6:
	mov	si,di

l0800_41F8:
	mov	ax,[bp+6h]
	add	ax,[9C1Fh]
	add	ax,[bp-2h]
	mov	bx,[9BEAh]
	cmp	ax,[bx+2h]
	ja	4244h

l0800_420B:
	mov	ax,[bp+6h]
	add	ax,[9C1Fh]
	jl	4244h

l0800_4214:
	or	si,si
	jc	4244h

l0800_4218:
	mov	ax,[bp+8h]
	add	ax,[9C21h]
	jl	4244h

l0800_4221:
	les	bx,[bp+0Ah]
	mov	es:[bx+2h],si
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	bx
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:4D52h
	add	sp,0Ah
	les	bx,[bp+0Ah]
	mov	es:[bx+2h],di

l0800_4244:
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
0800:424B                                  55 8B EC 1E B8            U....
0800:4250 00 08 8E D8 C4 5E 06 06 53 BB 4C 9C 1E 53 B9 0A .....^..S.L..S..
0800:4260 00 9A 7A 6F 00 08 1F 5D CB 55 8B EC 1E B8 00 08 ..zo...].U......
0800:4270 8E D8 FF 76 08 FF 76 06 FF 36 17 9C FF 36 15 9C ...v..v..6...6..
0800:4280 9A D9 4B 00 08 83 C4 08 83 3E 52 9C 00 75 23 83 ..K......>R..u#.
0800:4290 3E 4E 9C 00 75 1C FF 36 17 9C FF 76 08 FF 76 06 >N..u..6...v..v.
0800:42A0 9A 86 4C 00 08 59 59 03 06 15 9C 50 0E E8 1F FA ..L..YY....P....
0800:42B0 59 59 1F 5D CB                                  YY.].          

;; fn0800_42B5: 0800:42B5
;;   Called from:
;;     0800:024E (in fn0800_0215)
;;     0800:065A (in fn0800_0635)
;;     0800:3610 (in fn0800_3542)
fn0800_42B5 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	di,[bp+8h]
	mov	si,[bp+6h]
	or	si,si
	jl	42D8h

l0800_42CA:
	cmp	si,2h
	jg	42D8h

l0800_42CF:
	or	di,di
	jl	42D8h

l0800_42D3:
	cmp	di,2h
	jle	42E0h

l0800_42D8:
	mov	word ptr [9C06h],0FFF5h
	jmp	42F1h

l0800_42E0:
	mov	[9C52h],si
	mov	[9C54h],di
	push	di
	push	si
	call	far 0800h:46F7h
	pop	cx
	pop	cx

l0800_42F1:
	pop	ds
	pop	di
	pop	si
	pop	bp
	retf

;; fn0800_42F6: 0800:42F6
;;   Called from:
;;     0800:0241 (in fn0800_0215)
;;     0800:064B (in fn0800_0635)
;;     0800:3601 (in fn0800_3542)
fn0800_42F6 proc
	push	bp
	mov	bp,sp
	sub	sp,0Ch
	push	si
	push	di
	push	ds
	mov	ax,800h
	mov	ds,ax
	mov	si,[bp+6h]
	mov	bx,[9BEAh]
	cmp	byte ptr [bx+1h],3h
	jnz	4314h

l0800_4311:
	jmp	4496h

l0800_4314:
	or	si,si
	jnz	431Bh

l0800_4318:
	jmp	4496h

l0800_431B:
	or	si,si
	jl	4325h

l0800_431F:
	cmp	si,[9A61h]
	jle	432Eh

l0800_4325:
	mov	word ptr [9C06h],0FFF2h
	jmp	448Fh

l0800_432E:
	cmp	si,[9C4Ch]
	jnz	4337h

l0800_4334:
	jmp	4496h

l0800_4337:
	mov	ax,si
	dec	ax
	mov	dx,0Fh
	mul	dx
	mov	di,ax
	add	di,9A63h
	cmp	si,[9C1Dh]
	jnz	434Eh

l0800_434B:
	jmp	447Ch

l0800_434E:
	mov	ax,[9C1Dh]
	dec	ax
	mov	dx,0Fh
	mul	dx
	mov	bx,ax
	cmp	word ptr [bx+9A6Bh],0h
	jz	4397h

l0800_4360:
	mov	ax,[9C1Dh]
	dec	ax
	mov	dx,0Fh
	mul	dx
	add	ax,9A63h
	mov	[bp-2h],ax
	mov	bx,ax
	push	word ptr [bx+8h]
	push	ds
	push	ax
	call	3042h
	add	sp,6h
	mov	bx,[bp-2h]
	mov	word ptr [bx+2h],0h
	mov	word ptr [bx],0h
	mov	word ptr [bx+6h],0h
	mov	word ptr [bx+4h],0h
	mov	word ptr [bx+8h],0h

l0800_4397:
	mov	ax,[di+4h]
	or	ax,[di+6h]
	jz	43A2h

l0800_439F:
	jmp	4478h

l0800_43A2:
	push	ds
	mov	ax,99F8h
	push	ax
	push	ds
	mov	ax,di
	add	ax,0Ah
	push	ax
	push	ds
	mov	ax,0A048h
	push	ax
	call	2D7Eh
	push	ds
	mov	ax,9A0Eh
	push	ax
	push	ds
	mov	ax,99F8h
	push	ax
	push	ss
	lea	ax,[bp-0Ch]
	push	ax
	mov	ax,0FFF3h
	push	ax
	call	33E3h
	or	ax,ax
	jz	43E3h

l0800_43D0:
	cmp	word ptr [9C06h],0FDh
	jz	43DAh

l0800_43D7:
	jmp	448Fh

l0800_43DA:
	mov	word ptr [9C06h],0FFF8h
	jmp	448Fh

l0800_43E3:
	mov	ax,[bp-0Ch]
	add	ax,10h
	push	ax
	push	ss
	lea	ax,[bp-0Ah]
	push	ax
	call	3010h
	add	sp,6h
	or	ax,ax
	jz	4405h

l0800_43F9:
	call	2DBCh
	mov	word ptr [9C06h],0FFF7h
	jmp	448Fh

l0800_4405:
	mov	dx,[bp-8h]
	mov	ax,[bp-0Ah]
	add	ax,0Fh
	mov	cl,4h
	shr	ax,cl
	add	dx,ax
	xor	ax,ax
	mov	[bp-4h],dx
	mov	[bp-6h],ax
	push	ax
	push	word ptr [bp-0Ch]
	push	dx
	push	ax
	call	2E0Ch
	or	ax,ax
	jz	443Dh

l0800_4429:
	mov	ax,[bp-0Ch]
	add	ax,10h
	push	ax
	push	ss
	lea	ax,[bp-0Ah]
	push	ax
	call	3042h
	add	sp,6h
	jmp	448Fh

l0800_443D:
	call	2DBCh
	push	word ptr [bp-4h]
	push	word ptr [bp-6h]
	push	cs
	call	3172h
	pop	cx
	pop	cx
	cmp	ax,si
	jz	4464h

l0800_4450:
	mov	ax,[bp-0Ch]
	add	ax,10h
	push	ax
	push	ss
	lea	ax,[bp-0Ah]
	push	ax
	call	3042h
	add	sp,6h
	jmp	4489h

l0800_4464:
	mov	dx,[bp-8h]
	mov	ax,[bp-0Ah]
	mov	[di+2h],dx
	mov	[di],ax
	mov	ax,[bp-0Ch]
	add	ax,10h
	mov	[di+8h],ax

l0800_4478:
	mov	[9C1Dh],si

l0800_447C:
	les	bx,[di+4h]
	mov	[9C0Ah],es
	mov	[9C08h],bx
	jmp	4496h

l0800_4489:
	mov	word ptr [9C06h],0FFF3h

l0800_448F:
	xor	si,si
	mov	word ptr [bp+0Ah],1h

l0800_4496:
	mov	[9C4Ch],si
	mov	ax,[bp+8h]
	mov	[9C4Eh],ax
	mov	ax,[bp+0Ah]
	mov	[9C50h],ax
	push	ax
	push	word ptr [bp+8h]
	push	si
	call	far 0800h:4C0Fh
	add	sp,6h
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
0800:44BA                               55 8B EC 1E B8 00           U.....
0800:44C0 08 8E D8 8B 1E EA 9B 8B 47 02 3B 46 06 72 2C 8B ........G.;F.r,.
0800:44D0 47 02 3B 46 08 72 24 8B 47 04 3B 46 0A 72 1C 8B G.;F.r$.G.;F.r..
0800:44E0 47 04 3B 46 0C 72 14 FF 76 0C FF 76 0A FF 76 08 G.;F.r..v..v..v.
0800:44F0 FF 76 06 9A 60 4C 00 08 83 C4 08 C7 06 50 9C 00 .v..`L.......P..
0800:4500 00 1F 5D CB 55 8B EC 1E B8 00 08 8E D8 9A B3 4C ..].U..........L
0800:4510 00 08 1F 5D CB                                  ...].          

;; fn0800_4515: 0800:4515
;;   Called from:
;;     0800:4698 (in fn0800_46A1)
fn0800_4515 proc
	push	es
	push	bx
	retf

;; fn0800_4518: 0800:4518
;;   Called from:
;;     0800:4815 (in fn0800_480A)
fn0800_4518 proc
	cmp	byte ptr [0A057h],0FFh
	jnz	4556h

l0800_451F:
	cmp	byte ptr [99F6h],0A5h
	jnz	452Ch

l0800_4526:
	mov	byte ptr [0A057h],0h
	ret

l0800_452C:
	mov	ah,0Fh
	int	10h
	mov	[0A057h],al
	mov	ax,40h
	mov	es,ax
	mov	bx,10h
	mov	al,es:[bx]
	mov	[0A058h],al
	cmp	byte ptr [0A050h],5h
	jz	4556h

l0800_4548:
	cmp	byte ptr [0A050h],7h
	jz	4556h

l0800_454F:
	and	al,0CFh
	or	al,20h
	mov	es:[bx],al

l0800_4556:
	ret
0800:4557                      55 8B EC 1E 2E 8E 1E 9D 01        U........
0800:4560 56 57 BE 06 00 FF 1E 8F 9B 5F 5E 1F 5D CB       VW......._^.]. 

;; fn0800_456E: 0800:456E
;;   Called from:
;;     0800:3820 (in fn0800_3632)
fn0800_456E proc
	mov	byte ptr [0A057h],0FFh

;; fn0800_4573: 0800:4573
;;   Called from:
;;     0800:3812 (in fn0800_3632)
;;     0800:456E (in fn0800_456E)
fn0800_4573 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	xor	ax,ax
	mov	ch,[0A051h]
	cmp	byte ptr [0A050h],5h
	jnz	458Dh

l0800_458B:
	mov	ch,3h

l0800_458D:
	mov	cl,[0A04Fh]
	les	bx,[bp+6h]
	mov	ah,1h
	cmp	byte ptr es:[bx+16h],0h
	jnz	45A3h

l0800_459D:
	xor	ah,ah
	les	bx,[9B93h]

l0800_45A3:
	mov	si,0h
	call	dword ptr [9B8Fh]
	mov	[9C0Ch],bx
	mov	[9C0Eh],es
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_45B7: 0800:45B7
;;   Called from:
;;     0800:3C24 (in fn0800_3BBE)
fn0800_45B7 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ax,[bp+6h]
	mov	bx,[bp+8h]
	mov	cx,[bp+0Ah]
	mov	dx,[bp+0Ch]
	cmp	byte ptr [bp+0Eh],0h
	jnz	45D7h

l0800_45D4:
	or	ah,80h

l0800_45D7:
	mov	si,38h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:45E3          55 8B EC 1E 2E 8E 1E 9D 01 56 57 E8 27    U........VW.'
0800:45F0 FF 8A 46 06 3C 0A 73 11 A2 4F A0 FF 36 55 A0 FF ..F.<.s..O..6U..
0800:4600 36 53 A0 0E E8 6C FF 58 58 C4 1E 53 A0 BE 02 00 6S...l.XX..S....
0800:4610 FF 1E 8F 9B 5F 5E 1F 5D CB                      ...._^.].      

;; fn0800_4619: 0800:4619
;;   Called from:
;;     0800:3ADA (in fn0800_3AD4)
fn0800_4619 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	cmp	byte ptr [0A057h],0FFh
	jz	464Eh

l0800_462B:
	mov	si,6h
	call	dword ptr [9B8Fh]
	cmp	byte ptr [99F6h],0A5h
	jz	464Eh

l0800_4639:
	mov	ax,40h
	mov	es,ax
	mov	bx,10h
	mov	al,[0A058h]
	mov	es:[bx],al
	xor	ah,ah
	mov	al,[0A057h]
	int	10h

l0800_464E:
	mov	byte ptr [0A057h],0FFh
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4658                         55 8B EC 1E 2E 8E 1E 9D         U.......
0800:4660 01 56 57 8A 46 06 32 E4 50 BE 32 00 FF 1E 8F 9B .VW.F.2.P.2.....
0800:4670 26 8B 5F 0C EB 21 5F 5E 1F 5D CB 55 8B EC 1E 2E &._..!_^.].U....
0800:4680 8E 1E 9D 01 56 57 8A 46 06 32 E4 50 BE 32 00 FF ....VW.F.2.P.2..
0800:4690 1E 8F 9B 26 8B 5F 0A                            ...&._.        

l0800_4697:
	pop	ax
	push	cs
	call	4515h
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_46A1: 0800:46A1
;;   Called from:
;;     0800:361A (in fn0800_3542)
fn0800_46A1 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	al,[bp+6h]
	xor	ah,ah
	push	ax
	mov	si,32h
	call	dword ptr [9B8Fh]
	mov	bx,es:[bx+0Eh]
	jmp	4697h
0800:46BF                                              5F                _
0800:46C0 5E 1F 5D CB                                     ^.].           

;; fn0800_46C4: 0800:46C4
;;   Called from:
;;     0800:3F53 (in fn0800_3F0B)
fn0800_46C4 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ah,[bp+0Ah]
	mov	[9C11h],ah
	mov	al,[9C10h]
	mov	si,1Eh
	call	dword ptr [9B8Fh]
	mov	byte ptr [9C14h],0Ch
	les	bx,[bp+6h]
	mov	ax,0FFFFh
	mov	si,20h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_46F7: 0800:46F7
;;   Called from:
;;     0800:42EA (in fn0800_42B5)
fn0800_46F7 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ah,[bp+6h]
	mov	al,[bp+8h]
	mov	si,2Ah
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4714             55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B     U........VW.
0800:4720 46 0A 2B 46 06 79 02 F7 D8 40 05 07 00 D1 E8 D1 F.+F.y...@......
0800:4730 E8 D1 E8 50 BE 32 00 FF 1E 8F 9B 26 8B 5F 08 0E ...P.2.....&._..
0800:4740 E8 D2 FD 5B F7 E3 8B 4E 0C 2B 4E 08 79 02 F7 D9 ...[...N.+N.y...
0800:4750 41 F7 E1 05 06 00 72 04 23 D2 74 05 B8 FF FF 8B A.....r.#.t.....
0800:4760 D0 5F 5E 1F 5D CB                               ._^.].         

;; fn0800_4766: 0800:4766
;;   Called from:
;;     0800:36DD (in fn0800_3632)
fn0800_4766 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	byte ptr [0A04Eh],0FFh
	mov	byte ptr [0A04Fh],0h
	mov	byte ptr [0A051h],0Ah
	les	di,[bp+0Ah]
	mov	al,es:[di]
	mov	[0A050h],al
	and	al,al
	jnz	479Bh

l0800_478D:
	add	bp,4h
	call	47E8h
	sub	bp,4h
	mov	al,[0A04Eh]
	jmp	47C0h

l0800_479B:
	les	di,[bp+0Eh]
	mov	al,es:[di]
	mov	[0A04Fh],al
	les	di,[bp+0Ah]
	mov	bl,es:[di]
	and	bl,bl
	js	47C8h

l0800_47AE:
	xor	bh,bh
	mov	al,cs:[bx+4D91h]
	mov	[0A051h],al
	mov	al,cs:[bx+4D75h]
	mov	[0A04Eh],al

l0800_47C0:
	les	di,[bp+6h]
	xor	ah,ah
	mov	es:[di],ax

l0800_47C8:
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:47CD                                        55 8B EC              U..
0800:47D0 1E 2E 8E 1E 9D 01 56 57 FF 36 4E A0 E8 09 00 8F ......VW.6N.....
0800:47E0 06 4E A0 5F 5E 1F 5D CB                         .N._^.].       

;; fn0800_47E8: 0800:47E8
;;   Called from:
;;     0800:4790 (in fn0800_4766)
fn0800_47E8 proc
	push	bp
	call	4D9Fh
	pop	bp
	les	di,[bp+6h]
	mov	al,[0A050h]
	xor	ah,ah
	cmp	al,0FFh
	jnz	47FBh

l0800_47F9:
	mov	ah,al

l0800_47FB:
	mov	es:[di],ax
	xor	ah,ah
	mov	al,[0A04Fh]
	les	di,[bp+0Ah]
	mov	es:[di],ax
	ret

;; fn0800_480A: 0800:480A
;;   Called from:
;;     0800:3844 (in fn0800_3632)
fn0800_480A proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	call	4518h
	les	bx,[bp+6h]
	mov	[0A053h],bx
	mov	[0A055h],es
	mov	si,2h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:482F                                              55                U
0800:4830 8B EC 1E 2E 8E 1E 9D 01 56 57 BE 04 00 FF 1E 8F ........VW......
0800:4840 9B 5F 5E 1F 5D CB                               ._^.].         

;; fn0800_4846: 0800:4846
;;   Called from:
;;     0800:3CDE (in fn0800_3CCF)
fn0800_4846 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ax,[bp+6h]
	mov	bx,[bp+8h]
	mov	si,8h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4863          55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 46    U........VW.F
0800:4870 06 8B 5E 08 BE 0A 00 FF 1E 8F 9B 5F 5E 1F 5D CB ..^........_^.].
0800:4880 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 46 06 8B 5E U........VW.F..^
0800:4890 08 8B 4E 0A 8B 56 0C BE 0C 00 FF 1E 8F 9B 5F 5E ..N..V........_^
0800:48A0 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 4E .].U........VW.N
0800:48B0 06 C4 5E 08 B8 06 00 BE 0E 00 FF 1E 8F 9B 5F 5E ..^..........._^
0800:48C0 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 4E .].U........VW.N
0800:48D0 06 C4 5E 08 B8 07 00 BE 0E 00 FF 1E 8F 9B 5F 5E ..^..........._^
0800:48E0 1F 5D CB                                        .].            

;; fn0800_48E3: 0800:48E3
;;   Called from:
;;     0800:061D (in fn0800_05E9)
;;     0800:0716 (in fn0800_06F3)
;;     0800:08CC (in fn0800_06F3)
;;     0800:0AF8 (in fn0800_0ADF)
;;     0800:0B54 (in fn0800_0B33)
fn0800_48E3 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ax,[bp+6h]
	mov	bx,[bp+8h]
	mov	cx,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	si,12h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4906                   55 8B EC 1E 2E 8E 1E 9D 01 56       U........V
0800:4910 57 8B 46 06 8B 5E 08 8B 4E 0A 8B 56 0C 3B C1 72 W.F..^..N..V.;.r
0800:4920 01 91 3B DA 73 02 87 DA 51 52 BE 08 00 FF 1E 8F ..;.s...QR......
0800:4930 9B 5B 58 8B 4E 0E 8B 56 10 BE 10 00 FF 1E 8F 9B .[X.N..V........
0800:4940 5F 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 _^.].U........VW
0800:4950 8B 46 06 8B 5E 08 BE 08 00 FF 1E 8F 9B 8B 46 0A .F..^.........F.
0800:4960 8B 5E 0C 8B 4E 0E 8B 56 10 BE 14 00 FF 1E 8F 9B .^..N..V........
0800:4970 5F 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 _^.].U........VW
0800:4980 8B 46 06 8B 5E 08 BE 08 00 FF 1E 8F 9B 8B 46 0A .F..^.........F.
0800:4990 8B 5E 0C BE 18 00 FF 1E 8F 9B B8 00 00 BB 68 01 .^............h.
0800:49A0 8B 4E 0A 8B 56 0C BE 14 00 FF 1E 8F 9B 5F 5E 1F .N..V........_^.
0800:49B0 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 46 06 ].U........VW.F.
0800:49C0 8B 5E 08 BE 08 00 FF 1E 8F 9B 8B 46 0A 8B 5E 0C .^.........F..^.
0800:49D0 8B 4E 0E 8B 56 10 BE 16 00 FF 1E 8F 9B 5F 5E 1F .N..V........_^.
0800:49E0 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 1E B8 FF ].U........VW...
0800:49F0 FF BE 14 00 FF 1E 8F 9B 8B F3 06 1F C4 7E 06 FC .............~..
0800:4A00 B9 06 00 F3 A5 1F 5F 5E 1F 5D CB                ......_^.].    

;; fn0800_4A0B: 0800:4A0B
;;   Called from:
;;     0800:021B (in fn0800_0215)
;;     0800:063F (in fn0800_0635)
;;     0800:35BF (in fn0800_3542)
fn0800_4A0B proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	al,[bp+6h]
	mov	[9C10h],al
	mov	ah,[9C11h]
	mov	si,1Eh
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4A2C: 0800:4A2C
;;   Called from:
;;     0800:35B9 (in fn0800_3542)
;;     0800:35C5 (in fn0800_3542)
;;     0800:35D8 (in fn0800_3542)
;;     0800:3F16 (in fn0800_3F0B)
fn0800_4A2C proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	xor	al,al
	mov	si,3Ah
	call	dword ptr [9B8Fh]
	mov	ax,cx
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4A47: 0800:4A47
;;   Called from:
;;     0800:35A1 (in fn0800_3542)
fn0800_4A47 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	xor	al,al
	mov	si,3Ah
	call	dword ptr [9B8Fh]
	mov	ax,bx
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4A62: 0800:4A62
;;   Called from:
;;     0800:3575 (in fn0800_3542)
fn0800_4A62 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	al,1h
	mov	si,3Ah
	call	dword ptr [9B8Fh]
	mov	dx,es
	mov	ax,bx
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4A7F                                              55                U
0800:4A80 8B EC 1E 2E 8E 1E 9D 01 56 57 B0 02 8B 4E 06 BE ........VW...N..
0800:4A90 00 00 FF 1E 8F 9B 8C C2 8B C3 40 5F 5E 1F 5D CB ..........@_^.].

;; fn0800_4AA0: 0800:4AA0
;;   Called from:
;;     0800:386B (in fn0800_3632)
fn0800_4AA0 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	al,1h
	mov	si,0h
	call	dword ptr [9B8Fh]
	mov	ax,cx
	dec	ax
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4ABC: 0800:4ABC
;;   Called from:
;;     0800:406C (in fn0800_403B)
fn0800_4ABC proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	bl,[bp+6h]
	xor	bh,bh
	mov	ax,0FFFFh
	mov	si,1Ah
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4ADB                                  55 8B EC 1E 2E            U....
0800:4AE0 8E 1E 9D 01 56 57 8B 46 06 80 CC 80 8B 5E 08 8B ....VW.F.....^..
0800:4AF0 4E 0A 8B 56 0C BE 1A 00 FF 1E 8F 9B 5F 5E 1F 5D N..V........_^.]
0800:4B00 CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 46 06 32 .U........VW.F.2
0800:4B10 E4 8B 5E 08 BE 1A 00 FF 1E 8F 9B 5F 5E 1F 5D CB ..^........_^.].

;; fn0800_4B20: 0800:4B20
;;   Called from:
;;     0800:4125 (in fn0800_408F)
fn0800_4B20 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	les	bx,[bp+6h]
	inc	bx
	mov	si,1Ch
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4B3B: 0800:4B3B
;;   Called from:
;;     0800:3E3A (in fn0800_3E06)
fn0800_4B3B proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ax,[bp+6h]
	mov	[9C13h],al
	mov	bx,[bp+8h]
	mov	cl,[bp+0Ah]
	mov	[0A052h],cl
	xor	ch,ch
	mov	si,22h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4B64             55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B     U........VW.
0800:4B70 46 06 8B 5E 08 8B 4E 0A C4 36 53 A0 26 8B 7C 0C F..^..N..6S.&.|.
0800:4B80 26 8B 54 0E 26 03 7C 10 83 EF 02 FA 87 E7 8C D5 &.T.&.|.........
0800:4B90 8E D2 FB 57 55 BE 2C 00 FF 1E 8F 9B 5B 58 FA 8E ...WU.,.....[X..
0800:4BA0 D3 8B E0 FB 5F 5E 1F 5D CB                      ...._^.].      

;; fn0800_4BA9: 0800:4BA9
;;   Called from:
;;     0800:3EE0 (in fn0800_3EBA)
fn0800_4BA9 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ah,[bp+8h]
	mov	[9C11h],ah
	mov	al,[9C10h]
	mov	si,1Eh
	call	dword ptr [9B8Fh]
	mov	al,[bp+6h]
	mov	[9C14h],al
	mov	ah,al
	mov	si,20h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4BD9: 0800:4BD9
;;   Called from:
;;     0800:025F (in fn0800_0215)
;;     0800:0682 (in fn0800_0635)
fn0800_4BD9 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	mov	ax,[bp+6h]
	mov	bx,[bp+8h]
	mov	si,8h
	call	dword ptr [9B8Fh]
	les	bx,[bp+0Ah]
	mov	di,bx
	xor	al,al
	mov	cx,0FFFFh
	cld

l0800_4BFC:
	repne scasb

l0800_4BFE:
	mov	cx,di
	sub	cx,bx
	dec	cx
	mov	si,26h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf

;; fn0800_4C0F: 0800:4C0F
;;   Called from:
;;     0800:44AB (in fn0800_42F6)
fn0800_4C0F proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	les	bx,[9C0Ch]
	mov	bx,es:[bx+10h]
	and	bx,7F7Fh
	mov	dl,[bp+0Ah]
	mov	al,bh
	mul	dl
	mov	cx,ax
	mov	al,bl
	mul	dl
	mov	bx,ax
	mov	al,[bp+6h]
	mov	ah,[bp+8h]
	and	al,al
	jz	4C54h

l0800_4C3F:
	les	di,[9C0Ch]
	cmp	byte ptr es:[di+1h],3h
	jz	4C54h

l0800_4C4A:
	mov	cl,dl
	xor	ch,ch
	mov	bx,cx
	mov	dx,[9C0Ah]

l0800_4C54:
	mov	si,24h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4C60 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B 46 06 8B 5E U........VW.F..^
0800:4C70 08 8B 4E 0A 8B 56 0C 80 CC 80 BE 24 00 FF 1E 8F ..N..V.....$....
0800:4C80 9B 5F 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 ._^.].U........V
0800:4C90 57 C4 5E 06 8B FB 32 C0 B9 FF FF FC F2 AE 8B CF W.^...2.........
0800:4CA0 2B CB 49 BE 28 00 FF 1E 8F 9B 8B C3 5F 5E 1F 5D +.I.(......._^.]
0800:4CB0 CB 4D 00 55 8B EC 1E 2E 8E 1E 9D 01 56 57 B9 01 .M.U........VW..
0800:4CC0 00 0E 07 BB B1 4C BE 28 00 FF 1E 8F 9B 8B C1 5F .....L.(......._
0800:4CD0 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 8B ^.].U........VW.
0800:4CE0 46 06 8B 5E 08 BE 2E 00 FF 1E 8F 9B 32 E4 8A C2 F..^........2...
0800:4CF0 5F 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 _^.].U........VW
0800:4D00 8B 46 06 8B 5E 08 8A 56 0A BE 30 00 FF 1E 8F 9B .F..^..V..0.....
0800:4D10 5F 5E 1F 5D CB 55 8B EC 1E 2E 8E 1E 9D 01 56 57 _^.].U........VW
0800:4D20 C4 5E 0E 8B 4E 06 8B 56 08 8B 76 0A 8B 7E 0C 3B .^..N..V..v..~.;
0800:4D30 CE 72 02 87 F1 3B D7 72 02 87 FA 2B F1 26 89 37 .r...;.r...+.&.7
0800:4D40 2B FA 26 89 7F 02 BE 34 00 FF 1E 8F 9B 5F 5E 1F +.&....4....._^.
0800:4D50 5D CB                                           ].             

;; fn0800_4D52: 0800:4D52
;;   Called from:
;;     0800:4235 (in fn0800_41C5)
fn0800_4D52 proc
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,cs:[019Dh]
	push	si
	push	di
	les	bx,[bp+0Ah]
	mov	cx,[bp+6h]
	mov	dx,[bp+8h]
	mov	al,[bp+0Eh]
	mov	si,36h
	call	dword ptr [9B8Fh]
	pop	di
	pop	si
	pop	ds
	pop	bp
	retf
0800:4D75                00 00 00 01 01 01 02 03 04 01 05      ...........
0800:4D80 06 07 FF 00 04 05 01 00 00 00 00 05 02 00 00 00 ................
0800:4D90 00 00 04 05 01 01 00 01 00 05 02 00 00 00 7F    ...............

;; fn0800_4D9F: 0800:4D9F
;;   Called from:
;;     0800:47E9 (in fn0800_47E8)
fn0800_4D9F proc
	mov	byte ptr [0A04Eh],0FFh
	mov	byte ptr [0A050h],0FFh
	mov	byte ptr [0A04Fh],0h
	call	4DD5h
	mov	bl,[0A050h]
	cmp	bl,0FFh
	jz	4DD4h

l0800_4DBA:
	xor	bh,bh
	mov	al,cs:[bx+4D75h]
	mov	[0A04Eh],al
	mov	al,cs:[bx+4D83h]
	mov	[0A04Fh],al
	mov	al,cs:[bx+4D91h]
	mov	[0A051h],al

l0800_4DD4:
	ret

;; fn0800_4DD5: 0800:4DD5
;;   Called from:
;;     0800:4DAE (in fn0800_4D9F)
fn0800_4DD5 proc
	mov	ah,0Fh
	int	10h
	cmp	al,7h
	jz	4E0Eh

l0800_4DDD:
	call	4ECAh
	jnc	4DE8h

l0800_4DE2:
	mov	byte ptr [0A050h],6h
	ret

l0800_4DE8:
	call	4E3Ch
	jnc	4DF1h

l0800_4DED:
	call	4E5Ah
	ret

l0800_4DF1:
	call	4EFFh
	and	ax,ax
	jz	4DFEh

l0800_4DF8:
	mov	byte ptr [0A050h],0Ah
	ret

l0800_4DFE:
	mov	byte ptr [0A050h],1h
	call	4EA9h
	jnc	4E0Dh

l0800_4E08:
	mov	byte ptr [0A050h],2h

l0800_4E0D:
	ret

l0800_4E0E:
	call	4E3Ch
	jc	4DEDh

l0800_4E13:
	call	4ECDh
	and	al,al
	jz	4E20h

l0800_4E1A:
	mov	byte ptr [0A050h],7h
	ret

l0800_4E20:
	mov	si,0B800h
	mov	es,si
	xor	si,si
	mov	ax,es:[si]
	not	ax
	not	word ptr es:[si]
	nop
	nop
	cmp	ax,es:[si]
	jnz	4E3Bh

l0800_4E36:
	mov	byte ptr [0A050h],1h

l0800_4E3B:
	ret

;; fn0800_4E3C: 0800:4E3C
;;   Called from:
;;     0800:4DE8 (in fn0800_4DD5)
;;     0800:4E0E (in fn0800_4DD5)
fn0800_4E3C proc
	mov	ax,1200h
	mov	bl,10h
	mov	bh,0FFh
	mov	cl,0Fh
	int	10h
	cmp	cl,0Ch
	jge	4E58h

l0800_4E4C:
	cmp	bh,1h
	jg	4E58h

l0800_4E51:
	cmp	bl,3h
	jg	4E58h

l0800_4E56:
	stc
	ret

l0800_4E58:
	clc
	ret

;; fn0800_4E5A: 0800:4E5A
;;   Called from:
;;     0800:4DED (in fn0800_4DD5)
fn0800_4E5A proc
	mov	byte ptr [0A050h],4h
	cmp	bh,1h
	jz	4E94h

l0800_4E64:
	call	4E9Ah
	jc	4E93h

l0800_4E69:
	and	bl,bl
	jz	4E93h

l0800_4E6D:
	mov	byte ptr [0A050h],3h
	call	4EA9h
	jc	4E8Eh

l0800_4E77:
	mov	bx,0C000h
	mov	es,bx
	mov	bx,39h
	cmp	word ptr es:[bx],345Ah
	jnz	4E93h

l0800_4E86:
	cmp	word ptr es:[bx+2h],3934h
	jnz	4E93h

l0800_4E8E:
	mov	byte ptr [0A050h],9h

l0800_4E93:
	ret

l0800_4E94:
	mov	byte ptr [0A050h],5h
	ret

;; fn0800_4E9A: 0800:4E9A
;;   Called from:
;;     0800:4E64 (in fn0800_4E5A)
fn0800_4E9A proc
	cmp	cl,2h
	jc	4EA8h

l0800_4E9F:
	cmp	cl,6h
	cmc
	jnc	4EA8h

l0800_4EA5:
	cmp	cl,8h

l0800_4EA8:
	ret

;; fn0800_4EA9: 0800:4EA9
;;   Called from:
;;     0800:4E03 (in fn0800_4DD5)
;;     0800:4E72 (in fn0800_4E5A)
fn0800_4EA9 proc
	mov	ax,1A00h
	int	10h
	cmp	al,1Ah
	jnz	4EC8h

l0800_4EB2:
	cmp	bl,7h
	jz	4EC6h

l0800_4EB7:
	cmp	bl,8h
	jz	4EC6h

l0800_4EBC:
	cmp	bl,0Bh
	jc	4EC8h

l0800_4EC1:
	cmp	bl,0Ch
	ja	4EC8h

l0800_4EC6:
	stc
	ret

l0800_4EC8:
	clc
	ret

;; fn0800_4ECA: 0800:4ECA
;;   Called from:
;;     0800:4DDD (in fn0800_4DD5)
fn0800_4ECA proc
	xor	al,al
	ret

;; fn0800_4ECD: 0800:4ECD
;;   Called from:
;;     0800:4E13 (in fn0800_4DD5)
fn0800_4ECD proc
	mov	dx,3BAh
	xor	bl,bl
	in	al,dx
	and	al,80h
	mov	ah,al
	mov	cx,8000h

l0800_4EDA:
	in	al,dx
	and	al,80h
	cmp	al,ah
	jz	4EE8h

l0800_4EE1:
	inc	bl
	cmp	bl,0Ah
	jnc	4EEDh

l0800_4EE8:
	loop	4EDAh

l0800_4EEA:
	xor	al,al
	ret

l0800_4EED:
	mov	cx,8000h

l0800_4EF0:
	in	al,dx
	and	al,30h
	cmp	al,10h
	jnz	4EFCh

l0800_4EF7:
	loop	4EF0h

l0800_4EF9:
	mov	al,2h
	ret

l0800_4EFC:
	mov	al,1h
	ret

;; fn0800_4EFF: 0800:4EFF
;;   Called from:
;;     0800:4DF1 (in fn0800_4DD5)
fn0800_4EFF proc
	mov	al,6h
	xor	cx,cx
	xor	dx,dx
	mov	ah,30h
	int	10h
	mov	ax,cx
	or	ax,dx
	jz	4F2Ch

l0800_4F0F:
	push	ds
	mov	ds,cx
	mov	bx,dx
	mov	al,[bx+2h]
	pop	ds
	or	al,al
	jz	4F20h

l0800_4F1C:
	cmp	al,2h
	jnz	4F2Ch

l0800_4F20:
	mov	dx,188h
	in	al,dx
	test	al,4h
	jz	4F2Ch

l0800_4F28:
	mov	ax,1h
	ret

l0800_4F2C:
	xor	ax,ax
	ret
0800:4F2F                                              00                .
0800:4F30 20 00 30 19 00 00 00 00 00 00 00 00 00 00 00 00  .0.............
0800:4F40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:4F50 1E 0E 1F 56 FF 94 13 00 5E 1F 2E FF 2E 70 00 90 ...V....^....p..
0800:4F60 20 20 00 C6 01 50 02 A7 00 A7 00 0D 01 18 01 65   ...P.........e
0800:4F70 01 A9 00 5C 01 7C 01 85 01 A7 00 A7 00 A7 00 A7 ...\.|..........
0800:4F80 00 9B 02 AA 02 DB 02 80 13 92 01 98 01 BC 01 34 ...............4
0800:4F90 01 5C 01 53 01 A7 00 71 01 71 01 B0 00 A7 00 A8 .\.S...q.q......
0800:4FA0 00 AE 00 A7 00 A7 00 A7 00 A7 00 A7 00 A7 00 A7 ................
0800:4FB0 00 A7 00 A7 00 A7 00 A7 00 A7 00 A7 00 A7 00 00 ................
0800:4FC0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:4FD0 00 10 27 00 00 00 00 00 00 00 00 00 00 08 00 08 ..'.............
0800:4FE0 01 00 00 00 00 64 00 64 00 00 01 00 00 00 00 01 .....d.d........
0800:4FF0 00 00 00 5E 5E 1F CB C3 C3 E8 01 04 EB F5 EB F3 ...^^...........
0800:5000 50 C7 06 84 00 00 00 C7 06 86 00 00 00 80 E4 7F P...............
0800:5010 3B C1 72 01 91 3B DA 72 02 87 DA 23 C0 78 21 23 ;.r..;.r...#.x!#
0800:5020 DB 78 1D 83 F9 01 7C 18 83 FA 01 7C 13 A3 84 00 .x....|....|....
0800:5030 89 1E 86 00 E8 16 00 58 22 E4 79 03 E8 02 00 C3 .......X".y.....
0800:5040 58 33 C0 8B D8 8B 0E 7D 00 8B 16 7F 00 A3 88 00 X3.....}........
0800:5050 89 1E 8A 00 89 0E 8C 00 89 16 8E 00 C3 E8 4C 00 ..............L.
0800:5060 A3 F0 02 89 1E F2 02 C3 8B 0E F0 02 8B 16 F2 02 ................
0800:5070 E8 EA FF 50 53 E8 1D 03 5B 58 BE 08 00 FF 1E 70 ...PS...[X.....p
0800:5080 00 E9 6F FF E8 25 00 E8 03 12 73 14 BE 2C 00 FF ..o..%....s..,..
0800:5090 1E 70 00 3C FF 75 09 C4 1E 78 00 26 C7 07 F9 FF .p.<.u...x.&....
0800:50A0 E9 50 FF E8 06 00 E8 E4 11 73 F5 C3 03 06 84 00 .P.......s......
0800:50B0 03 1E 86 00 C3 E8 06 00 E8 DA 02 E9 35 FF E8 EB ............5...
0800:50C0 FF 91 87 DA E8 E5 FF 91 87 DA C3 C3 E8 EF FF E8 ................
0800:50D0 6E 11 73 CC C3 3D FF FF 75 F1 0E 07 BB F4 02 E9 n.s..=..u.......
0800:50E0 11 FF E8 D8 11 E9 0B FF 80 3E 99 00 00 74 06 E8 .........>...t..
0800:50F0 D1 14 E9 FE FE 80 3E 6F 00 00 74 0F 8B C1 F7 26 ......>o..t....&
0800:5100 64 13 8B D8 8B 0E 66 13 E9 E8 FE C3 88 26 62 13 d.....f......&b.
0800:5110 A2 63 13 E9 DD FE 22 C0 74 01 C3 C6 06 92 00 00 .c....".t.......
0800:5120 C6 06 7C 00 00 89 1E 70 00 8C 06 72 00 A2 6F 00 ..|....p...r..o.
0800:5130 33 C0 8B F0 FF 1E 70 00 89 1E 74 00 8C 06 76 00 3.....p...t...v.
0800:5140 06 53 C4 3E 70 00 83 C7 10 B0 9A FC AA B8 38 03 .S.>p.........8.
0800:5150 AB 8C C8 AB 2E C4 36 74 00 83 C6 02 26 8B 04 A3 ......6t....&...
0800:5160 7D 00 2E C4 36 74 00 83 C6 04 26 8B 04 A3 7F 00 }...6t....&.....
0800:5170 A1 7D 00 B9 E8 03 F7 E1 2E C4 36 74 00 83 C6 0A .}........6t....
0800:5180 26 F7 34 40 A3 95 00 A1 7F 00 F7 E1 2E C4 36 74 &.4@..........6t
0800:5190 00 83 C6 0C 26 F7 34 40 A3 97 00 5B 07 E9 53 FE ....&.4@...[..S.
0800:51A0 50 53 51 52 06 26 8B 47 0C 40 40 A3 A3 04 26 8B PSQR.&.G.@@...&.
0800:51B0 47 0E A3 A5 04 26 8B 47 10 33 D2 B9 06 00 F7 F1 G....&.G.3......
0800:51C0 A3 9F 04 26 C4 5F 1A 89 1E 78 00 8C 06 7A 00 07 ...&._...x...z..
0800:51D0 5A 59 5B 58 FF 1E 70 00 C6 06 99 00 00 E9 13 FE ZY[X..p.........
0800:51E0 A3 9A 00 BE 1E 00 FF 1E 70 00 C3 A3 9A 00 C3 A3 ........p.......
0800:51F0 90 00 BE 20 00 FF 1E 70 00 C3 3C FF 75 07 C7 06 ... ...p..<.u...
0800:5200 90 00 0C 0C C3 A3 90 00 C3 32 C0 8B 1E A1 00 B9 .........2......
0800:5210 01 00 EB 05 32 C0 B9 03 00 A2 9E 00 88 0E 9F 00 ....2...........
0800:5220 B9 01 00 BE 22 00 FF 1E 70 00 C3 A2 9E 00 88 0E ...."...p.......
0800:5230 9F 00 89 1E A1 00 C3 00 00 00 00 00 00 00 00 00 ................
0800:5240 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:5250 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 ................
0800:5260 8A 06 12 00 03 04 20 00 CA 03 26 00 29 18 24 00 ...... ...&.).$.
0800:5270 97 13 28 00 73 16 16 00 0A 08 18 00 E7 07 0E 00 ..(.s...........
0800:5280 E3 0A 14 00 93 07 00 00 1E 0E 1F 50 8B FE BE 0E ...........P....
0800:5290 03 AD 23 C0 74 0C 3B C7 AD 75 F6 8B F8 58 FF D7 ..#.t.;..u...X..
0800:52A0 1F CB 58 1F CB A1 F0 02 8B 1E F2 02 EB 0A 2E A3 ..X.............
0800:52B0 F0 02 2E 89 1E F2 02 C3 E8 9A 02 72 0E A3 F0 02 ...........r....
0800:52C0 89 1E F2 02 BE 08 00 FF 1E 70 00 C3 03 06 F0 02 .........p......
0800:52D0 03 1E F2 02 A3 F0 02 89 1E F2 02 EB DB 03 06 F0 ................
0800:52E0 02 03 1E F2 02 50 53 E8 0A 00 5B 58 A3 F0 02 89 .....PS...[X....
0800:52F0 1E F2 02 C3 E8 5E 02 72 13 51 52 8B C8 8B D3 87 .....^.r.QR.....
0800:5300 06 F0 02 87 1E F2 02 E8 8B 00 5A 59 C3 E8 30 0F ..........ZY..0.
0800:5310 73 07 BE 12 00 FF 1E 70 00 C3 A3 90 00 C6 06 E2 s......p........
0800:5320 0A FF C3 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:5330 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
; ...
0800:5350 00 00 00 0E 07 43 41 8B FB BB D3 03 89 07 89 7F .....CA.........
0800:5360 02 89 47 04 89 57 06 89 4F 08 89 57 0A 89 4F 0C ..G..W..O..W..O.
0800:5370 89 7F 0E 89 47 10 89 7F 12 B8 00 80 89 47 14 89 ....G........G..
0800:5380 47 16 B8 06 00 B9 08 00 BE 0E 00 FF 1E 70 00 C3 G............p..
0800:5390 E8 C2 01 72 13 80 3E 9F 00 03 73 0D E8 ED 0C 73 ...r..>...s....s
0800:53A0 07 BE 0C 00 FF 1E 70 00 C3 E8 34 00 8B F8 2B F9 ......p...4...+.
0800:53B0 79 02 F7 DF 8B F3 2B F2 79 02 F7 DE 3B FE 8B 3E y.....+.y...;..>
0800:53C0 E0 0A 73 0F 2B C7 2B CF E8 15 00 D1 E7 03 C7 03 ..s.+.+.........
0800:53D0 CF EB 0D 2B DF 2B D7 E8 06 00 D1 E7 03 DF 03 D7 ...+.+..........
0800:53E0 50 53 51 52 57 E8 B4 FF 5F 5A 59 5B 58 C3 00 00 PSQRW..._ZY[X...
0800:53F0 00 00 00 00 00 00 00 00 00 00 00 00 00 3C 08 72 .............<.r
0800:5400 02 B0 05 32 E4 D0 E0 8B F8 FF A5 BD 04 CD 04 31 ...2...........1
0800:5410 05 6F 05 36 05 DF 04 5B 05 E5 04 E9 04 C6 06 9E .o.6...[........
0800:5420 04 01 C7 06 A1 04 00 00 C7 06 A7 04 00 00 C3 C6 ................
0800:5430 06 9E 04 02 C3 32 C0 EB 02 B0 FF E3 43 50 06 53 .....2......CP.S
0800:5440 51 33 C0 E8 B7 FF 59 5F 07 E8 F0 00 E8 5D FC E8 Q3....Y_.....]..
0800:5450 E0 00 23 C9 75 F3 58 22 C0 B8 01 00 74 1F C4 1E ..#.u.X"....t...
0800:5460 A3 04 26 8B 07 26 8B 5F 02 C7 06 A7 04 00 00 E8 ..&..&._........
0800:5470 46 FE B8 03 00 80 3E 9A 00 00 74 01 48 E8 7D FF F.....>...t.H.}.
0800:5480 C3 E8 2D 00 EB 58 E8 28 00 A1 A1 04 3B 06 9F 04 ..-..X.(....;...
0800:5490 73 19 3D 04 00 72 14 C4 1E A3 04 8B 0E 9F 04 C6 s.=..r..........
0800:54A0 06 9E 04 00 BE 0E 00 FF 1E 70 00 C6 06 9E 04 00 .........p......
0800:54B0 C3 B8 00 80 8B D8 E8 FF FD C6 06 9E 04 00 C3 81 ................
0800:54C0 3E 97 00 B4 00 72 05 C6 06 E2 0A FF 80 3E E2 0A >....r.......>..
0800:54D0 00 74 08 E8 DB FF E8 05 00 EB AE E8 A8 FF C6 06 .t..............
0800:54E0 9E 04 00 C4 3E A3 04 8B 0E A1 04 3B 0E 9F 04 72 ....>......;...r
0800:54F0 03 E9 D7 00 83 F9 02 72 B2 FF 36 F0 02 FF 36 F2 .......r..6...6.
0800:5500 02 E8 2B 00 E8 35 00 80 FF 80 75 0D 22 DB 74 16 ..+..5....u.".t.
0800:5510 E8 1C 00 23 C9 75 ED EB 0D 06 57 51 E8 D5 FD 59 ...#.u....WQ...Y
0800:5520 5F 07 23 C9 75 DE 8F 06 F2 02 8F 06 F0 02 C3 E8 _.#.u...........
0800:5530 0A 00 06 57 51 E8 80 FD 59 5F 07 C3 BB 00 80 E3 ...WQ...Y_......
0800:5540 0B 26 8B 05 47 47 26 8B 1D 47 47 49 C3 1E 0E 1F .&..GG&..GGI....
0800:5550 E8 02 00 1F C3 80 3E 9E 04 00 74 6E 80 3E 9E 04 ......>...tn.>..
0800:5560 02 74 10 83 3E A7 04 00 75 1A A3 A9 04 89 1E AB .t..>...u.......
0800:5570 04 EB 36 8A 16 9A 00 E8 13 0D 73 07 BE 30 00 FF ..6.......s..0..
0800:5580 1E 70 00 C3 3B 06 A9 04 75 1F 3B 1E AB 04 75 19 .p..;...u.;...u.
0800:5590 83 3E A7 04 01 74 32 E8 0F 00 B8 01 80 8B D8 E8 .>...t2.........
0800:55A0 07 00 C7 06 A7 04 00 00 C3 FF 06 A7 04 8B 3E A1 ..............>.
0800:55B0 04 3B 3E 9F 04 73 14 D1 E7 D1 E7 C4 36 A3 04 03 .;>..s......6...
0800:55C0 FE AB 26 89 1D FF 06 A1 04 F9 C3 06 53 C4 1E 78 ..&.........S..x
0800:55D0 00 26 C7 07 FA FF 5B 07 F9 C3 51 52 A3 04 03 89 .&....[...QR....
0800:55E0 1E 06 03 8B 0E F0 02 8B 16 F2 02 89 0E 00 03 89 ................
0800:55F0 16 02 03 E8 D1 00 A1 9A 00 72 09 86 E0 BE 1E 00 .........r......
0800:5600 FF 1E 70 00 8B 1E 06 03 53 A1 00 03 E8 E5 FC A1 ..p.....S.......
0800:5610 04 03 5B 50 E8 DD FC 58 8B 1E 02 03 53 E8 D4 FC ..[P...X....S...
0800:5620 5B A1 00 03 E8 CD FC A1 04 03 8B 1E 02 03 50 E8 [.............P.
0800:5630 86 FC 58 5A 59 0B C9 74 3F 52 8B D1 8B FA D1 E2 ..XZY..t?R......
0800:5640 03 D7 D1 EA D1 EA 80 3E 92 00 00 74 0F 8B CA F7 .......>...t....
0800:5650 D9 5F 23 FF 75 05 E8 4F 00 EB 1D 57 03 C1 2B DA ._#.u..O...W..+.
0800:5660 50 E8 90 FC 58 8B 1E 06 03 2B DA 53 E8 85 FC 5B P...X....+.S...[
0800:5670 5F 23 FF 74 03 E8 0B 00 A1 9A 00 BE 1E 00 FF 1E _#.t............
0800:5680 70 00 C3 A1 00 03 03 C1 E8 69 FC A1 00 03 8B 1E p........i......
0800:5690 06 03 53 E8 5E FC 5B A1 04 03 50 53 E8 19 FC 5B ..S.^.[...PS...[
0800:56A0 58 03 C1 2B DA E9 4C FC A1 00 03 8B 1E 06 03 53 X..+..L........S
0800:56B0 50 E8 04 FC 58 5B 2B DA 03 C1 53 E8 36 FC A1 04 P...X[+...S.6...
0800:56C0 03 03 C1 5B E9 2D FC 3B C1 7C 01 91 3B DA 7D 02 ...[.-.;.|..;.}.
0800:56D0 87 DA 40 49 4B 42 E8 34 FC F9 C3 F8 C3 00 00 00 ..@IKB.4........
0800:56E0 00 00 FF C6 06 92 07 00 E8 3C 01 80 3E 9F 00 03 .........<..>...
0800:56F0 73 12 BE 04 00 80 3E E2 0A 00 75 08 81 3E 97 00 s.....>...u..>..
0800:5700 B4 00 72 27 50 53 32 C0 B9 01 00 BE 22 00 FF 1E ..r'PS2....."...
0800:5710 70 00 33 C0 E8 E6 FC 5B 58 E8 9D 02 E8 6E 02 B8 p.3....[X....n..
0800:5720 01 00 E8 D8 FC A0 9E 00 E9 E0 FA E8 10 01 E8 5C ...............\
0800:5730 02 B8 05 00 E9 C6 FC FF 36 F0 02 FF 36 F2 02 50 ........6...6..P
0800:5740 53 FF 36 9A 00 33 FF 57 8B 3E F0 02 03 F8 8B 36 S.6..3.W.>.....6
0800:5750 F2 02 57 56 57 56 E8 47 05 C3 C6 06 92 07 FF 80 ..WVWV.G........
0800:5760 3E 92 00 00 74 02 87 CA E8 BC 00 80 3E E2 0A 00 >...t.......>...
0800:5770 75 08 81 3E 97 00 B4 00 72 03 E9 8F 02 33 D2 88 u..>....r....3..
0800:5780 16 91 07 89 16 8D 07 89 16 8F 07 89 16 04 03 89 ................
0800:5790 16 06 03 89 16 08 03 89 16 0A 03 E8 D0 01 50 53 ..............PS
0800:57A0 33 D2 B9 5A 00 F7 F1 8B F8 8B C3 33 D2 F7 F1 3D 3..Z.......3...=
0800:57B0 04 00 72 03 B8 03 00 8B F0 5B 58 3B F7 74 1E 53 ..r......[X;.t.S
0800:57C0 50 B8 5A 00 47 F7 E7 8B D8 58 53 33 F6 3B C3 9C P.Z.G....XS3.;..
0800:57D0 E8 6B 00 9D 74 03 E8 0E 01 58 5B EB C1 33 F6 3B .k..t....X[..3.;
0800:57E0 C3 9C E8 59 00 9D 74 03 E8 FC 00 A1 F0 02 8B 1E ...Y..t.........
0800:57F0 F2 02 8B 0E 8D 07 89 0E 04 03 8B 16 8F 07 89 16 ................
0800:5800 06 03 80 3E 92 07 00 74 1A 03 C8 03 D3 50 53 E8 ...>...t.....PS.
0800:5810 7E FB 5B 58 8B 0E 08 03 8B 16 0A 03 03 C8 03 D3 ~.[X............
0800:5820 E8 6D FB E8 67 01 C3 89 0E 00 03 89 16 02 03 50 .m..g..........P
0800:5830 A1 F0 02 A3 F4 02 A1 F2 02 A3 F6 02 58 C3 8B 0E ............X...
0800:5840 00 03 8B 16 02 03 80 3E 92 00 00 74 06 05 5A 00 .......>...t..Z.
0800:5850 83 C3 5A 8B FB 2B F8 89 3E 93 00 23 FF 75 03 E9 ..Z..+..>..#.u..
0800:5860 BF 00 FF 36 F0 02 FF 36 F2 02 51 52 FF 36 9A 00 ...6...6..QR.6..
0800:5870 BF FF FF 57 56 53 53 50 50 E8 BE 00 A3 04 03 58 ...WVSSPP......X
0800:5880 E8 C4 00 A3 06 03 58 E8 B0 00 A3 08 03 58 E8 B6 ......X......X..
0800:5890 00 A3 0A 03 5E 5E FF 36 04 03 FF 36 06 03 FF 36 ....^^.6...6...6
0800:58A0 08 03 50 8B C6 E8 55 FB A1 04 03 3B 06 08 03 75 ..P...U....;...u
0800:58B0 16 A1 06 03 3B 06 0A 03 75 0D 81 3E 93 00 5E 01 ....;...u..>..^.
0800:58C0 73 21 83 C4 14 EB 0A 83 3E 93 00 02 73 15 83 C4 s!......>...s...
0800:58D0 14 A1 08 03 8B 1E 0A 03 03 06 F0 02 03 1E F2 02 ................
0800:58E0 E9 D5 F9 E8 BA 03 C3 80 3E 92 07 00 75 08 B8 01 ........>...u...
0800:58F0 00 E8 09 FB EB 2B E8 AC F9 C4 1E A3 04 26 8B 07 .....+.......&..
0800:5900 26 8B 5F 02 C7 06 A7 04 00 00 E8 AB F9 B8 03 00 &._.............
0800:5910 E8 EA FA A1 A1 04 2D 03 00 72 06 A3 A1 04 E8 BD ......-..r......
0800:5920 FB 80 3E 91 07 00 75 11 C6 06 91 07 FF A1 04 03 ..>...u.........
0800:5930 A3 8D 07 A1 06 03 A3 8F 07 C3 5F E8 C9 06 8B 0E .........._.....
0800:5940 00 03 E8 11 00 FF E7 5F E8 C9 06 8B 0E 02 03 E8 ......._........
0800:5950 04 00 F7 D8 FF E7 8B D0 8B C3 8B D9 E8 03 00 8B ................
0800:5960 C2 C3 8B C8 8B C2 F7 E3 91 F7 E3 03 D1 C3 51 52 ..............QR
0800:5970 B9 68 01 33 D2 F7 F1 52 3B D9 74 08 33 D2 8B C3 .h.3...R;.t.3...
0800:5980 F7 F1 8B DA 58 3B C3 72 01 93 5A 59 C3 0E 07 FC ....X;.r..ZY....
0800:5990 BE F4 02 8B FE AD 2B 06 84 00 AB 8B D8 AD 2B 06 ......+.......+.
0800:59A0 86 00 AB 8B C8 BE 04 03 AD 03 C3 AB AD 03 C1 AB ................
0800:59B0 AD 03 C3 AB AD 03 C1 AB C3 3B C3 72 0B 81 C3 68 .........;.r...h
0800:59C0 01 EB 05 3B C3 72 01 93 80 3E 92 00 00 74 06 05 ...;.r...>...t..
0800:59D0 5A 00 83 C3 5A 8B 0E 00 03 89 0E 00 03 8B 0E 02 Z...Z...........
0800:59E0 03 89 0E 02 03 53 50 50 50 E8 4E FF A3 0C 03 58 .....SPPP.N....X
0800:59F0 E8 54 FF 8B D8 A1 0C 03 03 06 F0 02 03 1E F2 02 .T..............
0800:5A00 E8 B5 F8 58 58 5B 40 3B C3 7E DA C3 50 53 33 C0 ...XX[@;.~..PS3.
0800:5A10 E8 EA F9 5B 58 E8 AB FF E8 8A F8 C4 1E A3 04 26 ...[X..........&
0800:5A20 8B 07 26 8B 5F 02 E8 8F F8 B8 02 00 E9 CE F9 00 ..&._...........
0800:5A30 01 00 00 81 3E 97 00 B4 00 72 05 C6 06 E2 0A FF ....>....r......
0800:5A40 8B EC 83 EC 18 3D 03 00 72 26 89 4E F0 89 5E FE .....=..r&.N..^.
0800:5A50 89 46 F8 D1 E0 D1 E0 03 D8 89 5E FC FF 36 9A 00 .F........^..6..
0800:5A60 E8 D3 01 73 0B E8 0F 00 E8 2B 02 73 03 E8 07 00 ...s.....+.s....
0800:5A70 58 83 C4 18 E9 69 F7 06 1F E8 DB 00 8B 46 F4 89 X....i.......F..
0800:5A80 46 F6 C7 46 EE 00 00 E8 2F 00 E8 F9 00 8B 46 EC F..F..../.....F.
0800:5A90 80 7E E8 02 90 72 12 FF 46 EE 8B 5E EA 3B 5E EE .~...r..F..^.;^.
0800:5AA0 75 07 C7 46 EE 00 00 F7 EB 01 46 F6 8B 46 F6 3B u..F......F..F.;
0800:5AB0 46 F2 7C D3 1E 07 0E 1F C3 C7 46 FA 00 00 8B 5E F.|.......F....^
0800:5AC0 FE 43 43 8B 0F 8B 46 F6 83 C3 04 8B F9 8B 17 8B .CC...F.........
0800:5AD0 CA 80 FE 80 74 1A 3B D7 7C 02 87 D7 3B C2 7C E8 ....t.;.|...;.|.
0800:5AE0 3B C7 7D E4 53 51 E8 17 00 E8 3B 00 59 5B EB D5 ;.}.SQ....;.Y[..
0800:5AF0 80 FA 01 75 0A 83 C3 04 8B 0F 80 FD 80 75 C6 C3 ...u.........u..
0800:5B00 8B 77 FA 8B 7F FC 8B 4F FE 8B 17 3B D7 7C 04 87 .w.....O...;.|..
0800:5B10 CE 87 D7 8B C1 2B FA 74 0D 8B 46 F6 2B C2 2B F1 .....+.t..F.+.+.
0800:5B20 F7 EE F7 FF 03 C1 C3 8B D0 8B 76 FC 8B 46 FA 3B ..........v..F.;
0800:5B30 46 F0 73 22 FF 46 FA 23 C0 74 15 48 8B D8 D1 E3 F.s".F.#.t.H....
0800:5B40 8B 08 40 3B CA 7C 09 8B D8 D1 E3 89 08 48 75 EB ..@;.|.......Hu.
0800:5B50 8B D8 D1 E3 89 10 C3 C7 46 F4 FF 7F C7 46 F2 00 ........F....F..
0800:5B60 80 8B 5E FE 43 43 8B 07 43 43 80 FC 80 75 05 3C ..^.CC..CC...u.<
0800:5B70 01 74 F1 C3 3B 46 F4 7D 03 89 46 F4 3B 46 F2 7C .t..;F.}..F.;F.|
0800:5B80 E3 89 46 F2 EB DE 8B 76 FC 33 C0 8B 4E FA E3 26 ..F....v.3..N..&
0800:5B90 8B D8 D1 E3 50 56 1E 55 A9 01 00 8B 00 8B 5E F6 ....PV.U......^.
0800:5BA0 0E 1F 75 05 E8 14 00 EB 03 E8 21 00 5D 1F 5E 58 ..u.......!.].^X
0800:5BB0 40 3B 46 FA 72 DA C3 00 00 00 00 83 3E 44 0D 00 @;F.r.......>D..
0800:5BC0 74 03 E8 D1 00 A3 67 0C 89 1E 69 0C C3 83 3E 44 t.....g...i...>D
0800:5BD0 0D 00 74 03 E8 BF 00 8B C8 8B D3 87 0E 67 0C 87 ..t..........g..
0800:5BE0 16 69 0C 3B C1 72 01 91 80 3E E2 0A 00 75 03 E9 .i.;.r...>...u..
0800:5BF0 1B F7 BE 0C 00 FF 1E 70 00 C3 00 00 01 00 00 02 .......p........
0800:5C00 04 02 00 5A 00 00 0A E1 87 02 0A 01 E1 87 02 02 ...Z............
0800:5C10 05 87 E1 03 02 05 87 87 01 5A 0A 00 00 01 87 11 .........Z......
0800:5C20 E1 E1 03 05 01 00 00 03 0A 01 00 00 03 05 02 00 ................
0800:5C30 00 00 00 01 00 00 C7 06 44 0D 00 00 A0 90 00 FE ........D.......
0800:5C40 C8 F8 78 4F 80 3E E2 0A 00 75 02 32 C0 8A D8 D0 ..xO.>...u.2....
0800:5C50 E3 D0 E3 02 D8 32 FF 81 C3 AA 0C 8B F3 AC 88 46 .....2.........F
0800:5C60 E8 AC 32 E4 89 46 EA AC F7 2E E0 0A 89 46 EC AC ..2..F.......F..
0800:5C70 32 E4 80 3E 92 00 00 74 08 80 3E E2 0A 00 74 01 2..>...t..>...t.
0800:5C80 AC E8 12 00 06 A0 9B 00 8A E0 BE 1E 00 FF 1E 70 ...............p
0800:5C90 00 07 F9 C3 00 00 32 C0 C3 00 00 00 00 00 00 00 ......2.........
0800:5CA0 55 8B EC 83 EC 2A 8B 46 0E E8 72 02 89 46 0E A3 U....*.F..r..F..
0800:5CB0 9A 00 8B 46 0A 8B 5E 08 E8 15 02 89 46 DA 8B 46 ...F..^.....F..F
0800:5CC0 06 8B 5E 04 E8 09 02 C6 46 D6 00 3B 46 DA 7F 04 ..^.....F..;F...
0800:5CD0 C6 46 D6 FF 89 46 D8 F7 46 12 FF FF 75 03 FF 46 .F...F..F...u..F
0800:5CE0 12 F7 46 10 FF FF 75 03 FF 46 10 8B 46 10 8B 5E ..F...u..F..F..^
0800:5CF0 12 3B C3 77 02 8B C3 F7 E0 BB 64 00 E8 0A 02 73 .;.w......d....s
0800:5D00 03 E9 D1 00 89 46 DC 89 56 DE 8B 5E 12 E8 E7 01 .....F..V..^....
0800:5D10 E8 E4 01 89 46 F8 89 56 FA 33 C0 89 46 FE 89 46 ....F..V.3..F..F
0800:5D20 EC 89 46 EE 8B 46 DC 8B 56 DE 8B 5E 10 89 5E FC ..F..F..V..^..^.
0800:5D30 E8 C4 01 E8 C1 01 89 46 F4 89 56 F6 E8 CA 01 73 .......F..V....s
0800:5D40 03 E9 91 00 8B F2 8B F8 E8 BE 01 73 03 E9 85 00 ...........s....
0800:5D50 2B 46 DC 1B 56 DE 89 46 F0 89 56 F2 D1 E7 D1 D6 +F..V..F..V.....
0800:5D60 89 7E E8 89 76 EA E8 DE 00 E8 72 00 8B 46 F0 8B .~..v.....r..F..
0800:5D70 5E F2 03 C0 13 DB 03 46 E4 13 5E E6 03 46 E4 13 ^......F..^..F..
0800:5D80 5E E6 3B 5E E2 7C 0A 75 05 3B 46 E0 72 03 E8 94 ^.;^.|.u.;F.r...
0800:5D90 00 E8 6F 00 8B 46 EE 3B 46 EA 7C CA 75 08 8B 46 ..o..F.;F.|.u..F
0800:5DA0 EC 3B 46 E8 72 C0 E8 9E 00 E8 32 00 8B 46 E4 8B .;F.r.....2..F..
0800:5DB0 5E E6 D1 EB D1 D8 03 46 F0 13 5E F2 3B 5E E2 7F ^......F..^.;^..
0800:5DC0 0A 75 05 3B 46 E0 77 03 E8 38 00 E8 57 00 F7 46 .u.;F.w..8..W..F
0800:5DD0 FC 00 80 74 D1 8B E5 5D E8 58 01 C2 14 00 8B 46 ...t...].X.....F
0800:5DE0 EC 03 46 F8 89 46 E4 8B 46 EE 13 46 FA 89 46 E6 ..F..F..F..F..F.
0800:5DF0 8B 46 E8 2B 46 F4 89 46 E0 8B 46 EA 1B 46 F6 89 .F.+F..F..F..F..
0800:5E00 46 E2 C3 FF 46 FE 8B 46 E4 01 46 F0 8B 46 E6 11 F...F..F..F..F..
0800:5E10 46 F2 8B 46 E4 03 46 F8 89 46 EC 8B 46 E6 13 46 F..F..F..F..F..F
0800:5E20 FA 89 46 EE C3 FF 4E FC 8B 46 E0 29 46 F0 8B 46 ..F...N..F.)F..F
0800:5E30 E2 19 46 F2 8B 46 E0 2B 46 F4 89 46 E8 8B 46 E2 ..F..F.+F..F..F.
0800:5E40 1B 46 F6 89 46 EA C3 8B 56 0E 8B 76 FE 8B 7E FC .F..F...V..v..~.
0800:5E50 F7 46 0C 00 80 75 37 56 57 8B C6 8B DF 8B C8 8B .F...u7VW.......
0800:5E60 D3 F7 D8 E8 16 00 5F 5E 56 57 F7 DF 8B C6 8B DF ......_^VW......
0800:5E70 8B C8 8B D3 F7 D8 E8 03 00 5F 5E C3 03 46 16 03 ........._^..F..
0800:5E80 5E 14 03 4E 16 03 56 14 55 E8 81 F4 5D C3 E8 0E ^..N..V.U...]...
0800:5E90 00 F7 DE E8 09 00 F7 DE F7 DF E8 02 00 F7 DE 8B ................
0800:5EA0 C6 8B DF E8 2A 00 80 7E D6 00 75 0B 3B 46 DA 7C ....*..~..u.;F.|
0800:5EB0 05 3B 46 D8 7E 0C C3 3B 46 DA 7D 06 3B 46 D8 7E .;F.~..;F.}.;F.~
0800:5EC0 01 C3 57 56 03 76 16 03 7E 14 E8 4A 00 5E 5F C3 ..WV.v..~..J.^_.
0800:5ED0 F7 DB 0A E4 78 0F 0A FF 78 05 2B D8 8B C3 C3 05 ....x...x.+.....
0800:5EE0 70 17 03 C3 C3 0A FF 78 08 F7 D8 05 D0 07 2B C3 p......x......+.
0800:5EF0 C3 05 A0 0F 2B C3 C3 0B DB F9 74 0C 33 C9 87 CA ....+.....t.3...
0800:5F00 91 F7 F3 91 F7 F3 87 CA C3 8B C8 8B C2 F7 E3 72 ...............r
0800:5F10 05 91 F7 E3 03 D1 C3 8B C6 8B DF E9 9A F3 80 3E ...............>
0800:5F20 6F 00 00 75 24 50 BE 32 00 FF 1E 70 00 26 8B 1F o..u$P.2...p.&..
0800:5F30 58 EB 12 80 3E 6F 00 00 75 0F BE 32 00 FF 1E 70 X...>o..u..2...p
0800:5F40 00 26 8B 5F 02 0E E8 01 00 C3 06 53 CB 00 00 00 .&._.......S....
0800:5F50 00 00 00 3B 02 77 04 B2 06 ED 08 27 0B 61 0D 99 ...;.w.....'.a..
0800:5F60 0F D0 11 06 14 3A 16 6C 18 9C 1A CB 1C F7 1E 20 .....:.l....... 
0800:5F70 21 48 23 6C 25 8D 27 AC 29 C7 2B DF 2D F3 2F 03 !H#l%.'.).+.-./.
0800:5F80 32 0F 34 18 36 1C 38 1C 3A 17 3C 0E 3E 00 40 EC 2.4.6.8.:.<.>.@.
0800:5F90 41 D4 43 B6 45 93 47 6A 49 3C 4B 08 4D CD 4E 8D A.C.E.GjI<K.M.N.
0800:5FA0 50 46 52 F9 53 A6 55 4B 57 EA 58 82 5A 13 5C 9C PFR.S.UKW.X.Z.\.
0800:5FB0 5D 1F 5F 9A 60 0D 62 79 63 DD 64 39 66 8D 67 D9 ]._.`.byc.d9f.g.
0800:5FC0 68 1D 6A 59 6B 8C 6C B7 6D D9 6E F3 6F 04 71 0C h.jYk.l.m.n.o.q.
0800:5FD0 72 0B 73 01 74 EF 74 D3 75 AD 76 7F 77 47 78 06 r.s.t.t.u.v.wGx.
0800:5FE0 79 BC 79 68 7A 0A 7B A3 7B 32 7C B8 7C 33 7D A5 y.yhz.{.{2|.|3}.
0800:5FF0 7D 0E 7E 6C 7E C1 7E 0B 7F 4C 7F 83 7F B0 7F D3 }.~l~.~..L......
0800:6000 7F EC 7F FB 7F 00 80 55 83 EC 00 8B EC 83 46 04 .......U......F.
0800:6010 5A EB 07 90 55 83 EC 00 8B EC C6 06 00 10 00 8B Z...U...........
0800:6020 46 04 85 C0 7D 06 F7 D8 F6 16 00 10 33 D2 B9 68 F...}.......3..h
0800:6030 01 F7 F9 8B C2 3D B4 00 7E 07 2D B4 00 F6 16 00 .....=..~.-.....
0800:6040 10 3D 5A 00 7E 05 F7 D8 05 B4 00 D1 E0 8B F0 8B .=Z.~...........
0800:6050 9C 01 10 8B CB 33 C0 F8 D1 D3 D1 D0 80 3E 00 10 .....3.......>..
0800:6060 00 74 0A F7 D3 F7 D0 83 C3 01 15 00 00 83 C4 00 .t..............
0800:6070 5D C3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ]...............
0800:6080 00 00 00 00 00 00 00 00 00 00 00 00 C6 06 83 00 ................
0800:6090 01 80 3E 92 00 00 75 39 E8 F2 01 73 0C 91 87 DA ..>...u9...s....
0800:60A0 E8 EA 01 91 87 DA 73 01 C3 A3 34 11 89 1E 36 11 ......s...4...6.
0800:60B0 89 0E 38 11 89 16 3A 11 E8 28 00 80 3E 83 00 00 ..8...:..(..>...
0800:60C0 74 11 A1 34 11 8B 1E 36 11 8B 0E 38 11 8B 16 3A t..4...6...8...:
0800:60D0 11 F9 C3 B8 FF FF 8B D8 8B C8 8B D0 C6 06 83 00 ................
0800:60E0 00 F8 C3 BB 34 11 E8 F4 00 8A E8 BB 38 11 E8 EC ....4.......8...
0800:60F0 00 0A C5 75 01 C3 A1 38 11 2B 06 34 11 70 D4 A3 ...u...8.+.4.p..
0800:6100 30 11 A1 3A 11 2B 06 36 11 70 C8 A3 32 11 BB 34 0..:.+.6.p..2..4
0800:6110 11 E8 C9 00 8A E8 BB 38 11 E8 C1 00 8A D0 0A C5 .......8........
0800:6120 75 01 C3 22 D5 74 06 C6 06 83 00 00 C3 22 ED 75 u..".t.......".u
0800:6130 03 E8 D5 00 C6 06 83 00 02 83 3E 30 11 00 75 1E ..........>0..u.
0800:6140 A1 36 11 3B 06 8A 00 7D 06 A1 8A 00 A3 36 11 A1 .6.;...}.....6..
0800:6150 8E 00 3B 06 36 11 7D 03 A3 36 11 EB 76 90 83 3E ..;.6.}..6..v..>
0800:6160 32 11 00 75 1E A1 34 11 3B 06 88 00 7D 06 A1 88 2..u..4.;...}...
0800:6170 00 A3 34 11 A1 8C 00 3B 06 34 11 7D 03 A3 34 11 ..4....;.4.}..4.
0800:6180 EB 51 90 A1 34 11 3B 06 88 00 7D 0D A1 88 00 50 .Q..4.;...}....P
0800:6190 E8 9C 00 8F 06 34 11 EB 3A A1 8C 00 3B 06 34 11 .....4..:...;.4.
0800:61A0 7D 0A 50 E8 89 00 8F 06 34 11 EB 27 A1 36 11 3B }.P.....4..'.6.;
0800:61B0 06 8A 00 7D 0D A1 8A 00 50 E8 62 00 8F 06 36 11 ...}....P.b...6.
0800:61C0 EB 11 A1 8E 00 3B 06 36 11 7D 08 50 E8 4F 00 8F .....;.6.}.P.O..
0800:61D0 06 36 11 22 ED 75 03 E8 2F 00 E9 31 FF 32 D2 8B .6.".u../..1.2..
0800:61E0 07 3B 06 88 00 7D 02 B2 01 3B 06 8C 00 7E 02 B2 .;...}...;...~..
0800:61F0 02 8B 47 02 3B 06 8A 00 7D 03 80 C2 04 3B 06 8E ..G.;...}....;..
0800:6200 00 7E 03 80 C2 08 8A C2 C3 A1 34 11 87 06 38 11 .~........4...8.
0800:6210 A3 34 11 A1 36 11 87 06 3A 11 A3 36 11 C3 2B 06 .4..6...:..6..+.
0800:6220 36 11 F7 2E 30 11 F7 3E 32 11 01 06 34 11 C3 2B 6...0..>2...4..+
0800:6230 06 34 11 F7 2E 32 11 F7 3E 30 11 01 06 36 11 C3 .4...2..>0...6..
0800:6240 80 3E 92 00 00 75 36 50 53 51 52 E8 3E FE 72 05 .>...u6PSQR.>.r.
0800:6250 87 DA E8 37 FE 5A 59 5B 58 73 23 8B 3E 88 00 8B ...7.ZY[Xs#.>...
0800:6260 36 8C 00 E8 19 00 91 E8 15 00 91 8B 3E 8A 00 8B 6...........>...
0800:6270 36 8E 00 93 E8 08 00 93 92 E8 03 00 92 F9 C3 3B 6..............;
0800:6280 C7 7D 03 8B C7 C3 3B C6 76 02 8B C6 C3 80 3E 92 .}....;.v.....>.
0800:6290 00 00 75 18 3B 06 8C 00 77 14 3B 1E 8E 00 77 0E ..u.;...w.;...w.
0800:62A0 3B 06 88 00 7C 08 3B 1E 8A 00 7C 02 F9 C3 F8 C3 ;...|.;...|.....
0800:62B0 00 00 00 00 00 00 00 00 08 00 00 00 00 32 ED E3 .............2..
0800:62C0 0E 53 06 88 0E 6C 13 E8 0E 01 07 5B E8 3B 01 C3 .S...l.....[.;..
0800:62D0 80 3E 6F 00 00 75 06 E8 0D 00 E9 16 ED BE 24 00 .>o..u........$.
0800:62E0 FF 1E 70 00 E9 0C ED 22 E4 79 28 80 3E 6F 00 00 ..p....".y(.>o..
0800:62F0 75 18 50 53 51 52 BE 24 00 FF 1E 70 00 E8 0A 00 u.PSQR.$...p....
0800:6300 5A 59 5B 58 80 E4 7F E9 DB 01 89 1E 64 13 89 0E ZY[X........d...
0800:6310 66 13 C3 A3 60 13 89 1E 64 13 89 0E 66 13 C7 06 f...`...d...f...
0800:6320 68 13 08 00 C6 06 99 00 00 C7 06 6A 13 00 00 C7 h..........j....
0800:6330 06 68 15 00 00 80 3E 7C 00 03 74 17 22 C0 74 19 .h....>|..t.".t.
0800:6340 E8 4F 02 83 3E 68 15 00 74 0F C6 06 99 00 FF 89 .O..>h..t.......
0800:6350 1E 68 13 C7 06 6A 13 FF FF 8B 1E 64 13 8B 0E 66 .h...j.....d...f
0800:6360 13 80 3E 99 00 00 74 03 E8 54 00 A1 60 13 8B 16 ..>...t..T..`...
0800:6370 62 13 80 3E 99 00 00 74 05 E8 46 01 EB 19 0B DB b..>...t..F.....
0800:6380 75 05 BB 08 00 8B CB 33 D2 80 3E 6F 00 00 75 07 u......3..>o..u.
0800:6390 BE 24 00 FF 1E 70 00 89 1E 64 13 89 0E 66 13 C3 .$...p...d...f..
0800:63A0 00 00 03 05 02 03 03 04 01 01 04 03 05 03 02 01 ................
0800:63B0 05 02 03 01 04 01 E8 06 00 A1 60 13 E9 03 01 8B ..........`.....
0800:63C0 1E 68 13 83 FB 0A 72 03 BB 0A 00 D0 E3 8B 9F 50 .h....r........P
0800:63D0 14 8A CF 32 ED 32 FF C3 A1 F0 02 8B 1E F2 02 53 ...2.2.........S
0800:63E0 8B D8 80 3E 6A 13 00 75 03 E8 4F 00 58 53 8B D8 ...>j..u..O.XS..
0800:63F0 80 3E 6B 13 00 75 03 E8 68 00 58 A3 F0 02 89 1E .>k..u..h.X.....
0800:6400 F2 02 BE 08 00 FF 1E 70 00 C3 80 3E 6A 13 00 75 .......p...>j..u
0800:6410 08 A1 F0 02 23 C0 79 01 C3 8A 0E 6C 13 32 ED A1 ....#.y....l.2..
0800:6420 62 13 80 3E 7C 00 00 75 0A 80 3E 99 00 00 74 03 b..>|..u..>...t.
0800:6430 E9 46 03 BE 26 00 FF 1E 70 00 C3 A1 66 13 80 3E .F..&...p...f..>
0800:6440 61 13 01 74 10 80 3E 62 13 00 74 15 A0 6C 13 32 a..t..>b..t..l.2
0800:6450 E4 F7 26 64 13 80 3E 62 13 01 75 03 D1 E8 48 2B ..&d..>b..u...H+
0800:6460 D8 C3 A1 66 13 80 3E 61 13 01 75 09 A0 6C 13 32 ...f..>a..u..l.2
0800:6470 E4 F7 26 64 13 80 3E 63 13 02 74 0B 80 3E 63 13 ..&d..>c..t..>c.
0800:6480 01 75 02 D1 E8 2B D8 C3 00 00 00 00 00 00 00 00 .u...+..........
0800:6490 FF 00 01 00 01 00 01 00 01 00 01 00 01 00 01 00 ................
0800:64A0 01 00 2B 00 00 00 00 00 00 00 00 00 00 00 00 00 ..+.............
0800:64B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0800:64C0 00 00 80 3E 7C 00 03 74 1B 88 26 41 15 3A 06 40 ...>|..t..&A.:.@
0800:64D0 15 74 27 A2 40 15 53 51 E8 85 00 59 5B 72 1B C6 .t'.@.SQ...Y[r..
0800:64E0 06 40 15 FF C3 A3 4A 15 89 1E 4C 15 89 0E 4E 15 .@....J...L...N.
0800:64F0 89 16 50 15 33 DB 89 1E 68 13 23 DB 75 24 A1 4A ..P.3...h.#.u$.J
0800:6500 15 A3 42 15 A1 4E 15 A3 46 15 A1 4C 15 23 C0 75 ..B..N..F..L.#.u
0800:6510 01 40 A3 44 15 A1 50 15 23 C0 75 01 40 A3 48 15 .@.D..P.#.u.@.H.
0800:6520 EB 31 89 1E 42 15 89 1E 46 15 89 0E 44 15 89 0E .1..B...F...D...
0800:6530 48 15 80 3E 41 15 00 75 1A 8B 1E 81 00 B9 10 27 H..>A..u.......'
0800:6540 3B D9 73 0F F7 E1 F7 F3 8B D8 23 DB 75 01 43 89 ;.s.......#.u.C.
0800:6550 1E 42 15 E8 4B 00 8B 1E 6A 15 8B 0E 6C 15 F9 C3 .B..K...j...l...
0800:6560 A1 68 15 23 C0 75 06 C6 06 40 15 FF C3 C7 06 66 .h.#.u...@.....f
0800:6570 15 00 00 C5 36 66 15 B9 10 00 BF 52 15 0E 07 F3 ....6f.....R....
0800:6580 A4 0E 1F 80 3E 52 15 2B C6 06 59 15 00 F9 74 01 ....>R.+..Y...t.
0800:6590 F5 C3 8E C2 33 F6 26 80 3C 2B 75 04 89 16 68 15 ....3.&.<+u...h.
0800:65A0 C3 A0 5A 15 2A 06 5C 15 32 E4 50 F7 26 42 15 F7 ..Z.*.\.2.P.&B..
0800:65B0 36 44 15 A3 6A 15 58 F7 26 46 15 F7 36 48 15 A3 6D..j.X.&F..6H..
0800:65C0 6C 15 C3 E8 09 00 8B 1E 6E 15 8B 0E 6C 15 C3 53 l.......n...l..S
0800:65D0 51 E8 CD FF A1 53 15 D1 E0 05 10 00 C5 3E 66 15 Q....S.......>f.
0800:65E0 03 F8 33 D2 E3 1E 26 8A 07 43 2E 2A 06 56 15 2E ..3...&..C.*.V..
0800:65F0 3A 06 53 15 73 0C 32 E4 8B F7 03 F0 02 14 73 02 :.S.s.2.......s.
0800:6600 FE C6 E2 E2 0E 1F 8B C2 F7 26 42 15 F7 36 44 15 .........&B..6D.
0800:6610 A3 6E 15 59 5B C3 C7 06 62 15 00 00 C7 06 64 15 .n.Y[...b.....d.
0800:6620 00 00 2A 06 56 15 3A 06 53 15 72 01 C3 32 E4 D1 ..*.V.:.S.r..2..
0800:6630 E0 C4 3E 66 15 8B DF 83 C3 10 03 D8 26 03 3F 03 ..>f........&.?.
0800:6640 3E 57 15 80 3E 59 15 00 74 05 EB 77 90 5F 07 E8 >W..>Y..t..w._..
0800:6650 59 00 06 57 D0 E0 32 E4 8B F8 FF A5 0E 17 16 17 Y..W..2.........
0800:6660 45 17 3B 17 47 17 A1 62 15 8B 1E 64 15 8A 0E 92 E.;.G..b...d....
0800:6670 00 80 E1 01 8A 2E 41 15 3A CD 75 08 22 C9 74 05 ......A.:.u.".t.
0800:6680 F7 D8 EB 01 93 E8 AB 01 5F 07 C3 E8 93 00 A3 62 ........_......b
0800:6690 15 89 1E 64 15 EB B6 E8 87 00 8B C8 8B D3 87 0E ...d............
0800:66A0 62 15 87 16 64 15 E8 95 01 EB A2 26 8B 0D 86 E9 b...d......&....
0800:66B0 47 47 32 C0 F6 C5 80 74 02 04 02 F6 C1 80 74 02 GG2....t......t.
0800:66C0 FE C0 C3 06 57 33 C0 E8 33 ED 5F 07 E8 DC FF 06 ....W3..3._.....
0800:66D0 57 D0 E0 32 E4 8B F8 FF 95 8F 17 5F 07 EB ED 97 W..2......._....
0800:66E0 17 A5 17 B0 17 B0 17 FF 0E A1 04 B8 03 00 E8 0C ................
0800:66F0 ED 58 E9 71 FF B8 03 00 E8 02 ED 33 C0 E9 FD EC .X.q.......3....
0800:6700 E8 1E 00 A3 62 15 89 1E 64 15 F7 DB 80 3E 92 00 ....b...d....>..
0800:6710 00 74 03 F7 D8 93 03 06 F0 02 03 1E F2 02 E9 97 .t..............
0800:6720 EB 8A C5 E8 10 00 E8 22 00 50 8A C1 E8 07 00 E8 .......".P......
0800:6730 30 00 8B D8 58 C3 33 D2 24 7F 8A D8 32 FF 24 40 0...X.3.$...2.$@
0800:6740 74 06 FE CF 4A 80 CB 80 8B C3 C3 8B 1E 42 15 83 t...J........B..
0800:6750 FB 01 74 02 F7 EB 8B 1E 44 15 83 FB 01 74 02 F7 ..t.....D....t..
0800:6760 FB C3 8B 1E 46 15 83 FB 01 74 02 F7 EB 8B 1E 48 ....F....t.....H
0800:6770 15 83 FB 01 74 02 F7 FB C3 80 3E 40 15 FF 74 45 ....t.....>@..tE
0800:6780 E3 43 FF 36 9E 00 A3 70 15 06 53 E8 38 00 51 32 .C.6...p..S.8.Q2
0800:6790 C0 B9 01 00 E8 74 EA 80 3E 59 15 00 74 08 A1 9A .....t..>Y..t...
0800:67A0 00 86 C4 E8 3A EA 59 5B 07 26 8A 07 22 C0 74 0C ....:.Y[.&..".t.
0800:67B0 06 53 51 E8 60 FE 59 5B 07 43 E2 ED 58 50 E8 4A .SQ.`.Y[.C..XP.J
0800:67C0 EA 8F 06 9E 00 C3 51 E8 05 FE E8 05 00 E8 35 00 ......Q.......5.
0800:67D0 59 C3 A1 6E 15 80 3E 41 15 00 74 07 A1 6C 15 01 Y..n..>A..t..l..
0800:67E0 06 F0 02 80 3E 70 15 00 74 1A 80 3E 70 15 01 75 ....>p..t..>p..u
0800:67F0 03 D1 E8 48 80 3E 92 00 00 74 05 01 06 F2 02 C3 ...H.>...t......
0800:6800 29 06 F0 02 C3 A1 6E 15 80 3E 41 15 00 75 03 A1 ).....n..>A..u..
0800:6810 6C 15 80 3E 71 15 00 74 19 80 3E 71 15 01 75 02 l..>q..t..>q..u.
0800:6820 D1 E8 80 3E 92 00 00 74 05 01 06 F0 02 C3 01 06 ...>...t........
0800:6830 F2 02 C3 F7 DB 01 1E F2 02 01 06 F0 02 C3 50 A0 ..............P.
0800:6840 92 00 24 01 8A 26 41 15 3A C4 75 0B 22 C0 58 74 ..$..&A.:.u.".Xt
0800:6850 0E F7 D8 F7 D9 EB 0C 58 93 87 CA F7 D8 F7 D9 F7 .......X........
0800:6860 DB F7 DA 03 06 F0 02 03 1E F2 02 03 0E F0 02 03 ................
0800:6870 16 F2 02 E8 16 F8 73 07 BE 0C 00 FF 1E 70 00 C3 ......s......p..

;; fn0800_6880: 0800:6880
;;   Called from:
;;     0800:6E93 (in fn0800_6E01)
fn0800_6880 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	or	si,si
	jl	689Fh

l0800_688B:
	cmp	si,58h
	jbe	6893h

l0800_6890:
	mov	si,57h

l0800_6893:
	mov	[0A05Ah],si
	mov	al,[si+0A05Ch]
	cbw
	xchg	si,ax
	jmp	68ACh

l0800_689F:
	neg	si
	cmp	si,23h
	ja	6890h

l0800_68A6:
	mov	word ptr [0A05Ah],0FFFFh

l0800_68AC:
	mov	ax,si
	mov	[6FF6h],ax
	mov	ax,0FFFFh
	jmp	68B6h

l0800_68B6:
	pop	si
	pop	bp
	ret	2h
0800:68BB                                  C3                        .   

;; fn0800_68BC: 0800:68BC
;;   Called from:
;;     0800:018A (in fn0800_0100)
;;     0800:6D9A (in fn0800_6D94)
fn0800_68BC proc
	push	bp
	mov	bp,sp
	jmp	68CBh

l0800_68C1:
	mov	bx,[0A0C0h]
	shl	bx,1h
	call	word ptr [bx+0A382h]

l0800_68CB:
	mov	ax,[0A0C0h]
	dec	word ptr [0A0C0h]
	or	ax,ax
	jnz	68C1h

l0800_68D6:
	call	word ptr [0A0B6h]
	call	word ptr [0A0B8h]
	call	word ptr [0A0BAh]
	push	word ptr [bp+4h]
	call	018Dh
	pop	cx
	pop	bp
	ret
0800:68EB                                  55 8B EC 83 3E            U...>
0800:68F0 C0 A0 20 75 05 B8 01 00 EB 15 8B 46 04 8B 1E C0 .. u.......F....
0800:6900 A0 D1 E3 89 87 82 A3 FF 06 C0 A0 33 C0 EB 00 5D ...........3...]
0800:6910 C3                                              .              

;; fn0800_6911: 0800:6911
;;   Called from:
;;     0800:6A3D (in fn0800_69F0)
;;     0800:6CBC (in fn0800_6C8F)
;;     0800:6CF0 (in fn0800_6CC6)
fn0800_6911 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,[bp+4h]
	mov	ax,[di+6h]
	mov	[0A3C4h],ax
	cmp	ax,di
	jnz	692Bh

l0800_6923:
	mov	word ptr [0A3C4h],0h
	jmp	693Bh

l0800_692B:
	mov	si,[di+4h]
	mov	bx,[0A3C4h]
	mov	[bx+4h],si
	mov	ax,[0A3C4h]
	mov	[si+6h],ax

l0800_693B:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_693F: 0800:693F
;;   Called from:
;;     0800:6A2F (in fn0800_69F0)
fn0800_693F proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,[bp+4h]
	mov	ax,[bp+6h]
	sub	[di],ax
	mov	si,[di]
	add	si,di
	mov	ax,[bp+6h]
	inc	ax
	mov	[si],ax
	mov	[si+2h],di
	mov	ax,[0A3C2h]
	cmp	ax,di
	jnz	6966h

l0800_6960:
	mov	[0A3C2h],si
	jmp	696Eh

l0800_6966:
	mov	di,si
	add	di,[bp+6h]
	mov	[di+2h],si

l0800_696E:
	mov	ax,si
	add	ax,4h
	jmp	6975h

l0800_6975:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_6979: 0800:6979
;;   Called from:
;;     0800:6A54 (in fn0800_69F0)
fn0800_6979 proc
	push	bp
	mov	bp,sp
	push	si
	mov	ax,[bp+4h]
	xor	dx,dx
	and	ax,0FFFFh
	and	dx,0h
	push	dx
	push	ax
	call	6A82h
	pop	cx
	pop	cx
	mov	si,ax
	cmp	si,0FFh
	jnz	699Bh

l0800_6997:
	xor	ax,ax
	jmp	69B3h

l0800_699B:
	mov	ax,[0A3C2h]
	mov	[si+2h],ax
	mov	ax,[bp+4h]
	inc	ax
	mov	[si],ax
	mov	[0A3C2h],si
	mov	ax,[0A3C2h]
	add	ax,4h
	jmp	69B3h

l0800_69B3:
	pop	si
	pop	bp
	ret

;; fn0800_69B6: 0800:69B6
;;   Called from:
;;     0800:6A12 (in fn0800_69F0)
fn0800_69B6 proc
	push	bp
	mov	bp,sp
	push	si
	mov	ax,[bp+4h]
	xor	dx,dx
	and	ax,0FFFFh
	and	dx,0h
	push	dx
	push	ax
	call	6A82h
	pop	cx
	pop	cx
	mov	si,ax
	cmp	si,0FFh
	jnz	69D8h

l0800_69D4:
	xor	ax,ax
	jmp	69EDh

l0800_69D8:
	mov	[0A3C6h],si
	mov	[0A3C2h],si
	mov	ax,[bp+4h]
	inc	ax
	mov	[si],ax
	mov	ax,si
	add	ax,4h
	jmp	69EDh

l0800_69ED:
	pop	si
	pop	bp
	ret

;; fn0800_69F0: 0800:69F0
;;   Called from:
;;     0800:0317 (in fn0800_02F8)
;;     0800:032B (in fn0800_02F8)
;;     0800:6DB2 (in fn0800_6DAC)
fn0800_69F0 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,[bp+4h]
	or	di,di
	jnz	6A00h

l0800_69FC:
	xor	ax,ax
	jmp	6A5Ah

l0800_6A00:
	mov	ax,di
	add	ax,0Bh
	and	ax,0FFF8h
	mov	di,ax
	cmp	word ptr [0A3C6h],0h
	jnz	6A18h

l0800_6A11:
	push	di
	call	69B6h
	pop	cx
	jmp	6A5Ah

l0800_6A18:
	mov	si,[0A3C4h]
	mov	ax,si
	or	ax,ax
	jz	6A53h

l0800_6A22:
	mov	ax,[si]
	mov	dx,di
	add	dx,28h
	cmp	ax,dx
	jc	6A36h

l0800_6A2D:
	push	di
	push	si
	call	693Fh
	pop	cx
	pop	cx
	jmp	6A5Ah

l0800_6A36:
	mov	ax,[si]
	cmp	ax,di
	jc	6A4Ah

l0800_6A3C:
	push	si
	call	6911h
	pop	cx
	inc	word ptr [si]
	mov	ax,si
	add	ax,4h
	jmp	6A5Ah

l0800_6A4A:
	mov	si,[si+6h]
	cmp	si,[0A3C4h]
	jnz	6A22h

l0800_6A53:
	push	di
	call	6979h
	pop	cx
	jmp	6A5Ah

l0800_6A5A:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_6A5E: 0800:6A5E
;;   Called from:
;;     0800:6ABC (in fn0800_6AB6)
fn0800_6A5E proc
	push	bp
	mov	bp,sp
	mov	ax,[bp+4h]
	mov	dx,sp
	sub	dx,100h
	cmp	ax,dx
	jnc	6A75h

l0800_6A6E:
	mov	[6FE2h],ax
	xor	ax,ax
	jmp	6A80h

l0800_6A75:
	mov	word ptr [6FF6h],8h
	mov	ax,0FFFFh
	jmp	6A80h

l0800_6A80:
	pop	bp
	ret

;; fn0800_6A82: 0800:6A82
;;   Called from:
;;     0800:698B (in fn0800_6979)
;;     0800:69C8 (in fn0800_69B6)
fn0800_6A82 proc
	push	bp
	mov	bp,sp
	mov	ax,[bp+4h]
	mov	dx,[bp+6h]
	add	ax,[6FE2h]
	adc	dx,0h
	mov	cx,ax
	add	cx,100h
	adc	dx,0h
	or	dx,dx
	jnz	6AA9h

l0800_6A9F:
	cmp	cx,sp
	jnc	6AA9h

l0800_6AA3:
	xchg	[6FE2h],ax
	jmp	6AB4h

l0800_6AA9:
	mov	word ptr [6FF6h],8h
	mov	ax,0FFFFh
	jmp	6AB4h

l0800_6AB4:
	pop	bp
	ret

;; fn0800_6AB6: 0800:6AB6
;;   Called from:
;;     0800:6CD4 (in fn0800_6CC6)
;;     0800:6D0B (in fn0800_6CC6)
;;     0800:6D15 (in fn0800_6CC6)
fn0800_6AB6 proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+4h]
	call	6A5Eh
	pop	cx
	jmp	6AC2h

l0800_6AC2:
	pop	bp
	ret
0800:6AC4             55 8B EC 8B 46 04 99 52 50 E8 B2 FF     U...F..RP...
0800:6AD0 8B E5 EB 00 5D C3                               ....].         

;; fn0800_6AD6: 0800:6AD6
;;   Called from:
;;     0800:6B77 (in fn0800_6B55)
fn0800_6AD6 proc
	push	bp
	mov	bp,sp
	sub	sp,22h
	push	si
	push	di
	push	es
	mov	di,[bp+0Ah]
	push	ds
	pop	es
	mov	bx,[bp+8h]
	cmp	bx,24h
	ja	6B44h

l0800_6AEC:
	cmp	bl,2h
	jc	6B44h

l0800_6AF1:
	mov	ax,[bp+0Ch]
	mov	cx,[bp+0Eh]
	or	cx,cx
	jge	6B0Ch

l0800_6AFB:
	cmp	byte ptr [bp+6h],0h
	jz	6B0Ch

l0800_6B01:
	mov	byte ptr [di],2Dh
	inc	di
	neg	cx
	neg	ax
	sbb	cx,0h

l0800_6B0C:
	lea	si,[bp-22h]
	jcxz	6B20h

l0800_6B11:
	xchg	cx,ax
	sub	dx,dx
	div	bx
	xchg	cx,ax
	div	bx
	mov	[si],dl
	inc	si
	jcxz	6B27h

l0800_6B1E:
	jmp	6B11h

l0800_6B20:
	sub	dx,dx
	div	bx
	mov	[si],dl
	inc	si

l0800_6B27:
	or	ax,ax
	jnz	6B20h

l0800_6B2B:
	lea	cx,[bp-22h]
	neg	cx
	add	cx,si
	cld

l0800_6B33:
	dec	si
	mov	al,[si]
	sub	al,0Ah
	jnc	6B3Eh

l0800_6B3A:
	add	al,3Ah
	jmp	6B41h

l0800_6B3E:
	add	al,[bp+4h]

l0800_6B41:
	stosb
	loop	6B33h

l0800_6B44:
	mov	al,0h
	stosb
	pop	es
	mov	ax,[bp+0Ah]
	jmp	6B4Dh

l0800_6B4D:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	0Ch

;; fn0800_6B55: 0800:6B55
;;   Called from:
;;     0800:0608 (in fn0800_05E9)
fn0800_6B55 proc
	push	bp
	mov	bp,sp
	cmp	word ptr [bp+8h],0Ah
	jnz	6B64h

l0800_6B5E:
	mov	ax,[bp+4h]
	cwd
	jmp	6B69h

l0800_6B64:
	mov	ax,[bp+4h]
	xor	dx,dx

l0800_6B69:
	push	dx
	push	ax
	push	word ptr [bp+6h]
	push	word ptr [bp+8h]
	mov	al,1h
	push	ax
	mov	al,61h
	push	ax
	call	6AD6h
	jmp	6B7Ch

l0800_6B7C:
	pop	bp
	ret
0800:6B7E                                           55 8B               U.
0800:6B80 EC FF 76 06 FF 76 04 FF 76 08 FF 76 0A B0 00 50 ..v..v..v..v...P
0800:6B90 B0 61 50 E8 40 FF EB 00 5D C3 55 8B EC FF 76 06 .aP.@...].U...v.
0800:6BA0 FF 76 04 FF 76 08 FF 76 0A 83 7E 0A 0A 75 05 B8 .v..v..v..~..u..
0800:6BB0 01 00 EB 02 33 C0 50 B0 61 50 E8 19 FF EB 00 5D ....3.P.aP.....]
0800:6BC0 C3                                              .              

;; fn0800_6BC1: 0800:6BC1
;;   Called from:
;;     0800:6F60 (in fn0800_6F53)
fn0800_6BC1 proc
	push	si
	xchg	si,ax
	xchg	dx,ax
	test	ax,ax
	jz	6BCAh

l0800_6BC8:
	mul	bx

l0800_6BCA:
	xchg	cx,ax
	test	ax,ax
	jz	6BD3h

l0800_6BCF:
	mul	si
	add	cx,ax

l0800_6BD3:
	xchg	si,ax
	mul	bx
	add	dx,cx
	pop	si
	retf
0800:6BDA                               55 8B EC 56 57 1E           U..VW.
0800:6BE0 07 FC 8B 7E 04 32 C0 B9 FF FF F2 AE 8B C1 F7 D0 ...~.2..........
0800:6BF0 48 EB 00 5F 5E 5D C3                            H.._^].        

;; fn0800_6BF7: 0800:6BF7
;;   Called from:
;;     0800:02A2 (in fn0800_0267)
;;     0800:1167 (in fn0800_111E)
fn0800_6BF7 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	pop	es
	mov	ax,[bp+4h]
	cmp	ax,[bp+6h]
	jnc	6C0Ch

l0800_6C06:
	std
	mov	ax,1h
	jmp	6C0Fh

l0800_6C0C:
	cld
	xor	ax,ax

l0800_6C0F:
	mov	si,[bp+4h]
	mov	di,[bp+6h]
	mov	cx,[bp+8h]
	or	ax,ax
	jz	6C22h

l0800_6C1C:
	add	si,cx
	dec	si
	add	di,cx
	dec	di

l0800_6C22:
	test	di,1h
	jz	6C2Ch

l0800_6C28:
	jcxz	6C3Bh

l0800_6C2A:
	movsb
	dec	cx

l0800_6C2C:
	sub	si,ax
	sub	di,ax
	shr	cx,1h

l0800_6C32:
	rep movsw

l0800_6C34:
	jnc	6C3Bh

l0800_6C36:
	add	si,ax
	add	di,ax
	movsb

l0800_6C3B:
	cld
	pop	di
	pop	si
	pop	bp
	ret
0800:6C40 55 8B EC FF 76 08 FF 76 04 FF 76 06 E8 A8 FF 8B U...v..v..v.....
0800:6C50 E5 8B 46 04 5D C3                               ..F.].         

;; fn0800_6C56: 0800:6C56
;;   Called from:
;;     0800:6D51 (in fn0800_6D1F)
fn0800_6C56 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+4h]
	cmp	word ptr [0A3C4h],0h
	jz	6C81h

l0800_6C65:
	mov	bx,[0A3C4h]
	mov	di,[bx+6h]
	mov	bx,[0A3C4h]
	mov	[bx+6h],si
	mov	[di+4h],si
	mov	[si+6h],di
	mov	ax,[0A3C4h]
	mov	[si+4h],ax
	jmp	6C8Bh

l0800_6C81:
	mov	[0A3C4h],si
	mov	[si+4h],si
	mov	[si+6h],si

l0800_6C8B:
	pop	di
	pop	si
	pop	bp
	ret

;; fn0800_6C8F: 0800:6C8F
;;   Called from:
;;     0800:6D62 (in fn0800_6D1F)
fn0800_6C8F proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	si
	push	di
	mov	si,[bp+6h]
	mov	di,[bp+4h]
	mov	ax,[si]
	add	[di],ax
	mov	ax,[0A3C2h]
	cmp	ax,si
	jnz	6CAEh

l0800_6CA8:
	mov	[0A3C2h],di
	jmp	6CBBh

l0800_6CAE:
	mov	ax,[si]
	add	ax,si
	mov	[bp-2h],ax
	mov	bx,[bp-2h]
	mov	[bx+2h],di

l0800_6CBB:
	push	si
	call	6911h
	pop	cx
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret

;; fn0800_6CC6: 0800:6CC6
;;   Called from:
;;     0800:6D87 (in fn0800_6D6D)
fn0800_6CC6 proc
	push	si
	mov	ax,[0A3C6h]
	cmp	ax,[0A3C2h]
	jnz	6CE2h

l0800_6CD0:
	push	word ptr [0A3C6h]
	call	6AB6h
	pop	cx
	xor	ax,ax
	mov	[0A3C2h],ax
	mov	[0A3C6h],ax
	jmp	6D1Dh

l0800_6CE2:
	mov	bx,[0A3C2h]
	mov	si,[bx+2h]
	test	word ptr [si],1h
	jnz	6D11h

l0800_6CEF:
	push	si
	call	6911h
	pop	cx
	cmp	si,[0A3C6h]
	jnz	6D04h

l0800_6CFA:
	xor	ax,ax
	mov	[0A3C2h],ax
	mov	[0A3C6h],ax
	jmp	6D0Ah

l0800_6D04:
	mov	ax,[si+2h]
	mov	[0A3C2h],ax

l0800_6D0A:
	push	si
	call	6AB6h
	pop	cx
	jmp	6D1Dh

l0800_6D11:
	push	word ptr [0A3C2h]
	call	6AB6h
	pop	cx
	mov	[0A3C2h],si

l0800_6D1D:
	pop	si
	ret

;; fn0800_6D1F: 0800:6D1F
;;   Called from:
;;     0800:6D8D (in fn0800_6D6D)
fn0800_6D1F proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	si
	push	di
	mov	si,[bp+4h]
	dec	word ptr [si]
	mov	ax,[si]
	add	ax,si
	mov	[bp-2h],ax
	mov	di,[si+2h]
	test	word ptr [di],1h
	jnz	6D50h

l0800_6D3C:
	cmp	si,[0A3C6h]
	jz	6D50h

l0800_6D42:
	mov	ax,[si]
	add	[di],ax
	mov	bx,[bp-2h]
	mov	[bx+2h],di
	mov	si,di
	jmp	6D55h

l0800_6D50:
	push	si
	call	6C56h
	pop	cx

l0800_6D55:
	mov	bx,[bp-2h]
	test	word ptr [bx],1h
	jnz	6D67h

l0800_6D5E:
	push	word ptr [bp-2h]
	push	si
	call	6C8Fh
	pop	cx
	pop	cx

l0800_6D67:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret

;; fn0800_6D6D: 0800:6D6D
;;   Called from:
;;     0800:02E1 (in fn0800_02D6)
;;     0800:6DA6 (in fn0800_6DA0)
fn0800_6D6D proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	or	si,si
	jnz	6D7Ah

l0800_6D78:
	jmp	6D91h

l0800_6D7A:
	mov	ax,si
	add	ax,0FFFCh
	mov	si,ax
	cmp	si,[0A3C2h]
	jnz	6D8Ch

l0800_6D87:
	call	6CC6h
	jmp	6D91h

l0800_6D8C:
	push	si
	call	6D1Fh
	pop	cx

l0800_6D91:
	pop	si
	pop	bp
	ret

;; fn0800_6D94: 0800:6D94
;;   Called from:
;;     0800:3009 (in fn0800_2FEC)
fn0800_6D94 proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+6h]
	call	68BCh
	pop	cx
	pop	bp
	retf

;; fn0800_6DA0: 0800:6DA0
;;   Called from:
;;     0800:3061 (in fn0800_3042)
fn0800_6DA0 proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+6h]
	call	6D6Dh
	pop	cx
	pop	bp
	retf

;; fn0800_6DAC: 0800:6DAC
;;   Called from:
;;     0800:3016 (in fn0800_3010)
fn0800_6DAC proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+6h]
	call	69F0h
	pop	cx
	mov	dx,ds
	jmp	6DBAh

l0800_6DBA:
	pop	bp
	retf

;; fn0800_6DBC: 0800:6DBC
;;   Called from:
;;     0800:01D2 (in fn0800_01CE)
fn0800_6DBC proc
	push	bp
	mov	bp,sp
	push	cs
	push	word ptr [bp+4h]
	push	cs
	call	30B4h
	mov	sp,bp
	pop	bp
	ret
0800:6DCB                                  55 8B EC 0E FF            U....
0800:6DD0 76 04 0E E8 9C C3 8B E5 5D C3                   v.......].     

;; fn0800_6DDA: 0800:6DDA
;;   Called from:
;;     0800:03E5 (in fn0800_03CD)
fn0800_6DDA proc
	push	bp
	mov	bp,sp
	sub	sp,8h
	lea	ax,[bp-8h]
	push	ax
	call	6F96h
	pop	cx
	lea	ax,[bp-8h]
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	call	6E01h
	add	sp,8h
	jmp	6DFDh

l0800_6DFD:
	mov	sp,bp
	pop	bp
	ret

;; fn0800_6E01: 0800:6E01
;;   Called from:
;;     0800:6DF5 (in fn0800_6DDA)
fn0800_6E01 proc
	push	bp
	mov	bp,sp
	sub	sp,0Eh
	push	si
	push	di
	push	ds
	lea	cx,[bp-0Ah]
	mov	[bp-0Eh],cx
	mov	[bp-0Ch],ss
	mov	byte ptr [bp-0Ah],55h
	mov	byte ptr [bp-9h],0CDh
	mov	ax,[bp+4h]
	mov	[bp-8h],al
	mov	word ptr [bp-7h],0CB5Dh
	cmp	al,25h
	jc	6E3Fh

l0800_6E2A:
	cmp	al,26h
	ja	6E3Fh

l0800_6E2E:
	mov	byte ptr [bp-7h],36h
	mov	word ptr [bp-6h],68Fh
	mov	[bp-4h],cx
	mov	word ptr [bp-2h],0CB5Dh

l0800_6E3F:
	mov	si,[bp+0Ah]
	push	word ptr [si]
	push	word ptr [si+6h]
	mov	si,[bp+6h]
	mov	ax,[si]
	mov	bx,[si+2h]
	mov	cx,[si+4h]
	mov	dx,[si+6h]
	mov	di,[si+0Ah]
	mov	si,[si+8h]
	pop	ds
	pop	es
	call	dword ptr [bp-0Eh]
	pushf
	pushf
	push	si
	push	ds
	push	es
	mov	ds,[bp-14h]
	mov	si,[bp+0Ah]
	pop	word ptr [si]
	pop	word ptr [si+6h]
	mov	si,[bp+8h]
	pop	word ptr [si+8h]
	pop	word ptr [si+0Eh]
	pop	word ptr [si+0Ch]
	and	word ptr [si+0Ch],1h
	mov	[si+0Ah],di
	mov	[si+6h],dx
	mov	[si+4h],cx
	mov	[si+2h],bx
	mov	[si],ax
	pop	ds
	jz	6E97h

l0800_6E91:
	push	ax
	push	ax
	call	6880h
	pop	ax

l0800_6E97:
	jmp	6E99h

l0800_6E99:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret
0800:6E9F                                              33                3
0800:6EA0 C9 EB 0D B9 01 00 EB 08 B9 02 00 EB 03 B9 03 00 ................
0800:6EB0 55 56 57 8B EC 8B F9 8B 46 0A 8B 56 0C 8B 5E 0E UVW.....F..V..^.
0800:6EC0 8B 4E 10 0B C9 75 08 0B D2 74 69 0B DB 74 65 F7 .N...u...ti..te.
0800:6ED0 C7 01 00 75 1C 0B D2 79 0A F7 DA F7 D8 83 DA 00 ...u...y........
0800:6EE0 83 CF 0C 0B C9 79 0A F7 D9 F7 DB 83 D9 00 83 F7 .....y..........
0800:6EF0 04 8B E9 B9 20 00 57 33 FF 33 F6 D1 E0 D1 D2 D1 .... .W3.3......
0800:6F00 D6 D1 D7 3B FD 72 0B 77 04 3B F3 72 05 2B F3 1B ...;.r.w.;.r.+..
0800:6F10 FD 40 E2 E7 5B F7 C3 02 00 74 06 8B C6 8B D7 D1 .@..[....t......
0800:6F20 EB F7 C3 04 00 74 07 F7 DA F7 D8 83 DA 00 5F 5E .....t........_^
0800:6F30 5D CA 08 00 F7 F3 F7 C7 02 00 74 02 8B C2 33 D2 ].........t...3.
0800:6F40 EB EC 55 8B EC 8B 46 04 33 D2 89 16 C4 A0 A3 C2 ..U...F.3.......
0800:6F50 A0 5D C3                                        .].            

;; fn0800_6F53: 0800:6F53
;;   Called from:
;;     0800:11C5 (in fn0800_111E)
;;     0800:11E1 (in fn0800_111E)
;;     0800:1208 (in fn0800_111E)
fn0800_6F53 proc
	mov	dx,[0A0C4h]
	mov	ax,[0A0C2h]
	mov	cx,15Ah
	mov	bx,4E35h
	push	cs
	call	6BC1h
	add	ax,1h
	adc	dx,0h
	mov	[0A0C4h],dx
	mov	[0A0C2h],ax
	mov	ax,[0A0C4h]
	and	ax,7FFFh
	jmp	6F79h

l0800_6F79:
	ret
0800:6F7A                               55 8B EC 56 57 1E           U..VW.
0800:6F80 C5 76 06 C4 7E 0A FC D1 E9 F3 A5 13 C9 F3 A4 1F .v..~...........
0800:6F90 5F 5E 5D CA 08 00                               _^]...         

;; fn0800_6F96: 0800:6F96
;;   Called from:
;;     0800:6DE4 (in fn0800_6DDA)
fn0800_6F96 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	mov	[si],es
	mov	[si+2h],cs
	mov	[si+4h],ss
	mov	[si+6h],ds
	pop	si
	pop	bp
	ret

;; fn0800_6FAB: 0800:6FAB
;;   Called from:
;;     0800:0894 (in fn0800_06F3)
;;     0800:0BC2 (in fn0800_0B33)
fn0800_6FAB proc
	push	bp
	mov	bp,sp
	mov	bx,[bp+4h]
	mov	ax,34DDh
	mov	dx,12h
	cmp	dx,bx
	jnc	6FD5h

l0800_6FBB:
	div	bx
	mov	bx,ax
	in	al,61h
	test	al,3h
	jnz	6FCDh

l0800_6FC5:
	or	al,3h
	out	61h,al
	mov	al,0B6h
	out	43h,al

l0800_6FCD:
	mov	al,bl
	out	42h,al
	mov	al,bh
	out	42h,al

l0800_6FD5:
	pop	bp
	ret

;; fn0800_6FD7: 0800:6FD7
;;   Called from:
;;     0800:08A0 (in fn0800_06F3)
;;     0800:0BD3 (in fn0800_0B33)
;;     0800:0CC9 (in fn0800_0BDC)
fn0800_6FD7 proc
	in	al,61h
	and	al,0FCh
	out	61h,al
	ret
0800:6FDE                                           00 00               ..
