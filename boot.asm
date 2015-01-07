;%define	_BOOT_DEBUG_	; �궨�巽���

%ifdef	_BOOT_DEBUG_
	org  0100h			; ����״̬, ��ֱ�����У�0100hΪ�Կ��洢
%else
	org  07c00h			; Boot ״̬, Bios ���� Boot Sector ���ص� 0:7C00 ������ʼִ��,��������
%endif
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	call	str			; ������ʾ�ַ�������
	jmp	$			; ��ѭ��
str:
	mov	ax, BootMessage
	mov	bp, ax			; ES:BP = ����ַ
	mov	cx, 23			; CX = ������
	mov	ax, 01301h		; AH = 13,  AL = 01h
	mov	bx, 000ch		; ҳ��Ϊ0(BH = 0) �ڵ׺���(BL = 0Ch,����)
	mov	dl, 0
	int	10h			; ����10h���ж�
	ret
BootMessage:		db	"Hello, XBB! I am an OS"
times 	510-($-$$)	db	0	; ������̵ĵ�һ����ʣ�µĿռ䣬ʹ���ɵĶ����ƴ���ǡ��Ϊ512�ֽ�
dw 	0xaa55				; ��������������־
