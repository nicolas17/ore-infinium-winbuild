# enet library
# The build system is based on autotools, so I'll be lazy and use the
# precompiled Windows binary. Won't work on x64 though...

ExternalProject_Add(
    enet
    URL http://enet.bespin.org/download/enet-1.3.10.tar.gz
    URL_HASH MD5=829a283464a9a3d7611d4a7efc6755d6
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND
        COMMAND cmake -E make_directory <INSTALL_DIR>/lib
        COMMAND cmake -E copy <SOURCE_DIR>/enet.lib <INSTALL_DIR>/lib
        COMMAND cmake -E copy_directory <SOURCE_DIR>/include <INSTALL_DIR>/include
)

ExternalProject_Get_Property(enet INSTALL_DIR)
set(ENET_PREFIX ${INSTALL_DIR})
