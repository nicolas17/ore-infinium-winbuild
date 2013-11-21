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
    URL http://download.qt-project.org/development_releases/qt/5.2/5.2.0-beta1/submodules/qtbase-opensource-src-5.2.0-beta1.zip
    URL_HASH SHA1=36de3f52cba8f5a73aad4e63a16c247bada8d6a2
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
    qtdeclarative
    URL http://download.qt-project.org/development_releases/qt/5.2/5.2.0-beta1/submodules/qtdeclarative-opensource-src-5.2.0-beta1.tar.gz
    URL_HASH SHA1=c2702eb096cf09bb49e586ced20b876b88644c6d
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND nmake
    INSTALL_COMMAND nmake install
    DEPENDS qtbase
)
