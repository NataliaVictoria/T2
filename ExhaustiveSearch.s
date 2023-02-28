	.arch armv7
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"exs.c"
	.text
	.align	1
	.global	exhaustive_search
	.syntax unified
	.thumb
	.thumb_func
	.type	exhaustive_search, %function

exhaustive_search:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #28
	add	r7, sp, #0
	str	r0, [r7, #12]
	str	r1, [r7, #8]
	str	r2, [r7, #4]
	mov	r3, #-1
	str	r3, [r7, #16]
	movs	r3, #0
	str	r3, [r7, #20]
	b	.L2
.L5:
	ldr	r3, [r7, #20]
	lsls	r3, r3, #2
	ldr	r2, [r7, #12]
	add	r3, r3, r2
	ldr	r3, [r3]
	ldr	r2, [r7, #4]
	cmp	r2, r3
	bne	.L3
	ldr	r3, [r7, #20]
	str	r3, [r7, #16]
	b	.L4
.L3:
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	str	r3, [r7, #20]
.L2:
	ldr	r2, [r7, #20]
	ldr	r3, [r7, #8]
	cmp	r2, r3
	blt	.L5
.L4:
	ldr	r3, [r7, #16]
	mov	r0, r3
	adds	r7, r7, #28
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	exhaustive_search, .-exhaustive_search
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

read_user_input:
    push {r7, lr}
    push {r1}
    push {r0}

    mov r7, #0x3
    mov r0, #0x0
    pop {r1}
    pop {r2}

    svc 0x0
    pop {r7, pc}

my_atoi:
    push {r7}
    sub sp, sp, #28
    add r7, sp, #0

    str	r0, [r7, #4]

    movs r3, #0         @ string lenght counter
    str r3, [r7, #8]
    movs r3, #0         @ end state 
    str r3, [r7, #12]
    movs r3, #1
    str r3, [r7, #16]
    movs r3, #10
    str r3, [r7, #20]

_string_lenght_loop:
    ldr r3, [r7, #4]    @ load arg1
    ldrb r3, [r3]       @ load byte
    cmp r3, #0xa
    beq _count          @ branches if arg1 = 10
    ldr r3, [r7, #4]    @ load arg1
    add r3, r3, #1      @ arg1++
    str r3, [r7, #4]

    ldr r0, [r7, #8]
    add r0, r0, #1      @ l_counter ++; 
    str r0, [r7, #8]     
    b _string_lenght_loop

_count:
    ldr r0, [r7, #4]    @ load arg1
    sub r0, r0, #1
    str r0, [r7, #4]

    ldrb r0, [r0] 		@ first number in the string 
    sub r0, r0, #0x30
    str r0, [r7, #4]    @ store arg1

    ldr r1, [r7, #16]   @ load 1
    mul r2, r0, r1 		@ current place times vale
    mov r0, r2
    str r0, [r7, #24]

    ldr r0, [r7, #20]
    ldr r1, [r7, #16]
    mul r0, r1, r0 		@ incrememnt the place holder
    str r0, [r7, #16]

    ldr r0, [r7, #12]
    ldr r1, [r7, #24]
    add r0, r0, r1 		@ add current number to counter
    str r0, [r7, #12]

    ldr r0, [r7, #8]
    sub r0, r0, #1 		@ decrement lenght, check for end
    str r0, [r7, #8]
    cmp r0, #0x0
    beq _leave
    b _count
    
_leave:
    ldr r0, [r7, #12]
    adds r7, r7, #28
    mov sp, r7
    pop {r7}
    bx lr 

int_to_string:
	push	{r7, lr}    @ create frame
	sub	sp, sp, #24
	add	r7, sp, #0

	str	r0, [r7, #4]    @ store num
	str	r1, [r7]        @ store buff

	movs	r3, #0      @ i = 0
	str	r3, [r7, #8]    
	mov	r3, #1000       @ divisor = 1000
	str	r3, [r7, #12]
	movs	r3, #0x30   @ ascii = 0x30
	str	r3, [r7, #16]

	ldr	r3, [r7, #4]    @ load num
	cmp	r3, #0
	bge	.while          @ branches if num >= 0

    # *buf++ = '-';
	ldr	r3, [r7]        @ load buf
	adds	r2, r3, #1  @ buf++
	str	r2, [r7]        
	movs	r2, #45     @ '-'
	strb	r2, [r3]    @ *buf++ = '-';

    # num = -num;
	ldr	r3, [r7, #4]    @ load num
	rsbs	r3, r3, #0  @ -num
	str	r3, [r7, #4]    @ store num

.while:
    # digit = num / divisor;
	ldr	r1, [r7, #12]   @ load divisor
	ldr	r0, [r7, #4]    @ load num
	bl	__aeabi_idiv    @ num/divisor
	mov	r3, r0     
    str	r3, [r7, #20]   @ store digit

    # num -= digit * divisor;
	ldr	r3, [r7, #20]   @ load digit
	ldr	r2, [r7, #12]   @ load divisor
	mul	r3, r2, r3      @ digit * divisor
	ldr	r2, [r7, #4]    @ load num
	subs	r3, r2, r3  @ num - digit * divisor
	str	r3, [r7, #4]    @ store num

    # buf[i++] = digit + ascii_base;
	ldr	r3, [r7, #20]   @ load digit
	uxtb	r1, r3      
	ldr	r3, [r7, #16]   @ load ascii
	uxtb	r2, r3
	ldr	r3, [r7, #8]    @ load i
	adds	r0, r3, #1  @ i++
	str	r0, [r7, #8]    @ store i
	mov	r0, r3          @ i -> r0
	ldr	r3, [r7]        @ load buff
	add	r3, r3, r0      @ buff[i]
	add	r2, r2, r1      @ digit + ascii
	uxtb	r2, r2      
	strb	r2, [r3]    @ buf[i++] = digit + ascii_base;

    # divisor /= 10;
	ldr	r3, [r7, #12]   	@ load divisor 
	ldr	r2, .L6         	
	smull	r1, r2, r2, r3
	asrs	r2, r2, #2
	asrs	r3, r3, #31
	subs	r3, r2, r3
	str	r3, [r7, #12]

    # while(divisor!=0)
	ldr	r3, [r7, #12]   	@ load divisor
	cmp	r3, #0          
	bne	.while              @ branches if divisor!=0

    # buf[i] = '\0';
	ldr	r3, [r7, #8]    	@ load i
	ldr	r2, [r7]        	@ load buf
	add	r3, r3, r2      	@ buf[i]
	movs	r2, #0      	@ '\0'
	strb	r2, [r3]    	@ buf[i] = '\0';
	nop

    # epilogo
	adds	r7, r7, #24
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L7:
	.align	2
.L6:
	.word	1717986919
	.size	int_to_string, .-int_to_string
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

display:
    push {r7, lr}

    mov r7, #0x4
    mov r0, #0x1
    mov r1, r4			@ element address
    mov r2, #0x4		@ size of element
    svc 0x0

    pop {r7, pc}

main:
	# create frame 
	push	{r7, lr}
	sub	sp, sp, #48
	add	r7, sp, #0

	ldr	r3, .L13
	ldr	r3, [r3]
	str	r3, [r7, #44]
	mov	r3, #0

	movs	r3, #0
	str	r3, [r7, #4]
	b	.L8
.L9:
	ldr	r2, [r7, #4]    @ i
	mov	r3, r2

    # read
    add r0, r7, #20     @ load "val" address on r0
    ldr r1, =#0x6 
    bl read_user_input
    add r0, r7, #20
    bl my_atoi
	str	r0, [r7, #20]   @ stores value 

	ldr	r3, [r7, #4]    	@ i
	lsls	r3, r3, #2  	@ i<<2	 
	adds	r3, r3, #48 	@ (i<<2)+48
	add	r3, r3, r7			@ a[i]
	ldr	r2, [r7, #20]		@ load val
	str	r2, [r3, #-24]  	@ a[i] = val;

	ldr	r3, [r7, #4]		@ load i
	adds	r3, r3, #1		@ i++
	str	r3, [r7, #4]		
.L8:
	ldr	r3, [r7, #4]    	@ i
	cmp	r3, #4          	@ branches if i<=4
	ble	.L9

	# int key = 3;
	movs	r3, #3			
	str	r3, [r7, #12]		
	# int res=0;
	movs	r3, #0
	str	r3, [r7, #8]
	# load arguments to call exhaustive_search
	add	r3, r7, #24			
	ldr	r2, [r7, #12]		@ load key
	movs	r1, #10			@ load 10
	mov	r0, r3				@ load a
	bl	exhaustive_search
	str	r0, [r7, #16] 	    @ stores return value in index
	//; if(index > -1)
	ldr	r3, [r7, #16]		@ load index
	cmp	r3, #0				@ branches if (index<0)
	blt	.L10
	movs	r3, #1			@ res = 1;
	str	r3, [r7, #8]		
.L10:
	# covert index to string
	add r3, r7, #16			@ index address
	mov r1, r3
	ldr r0, [r7, #16]		@ index value
	bl int_to_string
	add r4, r7, #16			@ load index address 
	bl display
	# return res
	ldr	r3, [r7, #8]		@ load res
	ldr	r2, .L13			
	ldr	r1, [r2]
	ldr	r2, [r7, #44]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L12
	bl	__stack_chk_fail
.L12:
	# epilogo 
	mov	r0, r3
	adds	r7, r7, #48		
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L14:
	.align	2
.L13:
	.word	__stack_chk_guard
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",%progbits