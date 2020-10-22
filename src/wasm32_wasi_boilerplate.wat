(module
    (import "wasi_snapshot_preview1" "fd_write"
        (func $fd_write (param i32 i32 i32 i32) (result i32)))

    (import "wasi_snapshot_preview1" "proc_exit"
        (func $proc_exit (param i32)))

    (import "wasi_snapshot_preview1" "fd_read"
        (func $fd_read (param i32 i32 i32 i32) (result i32)))

    (memory 1)

    (func $_start (local $ptr i32)
        ;; setup array pointer
        i32.const 0
        local.set $ptr

        ;; setup iovec
        i32.const 30004     ;; 30004 offset
        local.get $ptr      ;; initial index = 0
        i32.store           ;; mem[30004-30008] = 0
        i32.const 30008     ;; 30008 offset
        i32.const 1         ;; read/write 1 byte
        i32.store           ;; mem[30008-30012] = 1

        ;; mem[30004-30012] = iovec { buf_adr, buf_len }
{{REPLACE}}
        i32.const 0
        call $proc_exit
    )

    (export "memory" (memory 0))
    (export "_start" (func $_start))
)