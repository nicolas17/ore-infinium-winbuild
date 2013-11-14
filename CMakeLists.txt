cmake_minimum_required(VERSION 2.8)
project(ore-infinium-deps C)

include(ExternalProject)

set_property(DIRECTORY PROPERTY EP_BASE "externals")

if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "MSVC")
    message(FATAL_ERROR "Currently only MSVC is supported here")
endif()

# 'patch' binary from GNUWin32

ExternalProject_Add(
    patch
    URL http://downloads.sourceforge.net/gnuwin32/patch-2.5.9-7-bin.zip
    BUILD_IN_SOURCE 1

    CONFIGURE_COMMAND ""
    BUILD_COMMAND mt -nologo -manifest "${CMAKE_SOURCE_DIR}\\patch.exe.manifest" -outputresource:bin\\patch.exe
    INSTALL_COMMAND cmake -E copy <SOURCE_DIR>/bin/patch.exe <INSTALL_DIR>/
)
ExternalProject_Get_Property(patch INSTALL_DIR)
set(PATCH_PROGRAM "${INSTALL_DIR}/patch")

# Chipmunk library

ExternalProject_Add(
    Chipmunk
    URL http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.2.1.tgz
    URL_HASH MD5=1cc6ff6a1f1cfcc6e167841fb24bf3c6
    CMAKE_ARGS
        -DBUILD_DEMOS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

# yaml-cpp library

ExternalProject_Add(
    yaml-cpp
    URL https://yaml-cpp.googlecode.com/files/yaml-cpp-0.3.0.tar.gz
    URL_HASH SHA1=28766efa95f1b0f697c4b4a1580a9972be7c9c41
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

# Protobuf library and compiler

if("${CMAKE_BUILD_TYPE}" STREQUAL Debug)
    set(CONFIG Debug)
else()
    set(CONFIG Release)
endif()

ExternalProject_Add(
    Protobuf
    URL https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2
    URL_HASH SHA1=62c10dcdac4b69cc8c6bb19f73db40c264cb2726
    BUILD_IN_SOURCE 1

    PATCH_COMMAND
        COMMAND ${PATCH_PROGRAM} -p1 < ${CMAKE_SOURCE_DIR}/protobuf-include-algorithm.patch

    CONFIGURE_COMMAND
        COMMAND cmake -E copy "${CMAKE_SOURCE_DIR}/protoc.vcproj" vsprojects/protoc.vcproj
        COMMAND vcupgrade "vsprojects\\libprotobuf.vcproj"
        COMMAND vcupgrade "vsprojects\\libprotoc.vcproj"
        COMMAND vcupgrade "vsprojects\\protoc.vcproj"

    BUILD_COMMAND
        COMMAND cd vsprojects && msbuild libprotobuf.vcxproj /p:Configuration=${CONFIG}
        COMMAND cd vsprojects && msbuild libprotoc.vcxproj /p:Configuration=${CONFIG}
        COMMAND cd vsprojects && msbuild protoc.vcxproj /p:Configuration=${CONFIG}

    INSTALL_COMMAND cd vsprojects && call extract_includes.bat
)

add_dependencies(Protobuf patch)

# Custom target to clean built files but not downloaded tarballs
# (still imperfect)

add_custom_target(clean_keep_downloads
    COMMAND cmake -E remove_directory externals/Build
    COMMAND cmake -E remove_directory externals/Install
    COMMAND cmake -E remove_directory externals/Source
    COMMAND cmake -E remove_directory externals/tmp
)
