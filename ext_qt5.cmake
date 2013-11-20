# Qt5 libraries

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    set(QT_BUILD_MODE debug)
else()
    set(QT_BUILD_MODE release)
endif()

# The .tar.gz file is missing configure.exe, so we have to use the .zip,
# which is unfortunate since the .tar.gz is smaller.
# Other modules don't have this problem, since they don't have nor need
# a configure.exe.

ExternalProject_Add(
    qtbase
    URL http://download.qt-project.org/official_releases/qt/5.1/5.1.1/submodules/qtbase-opensource-src-5.1.1.zip
    URL_HASH SHA1=7da0a4e0e319a2a6faeafcba94b091214f186b9f
    CONFIGURE_COMMAND "<SOURCE_DIR>\\configure" -opensource -confirm-license
        -${QT_BUILD_MODE}
        -prefix <INSTALL_DIR>
        -nomake tests -nomake examples -opengl desktop
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
)

ExternalProject_Get_Property(qtbase INSTALL_DIR)
set(QT_PREFIX ${INSTALL_DIR})

ExternalProject_Add(
    qtjsbackend
    URL http://download.qt-project.org/official_releases/qt/5.1/5.1.1/submodules/qtjsbackend-opensource-src-5.1.1.tar.gz
    URL_HASH SHA1=5723e3c3e563b6ca8f3a6c52d5c313df386384b3

    PATCH_COMMAND ${PATCH_PROGRAM} -p1 < ${CMAKE_SOURCE_DIR}/qtjsbackend-math.patch
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
    DEPENDS qtbase patch
)

ExternalProject_Add(
    qtdeclarative
    URL http://download.qt-project.org/official_releases/qt/5.1/5.1.1/submodules/qtdeclarative-opensource-src-5.1.1.tar.gz
    URL_HASH SHA1=b47a6fefea577a43aca8626cb20528e80b095875
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
    DEPENDS qtjsbackend
)
