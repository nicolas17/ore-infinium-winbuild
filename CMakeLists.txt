cmake_minimum_required(VERSION 2.8)
project(ore-infinium-deps C)

include(ExternalProject)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_CURRENT_BINARY_DIR})

if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "MSVC")
    message(FATAL_ERROR "Currently only MSVC is supported here")
endif()

set(PATCHES_DIR ${CMAKE_SOURCE_DIR}/patches)

include(ext_patch.cmake)
include(ext_chipmunk.cmake)
include(ext_yamlcpp.cmake)
include(ext_enet.cmake)
include(ext_protobuf.cmake)
include(ext_qt5.cmake)
include(ext_oreinfinium.cmake)

# Custom target to clean built files but not downloaded tarballs
# (still imperfect)

add_custom_target(clean_keep_downloads
    COMMAND cmake -E rename Source/ore-infinium bkp-ore-infinium
    COMMAND cmake -E remove_directory Build
    COMMAND cmake -E remove_directory Source
    COMMAND cmake -E remove_directory Install
    COMMAND cmake -E remove_directory Stamp
    COMMAND cmake -E remove_directory tmp
    COMMAND cmake -E make_directory Source
    COMMAND cmake -E rename bkp-ore-infinium Source/ore-infinium
)

# Installer stuff
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}")
find_package(WiX 3.7)

if(WIX_FOUND)
  WIX_ADD_PRODUCT(oreinfinium
    SOURCES main.wxs qt.wxs
    LINK_FLAGS -b qt5=${QT_PREFIX})
endif()
