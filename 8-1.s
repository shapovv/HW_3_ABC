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
