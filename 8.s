	.file	"8.c"
	.intel_syntax noprefix
	.text
	.local	count
	.comm	count,4,4
	.globl	f
	.type	f, @function
f:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0		#double x	
	mov	eax, DWORD PTR count[rip]	#counter
	add	eax, 1
	mov	DWORD PTR count[rip], eax
	movsd	xmm0, QWORD PTR -8[rbp]		# x
	mulsd	xmm0, QWORD PTR -8[rbp]		#x * x
	mulsd	xmm0, QWORD PTR -8[rbp]		#x*x*x
	mulsd	xmm0, QWORD PTR -8[rbp]		#x*x*x*x
	mulsd	xmm0, QWORD PTR -8[rbp]		#x*x*x*x*x
	subsd	xmm0, QWORD PTR -8[rbp]		#-0.2
	movsd	xmm1, QWORD PTR .LC0[rip]
	subsd	xmm0, xmm1			#return answer
	pop	rbp
	ret
	.size	f, .-f
	.globl	chord_method
	.type	chord_method, @function
chord_method:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR -40[rbp], rdi		#f
	movsd	QWORD PTR -48[rbp], xmm0	#a
	movsd	QWORD PTR -56[rbp], xmm1	#b
	movsd	QWORD PTR -64[rbp], xmm2	#eps
	mov	QWORD PTR -72[rbp], rsi		#*x
	mov	DWORD PTR -4[rbp], 0		#i = 0
	jmp	.L4
