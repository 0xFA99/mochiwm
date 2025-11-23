format ELF64

    include     'macros.inc'

    extrn       XConnection
    extrn       XScreen
    extrn       xcb_alloc_color
    extrn       xcb_alloc_color_reply

    extrn       free
    extrn       write


section '.text' executable
    
    public _get_color_pixel

_get_color_pixel:
    push        r12

    convert_color   edi

    mov         rdi, [XConnection]
    mov         rsi, [XScreen]
    mov         esi, [rsi + 4]              ; screen->colormap
    call        xcb_alloc_color

    mov         rdi, [XConnection]
    mov         esi, eax
    xor         edx, edx
    call        xcb_alloc_color_reply

    test        rax, rax
    jz          .error_color

    mov         r12d, dword [rax + 16]      ; pixel

    mov         rdi, rax
    call        free

    mov         eax, r12d
    jmp         .done

.error_color:
    mov         edi, 2
    lea         rsi, [ERR_COLOR]
    mov         edx, ERR_COLOR_LEN
    call        write

.done:
    pop         r12
    ret

section '.rodata'

    ERR_COLOR       db "[ERROR]: Could not alloc color", 0xa, 0x0
    ERR_COLOR_LEN   = $ - ERR_COLOR

section '.note.GNU-stack'

