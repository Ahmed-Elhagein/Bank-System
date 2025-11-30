.model small
.stack 100h

;====================================================================
;                       M A C R O S   S E C T I O N
;====================================================================

; Macro to print a string ending with $
printString MACRO str    
  mov ah,9
  lea dx,str
  int 21h
ENDM

; Macro for Option 1 Input (Name)
ISop11 MACRO str
    local input, exitMac
    mov si,offset str
    input: 
        mov ah,1
        int 21h
        cmp al,13
        je exitMac
        mov [si],al
        inc si
        jmp input
        
    exitMac:
ENDM

; Macro for Option 1 Input (PIN)
ISop12 MACRO str
    local input2, exitMac2
    mov si,offset str
    input2: 
        mov ah,1
        int 21h
        cmp al,13
        je exitMac2
        inc accountPINcount
        mov [si],al
        inc si
        jmp input2
        
    exitMac2:
ENDM

; Macro for Option 6 Input (Name)
ISop6 MACRO str
    local ISop6input, labelop6_1_mac
    mov si,offset str
    ISop6input: 
        mov ah,1
        int 21h
        cmp al,13
        je labelop6_1_mac
        mov [si],al
        inc si
        jmp ISop6input
    labelop6_1_mac:    
ENDM

; Macro for Option 6 Input (PIN)
ISop6_2 MACRO str
    local ISop6_2input, labelop6_2_mac
    mov si,offset str
    mov accountPINcount,0 ;reset pin count
    ISop6_2input: 
        mov ah,1
        int 21h
        cmp al,13
        je labelop6_2_mac
        inc accountPINcount ;increment pin account again
        mov [si],al
        inc si
        jmp ISop6_2input
    labelop6_2_mac:    
ENDM

