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
        COMMAND ${PATCH_PROGRAM} -p1 < ${PATCHES_DIR}/protobuf-vcproj-link.patch
        COMMAND ${PATCH_PROGRAM} -p1 < ${PATCHES_DIR}/protobuf-include-algorithm.patch

    CONFIGURE_COMMAND
        COMMAND vcupgrade "vsprojects\\libprotobuf.vcproj"
        COMMAND vcupgrade "vsprojects\\libprotoc.vcproj"
        COMMAND vcupgrade "vsprojects\\protoc.vcproj"

    BUILD_COMMAND
        COMMAND cd <SOURCE_DIR>\\vsprojects && msbuild libprotobuf.vcxproj /p:Configuration=${CONFIG}
        COMMAND cd <SOURCE_DIR>\\vsprojects && msbuild libprotoc.vcxproj /p:Configuration=${CONFIG}
        COMMAND cd <SOURCE_DIR>\\vsprojects && msbuild protoc.vcxproj /p:Configuration=${CONFIG}

    INSTALL_COMMAND cd vsprojects && call extract_includes.bat
)

add_dependencies(Protobuf patch)

ExternalProject_Get_Property(Protobuf SOURCE_DIR)
set(PROTOBUF_SRC ${SOURCE_DIR})
