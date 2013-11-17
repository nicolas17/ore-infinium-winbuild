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
