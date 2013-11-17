# 'patch' binary from GNUWin32

ExternalProject_Add(
    patch
    URL http://downloads.sourceforge.net/gnuwin32/patch-2.5.9-7-bin.zip
    URL_HASH MD5=b9c8b31d62f4b2e4f1887bbb63e8a905
    BUILD_IN_SOURCE 1

    CONFIGURE_COMMAND ""
    BUILD_COMMAND mt -nologo -manifest "${CMAKE_SOURCE_DIR}\\patch.exe.manifest" -outputresource:bin\\patch.exe
    INSTALL_COMMAND cmake -E copy <SOURCE_DIR>/bin/patch.exe <INSTALL_DIR>/
)
ExternalProject_Get_Property(patch INSTALL_DIR)
set(PATCH_PROGRAM "${INSTALL_DIR}/patch")
