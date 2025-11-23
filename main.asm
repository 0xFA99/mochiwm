
format ELF64

    include     'consts.inc'

    extrn       write

    extrn       xcb_connect
    extrn       xcb_connection_has_error
    extrn       xcb_disconnect
    extrn       xcb_get_setup
    extrn       xcb_setup_roots_iterator
    extrn       xcb_change_window_attributes_checked
    extrn       xcb_request_check

    extrn       _get_color_pixel
    extrn       _grab_keys

section '.text' executable

    public      _start
    public      _exit

_start:
    ; Connect to X server
    xor         edi, edi
    xor         esi, esi
    call        xcb_connect
    mov         [XConnection], rax

    mov         rdi, rax
    call        xcb_connection_has_error
    jz          .error_display

    ; Get screens
    mov         rdi, [XConnection]          ; x connection
    call        xcb_get_setup

    mov         rdi, rax
    call        xcb_setup_roots_iterator
    mov         [XScreen], rax

    mov         eax, [rax]                  ; screen->root
    mov         [XWindowRoot], eax

    mov         rdi, [XConnection]
    ; mov         esi, [XWindowRoot]
    mov         esi, eax
    mov         edx, XCB_CW_EVENT_MASK
    lea         ecx, [event_mask_all]
    call        xcb_change_window_attributes_checked
    
    ; mov         rdi, [XConnection]
    ; mov         esi, eax
    ; call        xcb_request_check
    ; jnz         .error_wm_run

    mov         edi, 0x00FF00
    call        _get_color_pixel
    
    call        _grab_keys
    ; call        _cleanup_xcb_connection

    mov         rdi, [XConnection]
    call        xcb_disconnect

    jmp         _exit

.error_display:
    mov         edi, 2                      ; standard error
    lea         rsi, [ERR_DISPLAY]          ; message
    mov         edx, ERR_DISPLAY_LEN        ; length
    call        write
    jmp         _exit

.error_wm_run:
    mov         edi, 2                      ; standard error
    lea         rsi, [ERR_WM_RUN]           ; message
    mov         edx, ERR_WM_RUN_LEN         ; length
    call        write
    jmp         _exit

_exit:
    mov         eax, 60
    xor         edi, edi
    syscall

section '.data' writeable
    event_mask_all  dd XCB_EVENT_MASK_ALL

section '.bss' writeable
    public          XConnection
    public          XScreen
    public          XWindowRoot

    XConnection     rq 1
    XScreen         rq 1
    XWindowRoot     rd 1

section '.rodata'

    ERR_DISPLAY     db "[ERROR]: Could not open display", 0xa, 0x0
    ERR_DISPLAY_LEN = $ - ERR_DISPLAY

    ERR_WM_RUN      db "[ERROR]: Another WM is already running", 0xa, 0x0
    ERR_WM_RUN_LEN  = $ - ERR_WM_RUN

section '.note.GNU-stack'

