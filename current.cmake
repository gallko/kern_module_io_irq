EXECUTE_PROCESS(
        COMMAND uname -r
        OUTPUT_VARIABLE VERSION_OS
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(KERNEL_DIR
        /lib/modules/${VERSION_OS}/build)
set(KERNEL_HEADERS
        ${KERNEL_DIR}/include)
set(PRECOMPILE_FILE
        ${KERNEL_HEADERS}/linux/kconfig.h)
set(EXTRA_FLAG "")