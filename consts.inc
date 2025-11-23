; XCB Constants
XCB_MOD_MASK_1                          equ 8
XCB_MOD_MASK_SHIFT                      equ 1
XCB_CW_EVENT_MASK                       equ 2048
XCB_GRAB_MODE_ASYNC                     equ 1

; Key codes
XK_Tab                                  equ 0xff09
XK_q                                    equ 0x0071
XK_Return                               equ 0xff0d
XK_d                                    equ 0xffff
XK_h                                    equ 0x0068
XK_j                                    equ 0x006a
XK_k                                    equ 0x006b
XK_l                                    equ 0x006c

; XCB Event Masks
XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT    equ 1048576
XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY      equ 524288
XCB_EVENT_MASK_BUTTON_PRESS             equ 4
XCB_EVENT_MASK_BUTTON_RELEASE           equ 8
XCB_EVENT_MASK_POINTER_MOTION           equ 64
XCB_EVENT_MASK_KEY_PRESS                equ 1
XCB_EVENT_MASK_ALL                      equ (XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT   or \
                                             XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY     or \
                                             XCB_EVENT_MASK_BUTTON_PRESS            or \
                                             XCB_EVENT_MASK_BUTTON_RELEASE          or \
                                             XCB_EVENT_MASK_POINTER_MOTION          or \
                                             XCB_EVENT_MASK_KEY_PRESS)

