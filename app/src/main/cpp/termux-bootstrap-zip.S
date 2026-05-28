     .global termux_blob
     .global termux_blob_size
     .section .rodata
 termux_blob:
 #if defined __i686__
     .incbin "cs-x86.tgz"
 #elif defined __x86_64__
     .incbin "cs-x86_64.tgz"
 #elif defined __aarch64__
     .incbin "cs-aarch64.tgz"
 #elif defined __arm__
     .incbin "cs-arm.tgz"
 #else
 # error Unsupported arch
 #endif
 1:
 termux_blob_size:
     .int 1b - termux_blob