;====================================================================
;                       D A T A   S E C T I O N
;====================================================================
.data
    ; ASCII Art and UI Strings
    
    
    
    dmsg1 db '    ____                 __      _____               __$'                 
    dmsg2 db '   / __ ) ____ _ ____   / /__   / ___/ __  __ _____ / /_ ___   ____ ___$' 
    dmsg3 db '  / __  |/ __ `// __ \ / //_/   \__ \ / / / // ___// __// _ \ / __ `__ \$'
    dmsg4 db ' / /_/ // /_/ // / / // ,<     ___/ // /_/ /(__  )/ /_ /  __// / / / / /$'
    dmsg5 db '/_____/ \__,_//_/ /_//_/|_|   /____/ \__, //____/ \__/ \___//_/ /_/ /_/$' 
    dmsg6 db '                                    /____/$'                                                                                                                                               
    
    op1mmsg1 db '   ______                    __$'      
    op1mmsg2 db '  / ____/_____ ___   ____ _ / /_ ___$' 
    op1mmsg3 db ' / /    / ___// _ \ / __ `// __// _ \$'
    op1mmsg4 db '/ /___ / /   /  __// /_/ // /_ /  __/$'
    op1mmsg5 db '\____//_/    \___/ \__,_/ \__/ \___/$'  
    
    op2mmsg1 db  '  ____         __          _  __$'     
    op2mmsg2 db '  / __ \ ___   / /_ ____ _ (_)/ /_____$'
    op2mmsg3 db ' / / / // _ \ / __// __ `// // // ___/$'
    op2mmsg4 db '/ /_/ //  __// /_ / /_/ // // /(__  )$' 
    op2mmsg5 db '/_____/ \___/ \__/ \__,_//_//_//____/$'
    
    op3mmsg1 db ' _       __ _  __   __         __$'                      
    op3mmsg2 db '| |     / /(_)/ /_ / /_   ____/ /_____ ____ _ _      __$'
    op3mmsg3 db '| | /| / // // __// __ \ / __  // ___// __ `/| | /| / /$'
    op3mmsg4 db '| |/ |/ // // /_ / / / // /_/ // /   / /_/ / | |/ |/ /$' 
    op3mmsg5 db '|__/|__//_/ \__//_/ /_/ \__,_//_/    \__,_/  |__/|__/$'  
                                                         
    op4mmsg1 db '    ____                             _  __ $'
    op4mmsg2 db '   / __ \ ___   ____   ____   _____ (_)/ /_$'
    op4mmsg3 db '  / / / // _ \ / __ \ / __ \ / ___// // __/$'
    op4mmsg4 db ' / /_/ //  __// /_/ // /_/ /(__  )/ // /_$'  
    op4mmsg5 db '/_____/ \___// .___/ \____//____//_/ \__/$'  
    op4mmsg6 db '            /_/$'                                                               
    
    op5mmsg1 db '    __  ___            __ _  ____$'      
    op5mmsg2 db '   /  |/  /____   ____/ /(_)/ __/__  __$'
    op5mmsg3 db '  / /|_/ // __ \ / __  // // /_ / / / /$'
    op5mmsg4 db ' / /  / // /_/ // /_/ // // __// /_/ /$' 
    op5mmsg5 db '/_/  /_/ \____/ \__,_//_//_/   \__, /$'  
    op5mmsg6 db '                              /____/$'
    
    op0mmsg1 db '   ____   __   __U _____ u$' 
    op0mmsg2 db 'U | __")u \ \ / /\| ___"|/$' 
    op0mmsg3 db ' \|  _ \/  \ V /  |  _|"$'   
    op0mmsg4 db '  | |_) | U_|"|_u | |___$'   
    op0mmsg5 db '  |____/    |_|   |_____|$'  
    op0mmsg6 db ' _|| \\_.-,//|(_  <<   >>$'  
    op0mmsg7 db '(__) (__)\_) (__)(__) (__)$'  
    
    

    
                                
    opmsg1 db '1. Create new Account$'
    opmsg2 db '2. Print Account Details$'
    opmsg3 db '3. Withdraw Money $'
    opmsg4 db '4. Deposit Money $'
    opmsg5 db '5. Reset Account $'
    opmsg6 db '6. Modify Account Details$'
    opmsg0 db '0. Exit$'
    
    opmsg8 db 'Press Enter To Return to Main Menu $'
    
    imsg db 'What Do You Want To Do ? : $'
    inputCode db ? 
    
    ;Account details  
    
    accountName db 100 dup('$')
    accountPIN db 100 dup('$')
    accountPINcount dw 0        ;This keeps track how many digit a pin is
    totalAmount dw 0
    inputAmountOption db ? 
                                    
    ;Option 1 (Create Account) Messages
    op1msg1 db '1. Enter Account Name: $'
    op1msg2 db '2. Enter Account Pin: $'    
    op1msg3 db 'Successfully Created New Account ! $'    
    
    ;Option 2 <Print details> Messages
    op2msg1 db 'Account Name: $' 
    op2msg2 db 'Currently Saved Account PIN: $'
    op2msg3 db 'No Accounts Currently Saved !$'    
    op2msg4 db 'Total Money Left: $'
    op2msg5 db 'You Have No Money $'
    
    ;Option 4 <Money> Messages
    op4msg1 db '1. Php 1000$'
    op4msg2 db '2. Php 2000$'
    op4msg3 db '3. Php 5000$'
    op4msg4 db '4. Php 10000$'
    op4msg5 db 'Enter Code: $'  
    op4msg6 db 'You Are Withdrawing Too MUCH !$'
    
    ;Option 5 <Reset> Messages
    op5msg1 db 'Account Has been reset successfully$'
    
    ;Option 6 <Modify Account> Messages  
    op6msg0   db 'Account Details Successfully Changed !$'
    op6msg1_1 db '1. New Account Name ( old: $'
    op6msg1_2 db ' ) : $' 
    op6msg2_1 db '2. New Account Pin ( old: $'
    op6msg2_2 db ' ) : $'
    
    ;PIN Protection
    pinop_msg1 db 'Enter PIN: $' 
    pinop_msg2 db 'Account NOT created ... $'

    ; Stack pointer fix variable
    stacktop dw ?

