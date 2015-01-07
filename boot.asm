;%define	_BOOT_DEBUG_	; 宏定义方便调

%ifdef	_BOOT_DEBUG_
	org  0100h			; 调试状态, 可直接运行，0100h为显卡存储
%else
	org  07c00h			; Boot 状态, Bios 将把 Boot Sector 加载到 0:7C00 处并开始执行,软盘启动
%endif
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	call	str			; 调用显示字符串例程
	jmp	$			; 死循环
str:
	mov	ax, BootMessage
	mov	bp, ax			; ES:BP = 串地址
	mov	cx, 23			; CX = 串长度
	mov	ax, 01301h		; AH = 13,  AL = 01h
	mov	bx, 000ch		; 页号为0(BH = 0) 黑底红字(BL = 0Ch,高亮)
	mov	dl, 0
	int	10h			; 触发10h号中断
	ret
BootMessage:		db	"Hello, XBB! I am an OS"
times 	510-($-$$)	db	0	; 填充软盘的第一扇区剩下的空间，使生成的二进制代码恰好为512字节
dw 	0xaa55				; 引导扇区结束标志
