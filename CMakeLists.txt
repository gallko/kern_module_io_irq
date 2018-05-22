cmake_minimum_required(VERSION 2.8.4)
set(PROJECT_NAME io_irq)
set(CMAKE_TOOLCHAIN_FILE "comcerto.cmake")

project(${PROJECT_NAME})

# => version, git
find_package(Git)
string(TIMESTAMP DATE %d.%m.%Y)
string(TIMESTAMP TIME %H:%M:%S)
set(VERSION "0.1")
EXECUTE_PROCESS(
        COMMAND ${GIT_EXECUTABLE} rev-list --count HEAD
        OUTPUT_VARIABLE COUNT_HEAD
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
EXECUTE_PROCESS(
        COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
EXECUTE_PROCESS(
        COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
        OUTPUT_VARIABLE GIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
EXECUTE_PROCESS(
        COMMAND ${GIT_EXECUTABLE} status --porcelain
        OUTPUT_VARIABLE GIT_GHANGE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(VERSION_FULL "v${VERSION} N${COUNT_HEAD} ${DATE} ${TIME} ${GIT_BRANCH}:${GIT_HASH}")
if (NOT (GIT_GHANGE STREQUAL ""))
    set(VERSION_FULL "${VERSION_FULL} *")
endif(NOT (GIT_GHANGE STREQUAL ""))
MESSAGE(STATUS "Build version: ${VERSION_FULL}")
add_definitions(-DVERSION="${VERSION_FULL}")
# <= end

# Library
set(LIST_PATH_SRC_VP
        ${LIST_PATH_SRC_VP})
set(VP_INCLUDE
        ${VP_INCLUDE})
# <= end

# add include directory
set(PROJECT_INCLUDE
        include
        ${VP_INCLUDE})
# add source directory
aux_source_directory(src SOURCE_FILES)
aux_source_directory(src/arch SOURCE_FILES)

foreach (PATH_SRC_VP ${LIST_PATH_SRC_VP})
    message("PATH_SRC_VP ${PATH_SRC_VP}")
    aux_source_directory(${PATH_SRC_VP} SOURCE_FILES)
endforeach(PATH_SRC_VP)

# for IDE
#include_directories(include/)
include_directories(${PROJECT_INCLUDE})
get_property(DIR_INC DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
include_directories(${KERNEL_HEADERS})
add_definitions(-imacros ${PRECOMPILE_FILE})
add_definitions(-D__KERNEL__)
add_definitions(-DMODULE)
add_definitions(-std=gnu99)
add_definitions(-DDRIVER_NAME=\"${PROJECT_NAME}\")
# <==

## *.c -> *.o
foreach (SRC ${SOURCE_FILES})
    string(REPLACE ".c" ".o" OBJ ${SRC})
    set(OBJ_SRC "${OBJ_SRC} ${OBJ}")
endforeach(SRC)
message(SOURCE_FILES " ${SOURCE_FILES}")
message(OBJ_SRC "     ${OBJ_SRC}")

## include for make
foreach(INC ${DIR_INC})
    set(INCLUDE "${INCLUDE}-I${INC} ")
endforeach()

set(FLAGS
        ${EXTRA_FLAG}
        DRIVER_NAME=${PROJECT_NAME})

set(OPT_MAKE_ALL
        -C ${CMAKE_CURRENT_SOURCE_DIR}
        NAME=${PROJECT_NAME}
        TOP_DIR=${CMAKE_CURRENT_SOURCE_DIR}
        SRC=${OBJ_SRC}
        KERNEL_DIR=${KERNEL_DIR}
        CROSS_COMPILE=${CROSS_COMPILE})

set(OPT_MAKE_BUILD
        VERSION=\"${VERSION_FULL}\"
        FLAGS=${FLAGS}
        INCLUDE=${INCLUDE})

add_custom_target(module
        COMMAND $(MAKE) ${OPT_MAKE_ALL} ${OPT_MAKE_BUILD})
add_custom_target(clean-module
        COMMAND $(MAKE) ${OPT_MAKE_ALL} clean)

add_library(not_use ${SOURCE_FILES})
