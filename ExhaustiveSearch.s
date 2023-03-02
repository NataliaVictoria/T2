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
	# prologue
	push	{r7}
	sub	sp, sp, #28     
	add	r7, sp, #0
    # store args
	str	r0, [r7, #12]       @ store * a 
	str	r1, [r7, #8]        @ store size
	str	r2, [r7, #4]        @ store key
    # int index = 9999;
	mov	r3, #9999           
	str	r3, [r7, #16]       @ store index 
	movs	r3, #0          @ int i = 0
	str	r3, [r7, #20]       @ store i
	b	.L2                 @ jump to for loop
.L5:
    //; if (a[i] == key)
	ldr	r3, [r7, #20]       @ load i
	lsls	r3, r3, #2      @ i*4 (i*size)
	ldr	r2, [r7, #12]       @ load * a 
	add	r3, r3, r2          @ a[i]
	ldr	r3, [r3]            @ load a[i] 
	ldr	r2, [r7, #4]        @ load key
	cmp	r2, r3              
	bne	.L3                 @ branches if a[i]!=key
    # index = i
	ldr	r3, [r7, #20]       @ load i
	str	r3, [r7, #16]       @ store index
	b	.L4                 @ break
.L3:
    # for increment
	ldr	r3, [r7, #20]       @ load i
	adds	r3, r3, #1      @ i++
	str	r3, [r7, #20]       @ store i
.L2:
    # for condition
	ldr	r2, [r7, #20]       @ load i
	ldr	r3, [r7, #8]        @ load size  
	cmp	r2, r3              
	blt	.L5                 @ branches if i<size
.L4:
    # epilogue
	ldr	r3, [r7, #16]       @ load index  
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
    push {r7}
    sub sp, sp, #12
    add r7, sp, #0
    
    str r0, [r7]            @ store base address
    str r1, [r7, #4]        @ store size 

    ldr r2, [r7, #4]        @ load size
    ldr r1, [r7]            @ load base address
    mov r0, #0x0
    mov r7, #3            

    svc 0x0
    mov r3, r0
    add r7, sp, #0
    # epilogo
    mov r0, r3
    adds r7, r7, #12
    mov sp, r7
    pop {r7}
    bx lr 

my_atoi:
    #prologue
	push	{r7}
	sub	sp, sp, #28
	add	r7, sp, #0

	str	r0, [r7, #4]        @ stor * str

	movs	r3, #0          
	str	r3, [r7, #8]        @ lenght counter; len
	movs	r3, #1
	str	r3, [r7, #12]       @ state_counter
	movs	r3, #0
	str	r3, [r7, #16]       @ value
	b	_string_lenght_loop
_count:
	ldr	r3, [r7, #4]        @ load * str
	adds	r3, r3, #1      @ str ++
	str	r3, [r7, #4]
	ldr	r3, [r7, #8]        @ load len
	adds	r3, r3, #1      @ len ++
	str	r3, [r7, #8]

_string_lenght_loop:
	ldr	r3, [r7, #4]        @ load * str
	ldrb	r3, [r3]	    @ load byte
	cmp	r3, #0xa         
	bne	_count              @ branches if arg1 != '\n' ; checks if it has reach the end of the string
	ldr	r3, [r7, #4]        @ load * str    
	subs	r3, r3, #1      @ str --
	str	r3, [r7, #4]
	b	_leave
_s_loop:
    # convert current digit to int 
	ldr	r3, [r7, #4]        @ load * str
	ldrb	r3, [r3]	    @ load byte
	subs	r3, r3, #48     @ converts value form ascii to int 
	str	r3, [r7, #20]       @ stores current digit
    # add the digit to the value we will return
	ldr	r3, [r7, #20]       @ load digit 
	ldr	r2, [r7, #12]       @ load state_counter
	mul	r3, r2, r3          @ digit * state_counter;
	ldr	r2, [r7, #16]       @ load value
	add	r3, r3, r2          @ value = value + digit * state_counter;
	str	r3, [r7, #16]       @ store value
    # adjust the state counter and move to the next digit
    # str--;
	ldr	r3, [r7, #4]        @ load str 
	subs	r3, r3, #1      @ str--
	str	r3, [r7, #4]        
    # state_counter
	ldr	r2, [r7, #12]       @ load state_counter 
	mov	r3, r2              
    # current_place *= 10;
	lsls	r3, r3, #2      
	add	r3, r3, r2
	lsls	r3, r3, #1
	str	r3, [r7, #12]       @ store result
    # len--;
	ldr	r3, [r7, #8]        @ load len   
	subs	r3, r3, #1      @ len--
	str	r3, [r7, #8]        
_leave:
    # check condition
	ldr	r3, [r7, #8]        @ load len
	cmp	r3, #0              @ branches if (len>0)
	bgt	_s_loop             
    # return value
	ldr	r3, [r7, #16]       @ load value
	mov	r0, r3              
    # epilogo
	adds	r7, r7, #28
	mov	sp, r7
	pop	{r7}
	bx	lr

int_to_string:
	push	{r7, lr}        @ create frame
	sub	sp, sp, #24
	add	r7, sp, #0

	str	r0, [r7, #4]        @ store num
	str	r1, [r7]            @ store buff

	movs	r3, #0          @ i = 0
	str	r3, [r7, #8]    
	mov	r3, #1000           @ divisor = 1000
	str	r3, [r7, #12]
	movs	r3, #0x30       @ ascii = 0x30
	str	r3, [r7, #16]

	ldr	r3, [r7, #4]        @ load num
	cmp	r3, #0
	bge	.while              @ branches if num >= 0

    # *buf++ = '-';
	ldr	r3, [r7]            @ load buf
	adds	r2, r3, #1      @ buf++
	str	r2, [r7]        
	movs	r2, #45         @ '-'
	strb	r2, [r3]        @ *buf++ = '-';

    # num = -num;
	ldr	r3, [r7, #4]        @ load num
	rsbs	r3, r3, #0      @ -num
	str	r3, [r7, #4]        @ store num

.while:
    # digit = num / divisor;
	ldr	r1, [r7, #12]       @ load divisor
	ldr	r0, [r7, #4]        @ load num
	bl	__aeabi_idiv        @ num/divisor
	mov	r3, r0     
    str	r3, [r7, #20]       @ store digit

    # num -= digit * divisor;
	ldr	r3, [r7, #20]       @ load digit
	ldr	r2, [r7, #12]       @ load divisor
	mul	r3, r2, r3          @ digit * divisor
	ldr	r2, [r7, #4]        @ load num
	subs	r3, r2, r3      @ num - digit * divisor
	str	r3, [r7, #4]        @ store num

    # buf[i++] = digit + ascii_base;
	ldr	r3, [r7, #20]       @ load digit
	uxtb	r1, r3      
	ldr	r3, [r7, #16]       @ load ascii
	uxtb	r2, r3
	ldr	r3, [r7, #8]        @ load i
	adds	r0, r3, #1      @ i++
	str	r0, [r7, #8]        @ store i
	mov	r0, r3              @ i -> r0
	ldr	r3, [r7]            @ load buff
	add	r3, r3, r0          @ buff[i]
	add	r2, r2, r1          @ digit + ascii
	uxtb	r2, r2      
	strb	r2, [r3]        @ buf[i++] = digit + ascii_base;

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
    # prologue
    push {r7}
    sub sp, sp, #12
    add r7, sp, #0
    
    str r0, [r7, #4]        @ store size 
    str r1, [r7]            @ store base add

    ldr r2, [r7, #4]        @ load size
    ldr r1, [r7]            @ load base add
    mov r7, #0x4
    mov r0, #0x1
    svc 0x0
    mov r3, r0
    add r7, sp, #0
    #epilogue
    mov r0, r3
    adds r7, r7, #12
    mov sp, r7
    pop {r7}
    bx  lr

main:
	# prologue
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
	ldr	r2, [r7, #4]        @ i
	mov	r3, r2

    # read
    ldr r1, =#0x6 
    add r0, r7, #20         @ load "val" address on r0
    bl read_user_input
    add r0, r7, #20
    bl my_atoi
	str	r0, [r7, #20]       @ stores value 

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
	movs	r3, #10			
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
	add r1, r7, #16			@ load index address 
    mov r0, #0x4
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
