set(CROSS_COMPILE mipsel-openwrt-linux-)
set(KERNEL_DIR
        /home/rus/MG/linux-3.10.14-p112871)
set(KERNEL_HEADERS
        ${KERNEL_DIR}/include)
set(PRECOMPILE_FILE
        ${KERNEL_HEADERS}/linux/kconfig.h)
set(EXTRA_FLAG "-mdspr2 -DMT7621AT")
set(CMAKE_C_COMPILER ${CROSS_COMPILE}gcc)
set(ARCH mips)
add_definitions(-DMT7621AT)