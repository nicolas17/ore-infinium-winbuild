# Qt5 libraries

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    set(QT_BUILD_MODE debug)
else()
    set(QT_BUILD_MODE release)
endif()

find_program(JOM_EXECUTABLE jom)
if(JOM_EXECUTABLE)
    message(STATUS "Found Jom: ${JOM_EXECUTABLE}")
    set(NMAKE_TOOL "${JOM_EXECUTABLE}")
else()
    message(STATUS "Could NOT find Jom; consider installing it to get multi-core builds")
    set(NMAKE_TOOL nmake)
endif()

# The .tar.gz file is missing configure.exe, so we have to use the .zip,
# which is unfortunate since the .tar.gz is smaller.
# Other modules don't have this problem, since they don't have nor need
# a configure.exe.

ExternalProject_Add(
    qtbase
    URL http://download.qt-project.org/official_releases/qt/5.3/5.3.2/submodules/qtbase-opensource-src-5.3.2.zip
    URL_HASH SHA1=cec5321a2148918e45efb08415f4a07b76cd4362

    CONFIGURE_COMMAND "<SOURCE_DIR>\\configure" -opensource -confirm-license
        -${QT_BUILD_MODE}
        -prefix <INSTALL_DIR>
        -nomake tests -nomake examples -opengl desktop
    BUILD_COMMAND ${NMAKE_TOOL}
    INSTALL_COMMAND ${NMAKE_TOOL} install
)

ExternalProject_Get_Property(qtbase INSTALL_DIR)
set(QT_PREFIX ${INSTALL_DIR})

ExternalProject_Add(
    qtdeclarative
    URL http://download.qt-project.org/official_releases/qt/5.3/5.3.2/submodules/qtdeclarative-opensource-src-5.3.2.tar.gz
    URL_HASH SHA1=24ebd632e7b1fe9c6523e9e7f37399757aa9c270
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND ${NMAKE_TOOL}
    INSTALL_COMMAND ${NMAKE_TOOL} install
    DEPENDS qtbase
)

ExternalProject_Add(
    qtquickcontrols
    URL http://download.qt-project.org/official_releases/qt/5.3/5.3.2/submodules/qtquickcontrols-opensource-src-5.3.2.tar.gz
    URL_HASH SHA1=81f6c97b980692b6b51d541eb6534f4f92c90d2a
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND ${NMAKE_TOOL}
    INSTALL_COMMAND ${NMAKE_TOOL} install
    DEPENDS qtdeclarative
)