.L8:
	movsd	xmm0, QWORD PTR -56[rbp]
	subsd	xmm0, QWORD PTR -48[rbp]
	movq	xmm1, QWORD PTR .LC1[rip]
	andpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -64[rbp]
	ucomisd	xmm1, xmm0
	ja	.L11
	mov	rdx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR -80[rbp], rdx
	movsd	xmm0, QWORD PTR -80[rbp]
	call	rax
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR -80[rbp], rdx
	movsd	xmm0, QWORD PTR -80[rbp]
	call	rax
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movsd	xmm0, QWORD PTR -56[rbp]
	subsd	xmm0, QWORD PTR -48[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	subsd	xmm1, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -56[rbp]
	subsd	xmm1, xmm0
	movapd	xmm0, xmm1
	movsd	QWORD PTR -48[rbp], xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	subsd	xmm0, QWORD PTR -56[rbp]
	mulsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR -16[rbp]
	subsd	xmm1, QWORD PTR -24[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -48[rbp]
	subsd	xmm1, xmm0
	movapd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	add	DWORD PTR -4[rbp], 1
.L4:
	cmp	DWORD PTR -4[rbp], 99999
	jle	.L8
	jmp	.L7
.L11:
	nop
.L7:
	cmp	DWORD PTR -4[rbp], 99999
	jg	.L9
	mov	rax, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	QWORD PTR [rax], xmm0
	mov	eax, DWORD PTR count[rip]	#return counter
	jmp	.L10
.L9:
	mov	eax, -1				#return -1
.L10:
	leave
	ret
	.size	chord_method, .-chord_method
	.section	.rodata
	.align 8
.LC2:
	.string	"Incrorrect input, check README.md"
.LC3:
	.string	"-h"
.LC4:
	.string	"\n-h help"
	.align 8
.LC5:
	.string	"-f use numbers from first file and save result in second file"
	.align 8
.LC6:
	.string	"-s take numbers from terminal and print result in file"
.LC7:
	.string	"-f"
.LC8:
	.string	"r"
.LC9:
	.string	"w"
.LC10:
	.string	"incorrect file"
.LC11:
	.string	"%lf"
.LC12:
	.string	"Root: %lf\nIterations: %d\n"
.LC13:
	.string	"I cant find root:(\n"
.LC15:
	.string	"time: %.6lf\n"
.LC16:
	.string	"-s"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	DWORD PTR -132[rbp], edi		#argc
	mov	QWORD PTR -144[rbp], rsi		#argv
	cmp	DWORD PTR -132[rbp], 2			#check correct input
	je	.L13
	cmp	DWORD PTR -132[rbp], 4			#check correct input
	je	.L13
	cmp	DWORD PTR -132[rbp], 3			#check correct input
	je	.L13
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L13:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	strcmp@PLT				#-h flag
	test	eax, eax
	jne	.L15
	lea	rdi, .LC4[rip]
	call	puts@PLT
	lea	rdi, .LC5[rip]
	call	puts@PLT
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L16
.L15:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	strcmp@PLT				#-f flag
	test	eax, eax
	jne	.L17
	cmp	DWORD PTR -132[rbp], 4
	je	.L18
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L18:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax			#input
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax			#out
	cmp	QWORD PTR -40[rbp], 0
	je	.L20
	cmp	QWORD PTR -48[rbp], 0
	jne	.L21
.L20:
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L21:
	call	clock@PLT
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -64[rbp]
	mov	rax, QWORD PTR -40[rbp]
	lea	rsi, .LC11[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	lea	rdx, -72[rbp]				
	mov	rax, QWORD PTR -40[rbp]			#a
	lea	rsi, .LC11[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	lea	rdx, -80[rbp]
	mov	rax, QWORD PTR -40[rbp]			#b
	lea	rsi, .LC11[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	movsd	xmm1, QWORD PTR -80[rbp]		
	movsd	xmm0, QWORD PTR -72[rbp]		#eps
	mov	rax, QWORD PTR -64[rbp]
	lea	rdx, -88[rbp]
	mov	rsi, rdx
	movapd	xmm2, xmm1				#x
	movapd	xmm1, xmm0				#eps
	mov	QWORD PTR -152[rbp], rax		#b
	movsd	xmm0, QWORD PTR -152[rbp]		#a
	lea	rdi, f[rip]				#f
	call	chord_method
	test	eax, eax
	jle	.L22
	mov	edx, DWORD PTR count[rip]		#return count
	mov	rcx, QWORD PTR -88[rbp]
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -152[rbp], rcx
	movsd	xmm0, QWORD PTR -152[rbp]
	lea	rsi, .LC12[rip]				#out
	mov	rdi, rax				
	mov	eax, 1
	call	fprintf@PLT
	jmp	.L23
.L22:
	mov	rax, QWORD PTR -48[rbp]
	mov	rcx, rax
	mov	edx, 19
	mov	esi, 1
	lea	rdi, .LC13[rip]
	call	fwrite@PLT
.L23:
	call	clock@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	sub	rax, QWORD PTR -16[rbp]
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC14[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0		#t
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -152[rbp], rdx
	movsd	xmm0, QWORD PTR -152[rbp]
	lea	rsi, .LC15[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L16
.L17:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC16[rip]
	mov	rdi, rax
	call	strcmp@PLT				#-s
	test	eax, eax
	jne	.L16
	cmp	DWORD PTR -132[rbp], 3
	je	.L24
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L24:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	call	fopen@PLT				#out
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L26
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L26:
	call	clock@PLT
	mov	QWORD PTR -16[rbp], rax
	lea	rax, -96[rbp]
	mov	rsi, rax
	lea	rdi, .LC11[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, -104[rbp]				#a
	mov	rsi, rax
	lea	rdi, .LC11[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, -112[rbp]				#b
	mov	rsi, rax
	lea	rdi, .LC11[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm1, QWORD PTR -112[rbp]
	movsd	xmm0, QWORD PTR -104[rbp]		#eps
	mov	rax, QWORD PTR -96[rbp]
	lea	rdx, -120[rbp]
	mov	rsi, rdx
	movapd	xmm2, xmm1				#x
	movapd	xmm1, xmm0				#eps
	mov	QWORD PTR -152[rbp], rax		#b
	movsd	xmm0, QWORD PTR -152[rbp]		#a
	lea	rdi, f[rip]				#f
	call	chord_method
	test	eax, eax
	jle	.L27
	mov	edx, DWORD PTR count[rip]		#return count
	mov	rcx, QWORD PTR -120[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR -152[rbp], rcx
	movsd	xmm0, QWORD PTR -152[rbp]
	lea	rsi, .LC12[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	jmp	.L28
.L27:
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	mov	edx, 19
	mov	esi, 1
	lea	rdi, .LC13[rip]
	call	fwrite@PLT
.L28:
	call	clock@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	sub	rax, QWORD PTR -16[rbp]
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC14[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0		#t
	mov	rdx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR -152[rbp], rdx
	movsd	xmm0, QWORD PTR -152[rbp]		
	lea	rsi, .LC15[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L16:
	mov	eax, 0
.L14:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	2576980378
	.long	1070176665
	.align 16
.LC1:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC14:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
