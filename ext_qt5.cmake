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
    URL http://download.qt-project.org/snapshots/qt/5.2/5.2.0-rc1/2013-11-27_177/submodules/qtbase-opensource-src-5.2.0-rc1.zip
    URL_HASH SHA1=6c5838986002c28eef86f8b70c727867a8725f45

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
    URL http://download.qt-project.org/snapshots/qt/5.2/5.2.0-rc1/2013-11-27_177/submodules/qtdeclarative-opensource-src-5.2.0-rc1.tar.gz
    URL_HASH SHA1=e8d031f286a771c2f8094ac499425dfec2843c3d
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND ${NMAKE_TOOL}
    INSTALL_COMMAND ${NMAKE_TOOL} install
    DEPENDS qtbase
)

ExternalProject_Add(
    qtquickcontrols
    URL http://download.qt-project.org/snapshots/qt/5.2/5.2.0-rc1/2013-11-27_177/submodules/qtquickcontrols-opensource-src-5.2.0-rc1.tar.gz
    URL_HASH SHA1=e7a2196fde96ce255bfd5a14e21117396ff73f62
    CONFIGURE_COMMAND ${QT_PREFIX}\\bin\\qmake <SOURCE_DIR>
    BUILD_COMMAND ${NMAKE_TOOL}
    INSTALL_COMMAND ${NMAKE_TOOL} install
    DEPENDS qtdeclarative
)
