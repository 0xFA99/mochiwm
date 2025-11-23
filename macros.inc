
macro grab_key keycode, modifiers
{
    mov         rdi, r12                    ; keysyms
    mov         esi, keycode
    call        xcb_key_symbols_get_keycode
    mov         r13, rax                    ; keycode

    mov         rdi, [XConnection]
    mov         esi, 1
    mov         edx, [XWindowRoot]
    mov         ecx, modifiers
    mov         r8, [r13]
    mov         r9d, XCB_GRAB_MODE_ASYNC
    mov         dword [rsp], XCB_GRAB_MODE_ASYNC
    call        xcb_grab_key

    mov         rdi, r13
    call        free
}

macro convert_color color_reg
{
    mov         edx, color_reg
    shr         edx, 16
    and         edx, 0xFF
    imul        edx, edx, 257               ; red
    
    mov         ecx, color_reg
    shr         ecx, 8
    and         ecx, 0xFF
    imul        ecx, ecx, 257               ; green
    
    mov         r8d, color_reg
    and         r8d, 0xFF
    imul        r8d, r8d, 257               ; blue
}

