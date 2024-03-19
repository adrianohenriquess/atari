    processor 6502

    seg code
    org $F000 ;Define the code origin at $F000
    
Start:
    sei         ; Disable interrupts
    cld         ; Disable the BCD decimal math mode
    ldx #$FF    ; Load the X register with #$FF
    txs         ; Transfer the X register to the stack pointer 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the page zero region ($00 to $FF)
; Meaning the entire RAM and also the entire TIA regiters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

    lda #0      ; A = 0 
    ldx #$FF    ; X = #$FF
MemLoop:
    sta $0,X    ; Store the value of A inside memory addres $0 + X, since FF to F000
    dex         ; The value loaded in X register = X-- 
    bne MemLoop ; Loop until X is equal to zero (z-flag is set)
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the Rom size to exatcly 4KB        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start ; Reset the vector at $FFFC (where the program starts)
    .word Start ; Interrupt vector at $FFFE (unused in the VCS)


    
