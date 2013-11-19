# Qt5 libraries

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    set(QT_BUILD_MODE debug)
else()
    set(QT_BUILD_MODE release)
endif()

# The .tar.gz file is missing configure.exe, so we have to use the .zip,
# which is unfortunate since the .tar.gz is smaller.

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
    URL http://download.qt-project.org/official_releases/qt/5.1/5.1.1/submodules/qtjsbackend-opensource-src-5.1.1.zip
    URL_HASH SHA1=7673782ee338fafb0554a88a40f5e701ca67b443

    PATCH_COMMAND ${PATCH_PROGRAM} -p1 < ${CMAKE_SOURCE_DIR}/qtjsbackend-math.patch
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
    DEPENDS qtbase patch
)

ExternalProject_Add(
    qtdeclarative
    URL http://download.qt-project.org/official_releases/qt/5.1/5.1.1/submodules/qtdeclarative-opensource-src-5.1.1.zip
    URL_HASH SHA1=1b6d569d0077a2cc0f0e724e097112adfe54e331
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
    DEPENDS qtjsbackend
)
