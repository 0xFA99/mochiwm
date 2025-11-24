format ELF64

    include     'consts.inc'
    include     'macros.inc'

    extrn       XConnection
    extrn       XWindowRoot

    extrn       xcb_key_symbols_alloc
    extrn       xcb_key_symbols_get_keycode
    extrn       xcb_key_symbols_free
    extrn       xcb_grab_key
    extrn       free

section '.text' executable

    public      _grab_keys

_grab_keys:
    push        r12         ; <----- END ?!?!?! WTFFFFF
    push        r13
    sub         rsp, 8

    mov         rdi, [XConnection]
    call        xcb_key_symbols_alloc
    mov         r12, rax                    ; keysyms

    grab_key    XK_Tab, XCB_MOD_MASK_1      ; MOD + Tab
    grab_key    XK_q, XCB_MOD_MASK_1        ; MOD + q

    ; MOD + Shift + q
    grab_key    XK_q,   (XCB_MOD_MASK_1 or XCB_MOD_MASK_SHIFT)

    grab_key    XK_Return, XCB_MOD_MASK_1   ; MOD + Return
    grab_key    XK_d, XCB_MOD_MASK_1        ; MOD + d
    grab_key    XK_h, XCB_MOD_MASK_1        ; MOD + h
    grab_key    XK_j, XCB_MOD_MASK_1        ; MOD + j
    grab_key    XK_k, XCB_MOD_MASK_1        ; MOD + k
    grab_key    XK_l, XCB_MOD_MASK_1        ; MOD + l
   
    ; MOD + Shift + h
    grab_key    XK_h, (XCB_MOD_MASK_1 or XCB_MOD_MASK_SHIFT)
    
    ; MOD + Shift + j
    grab_key    XK_j, (XCB_MOD_MASK_1 or XCB_MOD_MASK_SHIFT)
    
    ; MOD + Shift + k
    grab_key    XK_k, (XCB_MOD_MASK_1 or XCB_MOD_MASK_SHIFT)
    
    ; MOD + Shift + l
    grab_key    XK_l, (XCB_MOD_MASK_1 or XCB_MOD_MASK_SHIFT)

    mov         rdi, r12
    call        xcb_key_symbols_free

    add         rsp, 8
    pop         r13
    pop         r12
    ret
    

section '.note.GNU-stack'