;====================================================================
;                       C O D E   S E C T I O N
;====================================================================
.code

;--------------------------------------------------------------------
;                             U T I L S
;--------------------------------------------------------------------

; Enter to Continue - Returns to main loop
etc PROC
   etcin:
      mov ah,1
      int 21h
      cmp al,13
      je jump_main_etc
      jmp etcin
   
   jump_main_etc:
      jmp mainloop
   ret 
etc ENDP

newLine PROC near    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h     
    ret
newLine ENDP

clearScreen PROC near
    call newLine
    call newLine
    ret     
clearScreen ENDP

; Print Number in AX
printNumber PROC                   
    ;initilize count 
    mov cx,0 
    mov dx,0 
    label1: 
        ; if ax is zero 
        cmp ax,0 
        je print1        
          
        ;initilize bx to 10 
        mov bx,10          
          
        ; extract the last digit 
        div bx                     
          
        ;push it in the stack 
        push dx                
          
        ;increment the count 
        inc cx                
          
        ;set dx to 0  
        xor dx,dx 
        jmp label1
         
    print1: 
        ;check if count  
        ;is greater than zero 
        cmp cx,0 
        je exitprint
          
        ;pop the top of stack 
        pop dx 
          
        ;add 48 so that it  
        ;represents the ASCII 
        ;value of digits 
        add dx,48 
          
        ;interuppt to print a 
        ;character 
        mov ah,02h 
        int 21h 
          
        ;decrease the count 
        dec cx 
        jmp print1 
exitprint: 
ret 
printNumber ENDP

; Check if account exists
checkAccountCreated PROC
  cmp accountPINcount,0
  je accountNotCreated
  ret
  
  accountNotCreated:
    call clearScreen
    printString pinop_msg2
    call etc ; This will jump to mainloop
    ret      
checkAccountCreated ENDP

; Ask for user pin here
getPinInput PROC
  call clearScreen
 
  printString pinop_msg1
  
  mov si,offset accountPIN
  mov cx,accountPINcount     
  getinput:
    
    mov ah,7
    int 21h
    
    cmp al,[si]
    jne wrong_pin ; If pin is wrong
    
    mov dl,'*'
    mov ah,2
    int 21h
    
    inc si    
  loop getinput
  
  ret

  wrong_pin:
    call newLine
    mov dl, 'X'
    mov ah, 2
    int 21h
    call etc ; return to main
    ret 
getPinInput ENDP

; Gets amount code input (Used in Op3 and Op4)
inputAmountCode PROC
  call newLine
  printString op4msg5
  mov ah,1
  int 21h
  mov inputAmountOption,al
  ret  
inputAmountCode ENDP


;--------------------------------------------------------------------
;                        M E N U    S Y S T E M
;--------------------------------------------------------------------

DisplayMenu PROC near    
    printString dmsg1
    call newLine
    printString dmsg2
    call newLine
    printString dmsg3
    call newLine      
    printString dmsg4
    call newLine
    printString dmsg5
    call newLine
    printString dmsg6
    call newLine      
    
    call newLine 
    printString opmsg1
    call newLine
    printString opmsg2
    call newLine
    printString opmsg3
    call newLine
    printString opmsg4
    call newLine
    printString opmsg5
    call newLine
    printString opmsg6
    call newLine    
    printString opmsg0
    call newLine
    ret         
DisplayMenu ENDP        

GetInputMenuSystem PROC near 
    call newLine
    printString imsg
    mov ah,1
    int 21h
    mov inputCode,al
    ret         
GetInputMenuSystem ENDP 
 
;--------------------------------------------------------------------
;               O P T I O N  1   => CREATE ACCOUNT
;--------------------------------------------------------------------

