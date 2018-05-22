set(CROSS_COMPILE arm-openwrt-linux-gnu-)
set(KERNEL_DIR
        /home/rus/MG/kernel-linux_2.6.22.19-4.07.0)
set(KERNEL_HEADERS
        ${KERNEL_DIR}/include)
set(PRECOMPILE_FILE
        ${KERNEL_HEADERS}/linux/autoconf.h)
set(EXTRA_FLAG "-DCOMCERTO")
set(CMAKE_C_COMPILER ${CROSS_COMPILE}gcc)
set(ARCH arm)
add_definitions(-DCOMCERTO)