op1 PROC
        
    call clearScreen
    
    printString op1mmsg1
    call newLine
    printString op1mmsg2
    call newLine
    printString op1mmsg3
    call newLine
    printString op1mmsg4
    call newLine        
    printString op1mmsg5
    call newLine
    call newLine
    call newLine
    
    ; Reset old data
    mov accountPINcount, 0
    
    printString op1msg1
    ISop11 accountName
    
    call newLine 
    printString op1msg2
    ISop12 accountPIN
    
    call newLine
    call newLine
    printString op1msg3
    call etc
            
    ret
op1 ENDP                                                                     
 
;--------------------------------------------------------------------
;               O P T I O N  2   => PRINT DETAILS
;--------------------------------------------------------------------

etcop2 PROC
   call newLine
   printString opmsg8
   etcop2in:
      mov ah,1
      int 21h
      cmp al,13
      je jump_main_op2
      jmp etcop2in
   jump_main_op2:
      jmp mainloop
   ret 
etcop2 ENDP 

op2 PROC
  
  call checkAccountCreated 
  call getPinInput 
  call clearScreen
  
  printString op2mmsg1
  call newLine
  printString op2mmsg2
  call newLine
  printString op2mmsg3
  call newLine
  printString op2mmsg4
  call newLine        
  printString op2mmsg5
  call newLine
  call newLine
  call newLine
  
  printString op2msg1
  printString accountName  
  call newLine
  
  printString op2msg2
  printString accountPIN 
  call newLine    
  
  printString op2msg4
  mov ax,totalAmount
  cmp ax,0
  je noMoneyError
  call printNumber 
  call newLine
  
  call etcop2     
  
  noMoneyError:
    printString op2msg5
    call newLine
    call etcop2
    
  ret              
  
op2 ENDP
 
;--------------------------------------------------------------------
;               O P T I O N  3   => WITHDRAW MONEY
;--------------------------------------------------------------------
 
op3 PROC
  
  call checkAccountCreated
  call getPinInput
  call clearScreen
  
  printString op3mmsg1
  call newLine
  printString op3mmsg2
  call newLine
  printString op3mmsg3
  call newLine
  printString op3mmsg4
  call newLine        
  printString op3mmsg5
  call newLine
  call newLine
  call newLine
  
  printString op4msg1
  call newLine
  printString op4msg2
  call newLine
  printString op4msg3
  call newLine
  printString op4msg4
  call newLine
  
  call inputAmountCode  
  
  cmp inputAmountOption,'1'
  je wcop1
  
  cmp inputAmountOption,'2'
  je wcop2 
  
  cmp inputAmountOption,'3'
  je wcop3
  
  cmp inputAmountOption,'4'
  je wcop4
  
  jmp mainloop 

  wcop1:
    mov bx,totalAmount
    cmp bx,1000
    jl nowaybro     
    sub totalAmount,1000
    jmp mainloop
  wcop2:         
    mov bx,totalAmount
    cmp bx,2000
    jl nowaybro     
    sub totalAmount,2000
    jmp mainloop
  wcop3:         
    mov bx,totalAmount
    cmp bx,5000
    jl nowaybro     
    sub totalAmount,5000
    jmp mainloop
  wcop4:         
    mov bx,totalAmount
    cmp bx,10000
    jl nowaybro     
    sub totalAmount,10000
    jmp mainloop
    
  nowaybro:
    call newLine
    call newLine
    printString op4msg6
    call etc
    
  ret  

op3 ENDP
 
;--------------------------------------------------------------------
;               O P T I O N  4   => DEPOSIT MONEY
;--------------------------------------------------------------------

op4 PROC
  
  call checkAccountCreated 
  call getPinInput 
  call clearScreen
  
  printString op4mmsg1
  call newLine
  printString op4mmsg2
  call newLine
  printString op4mmsg3
  call newLine
  printString op4mmsg4
  call newLine        
  printString op4mmsg5
  call newLine
  printString op4mmsg6
  call newLine
  call newLine
  call newLine
  
  printString op4msg1
  call newLine
  printString op4msg2
  call newLine
  printString op4msg3
  call newLine
  printString op4msg4
  call newLine
  
  call inputAmountCode  
  
  cmp inputAmountOption,'1'
  je dcop1
  
  cmp inputAmountOption,'2'
  je dcop2 
  
  cmp inputAmountOption,'3'
  je dcop3
  
  cmp inputAmountOption,'4'
  je dcop4
  
  jmp mainloop 
    
  dcop1:     
    add totalAmount,1000
    jmp mainloop
  dcop2:
    add totalAmount,2000    
    jmp mainloop
  dcop3:
    add totalAmount,5000
    jmp mainloop
  dcop4:
    add totalAmount,10000
    jmp mainloop
    
  ret  

op4 ENDP

;--------------------------------------------------------------------
;               O P T I O N  5   => RESET ACCOUNT
;--------------------------------------------------------------------

op5 PROC
  
  call checkAccountCreated 
  call getPinInput 
    
  call clearScreen
  
  mov si,offset accountName
  mov cx,30
  l1:
    mov byte ptr [si],' ' ; Fixed: Added byte ptr
    inc si
  loop l1
  
  mov cx,30
  mov si,offset accountPIN
  l2:
    mov byte ptr [si],' ' ; Fixed: Added byte ptr
    inc si
  loop l2   
  
  mov totalAmount,0
  mov accountPINcount,0
      
  printString op5msg1
  call etc    
  ret  
op5 ENDP

;--------------------------------------------------------------------
;               O P T I O N  6   => MODIFY ACCOUNT
;--------------------------------------------------------------------

op6 PROC
  
  call checkAccountCreated 
  call getPinInput   
  call clearScreen
  
  printString op5mmsg1
  call newLine
  printString op5mmsg2
  call newLine
  printString op5mmsg3
  call newLine
  printString op5mmsg4
  call newLine        
  printString op5mmsg5
  call newLine
  printString op5mmsg6
  call newLine
  call newLine
  call newLine
  
  ;;account name
  printString op6msg1_1
  printString accountName
  printString op6msg1_2
  
  ISop6 accountName 
  
  call newLine
  printString op6msg2_1
  printString accountPIN
  printString op6msg2_2
  ISop6_2 accountPIN
  
  call newLine
  call newLine
  printString op6msg0
  call etc
  
  ret  
op6 ENDP

;--------------------------------------------------------------------
;                      E N T R Y    P O I N T
;--------------------------------------------------------------------
        
Main PROC
    
    mov ax,@data
    mov ds,ax
    
    mov stacktop, sp
    
    mainloop:
        mov sp, stacktop
    
        call clearScreen
        call DisplayMenu
        call GetInputMenuSystem
                                           
        cmp inputCode,'0'
        je exit
        
        cmp inputCode,'2'
        jne check_4
        call op2
        jmp mainloop

        check_4:
        cmp inputCode,'4'
        jne check_3
        call op4
        jmp mainloop  
        
        check_3:
        cmp inputCode,'3'
        jne check_6
        call op3
        jmp mainloop
        
        check_6:
        cmp inputCode,'6'
        jne check_1
        call op6
        jmp mainloop
        
        check_1:
        cmp inputCode,'1'
        jne check_5
        call op1  
        jmp mainloop
        
        check_5:
        cmp inputCode,'5'   
        jne mainloop 
        call op5
        jmp mainloop
                        
    exit:
      
      call newLine
      call newLine
      
      printString op0mmsg1
      call newLine
      printString op0mmsg2
      call newLine
      printString op0mmsg3
      call newLine
      printString op0mmsg4
      call newLine        
      printString op0mmsg5
      call newLine
      printString op0mmsg6
      call newLine
      printString op0mmsg7
      call newLine
      
      call newLine
        
      mov ah,4ch
      int 21h
    
    Main ENDP
END Main